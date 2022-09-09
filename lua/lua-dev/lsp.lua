local util = require("lua-dev.util")

local M = {}

function M.setup()
  local lsputil = require("lspconfig.util")
  local hook = lsputil.add_hook_after
  lsputil.on_setup = hook(lsputil.on_setup, function(config)
    if config.name == "sumneko_lua" then
      config.on_new_config = hook(config.on_new_config, M.on_new_config)
    end
  end)
end

function M.on_new_config(config, root_dir)
  -- don't do anything when old style setup was used
  if config.settings.legacy then
    return
  end

  local opts = require("lua-dev.config").merge()

  opts.library.enabled = util.is_nvim_config(root_dir)

  if not opts.library.enabled and util.is_plugin(root_dir) then
    opts.library.enabled = true
    opts.library.plugins = false
  end

  pcall(function()
    opts = require("settings").get("lua-dev.nvim", opts, { file = root_dir })
  end)

  pcall(opts.override, root_dir, opts.library)

  local library = config.settings
      and config.settings.Lua
      and config.settings.Lua.workspace
      and config.settings.Lua.workspace.library
    or {}

  if opts.library.enabled then
    config.settings =
      vim.tbl_deep_extend("force", config.settings or {}, require("lua-dev.sumneko").setup(opts).settings)
    for _, lib in ipairs(library) do
      table.insert(config.settings.Lua.workspace.library, lib)
    end
  end
end

return M
