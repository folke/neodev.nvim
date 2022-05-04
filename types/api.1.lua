--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Writes a message to the Vim output buffer. Does not append
-- "\n", the message is buffered (won't display) until a linefeed
-- is written.
--- @param str string #Message
function vim.api.nvim_out_write(str) end

-- Parse command line.
--- @param str string #Command line string to parse. Cannot contain "\n".
--- @param opts dictionary #Optional parameters. Reserved for future use.
--- @return any #Dictionary containing command information, with these
---     keys:
---     • cmd: (string) Command name.
---     • line1: (number) Starting line of command range. Only
---       applicable if command can take a range.
---     • line2: (number) Final line of command range. Only
---       applicable if command can take a range.
---     • bang: (boolean) Whether command contains a bang (!)
---       modifier.
---     • args: (array) Command arguments.
---     • addr: (string) Value of |:command-addr|. Uses short
---       name.
---     • nargs: (string) Value of |:command-nargs|.
---     • nextcmd: (string) Next command if there are multiple
---       commands separated by a |:bar|. Empty if there isn't a
---       next command.
---     • magic: (dictionary) Which characters have special
---       meaning in the command arguments.
---       • file: (boolean) The command expands filenames. Which
---         means characters such as "%", "#" and wildcards are
---         expanded.
---       • bar: (boolean) The "|" character is treated as a
---         command separator and the double quote character (")
---         is treated as the start of a comment.
---
---     • mods: (dictionary) |:command-modifiers|.
---       • silent: (boolean) |:silent|.
---       • emsg_silent: (boolean) |:silent!|.
---       • sandbox: (boolean) |:sandbox|.
---       • noautocmd: (boolean) |:noautocmd|.
---       • browse: (boolean) |:browse|.
---       • confirm: (boolean) |:confirm|.
---       • hide: (boolean) |:hide|.
---       • keepalt: (boolean) |:keepalt|.
---       • keepjumps: (boolean) |:keepjumps|.
---       • keepmarks: (boolean) |:keepmarks|.
---       • keeppatterns: (boolean) |:keeppatterns|.
---       • lockmarks: (boolean) |:lockmarks|.
---       • noswapfile: (boolean) |:noswapfile|.
---       • tab: (integer) |:tab|.
---       • verbose: (integer) |:verbose|.
---       • vertical: (boolean) |:vertical|.
---       • split: (string) Split modifier string, is an empty
---         string when there's no split modifier. If there is a
---         split modifier it can be one of:
---         • "aboveleft": |:aboveleft|.
---         • "belowright": |:belowright|.
---         • "topleft": |:topleft|.
---         • "botright": |:botright|.
function vim.api.nvim_parse_cmd(str, opts) end

-- Parse a VimL expression.
--- @param expr string #Expression to parse. Always treated as a
---                  single line.
--- @param flags string #Flags:
---                  • "m" if multiple expressions in a row are
---                    allowed (only the first one will be
---                    parsed),
---                  • "E" if EOC tokens are not allowed
---                    (determines whether they will stop parsing
---                    process or be recognized as an
---                    operator/space, though also yielding an
---                    error).
---                  • "l" when needing to start parsing with
---                    lvalues for ":let" or ":for". Common flag
---                    sets:
---                  • "m" to parse like for ":echo".
---                  • "E" to parse like for "<C-r>=".
---                  • empty string for ":call".
---                  • "lm" to parse for ":let".
--- @param highlight boolean #If true, return value will also include
---                  "highlight" key containing array of 4-tuples
---                  (arrays) (Integer, Integer, Integer, String),
---                  where first three numbers define the
---                  highlighted region and represent line,
---                  starting column and ending column (latter
---                  exclusive: one should highlight region
---                  [start_col, end_col)).
--- @return any #
---     • AST: top-level dictionary with these keys:
---       • "error": Dictionary with error, present only if parser
---         saw some error. Contains the following keys:
---         • "message": String, error message in printf format,
---           translated. Must contain exactly one "%.*s".
---         • "arg": String, error message argument.
---
---       • "len": Amount of bytes successfully parsed. With flags
---         equal to "" that should be equal to the length of expr
---         string. (“Successfully parsed” here means
---         “participated in AST creation”, not “till the first
---         error”.)
---       • "ast": AST, either nil or a dictionary with these
---         keys:
---         • "type": node type, one of the value names from
---           ExprASTNodeType stringified without "kExprNode"
---           prefix.
---         • "start": a pair [line, column] describing where node
---           is "started" where "line" is always 0 (will not be 0
---           if you will be using nvim_parse_viml() on e.g.
---           ":let", but that is not present yet). Both elements
---           are Integers.
---         • "len": “length” of the node. This and "start" are
---           there for debugging purposes primary (debugging
---           parser and providing debug information).
---         • "children": a list of nodes described in top/"ast".
---           There always is zero, one or two children, key will
---           not be present if node has no children. Maximum
---           number of children may be found in node_maxchildren
---           array.
---
---
---     • Local values (present only for certain nodes):
---       • "scope": a single Integer, specifies scope for
---         "Option" and "PlainIdentifier" nodes. For "Option" it
---         is one of ExprOptScope values, for "PlainIdentifier"
---         it is one of ExprVarScope values.
---       • "ident": identifier (without scope, if any), present
---         for "Option", "PlainIdentifier", "PlainKey" and
---         "Environment" nodes.
---       • "name": Integer, register name (one character) or -1.
---         Only present for "Register" nodes.
---       • "cmp_type": String, comparison type, one of the value
---         names from ExprComparisonType, stringified without
---         "kExprCmp" prefix. Only present for "Comparison"
---         nodes.
---       • "ccs_strategy": String, case comparison strategy, one
---         of the value names from ExprCaseCompareStrategy,
---         stringified without "kCCStrategy" prefix. Only present
---         for "Comparison" nodes.
---       • "augmentation": String, augmentation type for
---         "Assignment" nodes. Is either an empty string, "Add",
---         "Subtract" or "Concat" for "=", "+=", "-=" or ".="
---         respectively.
---       • "invert": Boolean, true if result of comparison needs
---         to be inverted. Only present for "Comparison" nodes.
---       • "ivalue": Integer, integer value for "Integer" nodes.
---       • "fvalue": Float, floating-point value for "Float"
---         nodes.
---       • "svalue": String, value for "SingleQuotedString" and
---         "DoubleQuotedString" nodes.
function vim.api.nvim_parse_expression(expr, flags, highlight) end

-- Pastes at cursor, in any mode.
--- @param data string #Multiline input. May be binary (containing NUL
---              bytes).
--- @param crlf boolean #Also break lines at CR and CRLF.
--- @param phase integer #-1: paste in a single call (i.e. without
---              streaming). To "stream" a paste, call `nvim_paste` sequentially with these `phase` values:
---              • 1: starts the paste (exactly once)
---              • 2: continues the paste (zero or more times)
---              • 3: ends the paste (exactly once)
--- @return any #
---     • true: Client may continue pasting.
---     • false: Client must cancel the paste.
function vim.api.nvim_paste(data, crlf, phase) end

