local config = require("lua-dev.config")

local M = {}

function M.library(opts)
  opts = config.merge(opts)
  local ret = {}

  if opts.library.types then
    table.insert(ret, M.types())
  end

  local function add(lib, filter)
    ---@diagnostic disable-next-line: param-type-mismatch
    for _, p in pairs(vim.fn.expand(lib .. "/lua", false, true)) do
      p = vim.loop.fs_realpath(p)
      if p and (not filter or filter[vim.fn.fnamemodify(p, ":h:t")]) then
        table.insert(ret, vim.fn.fnamemodify(p, ":h"))
      end
    end
  end

  if opts.library.runtime then
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

function M.path()
  return {
    "lua/?.lua",
    "lua/?/init.lua",
  }
end

function M.types()
  local f = debug.getinfo(1, "S").source:sub(2)
  return vim.loop.fs_realpath(vim.fn.fnamemodify(f, ":h:h:h") .. "/types")
end

function M.setup(opts)
  opts = config.merge(opts)
  return {
    ---@type Settings.sumneko_lua
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
          path = M.path(),
        },
        ---@diagnostic disable-next-line: undefined-field
        completion = opts.snippet and { callSnippet = "Replace" } or nil,
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = M.library(opts),
        },
      },
    },
  }
end

return M
