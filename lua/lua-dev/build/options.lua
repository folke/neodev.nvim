local Docs = require("lua-dev.build.docs")
local Writer = require("lua-dev.build.writer")
local Annotations = require("lua-dev.build.annotations")
local Util = require("lua-dev.util")

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
        local str = ("%s.%s = %q\n"):format(var, name, option.default)
        if docs[name] then
          str = Annotations.comment(docs[name]) .. "\n" .. str
        end
        writer:write(str)
      end
    end)
    writer:write("\n\n")
  end

  write("global")
  write("win")
  write("buf")

  writer:write([[
---@type table<number, vim.go>
vim.go = {}

---@type table<number, vim.bo>
vim.bo = {}

---@type table<number, vim.wo>
vim.wo = {}

---@type vim.go | vim.wo | vim.bo
vim.o = {}

---@type vim.go | vim.wo | vim.bo
vim.opt = {}

---@type vim.go | vim.wo | vim.bo
vim.opt_global = {}

---@type vim.go | vim.wo | vim.bo
vim.opt_local = {}
  ]])

  writer:close()
end

return M