-- Puts text at cursor, in any mode.
--- @param lines string[] #|readfile()|-style list of lines.
---               |channel-lines|
--- @param type string #Edit behavior: any |getregtype()| result, or:
---               • "b" |blockwise-visual| mode (may include
---                 width, e.g. "b3")
---               • "c" |charwise| mode
---               • "l" |linewise| mode
---               • "" guess by contents, see |setreg()|
--- @param after boolean #If true insert after cursor (like |p|), or
---               before (like |P|).
--- @param follow boolean #If true place cursor at end of inserted text.
function vim.api.nvim_put(lines, type, after, follow) end

-- Replaces terminal codes and |keycodes| (<CR>, <Esc>, ...) in a
-- string with the internal representation.
--- @param str string #String to be converted.
--- @param from_part boolean #Legacy Vim parameter. Usually true.
--- @param do_lt boolean #Also translate <lt>. Ignored if `special` is
---                  false.
--- @param special boolean #Replace |keycodes|, e.g. <CR> becomes a "\r"
---                  char.
function vim.api.nvim_replace_termcodes(str, from_part, do_lt, special) end

-- Selects an item in the completion popupmenu.
--- @param item integer #Index (zero-based) of the item to select. Value
---               of -1 selects nothing and restores the original
---               text.
--- @param insert boolean #Whether the selection should be inserted in the
---               buffer.
--- @param finish boolean #Finish the completion and dismiss the popupmenu.
---               Implies `insert`.
--- @param opts dictionary #Optional parameters. Reserved for future use.
function vim.api.nvim_select_popupmenu_item(item, insert, finish, opts) end

-- Self-identifies the client.
--- @param name string #Short name for the connected client
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
function vim.api.nvim_set_client_info(name, version, type, methods, attributes) end

-- Sets the current buffer.
--- @param buffer buffer #Buffer handle
function vim.api.nvim_set_current_buf(buffer) end

-- Changes the global working directory.
--- @param dir string #Directory path
function vim.api.nvim_set_current_dir(dir) end

