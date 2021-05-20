--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Get all diagnostics for all clients
--- @return any #{bufnr:Diagnostic[]}
function vim.lsp.get_all() end

-- Get the counts for a particular severity
--- @param severity any #DiagnosticSeverity
--- @param bufnr any #number The buffer number
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

-- Get the diagnostics by line
--- @param opts any #table|nil Configuration keys
---                  • severity: (DiagnosticSeverity, default nil)
---                    • Only return diagnostics with this
---                      severity. Overrides severity_limit
--- 
---                  • severity_limit: (DiagnosticSeverity, default nil)
---                    • Limit severity of diagnostics found. E.g.
---                      "Warning" means { "Error", "Warning" }
---                      will be valid.
--- @param line_nr any #number The line number
--- @param bufnr any #number The buffer number
--- @param client_id any #number the client id
--- @return any #table Table with map of line number to list of
---     diagnostics.
function vim.lsp.get_line_diagnostics(bufnr, line_nr, opts, client_id) end

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
--- @param line_diags any #Diagnostic [] The diagnostics associated with the line
--- @param line any #number The line number to display the
---                   virtual text on
--- @param bufnr any #number The buffer to display the virtual
---                   text in
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
--- @param section any #a string indicating the field of the settings
---                 table
--- @param settings any #a table of language server settings
--- @return any #(table or string) The value of settings accessed via
---     section
function vim.lsp.lookup_section(settings, section) end

-- Gets a new ClientCapabilities object describing the LSP client
-- capabilities.
function vim.lsp.make_client_capabilities() end

-- Creates a table with sensible default options for a floating
-- window. The table can be passed to |nvim_open_win()|.
--- @param height any #(number) window height (in character cells)
--- @param width any #(number) window width (in character cells)
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
--- @param removed any #
--- @param added any #
function vim.lsp.make_workspace_params(added, removed) end

-- Sends a notification to the LSP server.
--- @param params any #(table): Parameters for the invoked LSP method
--- @param method any #(string) The invoked LSP method
--- @return any #(bool) `true` if notification could be sent, `false` if
---     not
function vim.lsp.notify(method, params) end

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
--- @return any #bufnr,winnr buffer and window number of the newly created
---     floating preview window
function vim.lsp.open_floating_preview(contents, syntax, opts) end

