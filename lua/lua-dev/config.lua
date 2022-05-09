local M = {}

--- @class LuaApiOptions
M.defaults = {
  config_name = "sumneko_lua", -- name of the lspconfig config
  library = {
    vimruntime = true, -- runtime path
    types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
    plugins = true, -- installed opt or start plugins in packpath
    -- you can also specify the list of plugins to make available as a workspace library
    -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
  },
  runtime_path = false, -- enable this to get completion in require strings. Slow!
  -- pass any additional options that will be merged in the final lsp config
  snippet = true,
  lspconfig = {
    -- cmd = {"lua-language-server"}
  },
}

--- @type LuaApiOptions
M.options = {}

function M.setup(options)
  M.options = vim.tbl_deep_extend("force", {}, M.defaults, options or {})
end

return M
