local Annotations = require("neodev.build.annotations")
local Docs = require("neodev.build.docs")

---@class NvimApiInfo
---@field functions NvimApiFunction[]

---@class NvimApiFunction
---@field name string
---@field deprecated_since? number
---@field parameters {[1]: string, [2]:string}[]
---@field return_type string
---@field since number
---@field method? boolean

---@class LuaApiFunction: LuaFunction
---@field params_index? table<string, LuaParam>
---@field info? NvimApiFunction

local M = {}

---@return table<string, LuaFunction>
function M.get()
  local functions = Docs.parse_functions("api", {
    name = Annotations.fqn,
  })
  ---@cast functions table<string, LuaApiFunction>

  -- add params index
  for _, fun in pairs(functions) do
    fun.params_index = {}
    for _, param in ipairs(fun.params) do
      local name = param.name
      if name then
        fun.params_index[name] = param
      end
    end
  end

  ---@type NvimApiInfo
  local info = vim.fn.api_info()

  -- add api info
  for _, fun in ipairs(info.functions) do
    if not fun.deprecated_since then
      local name = Annotations.fqn(fun.name)
      if name then
        if not functions[name] then
          functions[name] = {
            doc = "",
            name = name,
            params = {},
            params_index = {},
          }
        end
        functions[name].info = fun
      end
    end
  end

  -- merge api info
  for _, fun in pairs(functions) do
    if fun.info then
      for _, param in ipairs(fun.info.parameters) do
        if fun.params_index[param[2]] then
          fun.params_index[param[2]].type = param[1]:lower()
        else
          fun.params_index[param[2]] = { name = param[2], type = param[1]:lower() }
        end
      end
      local return_type = fun.info.return_type:lower()
      fun["return"] = { { type = return_type == "nil" and nil or return_type } }
    end
  end

  return functions
end

M.get()

return M
