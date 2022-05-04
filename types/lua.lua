--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Add new filetype mappings.
--- @param filetypes any #table A table containing new filetype maps
---                  (see example).
function vim.add(filetypes) end

function vim.connection_failure_errmsg(consequence) end

-- Deep compare values for equality
--- @param a any #first value
--- @param b any #second value
--- @return any #`true` if values are equals, else `false`.
function vim.deep_equal(a, b) end

-- Returns a deep copy of the given object. Non-table objects are
-- copied as in a typical Lua assignment, whereas table objects
-- are copied recursively. Functions are naively copied, so
-- functions in the copied table point to the same functions as
-- those in the input table. Userdata and threads are not copied
-- and will throw an error.
--- @param orig any #table Table to copy
--- @return any #New table of copied keys and (nested) values.
function vim.deepcopy(orig) end

-- Defers calling `fn` until `timeout` ms passes.
--- @param fn fun(...) #Callback to call once `timeout` expires
--- @param timeout any #Number of milliseconds to wait before calling
---                `fn`
--- @return any #timer luv timer object
function vim.defer_fn(fn, timeout) end

-- Remove an existing mapping. Examples: >
--
--    vim.keymap.del('n', 'lhs')
--
--    vim.keymap.del({'n', 'i', 'v'}, '<leader>w', { buffer = 5 })
--
-- <
--- @param opts any #table A table of optional arguments:
---             • buffer: (number or boolean) Remove a mapping
---               from the given buffer. When "true" or 0, use the
---               current buffer.
function vim.del(modes, lhs, opts) end

-- Display a deprecation notification to the user.
--- @param name any #string Deprecated function.
--- @param alternative any #string|nil Preferred alternative function.
--- @param version any #string Version in which the deprecated
---                    function will be removed.
--- @param plugin any #string|nil Plugin name that the function
---                    will be removed from. Defaults to "Nvim".
function vim.deprecate(name, alternative, version, plugin) end

-- Tests if `s` ends with `suffix`.
--- @param s any #(string) a string
--- @param suffix any #(string) a suffix
--- @return any #(boolean) true if `suffix` is a suffix of s
function vim.endswith(s, suffix) end

-- Splits a string at each instance of a separator.
--- @param s any #String to split
--- @param sep any #Separator string or pattern
--- @param plain any #If `true` use `sep` literally (passed to
---              String.find)
--- @return any #Iterator over the split components
function vim.gsplit(s, sep, plain) end

-- Prompts the user for input
--- @param opts any #table Additional options. See |input()|
---                   • prompt (string|nil) Text of the prompt.
---                     Defaults to `Input:`.
---                   • default (string|nil) Default reply to the
---                     input
---                   • completion (string|nil) Specifies type of
---                     completion supported for input. Supported
---                     types are the same that can be supplied to
---                     a user-defined command using the
---                     "-complete=" argument. See
---                     |:command-completion|
---                   • highlight (function) Function that will be
---                     used for highlighting user inputs.
--- @param on_confirm any #function ((input|nil) -> ()) Called once the
---                   user confirms or abort the input. `input` is
---                   what the user typed. `nil` if the user
---                   aborted the dialog.
function vim.input(opts, on_confirm) end

-- Returns true if object `f` can be called as a function.
--- @param f any #Any object
--- @return any #true if `f` is callable, else false
function vim.is_callable(f) end

-- Extends a list-like table with the values of another list-like
-- table.
--- @param dst any #list which will be modified and appended to.
--- @param src any #list from which values will be inserted.
--- @param start any #Start index on src. defaults to 1
--- @param finish any #Final index on src. defaults to #src
--- @return any #dst
function vim.list_extend(dst, src, start, finish) end

-- Creates a copy of a table containing only elements from start
-- to end (inclusive)
--- @param list any[] #table table
--- @param start any #integer Start range of slice
--- @param finish any #integer End range of slice
--- @return any #Copy of table sliced from start to finish (inclusive)
function vim.list_slice(list, start, finish) end

-- Set the filetype for the given buffer from a file name.
--- @param name any #string File name (can be an absolute or relative
---              path)
--- @param bufnr any #number|nil The buffer to set the filetype for.
---              Defaults to the current buffer.
function vim.match(name, bufnr) end

-- Display a notification to the user.
--- @param msg any #string Content of the notification to show to the
---              user.
--- @param level any #number|nil One of the values from
---              |vim.log.levels|.
--- @param opts any #table|nil Optional parameters. Unused by default.
function vim.notify(msg, level, opts) end

-- Display a notification only one time.
--- @param msg any #string Content of the notification to show to the
---              user.
--- @param level any #number|nil One of the values from
---              |vim.log.levels|.
--- @param opts any #table|nil Optional parameters. Unused by default.
function vim.notify_once(msg, level, opts) end

