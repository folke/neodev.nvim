--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Parses snippets in a completion entry.
--- @param input any #(string) unparsed snippet
--- @return any #(string) parsed snippet
function vim.lsp.parse_snippet(input) end

function vim.lsp.prepare(bufnr, firstline, new_lastline, changedtick) end

-- Jump to new location (adjusting for UTF-16 encoding of
-- characters)
--- @param location any #a single `Location` or `LocationLink`
--- @return any #(bufnr,winnr) buffer and window number of floating window
---     or nil
function vim.lsp.preview_location(location) end

function vim.lsp.progress_handler(_, _, params, client_id) end

-- Performs |vim.lsp.buf.code_action()| for a given range.
--- @param context any #(table, optional) Valid `CodeActionContext`
---                  object
--- @param start_pos any #({number, number}, optional) mark-indexed
---                  position. Defaults to the start of the last
---                  visual selection.
--- @param end_pos any #({number, number}, optional) mark-indexed
---                  position. Defaults to the end of the last
---                  visual selection.
function vim.lsp.range_code_action(context, start_pos, end_pos) end

-- Formats a given range.
--- @param options any #Table with valid `FormattingOptions` entries.
--- @param start_pos any #({number, number}, optional) mark-indexed
---                  position. Defaults to the start of the last
---                  visual selection.
--- @param end_pos any #({number, number}, optional) mark-indexed
---                  position. Defaults to the end of the last
---                  visual selection.
function vim.lsp.range_formatting(options, start_pos, end_pos) end

-- Lists all the references to the symbol under the cursor in the
-- quickfix window.
--- @param context any #(table) Context for the request
function vim.lsp.references(context) end

-- Remove the folder at path from the workspace folders. If
-- {path} is not provided, the user will be prompted for a path
-- using |input()|.
function vim.lsp.remove_workspace_folder(workspace_folder) end

-- Rename old_fname to new_fname.
--- @param opts any #(table)
function vim.lsp.rename(old_fname, new_fname, opts) end

-- Sends a request to the LSP server and runs {callback} upon
-- response.
--- @param method any #(string) The invoked LSP method
--- @param params any #(table) Parameters for the invoked LSP method
--- @param callback any #(function) Callback to invoke
--- @return any #(bool, number) `(true, message_id)` if request could be
---     sent, `false` if not
function vim.lsp.request(method, params, callback) end

-- Clear diagnotics and diagnostic cache
--- @param client_id any #number
--- @param buffer_client_map any #table map of buffers to active
---                          clients
function vim.lsp.reset(client_id, buffer_client_map) end

function vim.lsp.reset_buf(client, bufnr) end

-- Creates a normalized object describing LSP server
-- capabilities.
function vim.lsp.resolve_capabilities(server_capabilities) end

-- Save diagnostics to the current buffer.
--- @param diagnostics any #Diagnostic []
--- @param bufnr any #number
--- @param client_id any #number
function vim.lsp.save(diagnostics, bufnr, client_id) end

-- Checks whether the language servers attached to the current
-- buffer are ready.
--- @return any #`true` if server responds.
function vim.lsp.server_ready() end

-- Sets the current log level.
--- @param level any #(string or number) One of `vim.lsp.log.levels`
function vim.lsp.set_level(level) end

-- Replaces text in a range with new text.
--- @param lines any #(table) Original list of strings
--- @param A any #(table) Start position; a 2-tuple of {line,
---                  col} numbers
--- @param B any #(table) End position; a 2-tuple of {line,
---                  col} numbers
--- @param new_lines any #A list of strings to replace the original
--- @return any #(table) The modified {lines} object
function vim.lsp.set_lines(lines, A, B, new_lines) end

-- Fills current window's location list with given list of items.
-- Can be obtained with e.g. |vim.lsp.util.locations_to_items()|.
--- @param items any #(table) list of items
function vim.lsp.set_loclist(items) end

-- Fills quickfix list with given list of items. Can be obtained
-- with e.g. |vim.lsp.util.locations_to_items()|.
--- @param items any #(table) list of items
function vim.lsp.set_qflist(items) end

