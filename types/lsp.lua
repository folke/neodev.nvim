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
--- @param buf_nr any #(number) Buffer id
function vim.lsp.apply_text_edits(text_edits, bufnr) end

-- Applies a `WorkspaceEdit` .
--- @param workspace_edit any #(table) `WorkspaceEdit`
function vim.lsp.apply_workspace_edit(workspace_edit) end

-- Removes document highlights from a buffer.
--- @param bufnr any #buffer id
function vim.lsp.buf_clear_references(bufnr) end

-- Shows a list of document highlights for a certain buffer.
--- @param bufnr any #buffer id
--- @param references any #List of `DocumentHighlight` objects to
---                   highlight
function vim.lsp.buf_highlight_references(bufnr, references) end

-- Returns the UTF-32 and UTF-16 offsets for a position in a
-- certain buffer.
--- @param row any #0-indexed line
--- @param col any #0-indexed byte offset in line
--- @param buf any #buffer id (0 for current)
--- @return any #(number, number) UTF-32 and UTF-16 index of the character
---     in line {row} column {col} in buffer {buf}
function vim.lsp.character_offset(buf, row, col) end

-- Clears the currently displayed diagnostics
--- @param diagnostic_ns any #number|nil Associated diagnostic
---                      namespace
--- @param sign_ns any #number|nil Associated sign namespace
--- @param bufnr any #number The buffer number
--- @param client_id any #number the client id
function vim.lsp.clear(bufnr, client_id, diagnostic_ns, sign_ns) end

-- Removes document highlights from current buffer.
function vim.lsp.clear_references() end

-- Creates autocommands to close a preview window when events
-- happen.
--- @param winnr any #(number) window id of preview window
--- @param events any #(table) list of events
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
--- @param offset_encoding any #string encoding requested by language
---                        server
--- @param end_line_idx any #int line to begin search for last
---                        difference
--- @param new_lines any #table list of lines
--- @param start_line_idx any #int line to begin search for first
---                        difference
--- @return any #table start_line_idx and start_col_idx of range
function vim.lsp.compute_diff(old_lines, new_lines, start_line_idx, end_line_idx, offset_encoding) end

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

-- Converts `textDocument/SignatureHelp` response to markdown
-- lines.
--- @param signature_help any #Response of `textDocument/SignatureHelp`
--- @return any #list of lines of converted markdown.
function vim.lsp.convert_signature_help_to_markdown_lines(signature_help) end

function vim.lsp.create_file(change) end

-- Jumps to the declaration of the symbol under the cursor.
-- Note:
--     Many servers do not implement this method. Generally, see
--     |vim.lsp.buf.definition()| instead.
-- 
function vim.lsp.declaration() end

-- Jumps to the definition of the symbol under the cursor.
function vim.lsp.definition() end

function vim.lsp.delete_file(change) end

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

-- Converts markdown into syntax highlighted regions by stripping
-- the code blocks and converting them into highlighted code.
-- This will by default insert a blank line separator after those
-- code block regions to improve readability. The result is shown
-- in a floating preview.
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
function vim.lsp.fancy_floating_markdown(contents, opts) end

-- Flushes any outstanding change notification.
function vim.lsp.flush(client) end

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

-- Constructs an error message from an LSP error object.
--- @param err any #(table) The error object
--- @return any #(string) The formatted error message
function vim.lsp.format_rpc_error(err) end

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
--- @param order any #(optional, table) List of client names.
---                   Formatting is requested from clients in the
---                   following order: first all clients that are
---                   not in the `order` list, then the remaining
---                   clients in the order as they occur in the
---                   `order` list.
--- @param timeout_ms any #(optional, number) Request timeout
function vim.lsp.formatting_seq_sync(options, timeout_ms, order) end

-- Performs |vim.lsp.buf.formatting()| synchronously.
--- @param timeout_ms any #(number) Request timeout
--- @param options any #Table with valid `FormattingOptions` entries
function vim.lsp.formatting_sync(options, timeout_ms) end

-- Return associated diagnostics for bufnr
--- @param bufnr any #number
--- @param client_id any #number|nil If nil, then return all of the
---                  diagnostics. Else, return just the
---                  diagnostics associated with the client_id.
function vim.lsp.get(bufnr, client_id) end

