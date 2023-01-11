local Docs = require("neodev.build.docs")
local Writer = require("neodev.build.writer")
local Annotations = require("neodev.build.annotations")
local Util = require("neodev.util")
local Config = require("neodev.config")

---@class OptionInfo
---@field allows_duplicates boolean
---@field commalist boolean
---@field default any
---@field flaglist boolean
---@field global_local boolean
---@field name string
---@field scope "global" | "win" | "buf"
---@field shortname string
---@field type string

---@alias OptionsInfo table<string, OptionInfo>

local M = {}

M.metatype2lua = {
  map = function(info)
    return ("table<string, %s>"):format(info.type)
  end,
  set = function(info)
    return ("%s[]"):format(info.type)
  end,
  array = function(info)
    return ("%s[]"):format(info.type)
  end,
}

function M.build()
  local writer = Writer("options")

  local docs = Docs.options()

  ---@type OptionsInfo
  local info = vim.api.nvim_get_all_options_info()

  ---@param scope string
  local function write(scope)
    local var = "vim." .. scope:sub(1, 1) .. "o"

    writer:write("---@class " .. var .. "\n")
    writer:write(var .. " = {}\n\n")
    Util.for_each(info, function(name, option)
      if option.scope == scope then
        local default = vim.inspect(option.default)
        local str = ""
        if docs[name] then
          str = str .. Annotations.comment(docs[name]) .. "\n"
        end
        str = str .. ("%s.%s = %s\n"):format(var, name, default)
        if option.shortname ~= "" then
          str = str .. ("%s.%s = %s.%s\n"):format(var, option.shortname, var, name)
        end
        writer:write(str)
      end
    end)
    writer:write("\n\n")
  end

  write("global")
  write("win")
  write("buf")

  -- Write vim.opt
  Util.for_each(info, function(name, option)
    local str = ""
    if docs[name] then
      str = str .. Annotations.comment(docs[name]) .. "\n"
    end
    ---@type string
    local return_type = option.type

    pcall(function()
      ---@diagnostic disable-next-line: no-unknown
      return_type = vim.opt[name]._info.metatype
      if M.metatype2lua[return_type] then
        ---@diagnostic disable-next-line: no-unknown
        return_type = M.metatype2lua[return_type](option)
      end
    end)

    str = str .. ("--- @class vim.opt.%s: vim.Option,%s\n"):format(name, return_type)
    str = str .. ("--- @operator add: vim.opt.%s\n"):format(name)
    str = str .. ("--- @operator sub: vim.opt.%s\n"):format(name)
    str = str .. ("--- @operator pow: vim.opt.%s\n"):format(name)
    str = str .. ("vim.opt.%s = %s\n"):format(name, vim.inspect(option.default))
    if option.shortname ~= "" then
      str = str .. ("vim.opt.%s = vim.opt.%s\n"):format(option.shortname, name)
    end

    str = str .. ("--- @return %s\nfunction vim.opt.%s:get()end\n\n"):format(return_type, name)
    writer:write(str)
  end)

  local code = Util.read_file(Config.root("/types/override/options.lua"))
  writer:write(code .. "\n")

  writer:close()
end

return M
