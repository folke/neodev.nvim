---@class vim.loop.Timer
---@field start fun(timer:vim.loop.Timer, timeout:integer, repeat:integer, callback:fun())
---@field stop fun(timer:vim.loop.Timer)

return {
  ["vim.loop.new_timer"] = {
    ["return"] = { {
      ["type"] = "vim.loop.Timer",
    } },
  },
}
