--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

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

-- Gets internal stats.
--- @return any #Map of various internal stats.
function vim.api.nvim__stats() end

-- Deactivates UI events on the channel.
function vim.api.nvim_ui_detach() end

-- Gets the immediate children of process `pid` .
--- @return any #Array of child process ids, empty if process not found.
function vim.api.nvim_get_proc_children(pid) end

-- Gets info describing process `pid` .
--- @return any #Map of process properties, or NIL if process not found.
function vim.api.nvim_get_proc(pid) end

-- Selects an item in the completion popupmenu.
--- @param finish boolean #Finish the completion and dismiss the popupmenu.
---               Implies `insert` .
--- @param item integer #Index (zero-based) of the item to select. Value
---               of -1 selects nothing and restores the original
---               text.
--- @param opts dictionary #Optional parameters. Reserved for future use.
--- @param insert boolean #Whether the selection should be inserted in the
---               buffer.
function vim.api.nvim_select_popupmenu_item(item, insert, finish, opts) end

-- NB: if your UI doesn't use hlstate, this will not return
-- hlstate first time.
function vim.api.nvim__inspect_cell(grid, row, col) end

function vim.api.nvim__screenshot(path) end

-- Set or change decoration provider for a namespace
--- @param opts dictionaryof(luaref) #Callbacks invoked during redraw:
---              • on_start: called first on each screen redraw
---                ["start", tick]
---              • on_buf: called for each buffer being redrawn
---                (before window callbacks) ["buf", bufnr, tick]
---              • on_win: called when starting to redraw a
---                specific window. ["win", winid, bufnr, topline,
---                botline_guess]
---              • on_line: called for each buffer line being
---                redrawn. (The interation with fold lines is
---                subject to change) ["win", winid, bufnr, row]
---              • on_end: called at the end of a redraw cycle
---                ["end", tick]
--- @param ns_id integer #Namespace id from |nvim_create_namespace()|
function vim.api.nvim_set_decoration_provider(ns_id, opts) end

-- Returns a 2-tuple (Array), where item 0 is the current channel
-- id and item 1 is the |api-metadata| map (Dictionary).
--- @return any #2-tuple [{channel-id}, {api-metadata}]
function vim.api.nvim_get_api_info() end

-- Sets the current buffer in a window, without side-effects
--- @param window window #Window handle, or 0 for current window
--- @param buffer buffer #Buffer handle
function vim.api.nvim_win_set_buf(window, buffer) end

-- Gets the (1,0)-indexed cursor position in the window.
-- |api-indexing|
--- @param window window #Window handle, or 0 for current window
--- @return any #(row, col) tuple
function vim.api.nvim_win_get_cursor(window) end

-- Sets the (1,0)-indexed cursor position in the window.
-- |api-indexing|
--- @param window window #Window handle, or 0 for current window
--- @param pos arrayof(integer, 2) #(row, col) tuple representing the new position
function vim.api.nvim_win_set_cursor(window, pos) end

-- Gets the window height
--- @param window window #Window handle, or 0 for current window
--- @return any #Height as a count of rows
function vim.api.nvim_win_get_height(window) end

-- Sets the window height. This will only succeed if the screen
-- is split horizontally.
--- @param window window #Window handle, or 0 for current window
--- @param height integer #Height as a count of rows
function vim.api.nvim_win_set_height(window, height) end

-- Gets the window width
--- @param window window #Window handle, or 0 for current window
--- @return any #Width as a count of columns
function vim.api.nvim_win_get_width(window) end

-- Sets the window width. This will only succeed if the screen is
-- split vertically.
--- @param window window #Window handle, or 0 for current window
--- @param width integer #Width as a count of columns
function vim.api.nvim_win_set_width(window, width) end

-- Gets a window-scoped (w:) variable
--- @param name string #Variable name
--- @param window window #Window handle, or 0 for current window
--- @return any #Variable value
function vim.api.nvim_win_get_var(window, name) end

-- Sets a window-scoped (w:) variable
--- @param window window #Window handle, or 0 for current window
--- @param name string #Variable name
--- @param value object #Variable value
function vim.api.nvim_win_set_var(window, name, value) end

-- Removes a window-scoped (w:) variable
--- @param name string #Variable name
--- @param window window #Window handle, or 0 for current window
function vim.api.nvim_win_del_var(window, name) end

-- Gets a window option value
--- @param name string #Option name
--- @param window window #Window handle, or 0 for current window
--- @return any #Option value
function vim.api.nvim_win_get_option(window, name) end