-- Adds Lua function {fn} with namespace id {ns_id} as a listener
-- to every, yes every, input key.
--- @param fn fun(...) #function: Callback function. It should take one
---              string argument. On each key press, Nvim passes
---              the key char to fn(). |i_CTRL-V| If {fn} is nil,
---              it removes the callback for the associated
---              {ns_id}
--- @param ns_id any #number? Namespace ID. If nil or 0, generates and
---              returns a new |nvim_create_namespace()| id.
--- @return any #number Namespace id associated with {fn}. Or count of all
---     callbacks if on_key() is called without arguments.
--- @return any #
--- Note:
---     {fn} will be removed if an error occurs while calling.
function vim.on_key(fn, ns_id) end

-- Paste handler, invoked by |nvim_paste()| when a conforming UI
-- (such as the |TUI|) pastes text into the editor.
--- @param lines any #|readfile()|-style list of lines to paste.
---              |channel-lines|
--- @param phase any #-1: "non-streaming" paste: the call contains all
---              lines. If paste is "streamed", `phase` indicates the stream state:
---              • 1: starts the paste (exactly once)
---              • 2: continues the paste (zero or more times)
---              • 3: ends the paste (exactly once)
--- @return any #false if client should cancel the paste.
function vim.paste(lines, phase) end

-- Escapes magic chars in a Lua pattern.
--- @param s any #String to escape
--- @return any #%-escaped pattern string
function vim.pesc(s) end

-- Prints given arguments in human-readable format. Example: >
--   -- Print highlight group Normal and store it's contents in a variable.
--   local hl_normal = vim.pretty_print(vim.api.nvim_get_hl_by_name("Normal", true))
--
-- <
--- @return any #given arguments.
function vim.pretty_print(...) end

-- Get a table of lines with start, end columns for a region
-- marked by two points
--- @param bufnr any #number of buffer
--- @param pos1 any #(line, column) tuple marking beginning of
---                  region
--- @param pos2 any #(line, column) tuple marking end of region
--- @param regtype any #type of selection (:help setreg)
--- @param inclusive any #boolean indicating whether the selection is
---                  end-inclusive
--- @return any #region lua table of the form {linenr = {startcol,endcol}}
function vim.region(bufnr, pos1, pos2, regtype, inclusive) end

-- Defers callback `cb` until the Nvim API is safe to call.
function vim.schedule_wrap(cb) end

-- Prompts the user to pick a single item from a collection of
-- entries
--- @param items any #table Arbitrary items
--- @param opts any #table Additional options
---                  • prompt (string|nil) Text of the prompt.
---                    Defaults to `Select one of:`
---                  • format_item (function item -> text)
---                    Function to format an individual item from
---                    `items`. Defaults to `tostring`.
---                  • kind (string|nil) Arbitrary hint string
---                    indicating the item shape. Plugins
---                    reimplementing `vim.ui.select` may wish to
---                    use this to infer the structure or
---                    semantics of `items`, or the context in
---                    which select() was called.
--- @param on_choice any #function ((item|nil, idx|nil) -> ()) Called
---                  once the user made a choice. `idx` is the
---                  1-based index of `item` within `items`. `nil`
---                  if the user aborted the dialog.
function vim.select(items, opts, on_choice) end

-- Add a new |mapping|. Examples: >
--
--    -- Can add mapping to Lua functions
--    vim.keymap.set('n', 'lhs', function() print("real lua function") end)
--
--    -- Can use it to map multiple modes
--    vim.keymap.set({'n', 'v'}, '<leader>lr', vim.lsp.buf.references, { buffer=true })
--
--    -- Can add mapping for specific buffer
--    vim.keymap.set('n', '<leader>w', "<cmd>w<cr>", { silent = true, buffer = 5 })
--
--    -- Expr mappings
--    vim.keymap.set('i', '<Tab>', function()
--      return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
--    end, { expr = true })
--    -- <Plug> mappings
--    vim.keymap.set('n', '[%', '<Plug>(MatchitNormalMultiBackward)')
--
-- <
--- @param mode any #string|table Same mode short names as
---             |nvim_set_keymap()|. Can also be list of modes to
---             create mapping on multiple modes.
--- @param lhs any #string Left-hand side |{lhs}| of the mapping.
--- @param rhs any #string|function Right-hand side |{rhs}| of the
---             mapping. Can also be a Lua function. If a Lua
---             function and `opts.expr == true`, returning `nil`
---             is equivalent to an empty string.
--- @param opts any #table A table of |:map-arguments| such as
---             "silent". In addition to the options listed in
---             |nvim_set_keymap()|, this table also accepts the
---             following keys:
---             • buffer: (number or boolean) Add a mapping to the
---               given buffer. When "true" or 0, use the current
---               buffer.
---             • replace_keycodes: (boolean, default true) When
---               both this and expr is "true",
---               |nvim_replace_termcodes()| is applied to the
---               result of Lua expr maps.
---             • remap: (boolean) Make the mapping recursive.
---               This is the inverse of the "noremap" option from
---               |nvim_set_keymap()|. Default `false`.
function vim.set(mode, lhs, rhs, opts) end

