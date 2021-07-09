--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Sets an option value.
--- @param name string #Option name
--- @param value object #New option value
function vim.api.nvim_set_option(name, value) end

-- Sets a global (g:) variable.
--- @param name string #Variable name
--- @param value object #Variable value
function vim.api.nvim_set_var(name, value) end

-- Sets a v: variable, if it is not readonly.
--- @param name string #Variable name
--- @param value object #Variable value
function vim.api.nvim_set_vvar(name, value) end

-- Calculates the number of display cells occupied by `text` .
-- <Tab> counts as one cell.
--- @param text string #Some text
--- @return any #Number of cells
function vim.api.nvim_strwidth(text) end

-- Subscribes to event broadcasts.
--- @param event string #Event type string
function vim.api.nvim_subscribe(event) end

-- Removes a tab-scoped (t:) variable
--- @param tabpage tabpage #Tabpage handle, or 0 for current tabpage
--- @param name string #Variable name
function vim.api.nvim_tabpage_del_var(tabpage, name) end

-- Gets the tabpage number
--- @param tabpage tabpage #Tabpage handle, or 0 for current tabpage
--- @return any #Tabpage number
function vim.api.nvim_tabpage_get_number(tabpage) end

-- Gets a tab-scoped (t:) variable
--- @param tabpage tabpage #Tabpage handle, or 0 for current tabpage
--- @param name string #Variable name
--- @return any #Variable value
function vim.api.nvim_tabpage_get_var(tabpage, name) end

-- Gets the current window in a tabpage
--- @param tabpage tabpage #Tabpage handle, or 0 for current tabpage
--- @return any #Window handle
function vim.api.nvim_tabpage_get_win(tabpage) end

-- Checks if a tabpage is valid
--- @param tabpage tabpage #Tabpage handle, or 0 for current tabpage
--- @return any #true if the tabpage is valid, false otherwise
function vim.api.nvim_tabpage_is_valid(tabpage) end

-- Gets the windows in a tabpage
--- @param tabpage tabpage #Tabpage handle, or 0 for current tabpage
--- @return any #List of windows in `tabpage`
function vim.api.nvim_tabpage_list_wins(tabpage) end

-- Sets a tab-scoped (t:) variable
--- @param tabpage tabpage #Tabpage handle, or 0 for current tabpage
--- @param name string #Variable name
--- @param value object #Variable value
function vim.api.nvim_tabpage_set_var(tabpage, name, value) end

-- Activates UI events on the channel.
--- @param width integer #Requested screen columns
--- @param height integer #Requested screen rows
--- @param options dictionary #|ui-option| map
function vim.api.nvim_ui_attach(width, height, options) end

-- Deactivates UI events on the channel.
function vim.api.nvim_ui_detach() end

-- Tells Nvim the geometry of the popumenu, to align floating
-- windows with an external popup menu.
--- @param width float #Popupmenu width.
--- @param height float #Popupmenu height.
--- @param row float #Popupmenu row.
--- @param col float #Popupmenu height.
function vim.api.nvim_ui_pum_set_bounds(width, height, row, col) end

-- Tells Nvim the number of elements displaying in the popumenu,
-- to decide <PageUp> and <PageDown> movement.
--- @param height integer #Popupmenu height, must be greater than zero.
function vim.api.nvim_ui_pum_set_height(height) end

--- @param name string
--- @param value object
function vim.api.nvim_ui_set_option(name, value) end

--- @param width integer
--- @param height integer
function vim.api.nvim_ui_try_resize(width, height) end

-- Tell Nvim to resize a grid. Triggers a grid_resize event with
-- the requested grid size or the maximum size if it exceeds size
-- limits.
--- @param grid integer #The handle of the grid to be changed.
--- @param width integer #The new requested width.
--- @param height integer #The new requested height.
function vim.api.nvim_ui_try_resize_grid(grid, width, height) end

-- Unsubscribes to event broadcasts.
--- @param event string #Event type string
function vim.api.nvim_unsubscribe(event) end

-- Calls a function with window as temporary current window.
--- @param window window #Window handle, or 0 for current window
--- @param fun luaref #Function to call inside the window (currently
---               lua callable only)
--- @return any #Return value of function. NB: will deepcopy lua values
---     currently, use upvalues to send lua references in and out.
function vim.api.nvim_win_call(window, fun) end

