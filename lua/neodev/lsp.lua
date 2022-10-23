local util = require("neodev.util")

local M = {}

function M.setup()
  local opts = require("neodev.config").options

  local lsputil = require("lspconfig.util")
  local hook = lsputil.add_hook_after
  lsputil.on_setup = hook(lsputil.on_setup, function(config)
    if opts.setup_jsonls and config.name == "jsonls" then
      M.setup_jsonls(config)
    end
    if config.name == "sumneko_lua" then
      config.on_new_config = hook(config.on_new_config, M.on_new_config)
      -- config.before_init = hook(config.before_init, M.before_init)
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

---@return string[]
function M.get_lua_dirs(root_dir)
  ---@type table<string, boolean>
  local lua_dirs = {}

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local name = vim.api.nvim_buf_get_name(buf) or ""
    local lua_dir = name:match("^(.*/lua/)")
    if lua_dir and util.has_file(root_dir, lua_dir) then
      lua_dirs[lua_dir] = true
    end
  end

  lua_dirs = vim.tbl_keys(lua_dirs)

  table.insert(lua_dirs, "../lua")

  lua_dirs = vim.tbl_map(function(f)
    return util.fqn(f)
  end, lua_dirs)

  ---@type string[]
  return vim.tbl_filter(function(dir)
    return dir and util.exists(dir)
  end, lua_dirs)
end

function M.before_init(params, config)
  M.on_new_config(config, params.rootPath)
end

function M.on_new_config(config, root_dir)
  -- don't do anything when old style setup was used
  if config.settings.legacy then
    util.warn(
      "You're using the old way of setting up neodev (previously lua-dev).\nPlease check the docs at https://github.com/folke/neodev.nvim#-setup"
    )
    return
  end

  local lua_dirs = M.get_lua_dirs(root_dir)

  local opts = require("neodev.config").merge()

  opts.library.enabled = util.is_nvim_config(root_dir)

  if not opts.library.enabled and #lua_dirs > 0 then
    opts.library.enabled = true
    opts.library.plugins = false
  end

  pcall(function()
    opts = require("neoconf").get("neodev", opts, { file = root_dir })
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
      require("neodev.sumneko").setup(opts, config.settings).settings
    )
    for _, lib in ipairs(library) do
      table.insert(config.settings.Lua.workspace.library, lib)
    end

    if require("neodev.config").options.experimental.pathStrict then
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
