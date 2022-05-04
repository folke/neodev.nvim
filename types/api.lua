--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

--- @param buffer buffer
--- @param first integer
--- @param last integer
function vim.api.nvim__buf_redraw_range(buffer, first, last) end

--- @param buffer buffer
function vim.api.nvim__buf_stats(buffer) end

--- @param ns_id integer
function vim.api.nvim__get_hl_defs(ns_id) end

function vim.api.nvim__get_lib_dir() end

-- Find files in runtime directories
--- @param pat array #pattern of files to search for
--- @param all boolean #whether to return all matches or only the first
--- @param opts dict(runtime) * #is_lua: only search lua subdirs
--- @return any #list of absolute paths to the found files
function vim.api.nvim__get_runtime(pat, all, opts) end

-- Returns object given as argument.
--- @param obj object #Object to return.
--- @return any #its argument.
function vim.api.nvim__id(obj) end

-- Returns array given as argument.
--- @param arr array #Array to return.
--- @return any #its argument.
function vim.api.nvim__id_array(arr) end

-- Returns dictionary given as argument.
--- @param dct dictionary #Dictionary to return.
--- @return any #its argument.
function vim.api.nvim__id_dictionary(dct) end

-- Returns floating-point value given as argument.
--- @param flt float #Value to return.
--- @return any #its argument.
function vim.api.nvim__id_float(flt) end

-- NB: if your UI doesn't use hlstate, this will not return
-- hlstate first time.
--- @param grid integer
--- @param row integer
--- @param col integer
function vim.api.nvim__inspect_cell(grid, row, col) end

function vim.api.nvim__runtime_inspect() end

--- @param path string
function vim.api.nvim__screenshot(path) end

-- Set active namespace for highlights.
--- @param ns_id integer #the namespace to activate
function vim.api.nvim__set_hl_ns(ns_id) end

-- Gets internal stats.
--- @return any #Map of various internal stats.
function vim.api.nvim__stats() end

-- Adds a highlight to buffer.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param ns_id integer #namespace to use or -1 for ungrouped
---                  highlight
--- @param hl_group string #Name of the highlight group to use
--- @param line integer #Line to highlight (zero-indexed)
--- @param col_start integer #Start of (byte-indexed) column range to
---                  highlight
--- @param col_end integer #End of (byte-indexed) column range to
---                  highlight, or -1 to highlight to end of line
--- @return any #The ns_id that was used
function vim.api.nvim_buf_add_highlight(buffer, ns_id, hl_group, line, col_start, col_end) end

-- Activates buffer-update events on a channel, or as Lua
-- callbacks.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param send_buffer boolean #True if the initial notification should
---                    contain the whole buffer: first
---                    notification will be
---                    `nvim_buf_lines_event`. Else the first
---                    notification will be
---                    `nvim_buf_changedtick_event`. Not for Lua
---                    callbacks.
--- @param opts table<string, luaref> #Optional parameters.
---                    • on_lines: Lua callback invoked on change.
---                      Return `true` to detach. Args:
---                      • the string "lines"
---                      • buffer handle
---                      • b:changedtick
---                      • first line that changed (zero-indexed)
---                      • last line that was changed
---                      • last line in the updated range
---                      • byte count of previous contents
---                      • deleted_codepoints (if `utf_sizes` is
---                        true)
---                      • deleted_codeunits (if `utf_sizes` is
---                        true)
---
---                    • on_bytes: lua callback invoked on change.
---                      This callback receives more granular
---                      information about the change compared to
---                      on_lines. Return `true` to detach. Args:
---                      • the string "bytes"
---                      • buffer handle
---                      • b:changedtick
---                      • start row of the changed text
---                        (zero-indexed)
---                      • start column of the changed text
---                      • byte offset of the changed text (from
---                        the start of the buffer)
---                      • old end row of the changed text
---                      • old end column of the changed text
---                      • old end byte length of the changed text
---                      • new end row of the changed text
---                      • new end column of the changed text
---                      • new end byte length of the changed text
---
---                    • on_changedtick: Lua callback invoked on
---                      changedtick increment without text
---                      change. Args:
---                      • the string "changedtick"
---                      • buffer handle
---                      • b:changedtick
---
---                    • on_detach: Lua callback invoked on
---                      detach. Args:
---                      • the string "detach"
---                      • buffer handle
---
---                    • on_reload: Lua callback invoked on
---                      reload. The entire buffer content should
---                      be considered changed. Args:
---                      • the string "reload"
---                      • buffer handle
---
---                    • utf_sizes: include UTF-32 and UTF-16 size
---                      of the replaced region, as args to
---                      `on_lines`.
---                    • preview: also attach to command preview
---                      (i.e. 'inccommand') events.
--- @return any #False if attach failed (invalid parameter, or buffer isn't
---     loaded); otherwise True. TODO: LUA_API_NO_EVAL
function vim.api.nvim_buf_attach(buffer, send_buffer, opts) end

-- call a function with buffer as temporary current buffer
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param fun luaref #Function to call inside the buffer (currently
---               lua callable only)
--- @return any #Return value of function. NB: will deepcopy lua values
---     currently, use upvalues to send lua references in and out.
function vim.api.nvim_buf_call(buffer, fun) end

