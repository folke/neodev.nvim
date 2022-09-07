local M = {}

function M.setup(opts)
  local config = require("lua-dev.config")
  config.setup(opts)
  require("lua-dev.lsp").setup()
  local ret = require("lua-dev.sumneko").setup()

  -- leave this for now for backward compatibility
  ret.settings.legacy = true
  ---@diagnostic disable-next-line: undefined-field
  return vim.tbl_deep_extend("force", {}, ret, config.options.lspconfig or {})
end

return M
