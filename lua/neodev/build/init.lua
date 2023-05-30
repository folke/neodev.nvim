local Config = require("neodev.config")
local Util = require("neodev.util")

local Annotations = require("neodev.build.annotations")
local Api = require("neodev.build.api")
local Docs = require("neodev.build.docs")
local Mpack = require("neodev.build.mpack")
local Writer = require("neodev.build.writer")
local Options = require("neodev.build.options")

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

---@return table<string, LuaFunction>, string?
function M.override(fname)
  local override = Config.root("/types/override/" .. fname .. ".lua")
  if override then
    local code = Util.read_file(override)
    local mod = {}
    local mod_code = code:match("\n(return.*)") or code:match("^(return.*)")
    if mod_code then
      mod = load(mod_code)()
    end
    code = code:gsub("\nreturn.*", "")
    code = code:gsub("^return.*", "")
    return mod, code
  end
  return {}
end

---@param fname string
---@param functions table<string, LuaFunction>
function M.write(fname, functions)
  local override, override_code = M.override(fname)
  functions = vim.tbl_deep_extend("force", functions, override)

  local writer = Writer(fname)
  if override_code then
    writer:write(override_code .. "\n\n")
  end
  Util.for_each(functions, function(_, fun)
    writer:write(Annotations.fun(fun))
  end)

  writer:close()
end

function M.alias()
  local writer = Writer("alias")
  Util.for_each(Annotations.nvim_types, function(key, value)
    writer:write(("---@alias %s %s"):format(key, value) .. "\n")
  end)
  writer:close()
end

function M.commands()
  local writer = Writer("cmd")
  Util.for_each(Docs.commands(), function(cmd, desc)
    writer:write(Annotations.comment(desc) .. "\n")
    if Annotations.is_keyword(cmd) then
      writer:write(("vim.cmd[%q] = function(...)end"):format(cmd) .. "\n\n")
    else
      writer:write(("function vim.cmd.%s(...)end"):format(cmd) .. "\n\n")
    end
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

function M.uv()
  local writer = Writer("uv")
  writer:write(Util.fetch("https://raw.githubusercontent.com/Bilal2453/luvit-meta/main/library/uv.lua"))
end

function M.lpeg()
  local writer = Writer("lpeg")
  writer:write(Util.fetch("https://raw.githubusercontent.com/LuaCATS/lpeg/main/library/lpeg.lua"))
end

function M.build()
  M.clean()
  M.uv()
  M.lpeg()

  M.alias()
  M.commands()

  Options.build()

  M.api()

  -- M.write("luv", Docs.luv())
  M.write("lua", Docs.lua())
  M.write("vim.fn", Docs.functions())
end

M.build()

return M
