local M = {}

local function setup_settings(config)
  pcall(function()
    require("settings.plugins").register({
      get_schema = function()
        local ret = require("settings.schema").plugin_schema("lua-dev.nvim", config.defaults, "Settings for lua-dev")
        ret.properties["lua-dev.nvim"].properties.library.properties.plugins = {
          description = "true/false or an array of plugin names to enable",
          anyOf = {
            { type = "boolean" },
            { type = "array", items = { type = "string" } },
          },
        }
        return ret
      end,
    })
  end)
end

function M.setup(opts)
  local config = require("lua-dev.config")
  config.setup(opts)
  require("lua-dev.lsp").setup()
  local ret = require("lua-dev.sumneko").setup()

  setup_settings(config)

  -- leave this for now for backward compatibility
  ret.settings.legacy = true
  ---@diagnostic disable-next-line: undefined-field
  return vim.tbl_deep_extend("force", {}, ret, config.options.lspconfig or {})
end

return M