-- Clears namespaced objects (highlights, extmarks, virtual text)
-- from a region.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param ns_id integer #Namespace to clear, or -1 to clear all
---                   namespaces.
--- @param line_start integer #Start of range of lines to clear
--- @param line_end integer #End of range of lines to clear (exclusive)
---                   or -1 to clear to end of buffer.
function vim.api.nvim_buf_clear_namespace(buffer, ns_id, line_start, line_end) end

-- Create a new user command |user-commands| in the given buffer.
--- @param buffer buffer #Buffer handle, or 0 for current buffer.
--- @param name string
--- @param command object
--- @param opts dict(user_command) *
function vim.api.nvim_buf_create_user_command(buffer, name, command, opts) end

-- Removes an extmark.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param ns_id integer #Namespace id from |nvim_create_namespace()|
--- @param id integer #Extmark id
--- @return any #true if the extmark was found, else false
function vim.api.nvim_buf_del_extmark(buffer, ns_id, id) end

-- Unmaps a buffer-local |mapping| for the given mode.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param mode string
--- @param lhs string
function vim.api.nvim_buf_del_keymap(buffer, mode, lhs) end

-- Deletes a named mark in the buffer. See |mark-motions|.
--- @param buffer buffer #Buffer to set the mark on
--- @param name string #Mark name
--- @return any #true if the mark was deleted, else false.
function vim.api.nvim_buf_del_mark(buffer, name) end

-- Delete a buffer-local user-defined command.
--- @param buffer buffer #Buffer handle, or 0 for current buffer.
--- @param name string #Name of the command to delete.
function vim.api.nvim_buf_del_user_command(buffer, name) end

-- Removes a buffer-scoped (b:) variable
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param name string #Variable name
function vim.api.nvim_buf_del_var(buffer, name) end

-- Deletes the buffer. See |:bwipeout|
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param opts dictionary #Optional parameters. Keys:
---               • force: Force deletion and ignore unsaved
---                 changes.
---               • unload: Unloaded only, do not delete. See
---                 |:bunload|
function vim.api.nvim_buf_delete(buffer, opts) end

-- Deactivates buffer-update events on the channel.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @return any #False if detach failed (because the buffer isn't loaded);
---     otherwise True.
function vim.api.nvim_buf_detach(buffer) end

-- Gets a changed tick of a buffer
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @return any #`b:changedtick` value.
function vim.api.nvim_buf_get_changedtick(buffer) end

-- Gets a map of buffer-local |user-commands|.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param opts dict(get_commands) * #Optional parameters. Currently not used.
--- @return any #Map of maps describing commands.
function vim.api.nvim_buf_get_commands(buffer, opts) end

-- Gets the position (0-indexed) of an extmark.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param ns_id integer #Namespace id from |nvim_create_namespace()|
--- @param id integer #Extmark id
--- @param opts dictionary #Optional parameters. Keys:
---               • details: Whether to include the details dict
--- @return any #0-indexed (row, col) tuple or empty list () if extmark id
---     was absent
function vim.api.nvim_buf_get_extmark_by_id(buffer, ns_id, id, opts) end

-- Gets extmarks in "traversal order" from a |charwise| region
-- defined by buffer positions (inclusive, 0-indexed
-- |api-indexing|).
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param ns_id integer #Namespace id from |nvim_create_namespace()|
--- @param start object #Start of range: a 0-indexed (row, col) or valid
---               extmark id (whose position defines the bound).
---               |api-indexing|
--- @param end_ object #End of range (inclusive): a 0-indexed (row, col)
---               or valid extmark id (whose position defines the
---               bound). |api-indexing|
--- @param opts dictionary #Optional parameters. Keys:
---               • limit: Maximum number of marks to return
---               • details Whether to include the details dict
--- @return any #List of [extmark_id, row, col] tuples in "traversal
---     order".
function vim.api.nvim_buf_get_extmarks(buffer, ns_id, start, end_, opts) end

-- Gets a list of buffer-local |mapping| definitions.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param mode string #Mode short-name ("n", "i", "v", ...)
--- @return any #Array of maparg()-like dictionaries describing mappings.
---     The "buffer" key holds the associated buffer handle.
function vim.api.nvim_buf_get_keymap(buffer, mode) end

-- Gets a line-range from the buffer.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param start integer #First line index
--- @param end_ integer #Last line index (exclusive)
--- @param strict_indexing boolean #Whether out-of-bounds should be an
---                        error.
--- @return any #Array of lines, or empty array for unloaded buffer.
function vim.api.nvim_buf_get_lines(buffer, start, end_, strict_indexing) end

-- Returns a tuple (row,col) representing the position of the
-- named mark. See |mark-motions|.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param name string #Mark name
--- @return any #(row, col) tuple, (0, 0) if the mark is not set, or is an
---     uppercase/file mark set in another buffer.
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

-- Gets a range from the buffer.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param start_row integer #First line index
--- @param start_col integer #Starting byte offset of first line
--- @param end_row integer #Last line index
--- @param end_col integer #Ending byte offset of last line (exclusive)
--- @param opts dictionary #Optional parameters. Currently unused.
--- @return any #Array of lines, or empty array for unloaded buffer.
function vim.api.nvim_buf_get_text(buffer, start_row, start_col, end_row, end_col, opts) end

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

-- Returns the number of lines in the given buffer.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @return any #Line count, or 0 for unloaded buffer. |api-buffer|
function vim.api.nvim_buf_line_count(buffer) end

