local Config = require("lua-dev.config")

local S = {}

function S.get(opts)
  local M = {}

  function M.library()
    local ret = {}

    if opts.library.types then
      ret[M.types()] = true
    end

    local function add(lib, filter)
      for _, p in pairs(vim.fn.expand(lib .. "/lua", false, true)) do
        p = vim.loop.fs_realpath(p)
        if p then
          -- p = vim.fn.fnamemodify(p, ":h")
          local skip = false
          if type(filter) == "table" then
            local name = vim.fn.fnamemodify(p, ":h:t")
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

    if opts.library.vimruntime then
      add("$VIMRUNTIME")
    end

    if opts.library.plugins then
      for _, site in pairs(vim.split(vim.o.packpath, ",")) do
        add(site .. "/pack/*/opt/*", opts.library.plugins)
        add(site .. "/pack/*/start/*", opts.library.plugins)
      end
    end

    return ret
  end

  function M.path()
    local path = {} --vim.split(package.path, ";")
    table.insert(path, "lua/?.lua")
    table.insert(path, "lua/?/init.lua")
    -- for lib, _ in pairs(M.library()) do
    -- table.insert(path, lib .. "/?.lua")
    -- table.insert(path, lib .. "/?/init.lua")
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

  function M.setup()
    local path = M.path()
    return {
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
            -- Setup your lua path
            path = path,
          },
          completion = { callSnippet = "Replace" },
          -- diagnostics = {
          --   -- Get the language server to recognize the `vim` global
          --   globals = { "vim" },
          -- },
          -- hint = { enable = true },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = M.library(),
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
end

S = vim.tbl_deep_extend("force", S, S.get(Config.options))

return S
