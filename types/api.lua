--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Tell Nvim to resize a grid. Triggers a grid_resize event with
-- the requested grid size or the maximum size if it exceeds size
-- limits.
--- @param width integer #The new requested width.
--- @param grid integer #The handle of the grid to be changed.
--- @param height integer #The new requested height.
function vim.api.nvim_ui_try_resize_grid(grid, width, height) end

-- Deactivates buffer-update events on the channel.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @return any #False if detach failed (because the buffer isn't loaded);
---     otherwise True.
function vim.api.nvim_buf_detach(buffer) end

-- Gets the buffer line count
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @return any #Line count, or 0 for unloaded buffer. |api-buffer|
function vim.api.nvim_buf_line_count(buffer) end

-- Activates buffer-update events on a channel, or as Lua
-- callbacks.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param send_buffer boolean #True if the initial notification should
---                    contain the whole buffer: first
---                    notification will be `nvim_buf_lines_event`
---                    . Else the first notification will be
---                    `nvim_buf_changedtick_event` . Not for Lua
---                    callbacks.
--- @param opts dictionaryof(luaref) #Optional parameters.
---                    • on_lines: Lua callback invoked on change.
---                      Return`true`to detach. Args:
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
---                      on_lines. Return`true`to detach. Args:
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
---                      • the string "detach"
---                      • buffer handle
--- 
---                    • utf_sizes: include UTF-32 and UTF-16 size
---                      of the replaced region, as args to
---                      `on_lines` .
---                    • preview: also attach to command preview
---                      (i.e. 'inccommand') events.
--- @return any #False if attach failed (invalid parameter, or buffer isn't
---     loaded); otherwise True. TODO: LUA_API_NO_EVAL
function vim.api.nvim_buf_attach(buffer, send_buffer, opts) end

function vim.api.nvim__buf_redraw_range(buffer, first, last) end

-- Gets a line-range from the buffer.
--- @param _end integer #Last line index (exclusive)
--- @param start integer #First line index
--- @param strict_indexing boolean #Whether out-of-bounds should be an
---                        error.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @return any #Array of lines, or empty array for unloaded buffer.
function vim.api.nvim_buf_get_lines(buffer, start, _end, strict_indexing) end

-- Sets (replaces) a line-range in the buffer.
--- @param strict_indexing boolean #Whether out-of-bounds should be an
---                        error.
--- @param replacement string[] #Array of lines to use as replacement
--- @param start integer #First line index
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param _end integer #Last line index (exclusive)
function vim.api.nvim_buf_set_lines(buffer, start, _end, strict_indexing, replacement) end

-- Sets (replaces) a range in the buffer
--- @param start_row integer #First line index
--- @param start_column any #Last column
--- @param end_row integer #Last line index
--- @param replacement string[] #Array of lines to use as replacement
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param end_column any #Last column
function vim.api.nvim_buf_set_text(buffer, start_row, start_col, end_row, end_col, replacement) end

-- Returns the byte offset of a line (0-indexed). |api-indexing|
--- @param index integer #Line index
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @return any #Integer byte offset, or -1 for unloaded buffer.
function vim.api.nvim_buf_get_offset(buffer, index) end

-- Gets a buffer-scoped (b:) variable.
--- @param name string #Variable name
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @return any #Variable value
function vim.api.nvim_buf_get_var(buffer, name) end

-- Gets a changed tick of a buffer
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @return any #`b:changedtick` value.
function vim.api.nvim_buf_get_changedtick(buffer) end

-- Gets a list of buffer-local |mapping| definitions.
--- @param mode string #Mode short-name ("n", "i", "v", ...)
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @return any #Array of maparg()-like dictionaries describing mappings.
---     The "buffer" key holds the associated buffer handle.
function vim.api.nvim_buf_get_keymap(buffer, mode) end

-- Sets a buffer-local |mapping| for the given mode.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
function vim.api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts) end

-- Unmaps a buffer-local |mapping| for the given mode.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
function vim.api.nvim_buf_del_keymap(buffer, mode, lhs) end

-- Gets a map of buffer-local |user-commands|.
--- @param opts dictionary #Optional parameters. Currently not used.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @return any #Map of maps describing commands.
function vim.api.nvim_buf_get_commands(buffer, opts) end

-- Sets a buffer-scoped (b:) variable
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param name string #Variable name
--- @param value object #Variable value
function vim.api.nvim_buf_set_var(buffer, name, value) end

-- Removes a buffer-scoped (b:) variable
--- @param name string #Variable name
--- @param buffer buffer #Buffer handle, or 0 for current buffer
function vim.api.nvim_buf_del_var(buffer, name) end

-- Gets a buffer option value
--- @param name string #Option name
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @return any #Option value
function vim.api.nvim_buf_get_option(buffer, name) end

-- Sets a buffer option value. Passing 'nil' as value deletes the
-- option (only works if there's a global fallback)
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param name string #Option name
--- @param value object #Option value
function vim.api.nvim_buf_set_option(buffer, name, value) end

-- Gets the full file name for the buffer
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @return any #Buffer name
function vim.api.nvim_buf_get_name(buffer) end

-- Sets the full file name for a buffer
--- @param name string #Buffer name
--- @param buffer buffer #Buffer handle, or 0 for current buffer
function vim.api.nvim_buf_set_name(buffer, name) end

-- Gets window configuration.
--- @param window window #Window handle, or 0 for current window
--- @return any #Map defining the window configuration, see
---     |nvim_open_win()|
function vim.api.nvim_win_get_config(window) end

-- Closes the window and hide the buffer it contains (like
-- |:hide| with a |window-ID|).
--- @param window window #Window handle, or 0 for current window
function vim.api.nvim_win_hide(window) end

-- Closes the window (like |:close| with a |window-ID|).
--- @param window window #Window handle, or 0 for current window
--- @param force boolean #Behave like `:close!` The last window of a
---               buffer with unwritten changes can be closed. The
---               buffer will become hidden, even if 'hidden' is
---               not set.
function vim.api.nvim_win_close(window, force) end

-- Return a tuple (row,col) representing the position of the
-- named mark.
--- @param name string #Mark name
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @return any #(row, col) tuple
function vim.api.nvim_buf_get_mark(buffer, name) end

-- Returns position for a given extmark id
--- @param id integer #Extmark id
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param opts dictionary #Optional parameters. Keys:
---               • details: Whether to include the details dict
--- @param ns_id integer #Namespace id from |nvim_create_namespace()|
--- @return any #(row, col) tuple or empty list () if extmark id was absent
function vim.api.nvim_buf_get_extmark_by_id(buffer, ns_id, id, opts) end

