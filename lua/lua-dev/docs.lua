local config = require("lua-dev.config")

local M = {}

---@param name string
function M.read(name)
  local txtfile = config.runtime() .. "/doc/" .. name .. ".txt"

  ---@type string[]
  local lines = {}
  for line in io.lines(txtfile) do
    table.insert(lines, line)
  end
  return lines
end

---@return string
function M.strip_tags(str)
  return str
    :gsub(
      "(%*%S-%*)",
      ---@param tag string
      function(tag)
        tag = tag:sub(2, -2)
        return ""
      end
    )
    :gsub("%s*$", "")
end