-- Creates or updates an extmark.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param ns_id integer #Namespace id from |nvim_create_namespace()|
--- @param line integer #Line where to place the mark, 0-based.
---               |api-indexing|
--- @param col integer #Column where to place the mark, 0-based.
---               |api-indexing|
--- @param opts dict(set_extmark) * #Optional parameters.
---               • id : id of the extmark to edit.
---               • end_row : ending line of the mark, 0-based
---                 inclusive.
---               • end_col : ending col of the mark, 0-based
---                 exclusive.
---               • hl_group : name of the highlight group used to
---                 highlight this mark.
---               • hl_eol : when true, for a multiline highlight
---                 covering the EOL of a line, continue the
---                 highlight for the rest of the screen line
---                 (just like for diff and cursorline highlight).
---               • virt_text : virtual text to link to this mark.
---                 A list of [text, highlight] tuples, each
---                 representing a text chunk with specified
---                 highlight. `highlight` element can either be a
---                 a single highlight group, or an array of
---                 multiple highlight groups that will be stacked
---                 (highest priority last). A highlight group can
---                 be supplied either as a string or as an
---                 integer, the latter which can be obtained
---                 using |nvim_get_hl_id_by_name|.
---               • virt_text_pos : position of virtual text.
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
---                 affect `hl_group` in later versions.
---                 • "replace": only show the virt_text color.
---                   This is the default
---                 • "combine": combine with background text
---                   color
---                 • "blend": blend with background text color.
---
---               • virt_lines : virtual lines to add next to this
---                 mark This should be an array over lines, where
---                 each line in turn is an array over [text,
---                 highlight] tuples. In general, buffer and
---                 window options do not affect the display of
---                 the text. In particular 'wrap' and 'linebreak'
---                 options do not take effect, so the number of
---                 extra screen lines will always match the size
---                 of the array. However the 'tabstop' buffer
---                 option is still used for hard tabs. By default
---                 lines are placed below the buffer line
---                 containing the mark.
---               • virt_lines_above: place virtual lines above
---                 instead.
---               • virt_lines_leftcol: Place extmarks in the
---                 leftmost column of the window, bypassing sign
---                 and number columns.
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
---               • strict: boolean that indicates extmark should
---                 not be placed if the line or column value is
---                 past the end of the buffer or end of the line
---                 respectively. Defaults to true.
---               • sign_text: string of length 1-2 used to
---                 display in the sign column. Note: ranges are
---                 unsupported and decorations are only applied
---                 to start_row
---               • sign_hl_group: name of the highlight group
---                 used to highlight the sign column text. Note:
---                 ranges are unsupported and decorations are
---                 only applied to start_row
---               • number_hl_group: name of the highlight group
---                 used to highlight the number column. Note:
---                 ranges are unsupported and decorations are
---                 only applied to start_row
---               • line_hl_group: name of the highlight group
---                 used to highlight the whole line. Note: ranges
---                 are unsupported and decorations are only
---                 applied to start_row
---               • cursorline_hl_group: name of the highlight
---                 group used to highlight the line when the
---                 cursor is on the same line as the mark and
---                 'cursorline' is enabled. Note: ranges are
---                 unsupported and decorations are only applied
---                 to start_row
---               • conceal: string which should be either empty
---                 or a single character. Enable concealing
---                 similar to |:syn-conceal|. When a character is
---                 supplied it is used as |:syn-cchar|.
---                 "hl_group" is used as highlight for the cchar
---                 if provided, otherwise it defaults to
---                 |hl-Conceal|.
---               • ui_watched: boolean that indicates the mark
---                 should be drawn by a UI. When set, the UI will
---                 receive win_extmark events. Note: the mark is
---                 positioned by virt_text attributes. Can be
---                 used together with virt_text.
--- @return any #Id of the created/updated extmark
function vim.api.nvim_buf_set_extmark(buffer, ns_id, line, col, opts) end

-- Sets a buffer-local |mapping| for the given mode.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param mode string
--- @param lhs string
--- @param rhs string
--- @param opts dict(keymap) *
function vim.api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts) end

-- Sets (replaces) a line-range in the buffer.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param start integer #First line index
--- @param end_ integer #Last line index (exclusive)
--- @param strict_indexing boolean #Whether out-of-bounds should be an
---                        error.
--- @param replacement string[] #Array of lines to use as replacement
function vim.api.nvim_buf_set_lines(buffer, start, end_, strict_indexing, replacement) end

-- Sets a named mark in the given buffer, all marks are allowed
-- file/uppercase, visual, last change, etc. See |mark-motions|.
--- @param buffer buffer #Buffer to set the mark on
--- @param name string #Mark name
--- @param line integer #Line number
--- @param col integer #Column/row number
--- @param opts dictionary #Optional parameters. Reserved for future use.
--- @return any #true if the mark was set, else false.
function vim.api.nvim_buf_set_mark(buffer, name, line, col, opts) end

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
--- @param start_col integer #First column
--- @param end_row integer #Last line index
--- @param end_col integer #Last column
--- @param replacement string[] #Array of lines to use as replacement
function vim.api.nvim_buf_set_text(buffer, start_row, start_col, end_row, end_col, replacement) end

