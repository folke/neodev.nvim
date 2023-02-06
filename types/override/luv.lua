---@class vim.loop.Timer
---@field start fun(timer:vim.loop.Timer, timeout:integer, repeat:integer, callback:fun())
---@field stop fun(timer:vim.loop.Timer)

---@class vim.loop.Handle
local Handle = {}
function Handle:close() end
---@return boolean
function Handle:is_closing() end
---@return boolean
function Handle:is_active() end

---@class vim.loop.Pipe: vim.loop.Handle

---@class vim.loop.Check
local Check = {}
---@param fn fun()
function Check:start(fn) end
function Check:stop() end

---@class vim.loop.Process: vim.loop.Handle

return {
  ["vim.loop.new_timer"] = {
    ["return"] = { {
      ["type"] = "vim.loop.Timer",
    } },
  },
  ["vim.loop.new_pipe"] = {
    ["return"] = { {
      ["type"] = "vim.loop.Pipe",
    } },
  },
  ["vim.loop.new_check"] = {
    ["return"] = { {
      ["type"] = "vim.loop.Check",
    } },
  },
  ["vim.loop.spawn"] = {
    ["return"] = { {
      ["type"] = "vim.loop.Process",
    } },
  },
}
