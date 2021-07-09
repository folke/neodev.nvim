--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Add the folder at path to the workspace folders. If {path} is
-- not provided, the user will be prompted for a path using
-- |input()|.
function vim.lsp.add_workspace_folder(workspace_folder) end

-- Applies a `TextDocumentEdit` , which is a list of changes to a
-- single document.
--- @param text_document_edit any #table: a `TextDocumentEdit` object
--- @param index any #number: Optional index of the edit,
---                           if from a list of edits (or nil, if
---                           not from a list)
function vim.lsp.apply_text_document_edit(text_document_edit, index) end

-- Applies a list of text edits to a buffer.
--- @param text_edits any #(table) list of `TextEdit` objects
function vim.lsp.apply_text_edits(text_edits, bufnr) end

-- Applies a `WorkspaceEdit` .
--- @param workspace_edit any #(table) `WorkspaceEdit`
function vim.lsp.apply_workspace_edit(workspace_edit) end

function vim.lsp.border_height(id) end

function vim.lsp.border_width(id) end

-- Removes document highlights from a buffer.
--- @param bufnr any #buffer id
function vim.lsp.buf_clear_references(bufnr) end

-- Shows a list of document highlights for a certain buffer.
--- @param bufnr any #buffer id
--- @param references any #List of `DocumentHighlight` objects to
---                   highlight
function vim.lsp.buf_highlight_references(bufnr, references) end

function vim.lsp.buf_lines(bufnr) end

-- Returns the UTF-32 and UTF-16 offsets for a position in a
-- certain buffer.
--- @param row any #0-indexed line
--- @param col any #0-indexed byte offset in line
--- @return any #(number, number) UTF-32 and UTF-16 index of the character
---     in line {row} column {col} in buffer {buf}
function vim.lsp.character_offset(bufnr, row, col) end

-- Clears the currently displayed diagnostics
--- @param bufnr any #number The buffer number
--- @param client_id any #number the client id
--- @param diagnostic_ns any #number|nil Associated diagnostic
---                      namespace
--- @param sign_ns any #number|nil Associated sign namespace
function vim.lsp.clear(bufnr, client_id, diagnostic_ns, sign_ns) end

-- Removes document highlights from current buffer.
function vim.lsp.clear_references() end

-- Creates autocommands to close a preview window when events
-- happen.
--- @param events any #(table) list of events
--- @param winnr any #(number) window id of preview window
function vim.lsp.close_preview_autocmd(events, winnr) end

-- Selects a code action from the input list that is available at
-- the current cursor position.
--- @param context any #(table, optional) Valid `CodeActionContext`
---                object
function vim.lsp.code_action(context) end

-- Retrieves the completion items at the current cursor position.
-- Can only be called in Insert mode.
--- @param context any #(context support not yet implemented)
---                Additional information about the context in
---                which a completion was triggered (how it was
---                triggered, and by which trigger character, if
---                applicable)
function vim.lsp.completion(context) end

-- Returns the range table for the difference between old and new
-- lines
--- @param old_lines any #table list of lines
--- @param new_lines any #table list of lines
--- @param start_line_idx any #int line to begin search for first
---                        difference
--- @param end_line_idx any #int line to begin search for last
---                        difference
--- @param offset_encoding any #string encoding requested by language
---                        server
--- @return any #table start_line_idx and start_col_idx of range
function vim.lsp.compute_diff(old_lines, new_lines, start_line_idx, end_line_idx, offset_encoding) end

-- Converts any of `MarkedString` | `MarkedString[]` |
-- `MarkupContent` into a list of lines containing valid
-- markdown. Useful to populate the hover window for
-- `textDocument/hover` , for parsing the result of
-- `textDocument/signatureHelp` , and potentially others.
--- @param input any #( `MarkedString` | `MarkedString[]` |
---                 `MarkupContent` )
--- @param contents any #(table, optional, default `{}` ) List of
---                 strings to extend with converted lines
--- @return any #{contents}, extended with lines of converted markdown.
function vim.lsp.convert_input_to_markdown_lines(input, contents) end