-- Sets a buffer-scoped (b:) variable
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param name string #Variable name
--- @param value object #Variable value
function vim.api.nvim_buf_set_var(buffer, name, value) end

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

-- Send data to channel `id`. For a job, it writes it to the
-- stdin of the process. For the stdio channel |channel-stdio|,
-- it writes to Nvim's stdout. For an internal terminal instance
-- (|nvim_open_term()|) it writes directly to terminal output.
-- See |channel-bytes| for more information.
--- @param chan integer #id of the channel
--- @param data string #data to write. 8-bit clean: can contain NUL bytes.
function vim.api.nvim_chan_send(chan, data) end

-- Clear all autocommands that match the corresponding {opts}. To
-- delete a particular autocmd, see |nvim_del_autocmd|.
--- @param opts dict(clear_autocmds) * #Parameters
---             • event: (string|table) Examples:
---               • event: "pat1"
---               • event: { "pat1" }
---               • event: { "pat1", "pat2", "pat3" }
---
---             • pattern: (string|table)
---               • pattern or patterns to match exactly.
---                 • For example, if you have `*.py` as that
---                   pattern for the autocmd, you must pass
---                   `*.py` exactly to clear it. `test.py` will
---                   not match the pattern.
---
---               • defaults to clearing all patterns.
---               • NOTE: Cannot be used with {buffer}
---
---             • buffer: (bufnr)
---               • clear only |autocmd-buflocal| autocommands.
---               • NOTE: Cannot be used with {pattern}
---
---             • group: (string|int) The augroup name or id.
---               • NOTE: If not passed, will only delete autocmds not in any group.
function vim.api.nvim_clear_autocmds(opts) end

-- Executes an ex-command.
--- @param command string #Ex-command string
function vim.api.nvim_command(command) end

-- Create or get an autocommand group |autocmd-groups|.
--- @param name string #String: The name of the group
--- @param opts dict(create_augroup) * #Dictionary Parameters
---             • clear (bool) optional: defaults to true. Clear
---               existing commands if the group already exists
---               |autocmd-groups|.
--- @return any #Integer id of the created group.
function vim.api.nvim_create_augroup(name, opts) end

-- Create an |autocommand|
--- @param event object #(string|array) The event or events to register
---              this autocommand
--- @param opts dict(create_autocmd) * #Dictionary of autocommand options:
---              • group (string|integer) optional: the
---                autocommand group name or id to match against.
---              • pattern (string|array) optional: pattern or
---                patterns to match against |autocmd-pattern|.
---              • buffer (integer) optional: buffer number for
---                buffer local autocommands |autocmd-buflocal|.
---                Cannot be used with {pattern}.
---              • desc (string) optional: description of the
---                autocommand.
---              • callback (function|string) optional: if a
---                string, the name of a Vimscript function to
---                call when this autocommand is triggered.
---                Otherwise, a Lua function which is called when
---                this autocommand is triggered. Cannot be used
---                with {command}. Lua callbacks can return true
---                to delete the autocommand; in addition, they
---                accept a single table argument with the
---                following keys:
---                • id: (number) the autocommand id
---                • event: (string) the name of the event that
---                  triggered the autocommand |autocmd-events|
---                • group: (number|nil) the autocommand group id,
---                  if it exists
---                • match: (string) the expanded value of
---                  |<amatch>|
---                • buf: (number) the expanded value of |<abuf>|
---                • file: (string) the expanded value of
---                  |<afile>|
---
---              • command (string) optional: Vim command to
---                execute on event. Cannot be used with
---                {callback}
---              • once (boolean) optional: defaults to false. Run
---                the autocommand only once |autocmd-once|.
---              • nested (boolean) optional: defaults to false.
---                Run nested autocommands |autocmd-nested|.
--- @return any #Integer id of the created autocommand.
function vim.api.nvim_create_autocmd(event, opts) end

-- Creates a new, empty, unnamed buffer.
--- @param listed boolean #Sets 'buflisted'
--- @param scratch boolean #Creates a "throwaway" |scratch-buffer| for
---                temporary work (always 'nomodified'). Also sets
---                'nomodeline' on the buffer.
--- @return any #Buffer handle, or 0 on error
function vim.api.nvim_create_buf(listed, scratch) end

-- Creates a new *namespace* or gets an existing one.
--- @param name string #Namespace name or empty string
--- @return any #Namespace id
function vim.api.nvim_create_namespace(name) end

-- Create a new user command |user-commands|
--- @param name string #Name of the new user command. Must begin with
---                an uppercase letter.
--- @param command object #Replacement command to execute when this user
---                command is executed. When called from Lua, the
---                command can also be a Lua function. The
---                function is called with a single table argument
---                that contains the following keys:
---                • args: (string) The args passed to the
---                  command, if any |<args>|
---                • fargs: (table) The args split by unescaped
---                  whitespace (when more than one argument is
---                  allowed), if any |<f-args>|
---                • bang: (boolean) "true" if the command was
---                  executed with a ! modifier |<bang>|
---                • line1: (number) The starting line of the
---                  command range |<line1>|
---                • line2: (number) The final line of the command
---                  range |<line2>|
---                • range: (number) The number of items in the
---                  command range: 0, 1, or 2 |<range>|
---                • count: (number) Any count supplied |<count>|
---                • reg: (string) The optional register, if
---                  specified |<reg>|
---                • mods: (string) Command modifiers, if any
---                  |<mods>|
--- @param opts dict(user_command) * #Optional command attributes. See
---                |command-attributes| for more details. To use
---                boolean attributes (such as |:command-bang| or
---                |:command-bar|) set the value to "true". In
---                addition to the string options listed in
---                |:command-complete|, the "complete" key also
---                accepts a Lua function which works like the
---                "customlist" completion mode
---                |:command-completion-customlist|. Additional
---                parameters:
---                • desc: (string) Used for listing the command
---                  when a Lua function is used for {command}.
---                • force: (boolean, default true) Override any
---                  previous definition.
function vim.api.nvim_create_user_command(name, command, opts) end

