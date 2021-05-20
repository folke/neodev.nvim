--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Gets a line-range from the buffer.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param start integer #First line index
--- @param end_ integer #Last line index (exclusive)
--- @param strict_indexing boolean #Whether out-of-bounds should be an
---                        error.
--- @return any #Array of lines, or empty array for unloaded buffer.
function vim.api.nvim_buf_get_lines(buffer, start, end_, strict_indexing) end

-- Return a tuple (row,col) representing the position of the
-- named mark.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param name string #Mark name
--- @return any #(row, col) tuple
function vim.api.nvim_buf_get_mark(buffer, name) end

-- Gets the full file name for the buffer
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @return any #Buffer name
function vim.api.nvim_buf_get_name(buffer) end

-- Returns the byte offset of a line (0-indexed). |api-indexing|
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param index integer #Line index
--- @return any #Integer byte offset, or -1 for unloaded buffer.
function vim.api.nvim_buf_get_offset(buffer, index) end

-- Gets a buffer option value
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param name string #Option name
--- @return any #Option value
function vim.api.nvim_buf_get_option(buffer, name) end

-- Gets a buffer-scoped (b:) variable.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param name string #Variable name
--- @return any #Variable value
function vim.api.nvim_buf_get_var(buffer, name) end

-- Checks if a buffer is valid and loaded. See |api-buffer| for
-- more info about unloaded buffers.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @return any #true if the buffer is valid and loaded, false otherwise.
function vim.api.nvim_buf_is_loaded(buffer) end

-- Checks if a buffer is valid.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @return any #true if the buffer is valid, false otherwise.
function vim.api.nvim_buf_is_valid(buffer) end

-- Gets the buffer line count
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @return any #Line count, or 0 for unloaded buffer. |api-buffer|
function vim.api.nvim_buf_line_count(buffer) end

-- Creates or updates an extmark.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param ns_id integer #Namespace id from |nvim_create_namespace()|
--- @param line integer #Line number where to place the mark
--- @param col integer #Column where to place the mark
--- @param opts dictionary #Optional parameters.
---               • id : id of the extmark to edit.
---               • end_line : ending line of the mark, 0-based
---                 inclusive.
---               • end_col : ending col of the mark, 0-based
---                 inclusive.
---               • hl_group : name of the highlight group used to
---                 highlight this mark.
---               • virt_text : virtual text to link to this mark.
---               • virt_text_pos : positioning of virtual text.
---                 Possible values:
---                 • "eol": right after eol character (default)
---                 • "overlay": display over the specified
---                   column, without shifting the underlying
---                   text.
---                 • "right_align": display right aligned in the
---                   window.
---
---               • virt_text_win_col : position the virtual text
---                 at a fixed window column (starting from the
---                 first text column)
---               • virt_text_hide : hide the virtual text when
---                 the background text is selected or hidden due
---                 to horizontal scroll 'nowrap'
---               • hl_mode : control how highlights are combined
---                 with the highlights of the text. Currently
---                 only affects virt_text highlights, but might
---                 affect`hl_group`in later versions.
---                 • "replace": only show the virt_text color.
---                   This is the default
---                 • "combine": combine with background text
---                   color
---                 • "blend": blend with background text color.
---
---               • hl_eol : when true, for a multiline highlight
---                 covering the EOL of a line, continue the
---                 highlight for the rest of the screen line
---                 (just like for diff and cursorline highlight).
---               • ephemeral : for use with
---                 |nvim_set_decoration_provider| callbacks. The
---                 mark will only be used for the current redraw
---                 cycle, and not be permantently stored in the
---                 buffer.
---               • right_gravity : boolean that indicates the
---                 direction the extmark will be shifted in when
---                 new text is inserted (true for right, false
---                 for left). defaults to true.
---               • end_right_gravity : boolean that indicates the
---                 direction the extmark end position (if it
---                 exists) will be shifted in when new text is
---                 inserted (true for right, false for left).
---                 Defaults to false.
---               • priority: a priority value for the highlight
---                 group. For example treesitter highlighting
---                 uses a value of 100.
--- @return any #Id of the created/updated extmark
function vim.api.nvim_buf_set_extmark(buffer, ns_id, line, col, opts) end