-- Converts `textDocument/SignatureHelp` response to markdown
-- lines.
--- @param signature_help any #Response of `textDocument/SignatureHelp`
--- @param ft any #optional filetype that will be use as
---                       the `lang` for the label markdown code
---                       block
--- @param triggers any #optional list of trigger characters from
---                       the lsp server. used to better determine
---                       parameter offsets
--- @return any #list of lines of converted markdown.
function vim.lsp.convert_signature_help_to_markdown_lines(signature_help, ft, triggers) end

function vim.lsp.create_file(change) end

-- Jumps to the declaration of the symbol under the cursor.
-- Note:
--     Many servers do not implement this method. Generally, see
--     |vim.lsp.buf.definition()| instead.
function vim.lsp.declaration() end

-- Jumps to the definition of the symbol under the cursor.
function vim.lsp.definition() end

function vim.lsp.delete_file(change) end

-- Convert diagnostics grouped by bufnr to a list of items for
-- use in the quickfix or location list.
--- @param diagnostics_by_bufnr any #table bufnr -> Diagnostic []
--- @param predicate any #an optional function to filter the
---                             diagnostics.
--- @return any #table (A list of items)
function vim.lsp.diagnostics_to_items(diagnostics_by_bufnr, predicate) end

-- Display the lenses using virtual text
--- @param lenses any #table of lenses to display ( `CodeLens[] |
---                  null` )
--- @param bufnr any #number
--- @param client_id any #number
function vim.lsp.display(lenses, bufnr, client_id) end

-- Send request to the server to resolve document highlights for
-- the current text document position. This request can be
-- triggered by a key mapping or by events such as `CursorHold` ,
-- eg:
function vim.lsp.document_highlight() end

-- Lists all symbols in the current buffer in the quickfix
-- window.
function vim.lsp.document_symbol() end

-- Executes an LSP server command.
--- @param command any #A valid `ExecuteCommandParams` object
function vim.lsp.execute_command(command) end

-- Can be used to extract the completion items from a `textDocument/completion` request, which may return one of `CompletionItem[]` , `CompletionList` or null.
--- @param result any #(table) The result of a
---               `textDocument/completion` request
--- @return any #(table) List of completion items
function vim.lsp.extract_completion_items(result) end

-- Flushes any outstanding change notification.
function vim.lsp.flush(client) end

-- Constructs an error message from an LSP error object.
--- @return any #(string) The formatted error message
function vim.lsp.format_rpc_error() end

-- Formats the current buffer.
--- @param options any #(optional, table) Can be used to specify
---                FormattingOptions. Some unspecified options
---                will be automatically derived from the current
---                Neovim options.
function vim.lsp.formatting(options) end

-- Formats the current buffer by sequentially requesting
-- formatting from attached clients.
--- @param options any #(optional, table) `FormattingOptions`
---                   entries
--- @param timeout_ms any #(optional, number) Request timeout
--- @param order any #(optional, table) List of client names.
---                   Formatting is requested from clients in the
---                   following order: first all clients that are
---                   not in the `order` list, then the remaining
---                   clients in the order as they occur in the
---                   `order` list.
function vim.lsp.formatting_seq_sync(options, timeout_ms, order) end

-- Performs |vim.lsp.buf.formatting()| synchronously.
--- @param options any #Table with valid `FormattingOptions` entries
--- @param timeout_ms any #(number) Request timeout
function vim.lsp.formatting_sync(options, timeout_ms) end

-- Return associated diagnostics for bufnr
--- @param bufnr any #number
--- @param client_id any #number|nil If nil, then return all of the
---                  diagnostics. Else, return just the
---                  diagnostics associated with the client_id.
function vim.lsp.get(bufnr, client_id) end

-- Get all diagnostics for clients
--- @param client_id any #number Restrict included diagnostics to the
---                  client If nil, diagnostics of all clients are
---                  included.
--- @return any #table with diagnostics grouped by bufnr (bufnr:Diagnostic[])
function vim.lsp.get_all(client_id) end

-- Get the counts for a particular severity
--- @param bufnr any #number The buffer number
--- @param severity any #DiagnosticSeverity
--- @param client_id any #number the client id
function vim.lsp.get_count(bufnr, severity, client_id) end

-- Returns visual width of tabstop.
--- @param bufnr any #(optional, number): Buffer handle, defaults to
---              current
--- @return any #(number) tabstop visual width
function vim.lsp.get_effective_tabstop(bufnr) end

-- Returns the log filename.
--- @return any #(string) log filename
function vim.lsp.get_filename() end

--- @param uri any #string uri of the resource to get the line from
--- @param row any #number zero-indexed line number
--- @return any #string the line at row in filename
function vim.lsp.get_line(uri, row) end

-- Get the diagnostics by line
--- @param bufnr any #number The buffer number
--- @param line_nr any #number The line number
--- @param opts any #table|nil Configuration keys
---                  • severity: (DiagnosticSeverity, default nil)
---                    • Only return diagnostics with this
---                      severity. Overrides severity_limit
---
---                  • severity_limit: (DiagnosticSeverity, default nil)
---                    • Limit severity of diagnostics found. E.g.
---                      "Warning" means { "Error", "Warning" }
---                      will be valid.
--- @param client_id any #number the client id
--- @return any #table Table with map of line number to list of
---     diagnostics.
function vim.lsp.get_line_diagnostics(bufnr, line_nr, opts, client_id) end

--- @param uri any #string uri of the resource to get the lines from
--- @param rows any #number[] zero-indexed line numbers
--- @return any #table<number string> a table mapping rows to lines
function vim.lsp.get_lines(uri, rows) end

function vim.lsp.get_markdown_fences() end

-- Get the next diagnostic closest to the cursor_position
--- @param opts any #table See |vim.lsp.diagnostic.goto_next()|
--- @return any #table Next diagnostic
function vim.lsp.get_next(opts) end

-- Return the pos, {row, col}, for the next diagnostic in the
-- current buffer.
--- @param opts any #table See |vim.lsp.diagnostic.goto_next()|
--- @return any #table Next diagnostic position
function vim.lsp.get_next_pos(opts) end

-- Get the previous diagnostic closest to the cursor_position
--- @param opts any #table See |vim.lsp.diagnostic.goto_next()|
--- @return any #table Previous diagnostic
function vim.lsp.get_prev(opts) end

-- Return the pos, {row, col}, for the prev diagnostic in the
-- current buffer.
--- @param opts any #table See |vim.lsp.diagnostic.goto_next()|
--- @return any #table Previous diagnostic position
function vim.lsp.get_prev_pos(opts) end

-- Process and return progress reports from lsp server.
function vim.lsp.get_progress_messages() end

-- Default function to get text chunks to display using `nvim_buf_set_virtual_text` .
--- @param bufnr any #number The buffer to display the virtual
---                   text in
--- @param line any #number The line number to display the
---                   virtual text on
--- @param line_diags any #Diagnostic [] The diagnostics associated with the line
--- @param opts any #table See {opts} from
---                   |vim.lsp.diagnostic.set_virtual_text()|
--- @return any #table chunks, as defined by |nvim_buf_set_virtual_text()|
function vim.lsp.get_virtual_text_chunks_for_line(bufnr, line, line_diags, opts) end

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

-- Move to the previous diagnostic
--- @param opts any #table See |vim.lsp.diagnostic.goto_next()|
function vim.lsp.goto_prev(opts) end

-- Displays hover information about the symbol under the cursor
-- in a floating window. Calling the function twice will jump
-- into the floating window.
function vim.lsp.hover() end

-- Lists all the implementations for the symbol under the cursor
-- in the quickfix window.
function vim.lsp.implementation() end

-- Lists all the call sites of the symbol under the cursor in the
-- |quickfix| window. If the symbol can resolve to multiple
-- items, the user can pick one in the |inputlist|.
function vim.lsp.incoming_calls() end

-- client_id → state
function vim.lsp.init(client, bufnr) end

-- Jumps to a location.
--- @param location any #( `Location` | `LocationLink` )
--- @return any #`true` if the jump succeeded
function vim.lsp.jump_to_location(location) end

-- List workspace folders.
function vim.lsp.list_workspace_folders() end

-- Returns the items with the byte position calculated correctly
-- and in sorted order, for display in quickfix and location
-- lists.
--- @param locations any #(table) list of `Location` s or
---                  `LocationLink` s
--- @return any #(table) list of items
function vim.lsp.locations_to_items(locations) end

-- Helper function to return nested values in language server
-- settings
--- @param settings any #a table of language server settings
--- @param section any #a string indicating the field of the settings
---                 table
--- @return any #(table or string) The value of settings accessed via
---     section
function vim.lsp.lookup_section(settings, section) end

-- Gets a new ClientCapabilities object describing the LSP client
-- capabilities.
function vim.lsp.make_client_capabilities() end

-- Creates a table with sensible default options for a floating
-- window. The table can be passed to |nvim_open_win()|.
--- @param width any #(number) window width (in character cells)
--- @param height any #(number) window height (in character cells)
--- @param opts any #(table, optional)
--- @return any #(table) Options
function vim.lsp.make_floating_popup_options(width, height, opts) end

-- Creates a `FormattingOptions` object for the current buffer
-- and cursor position.
--- @param options any #Table with valid `FormattingOptions` entries
--- @return any #`FormattingOptions object
function vim.lsp.make_formatting_params(options) end