-- Delete an autocommand group by id.
--- @param id integer #Integer The id of the group.
function vim.api.nvim_del_augroup_by_id(id) end

-- Delete an autocommand group by name.
--- @param name string #String The name of the group.
function vim.api.nvim_del_augroup_by_name(name) end

-- Delete an autocommand by id.
--- @param id integer #Integer The id returned by nvim_create_autocmd
function vim.api.nvim_del_autocmd(id) end

-- Deletes the current line.
function vim.api.nvim_del_current_line() end

-- Unmaps a global |mapping| for the given mode.
--- @param mode string
--- @param lhs string
function vim.api.nvim_del_keymap(mode, lhs) end

-- Deletes an uppercase/file named mark. See |mark-motions|.
--- @param name string #Mark name
--- @return any #true if the mark was deleted, else false.
function vim.api.nvim_del_mark(name) end

-- Delete a user-defined command.
--- @param name string #Name of the command to delete.
function vim.api.nvim_del_user_command(name) end

-- Removes a global (g:) variable.
--- @param name string #Variable name
function vim.api.nvim_del_var(name) end

-- Echo a message.
--- @param chunks array #A list of [text, hl_group] arrays, each
---                representing a text chunk with specified
---                highlight. `hl_group` element can be omitted
---                for no highlight.
--- @param history boolean #if true, add to |message-history|.
--- @param opts dictionary #Optional parameters. Reserved for future use.
function vim.api.nvim_echo(chunks, history, opts) end

-- Writes a message to the Vim error buffer. Does not append
-- "\n", the message is buffered (won't display) until a linefeed
-- is written.
--- @param str string #Message
function vim.api.nvim_err_write(str) end

-- Writes a message to the Vim error buffer. Appends "\n", so the
-- buffer is flushed (and displayed).
--- @param str string #Message
function vim.api.nvim_err_writeln(str) end

-- Evaluates a VimL |expression|. Dictionaries and Lists are
-- recursively expanded.
--- @param expr string #VimL expression string
--- @return any #Evaluation result or expanded object
function vim.api.nvim_eval(expr) end

-- Evaluates statusline string.
--- @param str string #Statusline string (see 'statusline').
--- @param opts dict(eval_statusline) * #Optional parameters.
---             • winid: (number) |window-ID| of the window to use
---               as context for statusline.
---             • maxwidth: (number) Maximum width of statusline.
---             • fillchar: (string) Character to fill blank
---               spaces in the statusline (see 'fillchars').
---               Treated as single-width even if it isn't.
---             • highlights: (boolean) Return highlight
---               information.
---             • use_tabline: (boolean) Evaluate tabline instead
---               of statusline. When |TRUE|, {winid} is ignored.
--- @return any #Dictionary containing statusline information, with these
---     keys:
---     • str: (string) Characters that will be displayed on the
---       statusline.
---     • width: (number) Display width of the statusline.
---     • highlights: Array containing highlight information of
---       the statusline. Only included when the "highlights" key
---       in {opts} is |TRUE|. Each element of the array is a
---       |Dictionary| with these keys:
---       • start: (number) Byte index (0-based) of first
---         character that uses the highlight.
---       • group: (string) Name of highlight group.
function vim.api.nvim_eval_statusline(str, opts) end

-- Executes Vimscript (multiline block of Ex-commands), like
-- anonymous |:source|.
--- @param src string #Vimscript code
--- @param output boolean #Capture and return all (non-error, non-shell
---               |:!|) output
--- @return any #Output (non-error, non-shell |:!|) if `output` is true,
---     else empty string.
function vim.api.nvim_exec(src, output) end

-- Execute all autocommands for {event} that match the
-- corresponding {opts} |autocmd-execute|.
--- @param event object #(String|Array) The event or events to execute
--- @param opts dict(exec_autocmds) * #Dictionary of autocommand options:
---              • group (string|integer) optional: the
---                autocommand group name or id to match against.
---                |autocmd-groups|.
---              • pattern (string|array) optional: defaults to
---                "*" |autocmd-pattern|. Cannot be used with
---                {buffer}.
---              • buffer (integer) optional: buffer number
---                |autocmd-buflocal|. Cannot be used with
---                {pattern}.
---              • modeline (bool) optional: defaults to true.
---                Process the modeline after the autocommands
---                |<nomodeline>|.
function vim.api.nvim_exec_autocmds(event, opts) end

-- Execute Lua code. Parameters (if any) are available as `...`
-- inside the chunk. The chunk can return a value.
--- @param code string #Lua code to execute
--- @param args array #Arguments to the code
--- @return any #Return value of Lua code if present or NIL.
function vim.api.nvim_exec_lua(code, args) end

