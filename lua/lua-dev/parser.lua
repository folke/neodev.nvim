local util = require("lua-dev.util")
local uv = vim.loop
local M = {}

function M.comment(str, prefix)
  prefix = (prefix or "") .. "-- "
  return prefix .. str:gsub("\n", "\n" .. prefix)
end

function M.infer_type(param)
  local type = param.type or "any"
  if type == "" or not type then
    type = "any"
  end
  if type == "any" then
    if vim.tbl_contains({ "buffer", "bufid", "bufnr", "buf" }, param.name) then
      type = "buffer"
    elseif vim.tbl_contains({ "win", "window", "winid", "winnr" }, param.name) then
      type = "window"
    elseif vim.tbl_contains({ "col", "lnum", "tabnr", "nr", "pos", "ns", "index", "from", "to" }, param.name) then
      type = "number"
    elseif vim.tbl_contains({ "str", "text" }, param.name) then
      type = "string"
    elseif vim.tbl_contains({ "args", "opt", "opts", "options" }, param.name) then
      type = "table<string, any>"
    elseif vim.tbl_contains({ "fn", "function", "callback", "func" }, param.name) then
      type = "fun()"
    elseif param.name == "args" or param.name == "list" then
      type = "any[]"
    elseif param.name == "dict" then
      type = "dictionary"
    end
    return type
  end

  if type == "arrayof(string)" then
    type = "string[]"
  elseif type == "arrayof(integer, 2)" then
    type = "number[]"
  elseif type == "dictionaryof(luaref)" then
    type = "table<string, luaref>"
  elseif type and type:find("dict%(") == 1 then
    type = "dict"
  end
  return type
end

function M.emmy_param(param, is_return)
  local type = M.infer_type(param)
  local parts = {}
  if vim.tbl_contains({ "end", "repeat" }, param.name) then
    param.name = "_" .. param.name
  end
  if param.name then
    table.insert(parts, param.name .. (param.optional and "?" or ""))
  end
  if type then
    table.insert(parts, type)
  end
  if param.doc then
    table.insert(parts, "# " .. param.doc)
  end

  if not param.doc and type == "any" and not param.optional then
    return ""
  end

  local ret = table.concat(parts, " ")
  if is_return then
    return M.comment("@return " .. ret, "-") .. "\n"
  else
    return M.comment("@param " .. ret, "-") .. "\n"
  end
end

---@class MpackFunction
---@field doc string[]
---@field parameters string[][]
---@field parameters_doc table<string, string>
---@field return string[]
---@field seealso string[]
---@field signature string

---@class LuaType
---@field type? string
---@field doc? string
---@field optional? boolean

---@class LuaParam: LuaType
---@field name string

---@class LuaReturn: LuaType

--- @class LuaFunction
--- @field name string,
--- @field doc string,
--- @field deprecated? boolean
--- @field params LuaParam[]
--- @field return LuaReturn[]

