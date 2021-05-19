--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Removes document highlights from current buffer.
function vim.lsp.clear_references() end

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
--- @param client_id any #number the client id
--- @param bufnr any #number The buffer number
--- @return any #table Table with map of line number to list of
---     diagnostics.
function vim.lsp.get_line_diagnostics(bufnr, line_nr, opts, client_id) end

-- Performs |vim.lsp.buf.code_action()| for a given range.
--- @param context any #(table, optional) Valid `CodeActionContext`
---                  object
--- @param end_pos any #({number, number}, optional) mark-indexed
---                  position. Defaults to the end of the last
---                  visual selection.
--- @param start_pos any #({number, number}, optional) mark-indexed
---                  position. Defaults to the start of the last
---                  visual selection.
function vim.lsp.range_code_action(context, start_pos, end_pos) end

-- Set underline for given diagnostics
--- @param client_id any #number: The client id
--- @param bufnr any #number: The buffer number
--- @param opts any #table: Configuration table:
---                      • severity_limit (DiagnosticSeverity):
---                        • Limit severity of diagnostics found.
---                          E.g. "Warning" means { "Error",
---                          "Warning" } will be valid.
--- @param diagnostics any #Diagnostic []
--- @param diagnostic_ns any #number|nil: The namespace
function vim.lsp.set_underline(diagnostics, bufnr, client_id, diagnostic_ns, opts) end

-- Creates a normalized object describing LSP server
-- capabilities.
function vim.lsp.resolve_capabilities(server_capabilities) end

-- Using the current position in the current buffer, creates an
-- object that can be used as a building block for several LSP
-- requests, such as `textDocument/codeAction` ,
-- `textDocument/colorPresentation` ,
-- `textDocument/rangeFormatting` .
--- @return any #{ textDocument = { uri = `current_file_uri` }, range = {
---     start = `current_position` , end = `current_position` } }
function vim.lsp.make_range_params() end

-- Get the counts for a particular severity
--- @param severity any #DiagnosticSeverity
--- @param client_id any #number the client id
--- @param bufnr any #number The buffer number
function vim.lsp.get_count(bufnr, severity, client_id) end

-- Default function to get text chunks to display using `nvim_buf_set_virtual_text` .
--- @param line_diags any #Diagnostic [] The diagnostics associated with the line
--- @param line any #number The line number to display the
---                   virtual text on
--- @param opts any #table See {opts} from
---                   |vim.lsp.diagnostic.set_virtual_text()|
--- @param bufnr any #number The buffer to display the virtual
---                   text in
--- @return any #table chunks, as defined by |nvim_buf_set_virtual_text()|
function vim.lsp.get_virtual_text_chunks_for_line(bufnr, line, line_diags, opts) end

-- Sends a notification to the LSP server.
--- @param params any #(table): Parameters for the invoked LSP method
--- @param method any #(string) The invoked LSP method
--- @return any #(bool) `true` if notification could be sent, `false` if
---     not
function vim.lsp.notify(method, params) end

--- @param config any #table Configuration table.
---               • border: (default=nil)
---                 • Add borders to the floating window
---                 • See |vim.api.nvim_open_win()|
function vim.lsp.signature_help(_, method, result, _, bufnr, config) end

-- Removes document highlights from a buffer.
--- @param bufnr any #buffer id
function vim.lsp.buf_clear_references(bufnr) end

-- Converts symbols to quickfix list items.
--- @param symbols any #DocumentSymbol[] or SymbolInformation[]
function vim.lsp.symbols_to_items(symbols, bufnr) end

-- Process and return progress reports from lsp server.
function vim.lsp.get_progress_messages() end

-- Helper function to return nested values in language server
-- settings
--- @param section any #a string indicating the field of the settings
---                 table
--- @param settings any #a table of language server settings
--- @return any #(table or string) The value of settings accessed via
---     section
function vim.lsp.lookup_section(settings, section) end

-- Jumps to the declaration of the symbol under the cursor.
-- Note:
--     Many servers do not implement this method. Generally, see
--     |vim.lsp.buf.definition()| instead.
-- 
function vim.lsp.declaration() end

-- Fills quickfix list with given list of items. Can be obtained
-- with e.g. |vim.lsp.util.locations_to_items()|.
--- @param items any #(table) list of items
function vim.lsp.set_qflist(items) end

-- Jumps to the definition of the type of the symbol under the
-- cursor.
function vim.lsp.type_definition() end

-- Return associated diagnostics for bufnr
--- @param client_id any #number|nil If nil, then return all of the
---                  diagnostics. Else, return just the
---                  diagnostics associated with the client_id.
--- @param bufnr any #number
function vim.lsp.get(bufnr, client_id) end

-- Fills current window's location list with given list of items.
-- Can be obtained with e.g. |vim.lsp.util.locations_to_items()|.
--- @param items any #(table) list of items
function vim.lsp.set_loclist(items) end

-- Can be used to extract the completion items from a `textDocument/completion` request, which may return one of `CompletionItem[]` , `CompletionList` or null.
--- @param result any #(table) The result of a
---               `textDocument/completion` request
--- @return any #(table) List of completion items
function vim.lsp.extract_completion_items(result) end

-- Applies a `TextDocumentEdit` , which is a list of changes to a
-- single document.
--- @param text_document_edit any #table: a `TextDocumentEdit` object
--- @param index any #number: Optional index of the edit,
---                           if from a list of edits (or nil, if
---                           not from a list)
function vim.lsp.apply_text_document_edit(text_document_edit, index) end

-- Applies a `WorkspaceEdit` .
--- @param workspace_edit any #(table) `WorkspaceEdit`
function vim.lsp.apply_workspace_edit(workspace_edit) end

-- Enters/leaves the focusable window associated with the current
-- buffer via the.
--- @param unique_name any #(string) Window variable
--- @param fn fun(...) #(function) should return create a new
---                    window and return a tuple of
---                    ({focusable_buffer_id}, {window_id}). if
---                    {focusable_buffer_id} is a valid buffer id,
---                    the newly created window will be the new
---                    focus associated with the current buffer
---                    via the tag `unique_name` .
--- @return any #(pbufnr, pwinnr) if `fn()` has created a new window; nil
---     otherwise
function vim.lsp.focusable_float(unique_name, fn) end

-- Selects a code action from the input list that is available at
-- the current cursor position.
--- @param context any #(table, optional) Valid `CodeActionContext`
---                object
function vim.lsp.code_action(context) end

-- Removes empty lines from the beginning and end.
--- @param lines any #(table) list of lines to trim
--- @return any #(table) trimmed list of lines
function vim.lsp.trim_empty_lines(lines) end

-- Converts markdown into syntax highlighted regions by stripping
-- the code blocks and converting them into highlighted code.
-- This will by default insert a blank line separator after those
-- code block regions to improve readability. The result is shown
-- in a floating preview.
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
--- @param contents any #table of lines to show in window
--- @return any #width,height size of float
function vim.lsp.fancy_floating_markdown(contents, opts) end

-- Creates autocommands to close a preview window when events
-- happen.
--- @param events any #(table) list of events
--- @param winnr any #(number) window id of preview window
function vim.lsp.close_preview_autocmd(events, winnr) end

-- Executes an LSP server command.
--- @param command any #A valid `ExecuteCommandParams` object
function vim.lsp.execute_command(command) end

