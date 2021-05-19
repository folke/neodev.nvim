local M = {}

function M.setup(opts)
  require("lua-dev.config").setup(opts)
  return require("lua-dev.sumneko").setup()
end

return M
