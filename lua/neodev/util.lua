local config = require("neodev.config")
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

---@return string
function M.config_path()
  return vim.loop.fs_realpath(vim.fn.stdpath("config"))
end

function M.is_plugin(path)
  return M.fqn(path):find("/lua[/$]") ~= nil or M.has_file(path, path .. "/lua")
end

function M.is_nvim_config(path)
  return M.has_file(M.fqn(path), M.config_path()) or M.has_file(M.config_path(), M.fqn(path))
end

function M.keys(tbl)
  local ret = vim.tbl_keys(tbl)
  table.sort(ret)
  return ret
end

---@generic K
---@generic V
---@param tbl table<K, V>
---@param fn fun(key: K, value: V)
function M.for_each(tbl, fn)
  local keys = M.keys(tbl)
  for _, key in ipairs(keys) do
    fn(key, tbl[key])
  end
end

---@param file string
---@param flags? string
---@return string
function M.read_file(file, flags)
  local fd = io.open(file, "r" .. (flags or ""))
  if not fd then
    error(("Could not open file %s for reading"):format(file))
  end
  local data = fd:read("*a")
  fd:close()
  return data
end

function M.write_file(file, data)
  local fd = io.open(file, "w+")
  if not fd then
    error(("Could not open file %s for writing"):format(file))
  end
  fd:write(data)
  fd:close()
end

function M.debug(msg)
  if config.options.debug then
    M.error(msg)
  end
end

function M.error(msg)
  vim.notify_once(msg, vim.log.levels.ERROR, { title = "neodev.nvim" })
end

function M.warn(msg)
  vim.notify_once(msg, vim.log.levels.WARN, { title = "neodev.nvim" })
end

return M
