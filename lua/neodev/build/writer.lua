local config = require("neodev.config")

---@class AnnotationWriter
---@field name string
---@field fd? number
---@field fnum number
---@field size number
local M = {}
M.__index = M

M.MAX_SIZE = 1024 * 200

---@return AnnotationWriter
function M.new(name)
  local self = setmetatable({}, M)
  self.name = name
  self.size = 0
  self.fnum = 0
  return self
end

function M:close()
  if self.fd then
    vim.loop.fs_close(self.fd)
  end
end

function M:check()
  if not self.fd or self.size > M.MAX_SIZE then
    self:close()
    local types = config.types()
    local fname = types .. "/" .. self.name
    if self.fnum > 0 then
      fname = fname .. "." .. self.fnum
    end
    self.fd = vim.loop.fs_open(fname .. ".lua", "w+", 420)
    self.fnum = self.fnum + 1
    self.size = 0
    self:intro()
  end
end

function M:intro()
  self:write("---@meta\n\n")
end

function M:write(text)
  self:check()
  vim.loop.fs_write(self.fd, text, -1)
  self.size = self.size + #text
end

return M.new