-- Sends input-keys to Nvim, subject to various quirks controlled
-- by `mode` flags. This is a blocking call, unlike
-- |nvim_input()|.
--- @param keys string #to be typed
--- @param mode string #behavior flags, see |feedkeys()|
--- @param escape_ks boolean #If true, escape K_SPECIAL bytes in `keys`
---                  This should be false if you already used
---                  |nvim_replace_termcodes()|, and true
---                  otherwise.
function vim.api.nvim_feedkeys(keys, mode, escape_ks) end

-- Gets the option information for all options.
--- @return any #dictionary of all options
function vim.api.nvim_get_all_options_info() end

-- Returns a 2-tuple (Array), where item 0 is the current channel
-- id and item 1 is the |api-metadata| map (Dictionary).
--- @return any #2-tuple [{channel-id}, {api-metadata}]
function vim.api.nvim_get_api_info() end

-- Get all autocommands that match the corresponding {opts}.
--- @param opts dict(get_autocmds) * #Dictionary with at least one of the following:
---             • group (string|integer): the autocommand group
---               name or id to match against.
---             • event (string|array): event or events to match
---               against |autocmd-events|.
---             • pattern (string|array): pattern or patterns to
---               match against |autocmd-pattern|.
--- @return any #Array of autocommands matching the criteria, with each
---     item containing the following fields:
---     • id (number): the autocommand id (only when defined with
---       the API).
---     • group (integer): the autocommand group id.
---     • desc (string): the autocommand description.
---     • event (string): the autocommand event.
---     • command (string): the autocommand command.
---     • once (boolean): whether the autocommand is only run
---       once.
---     • pattern (string): the autocommand pattern. If the
---       autocommand is buffer local |autocmd-buffer-local|:
---     • buflocal (boolean): true if the autocommand is buffer
---       local.
---     • buffer (number): the buffer number.
function vim.api.nvim_get_autocmds(opts) end

-- Gets information about a channel.
--- @param chan integer
--- @return any #Dictionary describing a channel, with these keys:
---     • "id" Channel id.
---     • "argv" (optional) Job arguments list.
---     • "stream" Stream underlying the channel.
---       • "stdio" stdin and stdout of this Nvim instance
---       • "stderr" stderr of this Nvim instance
---       • "socket" TCP/IP socket or named pipe
---       • "job" Job with communication over its stdio.
---
---     • "mode" How data received on the channel is interpreted.
---       • "bytes" Send and receive raw bytes.
---       • "terminal" |terminal| instance interprets ASCII
---         sequences.
---       • "rpc" |RPC| communication on the channel is active.
---
---     • "pty" (optional) Name of pseudoterminal. On a POSIX
---       system this is a device path like "/dev/pts/1". If the
---       name is unknown, the key will still be present if a pty
---       is used (e.g. for conpty on Windows).
---     • "buffer" (optional) Buffer with connected |terminal|
---       instance.
---     • "client" (optional) Info about the peer (client on the
---       other end of the RPC channel), if provided by it via
---       |nvim_set_client_info()|.
function vim.api.nvim_get_chan_info(chan) end

-- Returns the 24-bit RGB value of a |nvim_get_color_map()| color
-- name or "#rrggbb" hexadecimal string.
--- @param name string #Color name or "#rrggbb" string
--- @return any #24-bit RGB value, or -1 for invalid argument.
function vim.api.nvim_get_color_by_name(name) end

-- Returns a map of color names and RGB values.
--- @return any #Map of color names and RGB values.
function vim.api.nvim_get_color_map() end

-- Gets a map of global (non-buffer-local) Ex commands.
--- @param opts dict(get_commands) * #Optional parameters. Currently only supports
---             {"builtin":false}
--- @return any #Map of maps describing commands.
function vim.api.nvim_get_commands(opts) end

-- Gets a map of the current editor state.
--- @param opts dict(context) * #Optional parameters.
---             • types: List of |context-types| ("regs", "jumps",
---               "bufs", "gvars", …) to gather, or empty for
---               "all".
--- @return any #map of global |context|.
function vim.api.nvim_get_context(opts) end

-- Gets the current buffer.
--- @return any #Buffer handle
function vim.api.nvim_get_current_buf() end

-- Gets the current line.
--- @return any #Current line string
function vim.api.nvim_get_current_line() end

-- Gets the current tabpage.
--- @return any #Tabpage handle
function vim.api.nvim_get_current_tabpage() end

-- Gets the current window.
--- @return any #Window handle
function vim.api.nvim_get_current_win() end

-- Gets a highlight definition by id. |hlID()|
--- @param hl_id integer #Highlight id as returned by |hlID()|
--- @param rgb boolean #Export RGB colors
--- @return any #Highlight definition map
function vim.api.nvim_get_hl_by_id(hl_id, rgb) end

-- Gets a highlight definition by name.
--- @param name string #Highlight group name
--- @param rgb boolean #Export RGB colors
--- @return any #Highlight definition map
function vim.api.nvim_get_hl_by_name(name, rgb) end

-- Gets a highlight group by name
--- @param name string
function vim.api.nvim_get_hl_id_by_name(name) end