-- Splits a string at each instance of a separator.
--- @param s any #String to split
--- @param sep any #Separator string or pattern
--- @param kwargs any #Keyword arguments:
---               • plain: (boolean) If `true` use `sep` literally
---                 (passed to string.find)
---               • trimempty: (boolean) If `true` remove empty
---                 items from the front and back of the list
--- @return any #List-like table of the split components.
function vim.split(s, sep, kwargs) end

-- Tests if `s` starts with `prefix`.
--- @param s any #(string) a string
--- @param prefix any #(string) a prefix
--- @return any #(boolean) true if `prefix` is a prefix of s
function vim.startswith(s, prefix) end

-- Add the reverse lookup values to an existing table. For
-- example: `tbl_add_reverse_lookup { A = 1 } == { [1] = 'A', A = 1 }`
--- @param o any #table The table to add the reverse to.
function vim.tbl_add_reverse_lookup(o) end

-- Checks if a list-like (vector) table contains `value`.
--- @param t any #Table to check
--- @param value any #Value to compare
--- @return any #true if `t` contains `value`
function vim.tbl_contains(t, value) end

-- Counts the number of non-nil values in table `t`.
--- @param t any #Table
--- @return any #Number that is the number of the value in table
function vim.tbl_count(t) end

-- Merges recursively two or more map-like tables.
--- @param behavior any #Decides what to do if a key is found in more
---                 than one map:
---                 • "error": raise an error
---                 • "keep": use value from the leftmost map
---                 • "force": use value from the rightmost map
--- @vararg any #Two or more map-like tables.
function vim.tbl_deep_extend(behavior, ...) end

-- Merges two or more map-like tables.
--- @param behavior any #Decides what to do if a key is found in more
---                 than one map:
---                 • "error": raise an error
---                 • "keep": use value from the leftmost map
---                 • "force": use value from the rightmost map
--- @vararg any #Two or more map-like tables.
function vim.tbl_extend(behavior, ...) end

-- Filter a table using a predicate function
--- @param func any #function or callable table
--- @param t any #table
function vim.tbl_filter(func, t) end

-- Creates a copy of a list-like table such that any nested
-- tables are "unrolled" and appended to the result.
--- @param t any #List-like table
--- @return any #Flattened copy of the given list-like table.
function vim.tbl_flatten(t) end

-- Index into a table (first argument) via string keys passed as
-- subsequent arguments. Return `nil` if the key does not exist. Examples: >
--
--   vim.tbl_get({ key = { nested_key = true }}, 'key', 'nested_key') == true
--   vim.tbl_get({ key = {}}, 'key', 'nested_key') == nil
--
-- <
--- @param o any #Table to index
--- @vararg any #Optional strings (0 or more, variadic) via which to
---            index the table
--- @return any #nested value indexed by key if it exists, else nil
function vim.tbl_get(o, ...) end

-- Checks if a table is empty.
--- @param t any #Table to check
function vim.tbl_isempty(t) end

-- Tests if a Lua table can be treated as an array.
--- @param t any #Table
--- @return any #`true` if array-like table, else `false`.
function vim.tbl_islist(t) end

-- Return a list of all keys used in a table. However, the order
-- of the return table of keys is not guaranteed.
--- @param t any #Table
--- @return any #list of keys
function vim.tbl_keys(t) end

-- Apply a function to all values of a table.
--- @param func any #function or callable table
--- @param t any #table
function vim.tbl_map(func, t) end

-- Return a list of all values used in a table. However, the
-- order of the return table of values is not guaranteed.
--- @param t any #Table
--- @return any #list of values
function vim.tbl_values(t) end

-- Trim whitespace (Lua pattern "%s") from both sides of a
-- string.
--- @param s any #String to trim
--- @return any #String with whitespace removed from its beginning and end
function vim.trim(s) end

-- Validates a parameter specification (types and values).
--- @param opt any #table of parameter names to validations. Each key
---            is a parameter name; each value is a tuple in one
---            of these forms:
---            1. (arg_value, type_name, optional)
---               • arg_value: argument value
---               • type_name: string|table type name, one of:
---                 ("table", "t", "string", "s", "number", "n",
---                 "boolean", "b", "function", "f", "nil",
---                 "thread", "userdata") or list of them.
---               • optional: (optional) boolean, if true, `nil`
---                 is valid
---
---            2. (arg_value, fn, msg)
---               • arg_value: argument value
---               • fn: any function accepting one argument,
---                 returns true if and only if the argument is
---                 valid. Can optionally return an additional
---                 informative error message as the second
---                 returned value.
---               • msg: (optional) error string if validation
---                 fails
function vim.validate(opt) end

