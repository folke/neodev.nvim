local M = {}

--- @class LuaApiOptions
M.defaults = {
  library = {
    -- these settings will be used for your neovim config directory
    runtime = true, -- runtime path
    types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
    plugins = true, -- installed opt or start plugins in packpath
    -- you can also specify the list of plugins to make available as a workspace library
    -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
  },
  plugin_library = {
    -- these settings will be used for plugins (root dirs containing a /lua directory)
    runtime = true,
    types = true,
    -- disable other plugins by default
    plugins = false,
  },
}

--- @type LuaApiOptions
M.options = {}

function M.setup(options)
  M.options = vim.tbl_deep_extend("force", {}, M.defaults, options or {})

  -- legacy config
  if M.options.library.vimruntime ~= nil then
    M.options.library.runtime = M.options.library.vimruntime
  end
end

---@return LuaApiOptions
function M.merge(options)
  return vim.tbl_deep_extend("force", {}, M.options, options or {})
end

return M
