--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Gets the current list of tabpage handles.
--- @return any #List of tabpage handles
function vim.api.nvim_list_tabpages() end

-- Gets the current tabpage.
--- @return any #Tabpage handle
function vim.api.nvim_get_current_tabpage() end

-- Sets the current tabpage.
--- @param tabpage tabpage #Tabpage handle
function vim.api.nvim_set_current_tabpage(tabpage) end

-- Creates a new namespace, or gets an existing one.
--- @param name string #Namespace name or empty string
--- @return any #Namespace id
function vim.api.nvim_create_namespace(name) end

-- Gets existing, non-anonymous namespaces.
--- @return any #dict that maps from names to namespace ids.
function vim.api.nvim_get_namespaces() end

-- Pastes at cursor, in any mode.
--- @param phase integer #-1: paste in a single call (i.e. without
---              streaming). To "stream" a paste, call `nvim_paste` sequentially with these `phase` values:
---              • 1: starts the paste (exactly once)
---              • 2: continues the paste (zero or more times)
---              • 3: ends the paste (exactly once)
--- @param data string #Multiline input. May be binary (containing NUL
---              bytes).
--- @param crlf boolean #Also break lines at CR and CRLF.
--- @return any #
---     • true: Client may continue pasting.
---     • false: Client must cancel the paste.
--- 
function vim.api.nvim_paste(data, crlf, phase) end

-- Puts text at cursor, in any mode.
--- @param lines string[] #|readfile()|-style list of lines.
---               |channel-lines|
--- @param type string #Edit behavior: any |getregtype()| result, or:
---               • "b" |blockwise-visual| mode (may include
---                 width, e.g. "b3")
---               • "c" |charwise| mode
---               • "l" |linewise| mode
---               • "" guess by contents, see |setreg()|
--- @param after boolean #If true insert after cursor (like |p|), or
---               before (like |P|).
--- @param follow boolean #If true place cursor at end of inserted text.
function vim.api.nvim_put(lines, type, after, follow) end

-- Returns the 24-bit RGB value of a |nvim_get_color_map()| color
-- name or "#rrggbb" hexadecimal string.
--- @param name string #Color name or "#rrggbb" string
--- @return any #24-bit RGB value, or -1 for invalid argument.
function vim.api.nvim_get_color_by_name(name) end

-- Returns a map of color names and RGB values.
--- @return any #Map of color names and RGB values.
function vim.api.nvim_get_color_map() end

-- Gets a map of the current editor state.
--- @param opts dictionary #Optional parameters.
---             • types: List of |context-types| ("regs", "jumps",
---               "bufs", "gvars", …) to gather, or empty for
---               "all".
--- @return any #map of global |context|.
function vim.api.nvim_get_context(opts) end

-- Tells Nvim the number of elements displaying in the popumenu,
-- to decide <PageUp> and <PageDown> movement.
--- @param height integer #Popupmenu height, must be greater than zero.
function vim.api.nvim_ui_pum_set_height(height) end

-- Gets the current mode. |mode()| "blocking" is true if Nvim is
-- waiting for input.
--- @return any #Dictionary { "mode": String, "blocking": Boolean }
function vim.api.nvim_get_mode() end

-- Gets a list of global (non-buffer-local) |mapping|
-- definitions.
--- @param mode string #Mode short-name ("n", "i", "v", ...)
--- @return any #Array of maparg()-like dictionaries describing mappings.
---     The "buffer" key is always zero.
function vim.api.nvim_get_keymap(mode) end

-- Sets a global |mapping| for the given mode.
--- @param opts dictionary #Optional parameters map. Accepts all
---             |:map-arguments| as keys excluding |<buffer>| but
---             including |noremap|. Values are Booleans. Unknown
---             key is an error.
--- @param rhs string #Right-hand-side |{rhs}| of the mapping.
--- @param lhs string #Left-hand-side |{lhs}| of the mapping.
--- @param mode string #Mode short-name (map command prefix: "n", "i",
---             "v", "x", …) or "!" for |:map!|, or empty string
---             for |:map|.
function vim.api.nvim_set_keymap(mode, lhs, rhs, opts) end

-- Unmaps a global |mapping| for the given mode.
function vim.api.nvim_del_keymap(mode, lhs) end

-- Gets a map of global (non-buffer-local) Ex commands.
--- @param opts dictionary #Optional parameters. Currently only supports
---             {"builtin":false}
--- @return any #Map of maps describing commands.
function vim.api.nvim_get_commands(opts) end

