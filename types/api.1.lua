--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Gets extmarks in "traversal order" from a |charwise| region
-- defined by buffer positions (inclusive, 0-indexed
-- |api-indexing|).
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param _end object #End of range, given as (row, col) or valid
---               extmark id (whose position defines the bound)
--- @param start object #Start of range, given as (row, col) or valid
---               extmark id (whose position defines the bound)
--- @param opts dictionary #Optional parameters. Keys:
---               • limit: Maximum number of marks to return
---               • details Whether to include the details dict
--- @param ns_id integer #Namespace id from |nvim_create_namespace()|
--- @return any #List of [extmark_id, row, col] tuples in "traversal
---     order".
function vim.api.nvim_buf_get_extmarks(buffer, ns_id, start, _end, opts) end

-- Creates or updates an extmark.
--- @param ns_id integer #Namespace id from |nvim_create_namespace()|
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param line integer #Line number where to place the mark
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
--- @param col integer #Column where to place the mark
--- @return any #Id of the created/updated extmark
function vim.api.nvim_buf_set_extmark(buffer, ns_id, line, col, opts) end

-- Removes an extmark.
--- @param id integer #Extmark id
--- @param ns_id integer #Namespace id from |nvim_create_namespace()|
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @return any #true if the extmark was found, else false
function vim.api.nvim_buf_del_extmark(buffer, ns_id, id) end

-- Adds a highlight to buffer.
--- @param ns_id integer #namespace to use or -1 for ungrouped
---                  highlight
--- @param hl_group string #Name of the highlight group to use
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param col_start integer #Start of (byte-indexed) column range to
---                  highlight
--- @param col_end integer #End of (byte-indexed) column range to
---                  highlight, or -1 to highlight to end of line
--- @param line integer #Line to highlight (zero-indexed)
--- @return any #The ns_id that was used
function vim.api.nvim_buf_add_highlight(buffer, ns_id, hl_group, line, col_start, col_end) end

-- Clears namespaced objects (highlights, extmarks, virtual text)
-- from a region.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param ns_id integer #Namespace to clear, or -1 to clear all
---                   namespaces.
--- @param line_start integer #Start of range of lines to clear
--- @param line_end integer #End of range of lines to clear (exclusive)
---                   or -1 to clear to end of buffer.
function vim.api.nvim_buf_clear_namespace(buffer, ns_id, line_start, line_end) end

-- Set the virtual text (annotation) for a buffer line.
--- @param ns_id any #Namespace to use or 0 to create a namespace, or
---               -1 for a ungrouped annotation
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @param opts dictionary #Optional parameters. Currently not used.
--- @param chunks array #A list of [text, hl_group] arrays, each
---               representing a text chunk with specified
---               highlight. `hl_group` element can be omitted for
---               no highlight.
--- @param line integer #Line to annotate with virtual text
---               (zero-indexed)
--- @return any #The ns_id that was used
function vim.api.nvim_buf_set_virtual_text(buffer, src_id, line, chunks, opts) end

-- call a function with buffer as temporary current buffer
--- @param fun luaref #Function to call inside the buffer (currently
---               lua callable only)
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @return any #Return value of function. NB: will deepcopy lua values
---     currently, use upvalues to send lua references in and out.
function vim.api.nvim_buf_call(buffer, fun) end

function vim.api.nvim__buf_stats(buffer) end

-- Gets the windows in a tabpage
--- @param tabpage tabpage #Tabpage handle, or 0 for current tabpage
--- @return any #List of windows in `tabpage`
function vim.api.nvim_tabpage_list_wins(tabpage) end

-- Gets a tab-scoped (t:) variable
--- @param name string #Variable name
--- @param tabpage tabpage #Tabpage handle, or 0 for current tabpage
--- @return any #Variable value
function vim.api.nvim_tabpage_get_var(tabpage, name) end

-- Sets a tab-scoped (t:) variable
--- @param value object #Variable value
--- @param name string #Variable name
--- @param tabpage tabpage #Tabpage handle, or 0 for current tabpage
function vim.api.nvim_tabpage_set_var(tabpage, name, value) end

-- Removes a tab-scoped (t:) variable
--- @param name string #Variable name
--- @param tabpage tabpage #Tabpage handle, or 0 for current tabpage
function vim.api.nvim_tabpage_del_var(tabpage, name) end

-- Gets the current window in a tabpage
--- @param tabpage tabpage #Tabpage handle, or 0 for current tabpage
--- @return any #Window handle
function vim.api.nvim_tabpage_get_win(tabpage) end

-- Gets the tabpage number
--- @param tabpage tabpage #Tabpage handle, or 0 for current tabpage
--- @return any #Tabpage number
function vim.api.nvim_tabpage_get_number(tabpage) end

-- Checks if a tabpage is valid
--- @param tabpage tabpage #Tabpage handle, or 0 for current tabpage
--- @return any #true if the tabpage is valid, false otherwise
function vim.api.nvim_tabpage_is_valid(tabpage) end

-- Executes Vimscript (multiline block of Ex-commands), like
-- anonymous |:source|.
--- @param output boolean #Capture and return all (non-error, non-shell
---               |:!|) output
--- @param src string #Vimscript code
--- @return any #Output (non-error, non-shell |:!|) if `output` is true,
---     else empty string.
function vim.api.nvim_exec(src, output) end

-- Executes an ex-command.
--- @param command string #Ex-command string
function vim.api.nvim_command(command) end

-- Activates UI events on the channel.
--- @param width integer #Requested screen columns
--- @param options dictionary #|ui-option| map
--- @param height integer #Requested screen rows
function vim.api.nvim_ui_attach(width, height, options) end

-- Gets a highlight definition by id. |hlID()|
--- @param hl_id integer #Highlight id as returned by |hlID()|
--- @param rgb boolean #Export RGB colors
--- @return any #Highlight definition map
function vim.api.nvim_get_hl_by_id(hl_id, rgb) end

-- Gets a highlight group by name
function vim.api.nvim_get_hl_id_by_name(name) end

function vim.api.nvim__get_hl_defs(ns_id) end

-- Set a highlight group.
--- @param val dictionary #highlight definiton map, like
---              |nvim_get_hl_by_name|. in addition the following
---              keys are also recognized: `default` : don't
---              override existing definition, like `hi default`
--- @param name string #highlight group name, like ErrorMsg
--- @param ns_id integer #number of namespace for this highlight
function vim.api.nvim_set_hl(ns_id, name, val) end

-- Set active namespace for highlights.
--- @param ns_id integer #the namespace to activate
function vim.api.nvim__set_hl_ns(ns_id) end

-- Sends input-keys to Nvim, subject to various quirks controlled
-- by `mode` flags. This is a blocking call, unlike
-- |nvim_input()|.
--- @param escape_csi boolean #If true, escape K_SPECIAL/CSI bytes in
---                   `keys`
--- @param mode string #behavior flags, see |feedkeys()|
--- @param keys string #to be typed
function vim.api.nvim_feedkeys(keys, mode, escape_csi) end