-- Sets a buffer-local |mapping| for the given mode.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param mode string
--- @param lhs string
--- @param rhs string
--- @param opts dictionary
function vim.api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts) end

-- Sets (replaces) a line-range in the buffer.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param start integer #First line index
--- @param end_ integer #Last line index (exclusive)
--- @param strict_indexing boolean #Whether out-of-bounds should be an
---                        error.
--- @param replacement string[] #Array of lines to use as replacement
function vim.api.nvim_buf_set_lines(buffer, start, end_, strict_indexing, replacement) end

-- Sets the full file name for a buffer
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param name string #Buffer name
function vim.api.nvim_buf_set_name(buffer, name) end

-- Sets a buffer option value. Passing 'nil' as value deletes the
-- option (only works if there's a global fallback)
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param name string #Option name
--- @param value object #Option value
function vim.api.nvim_buf_set_option(buffer, name, value) end

-- Sets (replaces) a range in the buffer
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param start_row integer #First line index
--- @param start_col integer
--- @param end_row integer #Last line index
--- @param end_col integer
--- @param replacement string[] #Array of lines to use as replacement
function vim.api.nvim_buf_set_text(buffer, start_row, start_col, end_row, end_col, replacement) end

-- Sets a buffer-scoped (b:) variable
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param name string #Variable name
--- @param value object #Variable value
function vim.api.nvim_buf_set_var(buffer, name, value) end

-- Set the virtual text (annotation) for a buffer line.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param src_id integer
--- @param line integer #Line to annotate with virtual text
---               (zero-indexed)
--- @param chunks array #A list of [text, hl_group] arrays, each
---               representing a text chunk with specified
---               highlight. `hl_group` element can be omitted for
---               no highlight.
--- @param opts dictionary #Optional parameters. Currently not used.
--- @return any #The ns_id that was used
function vim.api.nvim_buf_set_virtual_text(buffer, src_id, line, chunks, opts) end

-- Calls many API methods atomically.
--- @param calls array #an array of calls, where each call is described
---              by an array with two elements: the request name,
---              and an array of arguments.
--- @return any #Array of two elements. The first is an array of return
---     values. The second is NIL if all calls succeeded. If a
---     call resulted in an error, it is a three-element array
---     with the zero-based index of the call which resulted in an
---     error, the error type and the error message. If an error
---     occurred, the values from all preceding calls will still
---     be returned.
function vim.api.nvim_call_atomic(calls) end

-- Calls a VimL |Dictionary-function| with the given arguments.
--- @param dict object #Dictionary, or String evaluating to a VimL |self|
---             dict
--- @param fn string #Name of the function defined on the VimL dict
--- @param args array #Function arguments packed in an Array
--- @return any #Result of the function call
function vim.api.nvim_call_dict_function(dict, fn, args) end

-- Calls a VimL function with the given arguments.
--- @param fn string #Function to call
--- @param args array #Function arguments packed in an Array
--- @return any #Result of the function call
function vim.api.nvim_call_function(fn, args) end

-- Send data to channel `id` . For a job, it writes it to the
-- stdin of the process. For the stdio channel |channel-stdio|,
-- it writes to Nvim's stdout. For an internal terminal instance
-- (|nvim_open_term()|) it writes directly to terimal output. See
-- |channel-bytes| for more information.
--- @param chan integer #id of the channel
--- @param data string #data to write. 8-bit clean: can contain NUL bytes.
function vim.api.nvim_chan_send(chan, data) end

-- Executes an ex-command.
--- @param command string #Ex-command string
function vim.api.nvim_command(command) end

