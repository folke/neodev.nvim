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

---@class VimFunction
---@field name string
---@field doc string
---@field return? string
---@field params {name: string, optional?: boolean}[]

---@return table<string, VimFunction>
function M.functions()
  ---@type table<string, VimFunction>
  local ret = {}

  local builtin = M.read("builtin")

  ---@type table<string, string>
  local retvals = {}

  local in_list = false
  local in_details = false
  ---@type string?
  local last = nil
  for _, line in ipairs(builtin) do
    if line:find("*builtin-function-list", 1, true) then
      in_list = true
    elseif line:find("*builtin-function-details", 1, true) then
      in_details = true
      in_list = false
      last = nil
    end

    line = M.strip_tags(line)

    if in_list then
      local name, retval = line:match("^(%S+)%([^\t]*%)%s+([^\t]+)\t+.*$")
      if retval then
        retvals[name] = retval
      elseif last then
        name, retval = (last .. line):match("^(%S+)%([^\t]*%)\t+([^\t]+)\t+.*$")
        if retval then
          retvals[name] = retval
        else
          last = line
        end
      else
        last = line
      end
    elseif in_details then
      ---@type string, string, string
      local name, sig, doc = line:match("^(%S-)%((.-)%)%s*(.*)")
      if name then
        -- Parse args
        local optional = sig:find("%[")
        local params = {}
        local from = 0
        local to = 0
        local param = ""
        while from do
          from, to, param = sig:find("{(%S-)}", to)
          if from then
            table.insert(params, {
              name = param,
              optional = optional and from > optional and true or nil,
            })
          end
        end

        -- Parse return type

        ret[name] = {
          name = name,
          params = params,
          doc = doc,
          ["return"] = retvals[name],
        }
        last = name
      elseif last then
        if ret[last].doc == "" then
          ret[last].doc = line
        else
          ret[last].doc = ret[last].doc .. "\n" .. line
        end
      end
    end
  end

  return ret
end

return M