-- Using the given range in the current buffer, creates an object
-- that is similar to |vim.lsp.util.make_range_params()|.
--- @param start_pos any #({number, number}, optional) mark-indexed
---                  position. Defaults to the start of the last
---                  visual selection.
--- @param end_pos any #({number, number}, optional) mark-indexed
---                  position. Defaults to the end of the last
---                  visual selection.
--- @return any #{ textDocument = { uri = `current_file_uri` }, range = {
---     start = `start_position` , end = `end_position` } }
function vim.lsp.make_given_range_params(start_pos, end_pos) end

-- Creates a `TextDocumentPositionParams` object for the current
-- buffer and cursor position.
--- @return any #`TextDocumentPositionParams` object
function vim.lsp.make_position_params() end

-- Using the current position in the current buffer, creates an
-- object that can be used as a building block for several LSP
-- requests, such as `textDocument/codeAction` ,
-- `textDocument/colorPresentation` ,
-- `textDocument/rangeFormatting` .
--- @return any #{ textDocument = { uri = `current_file_uri` }, range = {
---     start = `current_position` , end = `current_position` } }
function vim.lsp.make_range_params() end

-- Creates a `TextDocumentIdentifier` object for the current
-- buffer.
--- @return any #`TextDocumentIdentifier`
function vim.lsp.make_text_document_params() end

