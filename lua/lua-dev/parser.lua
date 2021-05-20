local uv = vim.loop
local M = {}

function M.comment(str, comment_str)
  comment_str = comment_str or "--"
  return comment_str .. " " .. vim.fn.trim(str):gsub("[\n]", "\n" .. comment_str .. " "):gsub("%s+\n", "\n")
end

function M.infer_type(param)
  local type = param.type or "any"
  if type == "" then
    type = "any"
  end
  if type == "any" then
    if param.name == "fn" then
      type = "fun(...)"
    elseif param.name == "args" or param.name == "list" then
      type = "any[]"
    elseif param.name == "dict" then
      type = "dictionary"
    end
  end
  if type == "arrayof(string)" then
    type = "string[]"
  elseif type == "arrayof(integer, 2)" then
    type = "number[]"
  elseif type == "dictionaryof(luaref)" then
    type = "table<string, luaref>"
  end
  return type
end

function M.emmy_param(param, is_return)
  local type = M.infer_type(param)
  local parts = {}
  if param.name and param.name ~= "..." then
    table.insert(parts, param.name)
  end
  if type then
    table.insert(parts, type)
  end
  if param.doc then
    table.insert(parts, "#" .. param.doc)
  end

  if not param.doc and type == "any" then
    return ""
  end
  local ret = table.concat(parts, " ")
  if is_return then
    return M.comment("@return " .. ret, "---") .. "\n"
  elseif param.name == "..." then
    return M.comment("@vararg " .. ret, "---") .. "\n"
  else
    return M.comment("@param " .. ret, "---") .. "\n"
  end
end

--- @return ApiFunction
function M.process(name, fun, prefix)
  --- @class ApiFunction
  local ret = {
    doc = (fun.doc and fun.doc[1]) and fun.doc[1] or "",
    name = name,
    fqname = prefix .. "." .. name,
    params = {},
    ["return"] = {},
  }

  for _, r in pairs(fun["return"]) do
    table.insert(ret["return"], { doc = r })
  end

  local param_docs = {}
  for param, doc in pairs(fun.parameters_doc or {}) do
    param_docs[param] = doc
  end

  for i, p in ipairs(fun.parameters or {}) do
    local type, pname = unpack(p)
    local param = { name = pname }
    if type ~= "" then
      param.type = type:lower()
    end
    if param_docs[pname] then
      param.doc = param_docs[pname]
    end
    if param.name == "end" then
      param.name = "end_"
    end
    -- only include err param if it's documented
    -- most nvim_ functions have an err param at the end, but these should not be included
    local skip = i == #fun.parameters and (pname == "err" or pname == "error")
    -- skip self params
    if param.name == "self" or param.name == "" then
      skip = true
    end
    if not skip then
      table.insert(ret.params, param)
    end
  end
  return ret
end

--- @param fun ApiFunction
function M.emmy(fun)
  local ret = ""
  if fun.doc ~= "" then
    ret = ret .. (M.comment(fun.doc)) .. "\n"
  end

  local params = {}

  for _, param in pairs(fun.params) do
    table.insert(params, param.name)
    ret = ret .. M.emmy_param(param)
  end
  for _, r in pairs(fun["return"]) do
    ret = ret .. M.emmy_param(r, true)
  end

  local signature = "function %s(%s) end"

  ret = ret .. signature:format(fun.fqname, table.concat(params, ", "))
  return ret .. "\n\n"
end

function M.intro(fd)
  uv.fs_write(fd, [[
--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

]], -1)
end

function M.get_functions(mpack)
  mpack = "mpack/" .. mpack
  local data = vim.fn.msgpackparse(vim.fn.readfile(mpack, "b"))
  local ret = {}
  for _, functions in pairs(data) do
    for name, fun in pairs(functions) do
      table.insert(ret, { name, fun })
    end
  end
  table.sort(ret, function(a, b)
    return a[1] < b[1]
  end)
  return ret
end

function M.parse(mpack, prefix, exclude)
  -- exclude signatures for functions that are existing lua sources
  local skip = {}
  for _, value in pairs(exclude or {}) do
    for key, _ in pairs(require(value)) do
      skip[key] = true
    end
  end
  prefix = prefix or "vim"
  local fname = vim.fn.fnamemodify(mpack, ":t:r")

  local fnum = 0
  local fd = uv.fs_open("types/" .. fname .. ".lua", "w+", 420)
  M.intro(fd)
  local size = 0

  local classes = {}
  for _, f in pairs(M.get_functions(mpack)) do
    local name, fun = unpack(f)
    if not skip[name] then
      local parts = vim.fn.split(name, ":")
      if #parts > 1 and not classes[parts[1]] then
        uv.fs_write(fd, ([[
--- @class %s
%s = {}

]]):format(prefix .. "." .. parts[1], prefix .. "." .. parts[1]), -1)
        classes[parts[1]] = true
      end
      local emmy = M.emmy(M.process(name, fun, prefix))
      size = size + #emmy
      uv.fs_write(fd, emmy, -1)

      if size > 1024 * 10 then
        uv.fs_close(fd)
        fnum = fnum + 1
        size = 0
        fd = uv.fs_open("types/" .. fname .. "." .. fnum .. ".lua", "w+", 420)
        M.intro(fd)
      end
    end
  end
  uv.fs_close(fd)
end

function M.options()
  local ret = { o = {}, wo = {}, bo = {} }
  for name, option in pairs(vim.api.nvim_get_all_options_info()) do
    ret.o[name] = option.default
    if option.scope == "buf" then
      ret.bo[name] = option.default
    end
    if option.scope == "win" then
      ret.wo[name] = option.default
    end
  end
  local fd = uv.fs_open("types/options.lua", "w+", 420)
  M.intro(fd)
  uv.fs_write(fd, "vim = " .. vim.inspect(ret), -1)
  uv.fs_close(fd)
end

function M.build()
  M.options()
  M.parse("lua.mpack", "vim", { "vim.shared", "vim.uri", "vim.inspect" })
  M.parse("api.mpack", "vim.api")
  M.parse("lsp.mpack", "vim.lsp", { "vim.lsp" })
  M.parse("treesitter.mpack", "vim.treesitter", { "vim.treesitter" })
end

M.build()

return M
