local config = require("lua-dev.config")
local M = {}

function M.fqn(fname)
  fname = vim.fn.fnamemodify(fname, ":p")
  return vim.loop.fs_realpath(fname) or fname
end

function M.exists(fname)
  local stat = vim.loop.fs_stat(fname)
  return (stat and stat.type) or false
end

---@param root_dir string
---@param file string
function M.has_file(root_dir, file)
  root_dir = M.fqn(root_dir)
  file = M.fqn(file)
  return M.exists(file) and file:find(root_dir, 1, true) == 1
end

function M.config_path()
  return vim.loop.fs_realpath(vim.fn.stdpath("config"))
end

function M.is_plugin(path)
  return M.fqn(path):find("/lua[/$]") ~= nil or M.has_file(path, path .. "/lua")
end

function M.is_nvim_config(path)
  return M.has_file(M.fqn(path), M.config_path())
end

function M.debug(msg)
  if config.options.debug then
    M.error(msg)
  end
end

function M.error(msg)
  vim.notify_once(msg, vim.log.levels.ERROR, { title = "lua-dev.nvim" })
end

return M
