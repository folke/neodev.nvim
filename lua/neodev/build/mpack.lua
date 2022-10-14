local Annotations = require("neodev.build.annotations")
local util = require("neodev.util")
local M = {}

---@class MpackFunction
---@field doc string[]
---@field parameters {[1]: string, [2]:string}[]
---@field parameters_doc table<string, string>
---@field return string[]
---@field seealso string[]
---@field signature string

function M.read(mpack)
  mpack = "data/" .. mpack
  ---@type table<string, MpackFunction>
  local data = vim.mpack.decode(util.read_file(mpack))

  ---@type table<string, LuaFunction>
  local ret = {}
  for name, fun in pairs(data) do
    name = Annotations.fqn(name)
    if name then
      ret[name] = M.process(name, fun)
    end
  end
  return ret
end

---@param name string
--- @param fun MpackFunction
--- @return LuaFunction
function M.process(name, fun)
  ---@type LuaFunction
  local ret = {
    doc = (fun.doc and fun.doc[1]) and table.concat(fun.doc, "\n\n") or "",
    name = name,
    params = {},
    seealso = fun.seealso or {},
    ["return"] = {},
  }

  for _, r in pairs(fun["return"]) do
    table.insert(ret["return"], { doc = r })
  end

  for i, p in ipairs(fun.parameters or {}) do
    local type = p[1]
    local pname = p[2]
    local param = { name = pname }
    if type ~= "" then
      param.type = type:lower()
    end
    param.doc = fun.parameters_doc and fun.parameters_doc[pname] or nil

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

return M