-- Create the workspace params
--- @param added any #
--- @param removed any #
function vim.lsp.make_workspace_params(added, removed) end

-- Sends a notification to the LSP server.
--- @param method any #(string) The invoked LSP method
--- @param params any #(table): Parameters for the invoked LSP method
--- @return any #(bool) `true` if notification could be sent, `false` if
---     not
function vim.lsp.notify(method, params) end

-- |lsp-handler| for the method `textDocument/codeLens`
function vim.lsp.on_codelens(err, _, result, client_id, bufnr) end

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

-- Shows contents in a floating window.
--- @param contents any #table of lines to show in window
--- @param syntax any #string of syntax to set for opened buffer
--- @param opts any #dictionary with optional fields
---                 • height of floating window
---                 • width of floating window
---                 • wrap boolean enable wrapping of long lines
---                   (defaults to true)
---                 • wrap_at character to wrap at for computing
---                   height when wrap is enabled
---                 • max_width maximal width of floating window
---                 • max_height maximal height of floating window
---                 • pad_left number of columns to pad contents
---                   at left
---                 • pad_right number of columns to pad contents
---                   at right
---                 • pad_top number of lines to pad contents at
---                   top
---                 • pad_bottom number of lines to pad contents
---                   at bottom
---                 • focus_id if a popup with this id is opened,
---                   then focus it
---                 • close_events list of events that closes the
---                   floating window
---                 • focusable (boolean, default true): Make
---                   float focusable
--- @return any #bufnr,winnr buffer and window number of the newly created
---     floating preview window
function vim.lsp.open_floating_preview(contents, syntax, opts) end

