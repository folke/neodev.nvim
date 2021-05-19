--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Queues raw user-input. Unlike |nvim_feedkeys()|, this uses a
-- low-level input buffer and the call is non-blocking (input is
-- processed asynchronously by the eventloop).
--- @param keys string #to be typed
--- @return any #Number of bytes actually written (can be fewer than
---     requested if the buffer becomes full).
function vim.api.nvim_input(keys) end

-- Send mouse event from GUI.
--- @param action string #For ordinary buttons, one of "press", "drag",
---                 "release". For the wheel, one of "up", "down",
---                 "left", "right".
--- @param button string #Mouse button: one of "left", "right",
---                 "middle", "wheel".
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

-- Replaces terminal codes and |keycodes| (<CR>, <Esc>, ...) in a
-- string with the internal representation.
--- @param str string #String to be converted.
--- @param from_part boolean #Legacy Vim parameter. Usually true.
--- @param do_lt boolean #Also translate <lt>. Ignored if `special` is
---                  false.
--- @param special boolean #Replace |keycodes|, e.g. <CR> becomes a "\n"
---                  char.
function vim.api.nvim_replace_termcodes(str, from_part, do_lt, special) end

-- Evaluates a VimL |expression|. Dictionaries and Lists are
-- recursively expanded.
--- @param expr string #VimL expression string
--- @return any #Evaluation result or expanded object
function vim.api.nvim_eval(expr) end

-- Notify the user with a message
--- @param opts dictionary #Reserved for future use.
--- @param log_level integer #The log level
--- @param msg string #Message to display to the user
function vim.api.nvim_notify(msg, log_level, opts) end

-- Calls a VimL function with the given arguments.
--- @param args any[] #Function arguments packed in an Array
--- @param fn fun(...) #Function to call
--- @return any #Result of the function call
function vim.api.nvim_call_function(fn, args) end

-- Calls a VimL |Dictionary-function| with the given arguments.
--- @param dict dictionary #Dictionary, or String evaluating to a VimL |self|
---             dict
--- @param args any[] #Function arguments packed in an Array
--- @param fn fun(...) #Name of the function defined on the VimL dict
--- @return any #Result of the function call
function vim.api.nvim_call_dict_function(dict, fn, args) end

-- Calculates the number of display cells occupied by `text` .
-- <Tab> counts as one cell.
--- @param text string #Some text
--- @return any #Number of cells
function vim.api.nvim_strwidth(text) end

-- Gets the paths contained in 'runtimepath'.
--- @return any #List of paths
function vim.api.nvim_list_runtime_paths() end

-- Find files in runtime directories
--- @param all boolean #whether to return all matches or only the first
--- @param name string #pattern of files to search for
--- @return any #list of absolute paths to the found files
function vim.api.nvim_get_runtime_file(name, all) end

function vim.api.nvim__get_lib_dir() end

-- Changes the global working directory.
--- @param dir string #Directory path
function vim.api.nvim_set_current_dir(dir) end

-- Gets the current line.
--- @return any #Current line string
function vim.api.nvim_get_current_line() end

-- Sets the current line.
--- @param line string #Line contents
function vim.api.nvim_set_current_line(line) end

-- Deletes the current line.
function vim.api.nvim_del_current_line() end

-- Gets a global (g:) variable.
--- @param name string #Variable name
--- @return any #Variable value
function vim.api.nvim_get_var(name) end

function vim.api.nvim_ui_set_option(name, value, error) end

-- Removes a global (g:) variable.
--- @param name string #Variable name
function vim.api.nvim_del_var(name) end

-- Gets a v: variable.
--- @param name string #Variable name
--- @return any #Variable value
function vim.api.nvim_get_vvar(name) end

-- Sets a v: variable, if it is not readonly.
--- @param name string #Variable name
--- @param value object #Variable value
function vim.api.nvim_set_vvar(name, value) end

-- Gets an option value string.
--- @param name string #Option name
--- @return any #Option value (global)
function vim.api.nvim_get_option(name) end

-- Gets the option information for all options.
--- @return any #dictionary of all options
function vim.api.nvim_get_all_options_info() end

-- Gets the option information for one option
--- @param name string #Option name
--- @return any #Option Information
function vim.api.nvim_get_option_info(name) end

-- Sets an option value.
--- @param name string #Option name
--- @param value object #New option value
function vim.api.nvim_set_option(name, value) end

-- Echo a message.
--- @param opts dictionary #Optional parameters. Reserved for future use.
--- @param chunks array #A list of [text, hl_group] arrays, each
---                representing a text chunk with specified
---                highlight. `hl_group` element can be omitted
---                for no highlight.
--- @param history boolean #if true, add to |message-history|.
function vim.api.nvim_echo(chunks, history, opts) end

