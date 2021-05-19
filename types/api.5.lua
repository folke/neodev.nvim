--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Sets the current editor state from the given |context| map.
--- @param dict dictionary #|Context| map.
function vim.api.nvim_load_context(dict) end

-- Checks if a buffer is valid.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @return any #true if the buffer is valid, false otherwise.
function vim.api.nvim_buf_is_valid(buffer) end

-- Sets a global (g:) variable.
--- @param name string #Variable name
--- @param value object #Variable value
function vim.api.nvim_set_var(name, value) end

-- Checks if a buffer is valid and loaded. See |api-buffer| for
-- more info about unloaded buffers.
--- @param buffer buffer #Buffer handle, or 0 for current buffer
--- @return any #true if the buffer is valid and loaded, false otherwise.
function vim.api.nvim_buf_is_loaded(buffer) end

-- Gets a highlight definition by name.
--- @param name string #Highlight group name
--- @param rgb boolean #Export RGB colors
--- @return any #Highlight definition map
function vim.api.nvim_get_hl_by_name(name, rgb) end

-- Gets a list of dictionaries representing attached UIs.
--- @return any #Array of UI dictionaries, each with these keys:
---     • "height" Requested height of the UI
---     • "width" Requested width of the UI
---     • "rgb" true if the UI uses RGB colors (false implies
---       |cterm-colors|)
---     • "ext_..." Requested UI extensions, see |ui-option|
---     • "chan" Channel id of remote UI (not present for TUI)
--- 
function vim.api.nvim_list_uis() end

-- Gets the current buffer in a window
--- @param window window #Window handle, or 0 for current window
--- @return any #Buffer handle
function vim.api.nvim_win_get_buf(window) end

