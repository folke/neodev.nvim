local util = require("lua-dev.util")

local M = {}

function M.setup()
  local opts = require("lua-dev.config").options

  local lsputil = require("lspconfig.util")
  local hook = lsputil.add_hook_after
  lsputil.on_setup = hook(lsputil.on_setup, function(config)
    if opts.setup_jsonls and config.name == "jsonls" then
      M.setup_jsonls(config)
    end
    if config.name == "sumneko_lua" then
      config.on_new_config = hook(config.on_new_config, M.on_new_config)
    end
  end)
end

function M.setup_jsonls(config)
  local schemas = config.settings.json and config.settings.json.schemas or {}
  table.insert(schemas, {
    name = "Sumneko Lua Settings",
    url = "https://raw.githubusercontent.com/sumneko/vscode-lua/master/setting/schema.json",
    fileMatch = { ".luarc.json", ".luarc.jsonc" },
  })
  config.settings = vim.tbl_deep_extend("force", config.settings, {
    json = {
      schemas = schemas,
      validate = {
        enable = true,
      },
    },
  })
end

function M.on_new_config(config, root_dir)
  -- don't do anything when old style setup was used
  if config.settings.legacy then
    return
  end

  ---@type string[]
  local lua_dirs = vim.tbl_filter(function(dir)
    return util.exists(dir)
  end, vim.fn.glob(root_dir .. "/**/lua", false, true))

  local opts = require("lua-dev.config").merge()

  opts.library.enabled = util.is_nvim_config(root_dir)

  if not opts.library.enabled and #lua_dirs > 0 then
    opts.library.enabled = true
    opts.library.plugins = false
  end

  pcall(function()
    opts = require("neoconf").get("lua-dev", opts, { file = root_dir })
  end)

  pcall(opts.override, root_dir, opts.library)

  local library = config.settings
      and config.settings.Lua
      and config.settings.Lua.workspace
      and config.settings.Lua.workspace.library
    or {}

  local ignoreDir = config.settings
      and config.settings.Lua
      and config.settings.Lua.workspace
      and config.settings.Lua.workspace.ignoreDir
    or {}

  if opts.library.enabled then
    config.settings = vim.tbl_deep_extend(
      "force",
      config.settings or {},
      require("lua-dev.sumneko").setup(opts, config.settings).settings
    )
    for _, lib in ipairs(library) do
      table.insert(config.settings.Lua.workspace.library, lib)
    end

    if require("lua-dev.config").options.experimental.pathStrict then
      for _, lib in ipairs(lua_dirs) do
        table.insert(config.settings.Lua.workspace.library, lib)
      end
    end

    for _, dir in ipairs(ignoreDir) do
      table.insert(config.settings.Lua.workspace.ignoreDir, dir)
    end
  end
end

return M