-- Gets a list of global (non-buffer-local) |mapping|
-- definitions.
--- @param mode string #Mode short-name ("n", "i", "v", ...)
--- @return any #Array of maparg()-like dictionaries describing mappings.
---     The "buffer" key is always zero.
function vim.api.nvim_get_keymap(mode) end

-- Return a tuple (row, col, buffer, buffername) representing the
-- position of the uppercase/file named mark. See |mark-motions|.
--- @param name string #Mark name
--- @param opts dictionary #Optional parameters. Reserved for future use.
--- @return any #4-tuple (row, col, buffer, buffername), (0, 0, 0, '') if
---     the mark is not set.
function vim.api.nvim_get_mark(name, opts) end

-- Gets the current mode. |mode()| "blocking" is true if Nvim is
-- waiting for input.
--- @return any #Dictionary { "mode": String, "blocking": Boolean }
function vim.api.nvim_get_mode() end

-- Gets existing, non-anonymous namespaces.
--- @return any #dict that maps from names to namespace ids.
function vim.api.nvim_get_namespaces() end

-- Gets the global value of an option.
--- @param name string #Option name
--- @return any #Option value (global)
function vim.api.nvim_get_option(name) end

-- Gets the option information for one option
--- @param name string #Option name
--- @return any #Option Information
function vim.api.nvim_get_option_info(name) end

-- Gets the value of an option. The behavior of this function
-- matches that of |:set|: the local value of an option is
-- returned if it exists; otherwise, the global value is
-- returned. Local values always correspond to the current buffer
-- or window. To get a buffer-local or window-local option for a
-- specific buffer or window, use |nvim_buf_get_option()| or
-- |nvim_win_get_option()|.
--- @param name string #Option name
--- @param opts dict(option) * #Optional parameters
---             • scope: One of 'global' or 'local'. Analogous to
---               |:setglobal| and |:setlocal|, respectively.
--- @return any #Option value
function vim.api.nvim_get_option_value(name, opts) end

-- Gets info describing process `pid`.
--- @param pid integer
--- @return any #Map of process properties, or NIL if process not found.
function vim.api.nvim_get_proc(pid) end

-- Gets the immediate children of process `pid`.
--- @param pid integer
--- @return any #Array of child process ids, empty if process not found.
function vim.api.nvim_get_proc_children(pid) end

-- Find files in runtime directories
--- @param name string #pattern of files to search for
--- @param all boolean #whether to return all matches or only the first
--- @return any #list of absolute paths to the found files
function vim.api.nvim_get_runtime_file(name, all) end

-- Gets a global (g:) variable.
--- @param name string #Variable name
--- @return any #Variable value
function vim.api.nvim_get_var(name) end

-- Gets a v: variable.
--- @param name string #Variable name
--- @return any #Variable value
function vim.api.nvim_get_vvar(name) end

-- Queues raw user-input. Unlike |nvim_feedkeys()|, this uses a
-- low-level input buffer and the call is non-blocking (input is
-- processed asynchronously by the eventloop).
--- @param keys string #to be typed
--- @return any #Number of bytes actually written (can be fewer than
---     requested if the buffer becomes full).
function vim.api.nvim_input(keys) end

-- Send mouse event from GUI.
--- @param button string #Mouse button: one of "left", "right",
---                 "middle", "wheel".
--- @param action string #For ordinary buttons, one of "press", "drag",
---                 "release". For the wheel, one of "up", "down",
---                 "left", "right".
--- @param modifier string #String of modifiers each represented by a
---                 single char. The same specifiers are used as
---                 for a key press, except that the "-" separator
---                 is optional, so "C-A-", "c-a" and "CA" can all
---                 be used to specify Ctrl+Alt+click.
--- @param grid integer #Grid number if the client uses |ui-multigrid|,
---                 else 0.
--- @param row integer #Mouse row-position (zero-based, like redraw
---                 events)
--- @param col integer #Mouse column-position (zero-based, like redraw
---                 events)
function vim.api.nvim_input_mouse(button, action, modifier, grid, row, col) end

-- Gets the current list of buffer handles
--- @return any #List of buffer handles
function vim.api.nvim_list_bufs() end

-- Get information about all open channels.
--- @return any #Array of Dictionaries, each describing a channel with the
---     format specified at |nvim_get_chan_info()|.
function vim.api.nvim_list_chans() end

-- Gets the paths contained in 'runtimepath'.
--- @return any #List of paths
function vim.api.nvim_list_runtime_paths() end

-- Gets the current list of tabpage handles.
--- @return any #List of tabpage handles
function vim.api.nvim_list_tabpages() end

-- Gets a list of dictionaries representing attached UIs.
--- @return any #Array of UI dictionaries, each with these keys:
---     • "height" Requested height of the UI
---     • "width" Requested width of the UI
---     • "rgb" true if the UI uses RGB colors (false implies
---       |cterm-colors|)
---     • "ext_..." Requested UI extensions, see |ui-option|
---     • "chan" Channel id of remote UI (not present for TUI)
function vim.api.nvim_list_uis() end

-- Gets the current list of window handles.
--- @return any #List of window handles
function vim.api.nvim_list_wins() end

-- Sets the current editor state from the given |context| map.
--- @param dict dictionary #|Context| map.
function vim.api.nvim_load_context(dict) end

