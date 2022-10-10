local util = require("lua-dev.util")
local M = {}

---@param name string
function M.read(name)
  local docs = vim.fn.expand("$VIMRUNTIME/doc", false, false)
  local txtfile = docs .. "/" .. name .. ".txt"

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

---@param name string
---@param opts { pattern: string, continuation?: string, context?: number}
function M.parse(name, opts)
  opts = opts or {}
  opts.continuation = opts.continuation or "^[%s<>]"
  opts.context = opts.context or 1

  local tags = {}
  local line_tags = {}
  local chunk_tags = {}
  local chunk_match = {}
  local chunk = {}
  ---@type {tags:string[], text:string}[]
  local ret = {}

  local function save()
    if #chunk > 0 then
      table.insert(ret, {
        tags = chunk_tags,
        text = table.concat(chunk, "\n"),
        match = chunk_match,
      })
    end
    chunk = {}
    chunk_tags = {}
  end
  local lines = M.read(name)
  for l, line in ipairs(lines) do
    line, line_tags = M.strip_tags(line)

    if #line_tags > 0 then
      tags = line_tags
    end

    local context = line
    for c = 1, opts.context do
      if lines[l + c] then
        context = line .. "\n" .. lines[l + c]
      end
    end

    local match = { context:match(opts.pattern) }

    if #match > 0 then
      save()
      chunk_match = match
      chunk_tags = vim.deepcopy(tags)
      table.insert(chunk, line)
    elseif #chunk > 0 and (line:find(opts.continuation) or line:find("^%s*$")) then
      table.insert(chunk, line)
    else
      save()
    end
  end
  return ret
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

M.function_pattern = "^(%S-%(.-%))"
M.function_signature_pattern = "^(%S-)%((.-)%)"
M.vim_type_map = {
  number = "number",
  float = "float",
  string = "string",
  list = "any[]",
  any = "any",
  funcref = "fun()",
  dict = "table<string, any>",
  none = "nil",
  set = "table",
  boolean = "boolean",
}

---@return table<string, VimFunction>
function M.functions()
  ---@type table<string, VimFunction>
  local ret = {}

  local builtins = M.parse("builtin", { pattern = M.function_pattern })

  ---@type table<string, string>
  local retvals = {}

  for _, builtin in ipairs(builtins) do
    if vim.tbl_contains(builtin.tags, "builtin-function-list") then
      local text = builtin.text
      -- replace any whitespace after the function by a tab character
      text = text:gsub(M.function_pattern .. "%s+", "%1\t")
      -- replace consecutive whitespace by tabs
      text = text:gsub("%s%s+", "\t")
      ---@type string, string, string
      local name, _args, retval = text:match(M.function_signature_pattern .. "\t(%w+)")
      if name then
        retval = retval:lower()
        if M.vim_type_map[retval] then
          retval = M.vim_type_map[retval]
          if retval ~= "nil" then
            retvals[name] = retval
          end
        else
          util.debug(retval)
        end
      else
        util.error("Couldnt parse builtin-function-list: " .. vim.inspect(builtin))
      end
    else
      local parse = M.parse_signature(builtin.text)
      if parse then
        local name = parse.name
        ret[name] = {
          name = name,
          params = parse.params,
          doc = parse.doc,
          ["return"] = retvals[name],
        }
      end
    end
  end

  return ret
end

---@return {name: string, params: {name:string, optional?:boolean}[], doc: string}?
function M.parse_signature(line)
  ---@type string, string, string
  local name, sig, doc = line:match(M.function_signature_pattern .. "%s*(.*)")
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

return M
