local M = {}

local function setup_settings(config)
  pcall(function()
    require("neoconf.plugins").register({
      on_schema = function(schema)
        schema:import("lua-dev", config.defaults)
        schema:set("lua-dev.library.plugins", {
          description = "true/false or an array of plugin names to enable",
          anyOf = {
            { type = "boolean" },
            { type = "array", items = { type = "string" } },
          },
        })
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
