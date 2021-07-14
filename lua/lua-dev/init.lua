local M = {}

function M.setup(opts)
  local config = require("lua-dev.config")
  config.setup(opts)
  M.setup_workspace()
  local ret = require("lua-dev.sumneko").setup()
  return vim.tbl_deep_extend("force", {}, ret, config.options.lspconfig or {})
end

function M.setup_workspace()
  local ok, workspace = pcall(require, "workspace")
  if not ok then
    return
  end
  local config = require("lua-dev.config")
  local sumneko = require("lua-dev.sumneko")
  workspace.register({
    name = "lua-dev",

    get_schema = function()
      return require("workspace.schema").to_schema({ ["lua-dev"] = config.defaults })
    end,

    ---@param ws Workspace
    on_workspace_settings = function(ws)
      local local_settings = ws.local_settings

      -- merge global lua-dev options with workspace options
      local opts = ws.settings:get("lua-dev", { defaults = config.options })

      -- enable lua-dev if:
      -- * this is a lua file part of your nvim config
      -- * this is a workspace that has a lua folder (so most likely a plugin)
      -- * the local workspace settings have lua-dev.enabled = true
      local is_vim_config = ws:has_file(sumneko.config_path())
      local enabled = is_vim_config or ws:has_file(ws.root_dir .. "/lua") or local_settings:get("lua-dev.enabled")

      if enabled then
        -- enable plugins by default only for nvim configs
        if not is_vim_config and not local_settings:get("lua-dev.library.plugins") then
          opts.library.plugins = false
        end
        local settings = sumneko.get(opts).setup().settings
        ws.settings:merge(settings, "lspconfig." .. opts.config_name .. ".settings")
      end
    end,
  })
end

return M
