local M = {}

--- @class LuaApiOptions
M.defaults = {
  library = {
    vimruntime = true, -- runtime path
    vimconfig = true, -- typically ~/.config/nvim
    types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
    plugins = true, -- installed opt or start plugins in packpath
    -- you can also specify the list of plugins to make available as a workspace library
    -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
  },
}

--- @type LuaApiOptions
M.options = {}

function M.setup(options)
  M.options = vim.tbl_deep_extend("force", {}, M.defaults, options or {})
end

return M
