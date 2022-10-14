local M = {}

local function neoconf(config)
  pcall(function()
    require("neoconf.plugins").register({
      on_schema = function(schema)
        schema:import("neodev", config.defaults)
        schema:set("neodev.library.plugins", {
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

---@param opts LuaDevOptions
function M.setup(opts)
  local config = require("neodev.config")
  config.setup(opts)
  require("neodev.lsp").setup()

  neoconf(config)

  -- leave this for now for backward compatibility
  local ret = require("neodev.sumneko").setup()
  ret.settings.legacy = true
  ---@diagnostic disable-next-line: undefined-field
  return vim.tbl_deep_extend("force", {}, ret, config.options.lspconfig or {})
end

return M
