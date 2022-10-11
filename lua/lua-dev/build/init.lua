local Config = require("lua-dev.config")
local Util = require("lua-dev.util")

local Annotations = require("lua-dev.build.annotations")
local Api = require("lua-dev.build.api")
local Docs = require("lua-dev.build.docs")
local Mpack = require("lua-dev.build.mpack")
local Writer = require("lua-dev.build.writer")

local M = {}

function M.api()
  local api = Api.get()

  -- Only load mpack on nightly and add any missing functions
  -- Typically hidden functions
  if Config.version() == "nightly" then
    local functions = Mpack.read("api.mpack")

    for k, v in pairs(functions) do
      if not api[k] then
        api[k] = v
      end
    end
  end

  M.write("api", api)
end

---@param fname string
---@param functions table<string, LuaApiFunction>
function M.write(fname, functions)
  local writer = Writer(fname)
  Util.for_each(functions, function(_, fun)
    writer:write(Annotations.fun(fun))
  end)

  writer:close()
end

function M.options()
  local docs = Docs.options()

  ---@type table<string, table<string, any>>
  local ret = { o = {}, wo = {}, bo = {} }

  ---@type table<string, {scope:string, default:string, global_local: boolean}>
  local info = vim.api.nvim_get_all_options_info()

  for name, option in pairs(info) do
    if option.scope == "buf" then
      ret.bo[name] = option.default
    elseif option.scope == "win" then
      ret.wo[name] = option.default
    end
    if option.scope == "global" or option.global_local then
      ret.o[name] = option.default
    end
  end

  local writer = Writer("options")
  for _, scope in ipairs({ "bo", "o", "wo" }) do
    local options = ret[scope]
    Util.for_each(options, function(key, value)
      local str = ("vim.%s.%s = %q\n"):format(scope, key, value)
      local doc = docs[key] or nil
      if doc then
        str = Annotations.comment(doc) .. "\n" .. str
      end
      writer:write(str)
    end)
  end
  writer:close()
end

function M.alias()
  local writer = Writer("alias")
  Util.for_each(Annotations.nvim_types, function(key, value)
    writer:write(("---@alias %s %s"):format(key, value) .. "\n")
  end)
  writer:close()
end

function M.clean()
  local types = Config.types()
  for _, f in pairs(vim.fn.expand(types .. "/*.lua", false, true)) do
    if not f:find("/vim.lua", 1, true) then
      vim.loop.fs_unlink(f)
    end
  end
end

function M.build()
  M.clean()

  M.alias()
  M.options()
  M.api()

  M.write("luv", Docs.luv())
  M.write("lua", Docs.lua())
  M.write("vim.fn", Docs.functions())
end

M.build()

return M
