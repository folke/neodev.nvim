--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Creates a new, empty, unnamed buffer.
--- @param listed boolean #Sets 'buflisted'
--- @param scratch boolean #Creates a "throwaway" |scratch-buffer| for
---                temporary work (always 'nomodified'). Also sets
---                'nomodeline' on the buffer.
--- @return any #Buffer handle, or 0 on error
function vim.api.nvim_create_buf(listed, scratch) end

-- Creates a new namespace, or gets an existing one.
--- @param name string #Namespace name or empty string
--- @return any #Namespace id
function vim.api.nvim_create_namespace(name) end

-- Deletes the current line.
function vim.api.nvim_del_current_line() end

-- Unmaps a global |mapping| for the given mode.
--- @param mode string
--- @param lhs string
function vim.api.nvim_del_keymap(mode, lhs) end

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

-- Executes Vimscript (multiline block of Ex-commands), like
-- anonymous |:source|.
--- @param src string #Vimscript code
--- @param output boolean #Capture and return all (non-error, non-shell
---               |:!|) output
--- @return any #Output (non-error, non-shell |:!|) if `output` is true,
---     else empty string.
function vim.api.nvim_exec(src, output) end

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
--- @param escape_csi boolean #If true, escape K_SPECIAL/CSI bytes in
---                   `keys`
function vim.api.nvim_feedkeys(keys, mode, escape_csi) end

-- Gets the option information for all options.
--- @return any #dictionary of all options
function vim.api.nvim_get_all_options_info() end

-- Returns a 2-tuple (Array), where item 0 is the current channel
-- id and item 1 is the |api-metadata| map (Dictionary).
--- @return any #2-tuple [{channel-id}, {api-metadata}]
function vim.api.nvim_get_api_info() end

-- Get information about a channel.
--- @param chan integer
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
--- @param opts dictionary #Optional parameters. Currently only supports
---             {"builtin":false}
--- @return any #Map of maps describing commands.
function vim.api.nvim_get_commands(opts) end

-- Gets a map of the current editor state.
--- @param opts dictionary #Optional parameters.
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

-- Gets the current mode. |mode()| "blocking" is true if Nvim is
-- waiting for input.
--- @return any #Dictionary { "mode": String, "blocking": Boolean }
function vim.api.nvim_get_mode() end

-- Gets existing, non-anonymous namespaces.
--- @return any #dict that maps from names to namespace ids.
function vim.api.nvim_get_namespaces() end

-- Gets an option value string.
--- @param name string #Option name
--- @return any #Option value (global)
function vim.api.nvim_get_option(name) end

-- Gets the option information for one option
--- @param name string #Option name
--- @return any #Option Information
function vim.api.nvim_get_option_info(name) end

-- Gets info describing process `pid` .
--- @param pid integer
--- @return any #Map of process properties, or NIL if process not found.
function vim.api.nvim_get_proc(pid) end

-- Gets the immediate children of process `pid` .
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

