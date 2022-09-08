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

  local enabled = util.is_nvim_config(root_dir)

  if not enabled and util.is_plugin(root_dir) then
    enabled = true
    opts.library = opts.plugin_library
  end

  local library = {}

  if
    config.settings
    and config.settings.Lua
    and config.settings.Lua.workspace
    and config.settings.Lua.workspace.library
  then
    for _, lib in ipairs(config.settings.Lua.workspace.library) do
      -- Handle special workspace libraries
      if lib:match("^nvim:?.*$") then
        enabled = true
        lib = lib:gsub("^nvim:?", "")
        if lib == "" then
          opts.library.runtime = true
          opts.library.types = true
        elseif lib == "plugins" then
          opts.library.plugins = true
        elseif lib == "types" then
          opts.library.types = true
        elseif lib == "runtime" then
          opts.library.runtime = true
        else
          if type(opts.library.plugins) ~= "table" then
            opts.library.plugins = {}
          end
          table.insert(opts.library.plugins, lib)
        end
      else
        table.insert(library, lib)
      end
    end
  end

  if enabled then
    config.settings =
      vim.tbl_deep_extend("force", config.settings or {}, require("lua-dev.sumneko").setup(opts).settings)
    for _, lib in ipairs(library) do
      table.insert(config.settings, lib)
    end
  end
end

return M
