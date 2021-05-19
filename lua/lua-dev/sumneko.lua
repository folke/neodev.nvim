local Config = require("lua-dev.config")

local M = {}

function M.library()
  local ret = {}

  if Config.options.library.types then
    ret[M.types()] = true
  end

  local function add(lib)
    for _, p in pairs(vim.fn.expand(lib .. "/lua", false, true)) do
      p = vim.loop.fs_realpath(p)
      if p then
        p = vim.fn.fnamemodify(p, ":h")
        ret[p] = true
      end
    end
  end

  if Config.options.library.vimruntime then
    add("$VIMRUNTIME")
  end

  if Config.options.library.vimconfig then
    add(M.config_path())
  end

  if Config.options.library.plugins then
    for _, site in pairs(vim.split(vim.o.packpath, ",")) do
      add(site .. "/pack/*/opt/*")
      add(site .. "/pack/*/start/*")
    end
  end

  return ret
end

function M.path()
  local path = vim.split(package.path, ";")
  table.insert(path, "lua/?.lua")
  table.insert(path, "lua/?/init.lua")
  return path
end

function M.config_path()
  return vim.loop.fs_realpath(vim.fn.stdpath("config"))
end

function M.types()
  local f = debug.getinfo(1, "S").source:sub(2)
  return vim.loop.fs_realpath(f .. "/../../../types")
end

function M.setup()
  local library
  local path = M.path()

  return {
    on_new_config = function(config, root)
      if not library then
        library = M.library()
      end

      root = vim.loop.fs_realpath(root)
      -- delete root from workspace to make sure we don't trigger duplicate warnings
      local libs = vim.tbl_deep_extend("force", {}, library)
      libs[root] = nil
      config.settings.Lua.workspace.library = libs
      return config
    end,
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = path,
        },
        -- completion = { callSnippet = "Both" },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {},
          maxPreload = 2000,
          preloadFileSize = 150,
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = { enable = false },
      },
    },
  }
end

return M