-- Sets a window option value. Passing 'nil' as value deletes the
-- option(only works if there's a global fallback)
--- @param window window #Window handle, or 0 for current window
--- @param name string #Option name
--- @param value object #Option value
function vim.api.nvim_win_set_option(window, name, value) end

-- Gets the window position in display cells. First position is
-- zero.
--- @param window window #Window handle, or 0 for current window
--- @return any #(row, col) tuple with the window position
function vim.api.nvim_win_get_position(window) end

-- Gets the window tabpage
--- @param window window #Window handle, or 0 for current window
--- @return any #Tabpage that contains the window
function vim.api.nvim_win_get_tabpage(window) end

-- Gets the window number
--- @param window window #Window handle, or 0 for current window
--- @return any #Window number
function vim.api.nvim_win_get_number(window) end

-- Checks if a window is valid
--- @param window window #Window handle, or 0 for current window
--- @return any #true if the window is valid, false otherwise
function vim.api.nvim_win_is_valid(window) end

function vim.api.nvim_ui_try_resize(width, height) end

-- Subscribes to event broadcasts.
--- @param event string #Event type string
function vim.api.nvim_subscribe(event) end

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

-- Tells Nvim the geometry of the popumenu, to align floating
-- windows with an external popup menu.
--- @param width float #Popupmenu width.
--- @param height float #Popupmenu height.
--- @param row float #Popupmenu row.
--- @param col float #Popupmenu height.
function vim.api.nvim_ui_pum_set_bounds(width, height, row, col) end

-- Unsubscribes to event broadcasts.
--- @param event string #Event type string
function vim.api.nvim_unsubscribe(event) end

-- Execute Lua code. Parameters (if any) are available as `...`
-- inside the chunk. The chunk can return a value.
--- @param args any[] #Arguments to the code
--- @param code string #Lua code to execute
--- @return any #Return value of Lua code if present or NIL.
function vim.api.nvim_exec_lua(code, args) end

-- Configures window layout. Currently only for floating and
-- external windows (including changing a split window to those
-- layouts).
--- @param window window #Window handle, or 0 for current window
--- @param config dictionary #Map defining the window configuration, see
---               |nvim_open_win()|
function vim.api.nvim_win_set_config(window, config) end

-- Deletes the buffer. See |:bwipeout|
--- @param opts dictionary #Optional parameters. Keys:
---               • force: Force deletion and ignore unsaved
---                 changes.
---               • unload: Unloaded only, do not delete. See
---                 |:bunload|
--- @param buffer buffer #Buffer handle, or 0 for current buffer
function vim.api.nvim_buf_delete(buffer, opts) end

-- Self-identifies the client.
--- @param version dictionary #Dictionary describing the version, with
---                   these (optional) keys:
---                   • "major" major version (defaults to 0 if
---                     not set, for no release yet)
---                   • "minor" minor version
---                   • "patch" patch number
---                   • "prerelease" string describing a
---                     prerelease, like "dev" or "beta1"
---                   • "commit" hash or similar identifier of
---                     commit
--- @param name string #Short name for the connected client
--- @param methods dictionary #Builtin methods in the client. For a host,
---                   this does not include plugin methods which
---                   will be discovered later. The key should be
---                   the method name, the values are dicts with
---                   these (optional) keys (more keys may be
---                   added in future versions of Nvim, thus
---                   unknown keys are ignored. Clients must only
---                   use keys defined in this or later versions
---                   of Nvim):
---                   • "async" if true, send as a notification.
---                     If false or unspecified, use a blocking
---                     request
---                   • "nargs" Number of arguments. Could be a
---                     single integer or an array of two
---                     integers, minimum and maximum inclusive.
--- @param attributes dictionary #Arbitrary string:string map of informal
---                   client properties. Suggested keys:
---                   • "website": Client homepage URL (e.g.
---                     GitHub repository)
---                   • "license": License description ("Apache
---                     2", "GPLv3", "MIT", …)
---                   • "logo": URI or path to image, preferably
---                     small logo or icon. .png or .svg format is
---                     preferred.
--- @param type string #Must be one of the following values. Client
---                   libraries should default to "remote" unless
---                   overridden by the user.
---                   • "remote" remote client connected to Nvim.
---                   • "ui" gui frontend
---                   • "embedder" application using Nvim as a
---                     component (for example, IDE/editor
---                     implementing a vim mode).
---                   • "host" plugin host, typically started by
---                     nvim
---                   • "plugin" single plugin, started by nvim
function vim.api.nvim_set_client_info(name, version, type, methods, attributes) end

