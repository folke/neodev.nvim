local Config = require("lua-dev.config")

local M = {}

function M.library()
  local ret = {}

  if Config.options.library.types then
    ret[M.types()] = true
  end

  local function add(lib, filter)
    for _, p in pairs(vim.fn.expand(lib .. "/lua", false, true)) do
      p = vim.loop.fs_realpath(p)
      if p then
        -- p = vim.fn.fnamemodify(p, ":h")
        local skip = false
        if type(filter) == "table" then
          local name = vim.fn.fnamemodify(p, ":t")
          skip = true
          for _, f in pairs(filter) do
            if name == f then
              skip = false
              break
            end
          end
        end
        if not skip then
          ret[p] = true
        end
      end
    end
  end

  if Config.options.library.vimruntime then
    add("$VIMRUNTIME")
  end

  if Config.options.library.plugins then
    for _, site in pairs(vim.split(vim.o.packpath, ",")) do
      add(site .. "/pack/*/opt/*", Config.options.library.plugins)
      add(site .. "/pack/*/start/*", Config.options.library.plugins)
    end
  end

  return ret
end

function M.path()
  local path = {} --vim.split(package.path, ";")
  table.insert(path, "lua/?.lua")
  table.insert(path, "lua/?/init.lua")
  for lib, _ in pairs(M.library()) do
    -- table.insert(path, lib .. "/?.lua")
    -- table.insert(path, lib .. "/?/init.lua")
  end
  return path
end

function M.config_path()
  return vim.loop.fs_realpath(vim.fn.stdpath("config"))
end

function M.types()
  local f = debug.getinfo(1, "S").source:sub(2)
  return vim.loop.fs_realpath(vim.fn.fnamemodify(f, ":h:h:h") .. "/types")
end

function M.setup()
  local path = M.path()
  local library = M.library()
  return {
    on_new_config = function(config, root_dir)
      local lib = vim.tbl_deep_extend("force", {}, library)
      lib[vim.loop.fs_realpath(root_dir) .. "/lua"] = nil
      lib[vim.loop.fs_realpath(root_dir)] = nil
      config.settings.Lua.workspace.library = lib
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
        completion = { callSnippet = "Replace" },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        -- hint = { enable = true },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = library,
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
