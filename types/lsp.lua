--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Jump to new location (adjusting for UTF-16 encoding of
-- characters)
--- @param location any #a single `Location` or `LocationLink`
--- @return any #(bufnr,winnr) buffer and window number of floating window
---     or nil
function vim.lsp.preview_location(location) end

-- Flushes any outstanding change notification.
function vim.lsp.flush(client) end

function vim.lsp.delete_file(change) end

-- Clear diagnotics and diagnostic cache
--- @param client_id any #number
--- @param buffer_client_map any #table map of buffers to active
---                          clients
function vim.lsp.reset(client_id, buffer_client_map) end

-- Jumps to a location.
--- @param location any #( `Location` | `LocationLink` )
--- @return any #`true` if the jump succeeded
function vim.lsp.jump_to_location(location) end

-- Create the workspace params
--- @param added any #
--- @param removed any #
function vim.lsp.make_workspace_params(added, removed) end

-- Retrieves the completion items at the current cursor position.
-- Can only be called in Insert mode.
--- @param context any #(context support not yet implemented)
---                Additional information about the context in
---                which a completion was triggered (how it was
---                triggered, and by which trigger character, if
---                applicable)
function vim.lsp.completion(context) end

-- Accepts markdown lines and tries to reduce them to a filetype
-- if they comprise just a single code block.
--- @param lines any #(table) list of lines
--- @return any #(string) filetype or 'markdown' if it was unchanged.
function vim.lsp.try_trim_markdown_code_blocks(lines) end

-- Send request to the server to resolve document highlights for
-- the current text document position. This request can be
-- triggered by a key mapping or by events such as `CursorHold` ,
-- eg:
function vim.lsp.document_highlight() end

-- Creates a `FormattingOptions` object for the current buffer
-- and cursor position.
--- @param options any #Table with valid `FormattingOptions` entries
--- @return any #`FormattingOptions object
function vim.lsp.make_formatting_params(options) end

-- Rename old_fname to new_fname.
--- @param opts any #(table)
function vim.lsp.rename(old_fname, new_fname, opts) end

-- Constructs an error message from an LSP error object.
--- @param err any #(table) The error object
--- @return any #(string) The formatted error message
function vim.lsp.format_rpc_error(err) end

function vim.lsp.progress_handler(_, _, params, client_id) end

-- Lists all the references to the symbol under the cursor in the
-- quickfix window.
--- @param context any #(table) Context for the request
function vim.lsp.references(context) end

-- Remove the folder at path from the workspace folders. If
-- {path} is not provided, the user will be prompted for a path
-- using |input()|.
function vim.lsp.remove_workspace_folder(workspace_folder) end

-- |lsp-handler| for the method "textDocument/publishDiagnostics"
--- @param config any #table Configuration table.
---               • underline: (default=true)
---                 • Apply underlines to diagnostics.
---                 • See |vim.lsp.diagnostic.set_underline()|
--- 
---               • virtual_text: (default=true)
---                 • Apply virtual text to line endings.
---                 • See |vim.lsp.diagnostic.set_virtual_text()|
--- 
---               • signs: (default=true)
---                 • Apply signs for diagnostics.
---                 • See |vim.lsp.diagnostic.set_signs()|
--- 
---               • update_in_insert: (default=false)
---                 • Update diagnostics in InsertMode or wait
---                   until InsertLeave
--- 
---               • severity_sort: (default=false)
---                 • Sort diagnostics (and thus signs and virtual
---                   text)
function vim.lsp.on_publish_diagnostics(_, _, params, client_id, _, config) end

function vim.lsp.reset_buf(client, bufnr) end

function vim.lsp.prepare(bufnr, firstline, new_lastline, changedtick) end

-- Creates a `TextDocumentPositionParams` object for the current
-- buffer and cursor position.
--- @return any #`TextDocumentPositionParams` object
function vim.lsp.make_position_params() end

-- Using the given range in the current buffer, creates an object
-- that is similar to |vim.lsp.util.make_range_params()|.
--- @param end_pos any #({number, number}, optional) mark-indexed
---                  position. Defaults to the end of the last
---                  visual selection.
--- @param start_pos any #({number, number}, optional) mark-indexed
---                  position. Defaults to the start of the last
---                  visual selection.
--- @return any #{ textDocument = { uri = `current_file_uri` }, range = {
---     start = `start_position` , end = `end_position` } }
function vim.lsp.make_given_range_params(start_pos, end_pos) end

