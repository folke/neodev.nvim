---@class uv
local uv = vim.loop
vim.loop = uv

---@class uv.Timer
---@field start fun(timer:uv.Timer, timeout:integer, repeat:integer, callback:fun())
---@field stop fun(timer:uv.Timer)

---@class uv.Handle
local Handle = {}
function Handle:close() end
---@return boolean
function Handle:is_closing() end
---@return boolean
function Handle:is_active() end

---@class uv.Pipe: uv.Handle

---@class uv.Check
local Check = {}
---@param fn fun()
function Check:start(fn) end
function Check:stop() end

---@class uv.Process: uv.Handle

return {
  ["uv.new_timer"] = {
    ["return"] = { {
      ["type"] = "uv.Timer",
    } },
  },
  ["uv.new_pipe"] = {
    ["return"] = { {
      ["type"] = "uv.Pipe",
    } },
  },
  ["uv.new_check"] = {
    ["return"] = { {
      ["type"] = "uv.Check",
    } },
  },
  ["uv.spawn"] = {
    ["return"] = { {
      ["type"] = "uv.Process",
    } },
  },
}