-- Set signs for given diagnostics
--- @param diagnostics any #Diagnostic []
--- @param bufnr any #number The buffer number
--- @param client_id any #number the client id
--- @param sign_ns any #number|nil
--- @param opts any #table Configuration for signs. Keys:
---                    • priority: Set the priority of the signs.
---                    • severity_limit (DiagnosticSeverity):
---                      • Limit severity of diagnostics found.
---                        E.g. "Warning" means { "Error",
---                        "Warning" } will be valid.
function vim.lsp.set_signs(diagnostics, bufnr, client_id, sign_ns, opts) end

-- Set underline for given diagnostics
--- @param diagnostics any #Diagnostic []
--- @param bufnr any #number: The buffer number
--- @param client_id any #number: The client id
--- @param diagnostic_ns any #number|nil: The namespace
--- @param opts any #table: Configuration table:
---                      • severity_limit (DiagnosticSeverity):
---                        • Limit severity of diagnostics found.
---                          E.g. "Warning" means { "Error",
---                          "Warning" } will be valid.
function vim.lsp.set_underline(diagnostics, bufnr, client_id, diagnostic_ns, opts) end

-- Set virtual text given diagnostics
--- @param diagnostics any #Diagnostic []
--- @param bufnr any #number
--- @param client_id any #number
--- @param diagnostic_ns any #number
--- @param opts any #table Options on how to display virtual
---                      text. Keys:
---                      • prefix (string): Prefix to display
---                        before virtual text on line
---                      • spacing (number): Number of spaces to
---                        insert before virtual text
---                      • severity_limit (DiagnosticSeverity):
---                        • Limit severity of diagnostics found.
---                          E.g. "Warning" means { "Error",
---                          "Warning" } will be valid.
function vim.lsp.set_virtual_text(diagnostics, bufnr, client_id, diagnostic_ns, opts) end

-- Checks whether the level is sufficient for logging.
--- @param level any #number log level
--- @return any #(bool) true if would log, false if not
function vim.lsp.should_log(level) end

-- Open a floating window with the diagnostics from {line_nr}
--- @param opts any #table Configuration table
---                  • show_header (boolean, default true): Show
---                    "Diagnostics:" header.
--- @param bufnr any #number The buffer number
--- @param line_nr any #number The line number
--- @param client_id any #number|nil the client id
--- @return any #table {popup_bufnr, win_id}
function vim.lsp.show_line_diagnostics(opts, bufnr, line_nr, client_id) end

--- @param config any #table Configuration table.
---               • border: (default=nil)
---                 • Add borders to the floating window
---                 • See |vim.api.nvim_open_win()|
function vim.lsp.signature_help(_, method, result, _, bufnr, config) end

-- Starts an LSP server process and create an LSP RPC client
-- object to interact with it.
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
--- @param extra_spawn_params any #(table, optional) Additional context
---                           for the LSP server process. May
---                           contain:
---                           • {cwd} (string) Working directory
---                             for the LSP server process
---                           • {env} (table) Additional
---                             environment variables for LSP
---                             server process
--- @return any #Client RPC object.
--- @return any #Methods:
---     • `notify()` |vim.lsp.rpc.notify()|
---     • `request()` |vim.lsp.rpc.request()|
--- @return any #Members:
---     • {pid} (number) The LSP server's PID.
---     • {handle} A handle for low-level interaction with the LSP
---       server process |vim.loop|.
function vim.lsp.start(cmd, cmd_args, dispatchers, extra_spawn_params) end

-- Converts symbols to quickfix list items.
--- @param symbols any #DocumentSymbol[] or SymbolInformation[]
function vim.lsp.symbols_to_items(symbols, bufnr) end

-- Turns the result of a `textDocument/completion` request into
-- vim-compatible |complete-items|.
--- @param result any #The result of a `textDocument/completion` call,
---               e.g. from |vim.lsp.buf.completion()|, which may
---               be one of `CompletionItem[]` , `CompletionList`
---               or `null`
--- @param prefix any #(string) the prefix to filter the completion
---               items
--- @return any #{ matches = complete-items table, incomplete = bool }
function vim.lsp.text_document_completion_list_to_complete_items(result, prefix) end

-- Removes empty lines from the beginning and end.
--- @param lines any #(table) list of lines to trim
--- @return any #(table) trimmed list of lines
function vim.lsp.trim_empty_lines(lines) end

-- Accepts markdown lines and tries to reduce them to a filetype
-- if they comprise just a single code block.
--- @param lines any #(table) list of lines
--- @return any #(string) filetype or 'markdown' if it was unchanged.
function vim.lsp.try_trim_markdown_code_blocks(lines) end