--- @param fun MpackFunction
--- @return LuaFunction
function M.process(fun)
  ---@type LuaFunction
  local ret = {
    doc = (fun.doc and fun.doc[1]) and table.concat(fun.doc, "\n\n") or "",
    name = fun.name,
    params = {},
    seealso = fun.seealso or {},
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
    if param.type and param.type:find("%*$") then
      param.type = param.type:sub(1, -2)
      param.optional = true
    end
    -- only include err param if it's documented
    -- most nvim_ functions have an err param at the end, but these should not be included
    local skip = i == #fun.parameters and (pname == "err" or pname == "error")
    -- skip self params
    if param.name == "self" or param.name == "" or param.name == "arena" then
      skip = true
    end
    if not skip then
      table.insert(ret.params, param)
    end
  end
  return ret
end

---@param text string
function M.fix_indent(text)
  local lines = vim.split(text, "\n")
  local indent = 10
  for l, line in ipairs(lines) do
    if not (line:find("^%s*$") or line:find("^```")) then
      line = line:gsub("  ", "\t")
      lines[l] = line
      local prefix = line:match("^\t+")
      if prefix then
        indent = math.min(indent, #prefix)
      end
    end
  end
  if indent > 0 then
    for l, line in ipairs(lines) do
      lines[l] = line:gsub("^" .. ("\t"):rep(indent), ""):gsub("\t", "  ")
    end
  end
  return table.concat(lines, "\n")
end

--- @param fun LuaFunction
function M.emmy(fun)
  local special = { "or", "and", "repeat", "function", "end", "return" }

  local ret = ""
  if fun.doc ~= "" then
    -- make markdown lua code blocks for code regions
    local ft = fun.name:find("vim.fn") and "vim" or "lua"
    local doc = fun.doc:gsub("\n*>\n(.-)\n+<\n?", "\n```" .. ft .. "\n%1\n```\n")
    doc = M.fix_indent(doc)
    ret = ret .. (M.comment(doc)) .. "\n"
  end

  if fun.seealso and #fun.seealso > 0 then
    for _, also in ipairs(fun.seealso) do
      ret = ret .. "--- @see " .. also .. "\n"
    end
  end

  local params = {}

  for _, param in pairs(fun.params) do
    ret = ret .. M.emmy_param(param)
    table.insert(params, param.name)
  end
  for _, r in pairs(fun["return"]) do
    ret = ret .. M.emmy_param(r, true)
  end

  local signature = "function %s(%s) end"

  -- handle special Lua names. Set as a field instead of a function
  if vim.tbl_contains(special, fun.name:match("[^.]+$")) then
    local prefix, name = fun.name:match("(.*)%.([^.]+)$")
    fun.name = name
    signature = prefix .. "[%q] = function(%s) end"
  end

  ret = ret .. signature:format(fun.name, table.concat(params, ", "))
  return ret .. "\n\n"
end

function M.intro(fd)
  uv.fs_write(
    fd,
    [[
---@meta

--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

]],
    -1
  )
end

---@return {[1]:string, [2]:MpackFunction}[]
function M.get_functions(mpack)
  mpack = "data/" .. mpack
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

---@return string?, any?
function M.get_fn(prefix, name, alt)
  for _, p in ipairs(alt and { prefix, alt } or { prefix }) do
    local real_fn = vim.tbl_get(_G, unpack(vim.split(p .. "." .. name, ".", { plain = true })))
    if real_fn then
      return p, real_fn
    end
  end
end

---@param opts? {alt: string, extra: table<string,LuaFunction>}
function M.parse(mpack, prefix, opts)
  opts = opts or {}
  print(prefix)
  prefix = prefix or "vim"
  local fname = vim.fn.fnamemodify(mpack, ":t:r")

  local writer = M.writer(fname)
  for _, f in pairs(M.get_functions(mpack)) do
    local name = f[1]
    local fun = f[2]

    -- we shouldnt get classes here
    assert(not name:find(":"))

    local prefix_fn, real_fn = M.get_fn(prefix, name, opts.alt)

    if prefix_fn then
      name = prefix_fn .. "." .. name
      fun.name = name
      local skip = false

      if real_fn then
        if type(real_fn) == "function" then
          if prefix_fn ~= "vim.fn" and prefix_fn ~= "vim.api" then
            local info = debug.getinfo(real_fn, "S")
            skip = info.what == "Lua"
          end
        end
      end

      if not skip then
        local emmy = M.emmy(M.process(fun))
        writer.write(emmy)
      end
    end
  end

  if opts.extra then
    local names = vim.tbl_keys(opts.extra)
    table.sort(names)
    for _, name in ipairs(names) do
      local emmy = M.emmy(opts.extra[name])
      writer.write(emmy)
    end
  end
  writer.close()
end

function M.luv()
  local prefix = "luv"
  print(prefix)

  local writer = M.writer(prefix)
  local functions = require("lua-dev.docs").luv()
  local names = vim.tbl_keys(functions)
  table.sort(names)
  for _, name in ipairs(names) do
    local emmy = M.emmy(functions[name])
    writer.write(emmy)
  end
end

function M.options()
  local docs = require("lua-dev.docs").options()

  local ret = { o = {}, wo = {}, bo = {} }
  for name, option in pairs(vim.api.nvim_get_all_options_info()) do
    if option.scope == "buf" then
      ret.bo[name] = option.default
    elseif option.scope == "win" then
      ret.wo[name] = option.default
    end
    if option.scope == "global" or option.global_local then
      ret.o[name] = option.default
    end
  end

  local writer = M.writer("options")
  for _, scope in ipairs({ "bo", "o", "wo" }) do
    local options = ret[scope]
    local names = vim.tbl_keys(options)
    table.sort(names)
    for _, key in ipairs(names) do
      local value = options[key]
      local str = ("vim.%s.%s = %q\n"):format(scope, key, value)
      local doc = docs[key] or nil
      if doc then
        str = M.comment(doc) .. "\n" .. str
      end
      writer.write(str)
    end
  end
  writer.close()
end

function M.writer(file)
  local types = require("lua-dev.sumneko").types()
  local fd = uv.fs_open(types .. "/" .. file .. ".lua", "w+", 420)
  local size = 0
  local fnum = 0
  M.intro(fd)
  return {
    write = function(str)
      uv.fs_write(fd, str, -1)
      size = size + #str
      if size > 1024 * 200 then
        uv.fs_close(fd)
        fnum = fnum + 1
        size = 0
        fd = uv.fs_open(types .. "/" .. file .. "." .. fnum .. ".lua", "w+", 420)
        M.intro(fd)
      end
    end,
    close = function()
      uv.fs_close(fd)
    end,
  }
end

function M.functions()
  local functions = require("lua-dev.docs").functions()

  local writer = M.writer("vim.fn")
  local names = vim.tbl_keys(functions)
  table.sort(names)
  for _, name in ipairs(names) do
    local props = functions[name]
    if vim.fn[name] then
      local fun = {
        name = name,
        doc = props.doc or "",
        params = props.params,
        ["return"] = props["return"],
      }
      writer.write(M.emmy(fun))
    end
  end
  writer.close()
end

function M.clean()
  local types = require("lua-dev.sumneko").types()
  for _, f in pairs(vim.fn.expand(types .. "/*.lua", false, true)) do
    if not f:find("/vim.lua", 1, true) then
      uv.fs_unlink(f)
    end
  end
end

function M.build()
  M.clean()
  M.functions()
  M.options()
  M.parse("lua.mpack", "vim", { extra = require("lua-dev.docs").lua() })
  M.parse("api.mpack", "vim.api", { alt = "vim.fn" })
  M.luv()
end

M.build()

return M
