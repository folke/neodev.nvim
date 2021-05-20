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
---                    notification will be `nvim_buf_lines_event`
---                    . Else the first notification will be
---                    `nvim_buf_changedtick_event` . Not for Lua
---                    callbacks.
--- @param opts table<string, luaref> #Optional parameters.
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
--- @param opts dictionary #Optional parameters. Currently not used.
--- @return any #Map of maps describing commands.
function vim.api.nvim_buf_get_commands(buffer, opts) end

-- Returns position for a given extmark id
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param ns_id integer #Namespace id from |nvim_create_namespace()|
--- @param id integer #Extmark id
--- @param opts dictionary #Optional parameters. Keys:
---               • details: Whether to include the details dict
--- @return any #(row, col) tuple or empty list () if extmark id was absent
function vim.api.nvim_buf_get_extmark_by_id(buffer, ns_id, id, opts) end

-- Gets extmarks in "traversal order" from a |charwise| region
-- defined by buffer positions (inclusive, 0-indexed
-- |api-indexing|).
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param ns_id integer #Namespace id from |nvim_create_namespace()|
--- @param start object #Start of range, given as (row, col) or valid
---               extmark id (whose position defines the bound)
--- @param end_ object #End of range, given as (row, col) or valid
---               extmark id (whose position defines the bound)
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

