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

---@return string, string[]
function M.strip_tags(str)
  local tags = {}
  return str
    :gsub(
      "(%*%S-%*)",
      ---@param tag string
      function(tag)
        tag = tag:sub(2, -2)
        table.insert(tags, tag)
        return ""
      end
    )
    :gsub("%s*$", ""),
    tags
end

function M.options()
  local ret = {}

  ---@type string
  local option = nil
  for _, line in ipairs(M.read("options")) do
    line = M.strip_tags(line)
    local name, _, doc = line:match("^'(%S-)'%s*('%S-')%s*(.*)")
    if not name then
      name, doc = line:match("^'(%S-)'%s*(.*)")
    end
    if name then
      option = name
      ret[option] = doc
    elseif option and line:find("^\t") then
      if ret[option] then
        ret[option] = ret[option] .. "\n" .. line
      else
        ret[option] = line
      end
    end
  end
  return ret
end

function M.lua()
  ---@type table<string, ApiFunction>
  local ret = {}

  ---@type string[], string[]
  local tags, line_tags

  ---@type string[]
  local content = {}

  local function save()
    if tags then
      for _, tag in ipairs(tags) do
        if tag:find("vim.*%(%)$") then
          tag = tag:sub(1, -2)
          local doc = table.concat(content, "\n")
          doc = doc:gsub("^%S-%(", tag .. "(")
          local parse = M.parse_signature(doc)
          if parse then
            local name = parse.name
            ret[name] = {
              name = name,
              fqname = name,
              params = parse.params,
              doc = parse.doc,
              ["return"] = {},
            }
          end
        end
      end
    end
    content = {}
    tags = {}
  end

  ---@type string
  for _, line in ipairs(M.read("lua")) do
    line, line_tags = M.strip_tags(line)
    if #line_tags > 0 then
      save()
      tags = line_tags
      line = vim.trim(line)
      if #line > 0 then
        content = { line }
      end
    else
      table.insert(content, line)
    end
  end
  save()

  for k, v in pairs(ret) do
    local real_fn = vim.tbl_get(_G, unpack(vim.split(k, ".", { plain = true })))
    if type(real_fn) == "function" then
      local info = debug.getinfo(real_fn, "S")
      if info.what == "Lua" then
        ret[k] = nil
      end
    elseif type(real_fn) == "table" then
      ret[k] = nil
    end
    if not real_fn then
      ret[k] = nil
    end
  end
  return ret
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
      local parse = M.parse_signature(line)
      if parse then
        local name = parse.name
        ret[name] = {
          name = name,
          params = parse.params,
          doc = parse.doc,
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

---@return {name: string, params: {name:string, optional?:boolean}[], doc: string}?
function M.parse_signature(line)
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

    return { name = name, params = params, doc = doc }
  end
end
dumpp(M.lua())

return M