-- Lists all the items that are called by the symbol under the
-- cursor in the |quickfix| window. If the symbol can resolve to
-- multiple items, the user can pick one in the |inputlist|.
function vim.lsp.outgoing_calls() end

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
function vim.lsp.preview_location(location, opts) end

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

-- Refresh the codelens for the current buffer
function vim.lsp.refresh() end

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

--- @param last any #number last line that was changed
function vim.lsp.restore_extmarks(bufnr, last) end

-- Run the code lens in the current line
function vim.lsp.run() end

-- Save diagnostics to the current buffer.
--- @param diagnostics any #Diagnostic []
--- @param bufnr any #number
--- @param client_id any #number
function vim.lsp.save(diagnostics, bufnr, client_id) end

function vim.lsp.save_extmarks(bufnr, client_id) end

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

-- Fills target window's location list with given list of items.
-- Can be obtained with e.g. |vim.lsp.util.locations_to_items()|.
-- Defaults to current window.
--- @param items any #(table) list of items
function vim.lsp.set_loclist(items, win_id) end

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
---                  • Plus all the opts for
---                    |vim.lsp.diagnostic.get_line_diagnostics()|
---                    and |vim.lsp.util.open_floating_preview()|
---                    can be used here.
--- @param bufnr any #number The buffer number
--- @param line_nr any #number The line number
--- @param client_id any #number|nil the client id
--- @return any #table {popup_bufnr, win_id}
function vim.lsp.show_line_diagnostics(opts, bufnr, line_nr, client_id) end

--- @param config any #table Configuration table.
---               • border: (default=nil)
---                 • Add borders to the floating window
---                 • See |vim.api.nvim_open_win()|
function vim.lsp.signature_help(_, method, result, client_id, bufnr, config) end

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

-- Converts markdown into syntax highlighted regions by stripping
-- the code blocks and converting them into highlighted code.
-- This will by default insert a blank line separator after those
-- code block regions to improve readability.
--- @param contents any #table of lines to show in window
--- @param opts any #dictionary with optional fields
---                 • height of floating window
---                 • width of floating window
---                 • wrap_at character to wrap at for computing
---                   height
---                 • max_width maximal width of floating window
---                 • max_height maximal height of floating window
---                 • pad_left number of columns to pad contents
---                   at left
---                 • pad_right number of columns to pad contents
---                   at right
---                 • pad_top number of lines to pad contents at
---                   top
---                 • pad_bottom number of lines to pad contents
---                   at bottom
---                 • separator insert separator after code block
--- @return any #width,height size of float
function vim.lsp.stylize_markdown(bufnr, contents, opts) end

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

-- Jumps to the definition of the type of the symbol under the
-- cursor.
function vim.lsp.type_definition() end

-- Lists all symbols in the current workspace in the quickfix
-- window.
--- @param query any #(string, optional)
function vim.lsp.workspace_symbol(query) end