-- Notify the user with a message
--- @param msg string #Message to display to the user
--- @param log_level integer #The log level
--- @param opts dictionary #Reserved for future use.
function vim.api.nvim_notify(msg, log_level, opts) end

-- Open a terminal instance in a buffer
--- @param buffer buffer #the buffer to use (expected to be empty)
--- @param opts table<string, luaref> #Optional parameters.
---               • on_input: lua callback for input sent, i e
---                 keypresses in terminal mode. Note: keypresses
---                 are sent raw as they would be to the pty
---                 master end. For instance, a carriage return is
---                 sent as a "\r", not as a "\n". |textlock|
---                 applies. It is possible to call
---                 |nvim_chan_send| directly in the callback
---                 however. ["input", term, bufnr, data]
--- @return any #Channel id, or 0 on error
function vim.api.nvim_open_term(buffer, opts) end

-- Open a new window.
--- @param buffer buffer #Buffer to display, or 0 for current buffer
--- @param enter boolean #Enter the window (make it the current window)
--- @param config dict(float_config) * #Map defining the window configuration. Keys:
---               • relative: Sets the window layout to
---                 "floating", placed at (row,col) coordinates
---                 relative to:
---                 • "editor" The global editor grid
---                 • "win" Window given by the `win` field, or
---                   current window.
---                 • "cursor" Cursor position in current window.
---
---               • win: |window-ID| for relative="win".
---               • anchor: Decides which corner of the float to
---                 place at (row,col):
---                 • "NW" northwest (default)
---                 • "NE" northeast
---                 • "SW" southwest
---                 • "SE" southeast
---
---               • width: Window width (in character cells).
---                 Minimum of 1.
---               • height: Window height (in character cells).
---                 Minimum of 1.
---               • bufpos: Places float relative to buffer text
---                 (only when relative="win"). Takes a tuple of
---                 zero-indexed [line, column]. `row` and `col` if given are applied relative to this
---                 position, else they default to:
---                 • `row=1` and `col=0` if `anchor` is "NW" or
---                   "NE"
---                 • `row=0` and `col=0` if `anchor` is "SW" or
---                   "SE" (thus like a tooltip near the buffer
---                   text).
---
---               • row: Row position in units of "screen cell
---                 height", may be fractional.
---               • col: Column position in units of "screen cell
---                 width", may be fractional.
---               • focusable: Enable focus by user actions
---                 (wincmds, mouse events). Defaults to true.
---                 Non-focusable windows can be entered by
---                 |nvim_set_current_win()|.
---               • external: GUI should display the window as an
---                 external top-level window. Currently accepts
---                 no other positioning configuration together
---                 with this.
---               • zindex: Stacking order. floats with higher `zindex` go on top on floats with lower indices. Must
---                 be larger than zero. The following screen
---                 elements have hard-coded z-indices:
---                 • 100: insert completion popupmenu
---                 • 200: message scrollback
---                 • 250: cmdline completion popupmenu (when
---                   wildoptions+=pum) The default value for
---                   floats are 50. In general, values below 100
---                   are recommended, unless there is a good
---                   reason to overshadow builtin elements.
---
---               • style: Configure the appearance of the window.
---                 Currently only takes one non-empty value:
---                 • "minimal" Nvim will display the window with
---                   many UI options disabled. This is useful
---                   when displaying a temporary float where the
---                   text should not be edited. Disables
---                   'number', 'relativenumber', 'cursorline',
---                   'cursorcolumn', 'foldcolumn', 'spell' and
---                   'list' options. 'signcolumn' is changed to
---                   `auto` and 'colorcolumn' is cleared. The
---                   end-of-buffer region is hidden by setting
---                   `eob` flag of 'fillchars' to a space char,
---                   and clearing the |EndOfBuffer| region in
---                   'winhighlight'.
---
---               • border: Style of (optional) window border.
---                 This can either be a string or an array. The
---                 string values are
---                 • "none": No border (default).
---                 • "single": A single line box.
---                 • "double": A double line box.
---                 • "rounded": Like "single", but with rounded
---                   corners ("╭" etc.).
---                 • "solid": Adds padding by a single whitespace
---                   cell.
---                 • "shadow": A drop shadow effect by blending
---                   with the background.
---                 • If it is an array, it should have a length
---                   of eight or any divisor of eight. The array
---                   will specifify the eight chars building up
---                   the border in a clockwise fashion starting
---                   with the top-left corner. As an example, the
---                   double box style could be specified as [
---                   "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" ]. If
---                   the number of chars are less than eight,
---                   they will be repeated. Thus an ASCII border
---                   could be specified as [ "/", "-", "\\", "|"
---                   ], or all chars the same as [ "x" ]. An
---                   empty string can be used to turn off a
---                   specific border, for instance, [ "", "", "",
---                   ">", "", "", "", "<" ] will only make
---                   vertical borders but not horizontal ones. By
---                   default, `FloatBorder` highlight is used,
---                   which links to `WinSeparator` when not
---                   defined. It could also be specified by
---                   character: [ {"+", "MyCorner"}, {"x",
---                   "MyBorder"} ].
---
---               • noautocmd: If true then no buffer-related
---                 autocommand events such as |BufEnter|,
---                 |BufLeave| or |BufWinEnter| may fire from
---                 calling this function.
--- @return any #Window handle, or 0 on error
function vim.api.nvim_open_win(buffer, enter, config) end

