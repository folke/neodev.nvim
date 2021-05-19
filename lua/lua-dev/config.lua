local M = {}

--- @class LuaApiOptions
M.defaults = {
  library = {
    vimruntime = true, -- runtime path
    vimconfig = true, -- typically ~/.config/nvim
    plugins = true, -- installed opt or start plugins in packpath
    types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
  },
}

--- @type LuaApiOptions
M.options = {}

function M.setup(options)
  M.options = vim.tbl_deep_extend("force", {}, M.defaults, options or {})
end

return M
