local M = {}

function M.setup(opts)
  local config = require("lua-dev.config")
  config.setup(opts)
  local ret = require("lua-dev.sumneko").setup()
  return vim.tbl_deep_extend("force", {}, ret, config.options.lspconfig or {})
end

return M
