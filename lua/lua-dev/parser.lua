local uv = vim.loop
local M = {}

function M.comment(str, comment_str)
  comment_str = comment_str or "--"
  return comment_str .. " " .. str:gsub("[\n]", "\n" .. comment_str .. " ")
end

function M.infer_type(doc, param, param_type)
  local type = param_type or "any"
  if type == "" then
    type = "any"
  end

  if param == "fn" then
    type = "fun(...)"
  elseif param == "args" or param == "list" then
    type = "any[]"
  elseif param == "dict" then
    type = "dictionary"
  elseif type == "arrayof(string)" then
    type = "string[]"
  end

  local ret = ""
  if param then
    if param == "end" then
      param = "_end"
    end
    ret = ret .. param .. " "
  end
  if type then
    ret = ret .. type .. " "
  end
  return ret .. "#" .. doc
end

function M.emmy(name, fun, prefix)
  local ret = ""
  if fun.doc and fun.doc[1] then
    ret = ret .. (M.comment(fun.doc[1])) .. "\n"
  end
  local have_err = false
  if fun.parameters_doc then
    local types = {}
    for _, param in pairs(fun.parameters or {}) do
      if param[1] then
        types[param[2]] = string.lower(param[1])
      end
    end
    for param, param_doc in pairs(fun.parameters_doc) do
      if param == "err" then
        have_err = true
      end
      if param ~= "self" then
        ret = ret .. M.comment("@param " .. M.infer_type(param_doc, param, types[param]), "---") .. "\n"
      end
    end
  end
  if fun["return"] and fun["return"][1] then
    ret = ret .. M.comment("@return " .. M.infer_type(fun["return"][1]), "---") .. "\n"
  end

  local signature = "function %s.%s(%s) end"
  local params = {}
  for i, param in ipairs(fun.parameters or {}) do
    param = param[2]
    if param == "end" then
      param = "_end"
    end
    if have_err or not (i == #fun.parameters and param == "err") then
      if param ~= "self" then
        table.insert(params, param)
      end
    end
  end

  ret = ret .. signature:format(prefix, name, table.concat(params, ", "))
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
      local emmy = M.emmy(name, fun, prefix)
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

function M.build()
  M.parse("lua.mpack", "vim", { "vim.shared", "vim.uri", "vim.inspect" })
  M.parse("api.mpack", "vim.api")
  M.parse("lsp.mpack", "vim.lsp", { "vim.lsp" })
  M.parse("treesitter.mpack", "vim.treesitter", { "vim.treesitter" })
end

M.build()

return M