-- Get information about a channel.
--- @return any #Dictionary describing a channel, with these keys:
---     • "stream" the stream underlying the channel
---       • "stdio" stdin and stdout of this Nvim instance
---       • "stderr" stderr of this Nvim instance
---       • "socket" TCP/IP socket or named pipe
---       • "job" job with communication over its stdio
--- 
---     • "mode" how data received on the channel is interpreted
---       • "bytes" send and receive raw bytes
---       • "terminal" a |terminal| instance interprets ASCII
---         sequences
---       • "rpc" |RPC| communication on the channel is active
--- 
---     • "pty" Name of pseudoterminal, if one is used (optional).
---       On a POSIX system, this will be a device path like
---       /dev/pts/1. Even if the name is unknown, the key will
---       still be present to indicate a pty is used. This is
---       currently the case when using winpty on windows.
---     • "buffer" buffer with connected |terminal| instance
---       (optional)
---     • "client" information about the client on the other end
---       of the RPC channel, if it has added it using
---       |nvim_set_client_info()|. (optional)
--- 
function vim.api.nvim_get_chan_info(chan) end

-- Get information about all open channels.
--- @return any #Array of Dictionaries, each describing a channel with the
---     format specified at |nvim_get_chan_info()|.
function vim.api.nvim_list_chans() end

-- Parse a VimL expression.
--- @param flags string #Flags:
---                  • "m" if multiple expressions in a row are
---                    allowed (only the first one will be
---                    parsed),
---                  • "E" if EOC tokens are not allowed
---                    (determines whether they will stop parsing
---                    process or be recognized as an
---                    operator/space, though also yielding an
---                    error).
---                  • "l" when needing to start parsing with
---                    lvalues for ":let" or ":for". Common flag
---                    sets:
---                  • "m" to parse like for ":echo".
---                  • "E" to parse like for "<C-r>=".
---                  • empty string for ":call".
---                  • "lm" to parse for ":let".
--- @param highlight boolean #If true, return value will also include
---                  "highlight" key containing array of 4-tuples
---                  (arrays) (Integer, Integer, Integer, String),
---                  where first three numbers define the
---                  highlighted region and represent line,
---                  starting column and ending column (latter
---                  exclusive: one should highlight region
---                  [start_col, end_col)).
--- @param expr string #Expression to parse. Always treated as a
---                  single line.
--- @return any #
---     • AST: top-level dictionary with these keys:
---       • "error": Dictionary with error, present only if parser
---         saw some error. Contains the following keys:
---         • "message": String, error message in printf format,
---           translated. Must contain exactly one "%.*s".
---         • "arg": String, error message argument.
--- 
---       • "len": Amount of bytes successfully parsed. With flags
---         equal to "" that should be equal to the length of expr
---         string. (“Sucessfully parsed” here means “participated
---         in AST creation”, not “till the first error”.)
---       • "ast": AST, either nil or a dictionary with these
---         keys:
---         • "type": node type, one of the value names from
---           ExprASTNodeType stringified without "kExprNode"
---           prefix.
---         • "start": a pair [line, column] describing where node
---           is "started" where "line" is always 0 (will not be 0
---           if you will be using nvim_parse_viml() on e.g.
---           ":let", but that is not present yet). Both elements
---           are Integers.
---         • "len": “length” of the node. This and "start" are
---           there for debugging purposes primary (debugging
---           parser and providing debug information).
---         • "children": a list of nodes described in top/"ast".
---           There always is zero, one or two children, key will
---           not be present if node has no children. Maximum
---           number of children may be found in node_maxchildren
---           array.
--- 
--- 
---     • Local values (present only for certain nodes):
---       • "scope": a single Integer, specifies scope for
---         "Option" and "PlainIdentifier" nodes. For "Option" it
---         is one of ExprOptScope values, for "PlainIdentifier"
---         it is one of ExprVarScope values.
---       • "ident": identifier (without scope, if any), present
---         for "Option", "PlainIdentifier", "PlainKey" and
---         "Environment" nodes.
---       • "name": Integer, register name (one character) or -1.
---         Only present for "Register" nodes.
---       • "cmp_type": String, comparison type, one of the value
---         names from ExprComparisonType, stringified without
---         "kExprCmp" prefix. Only present for "Comparison"
---         nodes.
---       • "ccs_strategy": String, case comparison strategy, one
---         of the value names from ExprCaseCompareStrategy,
---         stringified without "kCCStrategy" prefix. Only present
---         for "Comparison" nodes.
---       • "augmentation": String, augmentation type for
---         "Assignment" nodes. Is either an empty string, "Add",
---         "Subtract" or "Concat" for "=", "+=", "-=" or ".="
---         respectively.
---       • "invert": Boolean, true if result of comparison needs
---         to be inverted. Only present for "Comparison" nodes.
---       • "ivalue": Integer, integer value for "Integer" nodes.
---       • "fvalue": Float, floating-point value for "Float"
---         nodes.
---       • "svalue": String, value for "SingleQuotedString" and
---         "DoubleQuotedString" nodes.
--- 
--- 
function vim.api.nvim_parse_expression(expr, flags, highlight) end