-- Focuses/unfocuses the floating preview window associated with
-- the current buffer via the window variable `unique_name` . If
-- no such preview window exists, makes a new one.
--- @param unique_name any #(string) Window variable
--- @param fn fun(...) #(function) The return values of this
---                    function will be passed directly to
---                    |vim.lsp.util.open_floating_preview()|, in
---                    the case that a new floating window should
---                    be created
function vim.lsp.focusable_preview(unique_name, fn) end

function vim.lsp.create_file(change) end

-- Lists all symbols in the current workspace in the quickfix
-- window.
--- @param query any #(string, optional)
function vim.lsp.workspace_symbol(query) end

-- Sets the current log level.
--- @param level any #(string or number) One of `vim.lsp.log.levels`
function vim.lsp.set_level(level) end

-- Lists all the implementations for the symbol under the cursor
-- in the quickfix window.
function vim.lsp.implementation() end

-- Returns the log filename.
--- @return any #(string) log filename
function vim.lsp.get_filename() end

-- Checks whether the level is sufficient for logging.
--- @param level any #number log level
--- @return any #(bool) true if would log, false if not
function vim.lsp.should_log(level) end

-- Replaces text in a range with new text.
--- @param A any #(table) Start position; a 2-tuple of {line,
---                  col} numbers
--- @param lines any #(table) Original list of strings
--- @param B any #(table) End position; a 2-tuple of {line,
---                  col} numbers
--- @param new_lines any #A list of strings to replace the original
--- @return any #(table) The modified {lines} object
function vim.lsp.set_lines(lines, A, B, new_lines) end

-- Starts an LSP server process and create an LSP RPC client
-- object to interact with it.
--- @param extra_spawn_params any #(table, optional) Additional context
---                           for the LSP server process. May
---                           contain:
---                           • {cwd} (string) Working directory
---                             for the LSP server process
---                           • {env} (table) Additional
---                             environment variables for LSP
---                             server process
--- @param cmd any #(string) Command to start the LSP
---                           server.
--- @param cmd_args any #(table) List of additional string
---                           arguments to pass to {cmd}.
--- @param dispatchers any #(table, optional) Dispatchers for
---                           LSP message types. Valid dispatcher
---                           names are:
---                           • `"notification"`
---                           • `"server_request"`
---                           • `"on_error"`
---                           • `"on_exit"`
--- @return any #Client RPC object.
function vim.lsp.start(cmd, cmd_args, dispatchers, extra_spawn_params) end

-- Save diagnostics to the current buffer.
--- @param client_id any #number
--- @param diagnostics any #Diagnostic []
--- @param bufnr any #number
function vim.lsp.save(diagnostics, bufnr, client_id) end

-- Checks whether the language servers attached to the current
-- buffer are ready.
--- @return any #`true` if server responds.
function vim.lsp.server_ready() end

-- Returns visual width of tabstop.
--- @param bufnr any #(optional, number): Buffer handle, defaults to
---              current
--- @return any #(number) tabstop visual width
function vim.lsp.get_effective_tabstop(bufnr) end

-- Move to the next diagnostic
--- @param opts any #table|nil Configuration table. Keys:
---             • {client_id}: (number)
---               • If nil, will consider all clients attached to
---                 buffer.
--- 
---             • {cursor_position}: (Position, default current
---               position)
---               • See |nvim_win_get_cursor()|
--- 
---             • {wrap}: (boolean, default true)
---               • Whether to loop around file or not. Similar to
---                 'wrapscan'
--- 
---             • {severity}: (DiagnosticSeverity)
---               • Exclusive severity to consider. Overrides
---                 {severity_limit}
--- 
---             • {severity_limit}: (DiagnosticSeverity)
---               • Limit severity of diagnostics found. E.g.
---                 "Warning" means { "Error", "Warning" } will be
---                 valid.
--- 
---             • {enable_popup}: (boolean, default true)
---               • Call
---                 |vim.lsp.diagnostic.show_line_diagnostics()|
---                 on jump
--- 
---             • {popup_opts}: (table)
---               • Table to pass as {opts} parameter to
---                 |vim.lsp.diagnostic.show_line_diagnostics()|
--- 
---             • {win_id}: (number, default 0)
---               • Window ID
function vim.lsp.goto_next(opts) end

-- Creates a table with sensible default options for a floating
-- window. The table can be passed to |nvim_open_win()|.
--- @param width any #(number) window width (in character cells)
--- @param opts any #(table, optional)
--- @param height any #(number) window height (in character cells)
--- @return any #(table) Options
function vim.lsp.make_floating_popup_options(width, height, opts) end