-- Sets the current line.
--- @param line string #Line contents
function vim.api.nvim_set_current_line(line) end

-- Sets the current tabpage.
--- @param tabpage tabpage #Tabpage handle
function vim.api.nvim_set_current_tabpage(tabpage) end

-- Sets the current window.
--- @param window window #Window handle
function vim.api.nvim_set_current_win(window) end

-- Set or change decoration provider for a namespace
--- @param ns_id integer #Namespace id from |nvim_create_namespace()|
--- @param opts table<string, luaref> #Callbacks invoked during redraw:
---              • on_start: called first on each screen redraw
---                ["start", tick]
---              • on_buf: called for each buffer being redrawn
---                (before window callbacks) ["buf", bufnr, tick]
---              • on_win: called when starting to redraw a
---                specific window. ["win", winid, bufnr, topline,
---                botline_guess]
---              • on_line: called for each buffer line being
---                redrawn. (The interaction with fold lines is
---                subject to change) ["win", winid, bufnr, row]
---              • on_end: called at the end of a redraw cycle
---                ["end", tick]
function vim.api.nvim_set_decoration_provider(ns_id, opts) end

-- Sets a highlight group.
--- @param ns_id integer #Namespace id for this highlight
---              |nvim_create_namespace()|. Use 0 to set a
---              highlight group globally |:highlight|.
--- @param name string #Highlight group name, e.g. "ErrorMsg"
--- @param val dict(highlight) * #Highlight definition map, like |synIDattr()|. In
---              addition, the following keys are recognized:
---              • default: Don't override existing definition
---                |:hi-default|
---              • ctermfg: Sets foreground of cterm color
---                |highlight-ctermfg|
---              • ctermbg: Sets background of cterm color
---                |highlight-ctermbg|
---              • cterm: cterm attribute map, like
---                |highlight-args|. Note: Attributes default to
---                those set for `gui` if not set.
function vim.api.nvim_set_hl(ns_id, name, val) end

-- Sets a global |mapping| for the given mode.
--- @param mode string #Mode short-name (map command prefix: "n", "i",
---             "v", "x", …) or "!" for |:map!|, or empty string
---             for |:map|.
--- @param lhs string #Left-hand-side |{lhs}| of the mapping.
--- @param rhs string #Right-hand-side |{rhs}| of the mapping.
--- @param opts dict(keymap) * #Optional parameters map. Accepts all
---             |:map-arguments| as keys excluding |<buffer>| but
---             including |noremap| and "desc". "desc" can be used
---             to give a description to keymap. When called from
---             Lua, also accepts a "callback" key that takes a
---             Lua function to call when the mapping is executed.
---             Values are Booleans. Unknown key is an error.
function vim.api.nvim_set_keymap(mode, lhs, rhs, opts) end

-- Sets the global value of an option.
--- @param name string #Option name
--- @param value object #New option value
function vim.api.nvim_set_option(name, value) end

-- Sets the value of an option. The behavior of this function
-- matches that of |:set|: for global-local options, both the
-- global and local value are set unless otherwise specified with
-- {scope}.
--- @param name string #Option name
--- @param value object #New option value
--- @param opts dict(option) * #Optional parameters
---              • scope: One of 'global' or 'local'. Analogous to
---                |:setglobal| and |:setlocal|, respectively.
function vim.api.nvim_set_option_value(name, value, opts) end

-- Sets a global (g:) variable.
--- @param name string #Variable name
--- @param value object #Variable value
function vim.api.nvim_set_var(name, value) end

-- Sets a v: variable, if it is not readonly.
--- @param name string #Variable name
--- @param value object #Variable value
function vim.api.nvim_set_vvar(name, value) end

-- Calculates the number of display cells occupied by `text`.
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

-- Sets the current buffer in a window, without side effects
--- @param window window #Window handle, or 0 for current window
--- @param buffer buffer #Buffer handle
function vim.api.nvim_win_set_buf(window, buffer) end

-- Configures window layout. Currently only for floating and
-- external windows (including changing a split window to those
-- layouts).
--- @param window window #Window handle, or 0 for current window
--- @param config dict(float_config) * #Map defining the window configuration, see
---               |nvim_open_win()|
function vim.api.nvim_win_set_config(window, config) end

-- Sets the (1,0)-indexed cursor position in the window.
-- |api-indexing| This scrolls the window even if it is not the
-- current one.
--- @param window window #Window handle, or 0 for current window
--- @param pos number[] #(row, col) tuple representing the new position
function vim.api.nvim_win_set_cursor(window, pos) end

-- Sets the window height.
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

