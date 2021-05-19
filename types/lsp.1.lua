--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Applies a list of text edits to a buffer.
--- @param text_edits any #(table) list of `TextEdit` objects
--- @param buf_nr any #(number) Buffer id
function vim.lsp.apply_text_edits(text_edits, bufnr) end

-- Get all diagnostics for all clients
--- @return any #{bufnr:Diagnostic[]}
function vim.lsp.get_all() end

-- Creates a `TextDocumentIdentifier` object for the current
-- buffer.
--- @return any #`TextDocumentIdentifier`
function vim.lsp.make_text_document_params() end

-- Formats the current buffer.
--- @param options any #(optional, table) Can be used to specify
---                FormattingOptions. Some unspecified options
---                will be automatically derived from the current
---                Neovim options.
function vim.lsp.formatting(options) end

-- Performs |vim.lsp.buf.formatting()| synchronously.
--- @param options any #Table with valid `FormattingOptions` entries
--- @param timeout_ms any #(number) Request timeout
function vim.lsp.formatting_sync(options, timeout_ms) end

-- Converts `textDocument/SignatureHelp` response to markdown
-- lines.
--- @param signature_help any #Response of `textDocument/SignatureHelp`
--- @return any #list of lines of converted markdown.
function vim.lsp.convert_signature_help_to_markdown_lines(signature_help) end

-- Jumps to the definition of the symbol under the cursor.
function vim.lsp.definition() end

-- Formats the current buffer by sequentially requesting
-- formatting from attached clients.
--- @param order any #(optional, table) List of client names.
---                   Formatting is requested from clients in the
---                   following order: first all clients that are
---                   not in the `order` list, then the remaining
---                   clients in the order as they occur in the
---                   `order` list.
--- @param options any #(optional, table) `FormattingOptions`
---                   entries
--- @param timeout_ms any #(optional, number) Request timeout
function vim.lsp.formatting_seq_sync(options, timeout_ms, order) end

-- Gets a new ClientCapabilities object describing the LSP client
-- capabilities.
function vim.lsp.make_client_capabilities() end

-- Shows contents in a floating window.
--- @param contents any #table of lines to show in window
--- @param opts any #dictionary with optional fields
--- @param syntax any #string of syntax to set for opened buffer
--- @return any #bufnr,winnr buffer and window number of the newly created
---     floating preview window
function vim.lsp.open_floating_preview(contents, syntax, opts) end

-- Formats a given range.
--- @param start_pos any #({number, number}, optional) mark-indexed
---                  position. Defaults to the start of the last
---                  visual selection.
--- @param options any #Table with valid `FormattingOptions` entries.
--- @param end_pos any #({number, number}, optional) mark-indexed
---                  position. Defaults to the end of the last
---                  visual selection.
function vim.lsp.range_formatting(options, start_pos, end_pos) end

-- client_id → state
function vim.lsp.init(client, bufnr) end

-- Returns the range table for the difference between old and new
-- lines
--- @param new_lines any #table list of lines
--- @param old_lines any #table list of lines
--- @param start_line_idx any #int line to begin search for first
---                        difference
--- @param end_line_idx any #int line to begin search for last
---                        difference
--- @param offset_encoding any #string encoding requested by language
---                        server
--- @return any #table start_line_idx and start_col_idx of range
function vim.lsp.compute_diff(old_lines, new_lines, start_line_idx, end_line_idx, offset_encoding) end

-- Lists all symbols in the current buffer in the quickfix
-- window.
function vim.lsp.document_symbol() end

-- Displays hover information about the symbol under the cursor
-- in a floating window. Calling the function twice will jump
-- into the floating window.
function vim.lsp.hover() end

-- Returns the items with the byte position calculated correctly
-- and in sorted order, for display in quickfix and location
-- lists.
--- @param locations any #(table) list of `Location` s or
---                  `LocationLink` s
--- @return any #(table) list of items
function vim.lsp.locations_to_items(locations) end

-- Parses snippets in a completion entry.
--- @param input any #(string) unparsed snippet
--- @return any #(string) parsed snippet
function vim.lsp.parse_snippet(input) end

-- Set signs for given diagnostics
--- @param sign_ns any #number|nil
--- @param client_id any #number the client id
--- @param bufnr any #number The buffer number
--- @param diagnostics any #Diagnostic []
--- @param opts any #table Configuration for signs. Keys:
---                    • priority: Set the priority of the signs.
---                    • severity_limit (DiagnosticSeverity):
---                      • Limit severity of diagnostics found.
---                        E.g. "Warning" means { "Error",
---                        "Warning" } will be valid.
function vim.lsp.set_signs(diagnostics, bufnr, client_id, sign_ns, opts) end