-- Closes the window (like |:close| with a |window-ID|).
--- @param window window #Window handle, or 0 for current window
--- @param force boolean #Behave like `:close!` The last window of a
---               buffer with unwritten changes can be closed. The
---               buffer will become hidden, even if 'hidden' is
---               not set.
function vim.api.nvim_win_close(window, force) end

-- Removes a window-scoped (w:) variable
--- @param window window #Window handle, or 0 for current window
--- @param name string #Variable name
function vim.api.nvim_win_del_var(window, name) end

-- Gets the current buffer in a window
--- @param window window #Window handle, or 0 for current window
--- @return any #Buffer handle
function vim.api.nvim_win_get_buf(window) end

-- Gets window configuration.
--- @param window window #Window handle, or 0 for current window
--- @return any #Map defining the window configuration, see
---     |nvim_open_win()|
function vim.api.nvim_win_get_config(window) end

-- Gets the (1,0)-indexed cursor position in the window.
-- |api-indexing|
--- @param window window #Window handle, or 0 for current window
--- @return any #(row, col) tuple
function vim.api.nvim_win_get_cursor(window) end

-- Gets the window height
--- @param window window #Window handle, or 0 for current window
--- @return any #Height as a count of rows
function vim.api.nvim_win_get_height(window) end

-- Gets the window number
--- @param window window #Window handle, or 0 for current window
--- @return any #Window number
function vim.api.nvim_win_get_number(window) end

-- Gets a window option value
--- @param window window #Window handle, or 0 for current window
--- @param name string #Option name
--- @return any #Option value
function vim.api.nvim_win_get_option(window, name) end

-- Gets the window position in display cells. First position is
-- zero.
--- @param window window #Window handle, or 0 for current window
--- @return any #(row, col) tuple with the window position
function vim.api.nvim_win_get_position(window) end

-- Gets the window tabpage
--- @param window window #Window handle, or 0 for current window
--- @return any #Tabpage that contains the window
function vim.api.nvim_win_get_tabpage(window) end

-- Gets a window-scoped (w:) variable
--- @param window window #Window handle, or 0 for current window
--- @param name string #Variable name
--- @return any #Variable value
function vim.api.nvim_win_get_var(window, name) end

-- Gets the window width
--- @param window window #Window handle, or 0 for current window
--- @return any #Width as a count of columns
function vim.api.nvim_win_get_width(window) end

-- Closes the window and hide the buffer it contains (like
-- |:hide| with a |window-ID|).
--- @param window window #Window handle, or 0 for current window
function vim.api.nvim_win_hide(window) end

-- Checks if a window is valid
--- @param window window #Window handle, or 0 for current window
--- @return any #true if the window is valid, false otherwise
function vim.api.nvim_win_is_valid(window) end

-- Sets the current buffer in a window, without side-effects
--- @param window window #Window handle, or 0 for current window
--- @param buffer buffer #Buffer handle
function vim.api.nvim_win_set_buf(window, buffer) end

-- Configures window layout. Currently only for floating and
-- external windows (including changing a split window to those
-- layouts).
--- @param window window #Window handle, or 0 for current window
--- @param config dictionary #Map defining the window configuration, see
---               |nvim_open_win()|
function vim.api.nvim_win_set_config(window, config) end

-- Sets the (1,0)-indexed cursor position in the window.
-- |api-indexing|
--- @param window window #Window handle, or 0 for current window
--- @param pos number[] #(row, col) tuple representing the new position
function vim.api.nvim_win_set_cursor(window, pos) end

-- Sets the window height. This will only succeed if the screen
-- is split horizontally.
--- @param window window #Window handle, or 0 for current window
--- @param height integer #Height as a count of rows
function vim.api.nvim_win_set_height(window, height) end

-- Sets a window option value. Passing 'nil' as value deletes the
-- option(only works if there's a global fallback)
--- @param window window #Window handle, or 0 for current window
--- @param name string #Option name
--- @param value object #Option value
function vim.api.nvim_win_set_option(window, name, value) end

-- Sets a window-scoped (w:) variable
--- @param window window #Window handle, or 0 for current window
--- @param name string #Variable name
--- @param value object #Variable value
function vim.api.nvim_win_set_var(window, name, value) end

-- Sets the window width. This will only succeed if the screen is
-- split vertically.
--- @param window window #Window handle, or 0 for current window
--- @param width integer #Width as a count of columns
function vim.api.nvim_win_set_width(window, width) end