-- Writes a message to the Vim output buffer. Does not append
-- "\n", the message is buffered (won't display) until a linefeed
-- is written.
--- @param str string #Message
function vim.api.nvim_out_write(str) end

-- Writes a message to the Vim error buffer. Does not append
-- "\n", the message is buffered (won't display) until a linefeed
-- is written.
--- @param str string #Message
function vim.api.nvim_err_write(str) end

-- Writes a message to the Vim error buffer. Appends "\n", so the
-- buffer is flushed (and displayed).
--- @param str string #Message
function vim.api.nvim_err_writeln(str) end

-- Gets the current list of buffer handles
--- @return any #List of buffer handles
function vim.api.nvim_list_bufs() end

-- Gets the current buffer.
--- @return any #Buffer handle
function vim.api.nvim_get_current_buf() end

-- Sets the current buffer.
--- @param buffer buffer #Buffer handle
function vim.api.nvim_set_current_buf(buffer) end

-- Gets the current list of window handles.
--- @return any #List of window handles
function vim.api.nvim_list_wins() end

-- Gets the current window.
--- @return any #Window handle
function vim.api.nvim_get_current_win() end

-- Sets the current window.
--- @param window window #Window handle
function vim.api.nvim_set_current_win(window) end

-- Creates a new, empty, unnamed buffer.
--- @param scratch boolean #Creates a "throwaway" |scratch-buffer| for
---                temporary work (always 'nomodified'). Also sets
---                'nomodeline' on the buffer.
--- @param listed boolean #Sets 'buflisted'
--- @return any #Buffer handle, or 0 on error
function vim.api.nvim_create_buf(listed, scratch) end

-- Open a terminal instance in a buffer
--- @param opts dictionary #Optional parameters. Reserved for future use.
--- @param buffer buffer #the buffer to use (expected to be empty)
--- @return any #Channel id, or 0 on error
function vim.api.nvim_open_term(buffer, opts) end

-- Send data to channel `id` . For a job, it writes it to the
-- stdin of the process. For the stdio channel |channel-stdio|,
-- it writes to Nvim's stdout. For an internal terminal instance
-- (|nvim_open_term()|) it writes directly to terimal output. See
-- |channel-bytes| for more information.
--- @param chan integer #id of the channel
--- @param data string #data to write. 8-bit clean: can contain NUL bytes.
function vim.api.nvim_chan_send(chan, data) end

-- Open a new window.
--- @param config dictionary #Map defining the window configuration. Keys:
---               • `relative`: Sets the window layout to "floating", placed
---                 at (row,col) coordinates relative to:
---                 • "editor" The global editor grid
---                 • "win" Window given by the `win` field, or
---                   current window.
---                 • "cursor" Cursor position in current window.
--- 
---               • `win` : |window-ID| for relative="win".
---               • `anchor`: Decides which corner of the float to place
---                 at (row,col):
---                 • "NW" northwest (default)
---                 • "NE" northeast
---                 • "SW" southwest
---                 • "SE" southeast
--- 
---               • `width` : Window width (in character cells).
---                 Minimum of 1.
---               • `height` : Window height (in character cells).
---                 Minimum of 1.
---               • `bufpos` : Places float relative to buffer
---                 text (only when relative="win"). Takes a tuple
---                 of zero-indexed [line, column]. `row` and
---                 `col` if given are applied relative to this
---                 position, else they default to `row=1` and
---                 `col=0` (thus like a tooltip near the buffer
---                 text).
---               • `row` : Row position in units of "screen cell
---                 height", may be fractional.
---               • `col` : Column position in units of "screen
---                 cell width", may be fractional.
---               • `focusable` : Enable focus by user actions
---                 (wincmds, mouse events). Defaults to true.
---                 Non-focusable windows can be entered by
---                 |nvim_set_current_win()|.
---               • `external` : GUI should display the window as
---                 an external top-level window. Currently
---                 accepts no other positioning configuration
---                 together with this.
---               • `style`: Configure the appearance of the window.
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
---               • `border`: style of (optional) window border. This can
---                 either be a string or an array. the string
---                 values are:
---                 • "none" No border. This is the default
---                 • "single" a single line box
---                 • "double" a double line box
---                 • "shadow" a drop shadow effect by blending
---                   with the background. If it is an array it
---                   should be an array of eight items or any
---                   divisor of eight. The array will specifify
---                   the eight chars building up the border in a
---                   clockwise fashion starting with the top-left
---                   corner. As, an example, the double box style
---                   could be specified as: [ "╔", "═" ,"╗", "║",
---                   "╝", "═", "╚", "║" ] if the number of chars
---                   are less than eight, they will be repeated.
---                   Thus an ASCII border could be specified as:
---                   [ "/", "-", "\\", "|" ] or all chars the
---                   same as: [ "x" ] An empty string can be used
---                   to turn off a specific border, for instance:
---                   [ "", "", "", ">", "", "", "", "<" ] will
---                   only make vertical borders but not
---                   horizontal ones. By default `FloatBorder`
---                   highlight is used which links to `VertSplit`
---                   when not defined. It could also be specified
---                   by character: [ {"+", "MyCorner"}, {"x",
---                   "MyBorder"} ]
--- @param buffer buffer #Buffer to display, or 0 for current buffer
--- @param enter boolean #Enter the window (make it the current window)
--- @return any #Window handle, or 0 on error
function vim.api.nvim_open_win(buffer, enter, config) end