-- Clears the currently displayed diagnostics
--- @param diagnostic_ns any #number|nil Associated diagnostic
---                      namespace
--- @param sign_ns any #number|nil Associated sign namespace
--- @param client_id any #number the client id
--- @param bufnr any #number The buffer number
function vim.lsp.clear(bufnr, client_id, diagnostic_ns, sign_ns) end

-- Lists all the call sites of the symbol under the cursor in the
-- |quickfix| window. If the symbol can resolve to multiple
-- items, the user can pick one in the |inputlist|.
function vim.lsp.incoming_calls() end

-- Turns the result of a `textDocument/completion` request into
-- vim-compatible |complete-items|.
--- @param prefix any #(string) the prefix to filter the completion
---               items
--- @param result any #The result of a `textDocument/completion` call,
---               e.g. from |vim.lsp.buf.completion()|, which may
---               be one of `CompletionItem[]` , `CompletionList`
---               or `null`
--- @return any #{ matches = complete-items table, incomplete = bool }
function vim.lsp.text_document_completion_list_to_complete_items(result, prefix) end

-- Lists all the items that are called by the symbol under the
-- cursor in the |quickfix| window. If the symbol can resolve to
-- multiple items, the user can pick one in the |inputlist|.
function vim.lsp.outgoing_calls() end

-- List workspace folders.
function vim.lsp.list_workspace_folders() end

-- Returns the UTF-32 and UTF-16 offsets for a position in a
-- certain buffer.
--- @param row any #0-indexed line
--- @param buf any #buffer id (0 for current)
--- @param col any #0-indexed byte offset in line
--- @return any #(number, number) UTF-32 and UTF-16 index of the character
---     in line {row} column {col} in buffer {buf}
function vim.lsp.character_offset(buf, row, col) end

-- Open a floating window with the diagnostics from {line_nr}
--- @param opts any #table Configuration table
---                  • show_header (boolean, default true): Show
---                    "Diagnostics:" header.
--- @param line_nr any #number The line number
--- @param client_id any #number|nil the client id
--- @param bufnr any #number The buffer number
--- @return any #table {popup_bufnr, win_id}
function vim.lsp.show_line_diagnostics(opts, bufnr, line_nr, client_id) end

-- Add the folder at path to the workspace folders. If {path} is
-- not provided, the user will be prompted for a path using
-- |input()|.
function vim.lsp.add_workspace_folder(workspace_folder) end

-- Get the previous diagnostic closest to the cursor_position
--- @param opts any #table See |vim.lsp.diagnostic.goto_next()|
--- @return any #table Previous diagnostic
function vim.lsp.get_prev(opts) end

-- Converts any of `MarkedString` | `MarkedString[]` |
-- `MarkupContent` into a list of lines containing valid
-- markdown. Useful to populate the hover window for
-- `textDocument/hover` , for parsing the result of
-- `textDocument/signatureHelp` , and potentially others.
--- @param contents any #(table, optional, default `{}` ) List of
---                 strings to extend with converted lines
--- @param input any #( `MarkedString` | `MarkedString[]` |
---                 `MarkupContent` )
--- @return any #{contents}, extended with lines of converted markdown.
function vim.lsp.convert_input_to_markdown_lines(input, contents) end

-- Return the pos, {row, col}, for the prev diagnostic in the
-- current buffer.
--- @param opts any #table See |vim.lsp.diagnostic.goto_next()|
--- @return any #table Previous diagnostic position
function vim.lsp.get_prev_pos(opts) end

-- Move to the previous diagnostic
--- @param opts any #table See |vim.lsp.diagnostic.goto_next()|
function vim.lsp.goto_prev(opts) end

-- Shows a list of document highlights for a certain buffer.
--- @param references any #List of `DocumentHighlight` objects to
---                   highlight
--- @param bufnr any #buffer id
function vim.lsp.buf_highlight_references(bufnr, references) end

-- Get the next diagnostic closest to the cursor_position
--- @param opts any #table See |vim.lsp.diagnostic.goto_next()|
--- @return any #table Next diagnostic
function vim.lsp.get_next(opts) end

-- Return the pos, {row, col}, for the next diagnostic in the
-- current buffer.
--- @param opts any #table See |vim.lsp.diagnostic.goto_next()|
--- @return any #table Next diagnostic position
function vim.lsp.get_next_pos(opts) end

-- Sends a request to the LSP server and runs {callback} upon
-- response.
--- @param params any #(table) Parameters for the invoked LSP method
--- @param method any #(string) The invoked LSP method
--- @param callback any #(function) Callback to invoke
--- @return any #(bool, number) `(true, message_id)` if request could be
---     sent, `false` if not
function vim.lsp.request(method, params, callback) end

-- Set virtual text given diagnostics
--- @param client_id any #number
--- @param bufnr any #number
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
--- @param diagnostics any #Diagnostic []
--- @param diagnostic_ns any #number
function vim.lsp.set_virtual_text(diagnostics, bufnr, client_id, diagnostic_ns, opts) end

