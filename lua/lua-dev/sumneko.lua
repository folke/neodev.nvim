local Config = require("lua-dev.config")

local M = {}

function M.library(opts)
  opts = opts or Config.options
  local ret = {}

  if opts.library.types then
    ret[M.types()] = true
  end

  local function add(lib, filter)
    for _, p in pairs(vim.fn.expand(lib .. "/lua", false, true)) do
      p = vim.loop.fs_realpath(p)
      if p and (not filter or filter[vim.fn.fnamemodify(p, ":h:t")]) then
        ret[p] = true
      end
    end
  end

  if opts.library.vimruntime then
    add("$VIMRUNTIME")
  end

  if opts.library.plugins then
    local filter
    if type(opts.library.plugins) == "table" then
      filter = {}
      for _, p in pairs(opts.library.plugins) do
        filter[p] = true
      end
    end
    for _, site in pairs(vim.split(vim.o.packpath, ",")) do
      add(site .. "/pack/*/opt/*", filter)
      add(site .. "/pack/*/start/*", filter)
    end
  end

  return ret
end

function M.path(opts)
  local path = {} --vim.split(package.path, ";")
  table.insert(path, "?.lua")
  table.insert(path, "?/init.lua")
  -- if opts and opts.runtime_path then
  --   for lib, _ in pairs(M.library()) do
  --     table.insert(path, lib .. "/?.lua")
  --     table.insert(path, lib .. "/?/init.lua")
  --   end
  -- end
  return path
end

function M.config_path()
  return vim.loop.fs_realpath(vim.fn.stdpath("config"))
end

function M.types()
  local f = debug.getinfo(1, "S").source:sub(2)
  return vim.loop.fs_realpath(vim.fn.fnamemodify(f, ":h:h:h") .. "/types")
end

function M.setup(opts)
  local lspconfig = require("lspconfig")
  return {
    on_new_config = lspconfig.util.add_hook_after(
      lspconfig.util.default_config.on_new_config,
      function(config, root_dir)
        -- remove the root_dir from the workspace, otherwise diagnostics break. See #21
        -- Should no longer be needed with workspace.nvim
        local lib = vim.tbl_deep_extend("force", {}, config.settings.Lua.workspace.library)
        lib[vim.loop.fs_realpath(root_dir) .. "/lua"] = nil
        lib[vim.loop.fs_realpath(root_dir)] = nil
        config.settings.Lua.workspace.library = lib
        return config
      end
    ),
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = M.path(),
        },
        completion = { callSnippet = "Replace" },
        -- diagnostics = {
        --   -- Get the language server to recognize the `vim` global
        --   globals = { "vim" },
        -- },
        -- hint = { enable = true },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = M.library(opts),
          maxPreload = 1000,
          preloadFileSize = 150,
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = { enable = false },
      },
    },
  }
end

return M
