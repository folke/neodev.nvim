---@meta

--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Add the folder at path to the workspace folders. If {path} is not
-- provided, the user will be prompted for a path using |input()|.
function vim.lsp.add_workspace_folder(workspace_folder) end

-- Applies a `TextDocumentEdit`, which is a list of changes to a single
-- document.
--- @see https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocumentEdit
--- @param text_document_edit any # table: a `TextDocumentEdit` object
--- @param index any # number: Optional index of the edit, if from a
--                           list of edits (or nil, if not from a list)
function vim.lsp.apply_text_document_edit(text_document_edit, index, offset_encoding) end

-- Applies a list of text edits to a buffer.
--- @see https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textEdit
--- @param text_edits any # (table) list of `TextEdit` objects
--- @param bufnr any # (number) Buffer id
--- @param offset_encoding any # (string) utf-8|utf-16|utf-32
function vim.lsp.apply_text_edits(text_edits, bufnr, offset_encoding) end

-- Applies a `WorkspaceEdit`.
--- @param workspace_edit any # (table) `WorkspaceEdit`
--- @param offset_encoding any # (string) utf-8|utf-16|utf-32 (required)
function vim.lsp.apply_workspace_edit(workspace_edit, offset_encoding) end

-- Removes document highlights from a buffer.
--- @param bufnr any # (number) Buffer id
function vim.lsp.buf_clear_references(bufnr) end

-- Shows a list of document highlights for a certain buffer.
--- @see https://microsoft.github.io/language-server-protocol/specifications/specification-3-17/#documentHighlight
--- @param bufnr any # (number) Buffer id
--- @param references any # (table) List of `DocumentHighlight` objects to
--                        highlight
--- @param offset_encoding any # (string) One of "utf-8", "utf-16", "utf-32".
function vim.lsp.buf_highlight_references(bufnr, references, offset_encoding) end

-- Returns the UTF-32 and UTF-16 offsets for a position in a certain buffer.
--- @param buf any # (number) buffer number (0 for current)
--- @param row any # 0-indexed line
--- @param col any # 0-indexed byte offset in line
--- @param offset_encoding any # (string) utf-8|utf-16|utf-32|nil defaults to
--                        `offset_encoding` of first client of `buf`
--- @return any # (number, number) `offset_encoding` index of the character in line
--     {row} column {col} in buffer {buf}
function vim.lsp.character_offset(buf, row, col, offset_encoding) end

-- Removes document highlights from current buffer.
function vim.lsp.clear_references() end

-- Selects a code action available at the current cursor position.
--- @see https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_codeAction
--- @param options any # (table|nil) Optional table which holds the following
--                optional fields:
--                • context: (table|nil) Corresponds to `CodeActionContext` of the LSP specification:
--                  • diagnostics (table|nil): LSP`Diagnostic[]` . Inferred from the current position if not provided.
--                  • only (table|nil): List of LSP `CodeActionKind`s used to
--                    filter the code actions. Most language servers support
--                    values like `refactor` or `quickfix`.
--
--                • filter: (function|nil) Predicate taking an `CodeAction`
--                  and returning a boolean.
--                • apply: (boolean|nil) When set to `true`, and there is
--                  just one remaining action (after filtering), the action
--                  is applied without user query.
--                • range: (table|nil) Range for which code actions should be
--                  requested. If in visual mode this defaults to the active
--                  selection. Table must contain `start` and `end` keys with
--                  {row, col} tuples using mark-like indexing. See
--                  |api-indexing|
function vim.lsp.code_action(options) end

-- Retrieves the completion items at the current cursor position. Can only be
-- called in Insert mode.
--- @see |vim.lsp.protocol.constants.CompletionTriggerKind|
--- @param context any # (context support not yet implemented) Additional
--                information about the context in which a completion was
--                triggered (how it was triggered, and by which trigger
--                character, if applicable)
function vim.lsp.completion(context) end

-- Returns the range table for the difference between prev and curr lines
--- @return any # (table) TextDocumentContentChangeEvent see https://microsoft.github.io/language-server-protocol/specifications/specification-3-17/#textDocumentContentChangeEvent
function vim.lsp.compute_diff(___MissingCloseParenHere___) end

-- Create a LSP RPC client factory that connects via TCP to the given host
-- and port
--- @param host any # (string)
--- @param port any # (number)
--- @return any # (function)
function vim.lsp.connect(host, port) end

-- Converts any of `MarkedString` | `MarkedString[]` | `MarkupContent` into a
-- list of lines containing valid markdown. Useful to populate the hover
-- window for `textDocument/hover`, for parsing the result of
-- `textDocument/signatureHelp`, and potentially others.
--- @see https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_hover
--- @param input any # (`MarkedString` | `MarkedString[]` | `MarkupContent`)
--- @param contents any # (table, optional, default `{}`) List of strings to extend
--                 with converted lines
--- @return any # {contents}, extended with lines of converted markdown.
function vim.lsp.convert_input_to_markdown_lines(input, contents) end

-- Converts `textDocument/SignatureHelp` response to markdown lines.
--- @see https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_signatureHelp
--- @param signature_help any # Response of `textDocument/SignatureHelp`
--- @param ft any # optional filetype that will be use as the `lang` for
--                       the label markdown code block
--- @param triggers any # optional list of trigger characters from the lsp
--                       server. used to better determine parameter offsets
--- @return any # list of lines of converted markdown.
function vim.lsp.convert_signature_help_to_markdown_lines(signature_help, ft, triggers) end

-- Jumps to the declaration of the symbol under the cursor.
-- Note:
--     Many servers do not implement this method. Generally, see
--     |vim.lsp.buf.definition()| instead.
--- @param options any # (table|nil) additional options
--                • reuse_win: (boolean) Jump to existing window if buffer is
--                  already open.
--                • on_list: (function) handler for list results. See
--                  |lsp-on-list-handler|
function vim.lsp.declaration(options) end

-- Jumps to the definition of the symbol under the cursor.
--- @param options any # (table|nil) additional options
--                • reuse_win: (boolean) Jump to existing window if buffer is
--                  already open.
--                • on_list: (function) handler for list results. See
--                  |lsp-on-list-handler|
function vim.lsp.definition(options) end

-- Display the lenses using virtual text
--- @param lenses any # (table) of lenses to display (`CodeLens[] | null`)
--- @param bufnr any # (number)
--- @param client_id any # (number)
function vim.lsp.display(lenses, bufnr, client_id) end

-- Send request to the server to resolve document highlights for the current
-- text document position. This request can be triggered by a key mapping or
-- by events such as `CursorHold`, e.g.:
--
--
-- ```lua
-- autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
-- autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
-- autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--
-- ```
--
-- Note: Usage of |vim.lsp.buf.document_highlight()| requires the following
-- highlight groups to be defined or you won't be able to see the actual
-- highlights. |LspReferenceText| |LspReferenceRead| |LspReferenceWrite|
function vim.lsp.document_highlight() end

-- Lists all symbols in the current buffer in the quickfix window.
--- @param options any # (table|nil) additional options
--                • on_list: (function) handler for list results. See
--                  |lsp-on-list-handler|
function vim.lsp.document_symbol(options) end

-- Executes an LSP server command.
--- @see https://microsoft.github.io/language-server-protocol/specifications/specification-current/#workspace_executeCommand
--- @param command_params any # (table) A valid `ExecuteCommandParams` object
function vim.lsp.execute_command(command_params) end

-- Can be used to extract the completion items from a `textDocument/completion` request, which may return one of `CompletionItem[]` , `CompletionList` or null.
--- @see https://microsoft.github.io/language-server-protocol/specification#textDocument_completion
--- @param result any # (table) The result of a `textDocument/completion` request
--- @return any # (table) List of completion items
function vim.lsp.extract_completion_items(result) end

-- Formats a buffer using the attached (and optionally filtered) language
-- server clients.
--- @param options any # table|nil Optional table which holds the following optional
--                fields:
--                • formatting_options (table|nil): Can be used to specify
--                  FormattingOptions. Some unspecified options will be
--                  automatically derived from the current Neovim options.
--                  See https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#formattingOptions
--                • timeout_ms (integer|nil, default 1000): Time in
--                  milliseconds to block for formatting requests. No effect
--                  if async=true
--                • bufnr (number|nil): Restrict formatting to the clients
--                  attached to the given buffer, defaults to the current
--                  buffer (0).
--                • filter (function|nil): Predicate used to filter clients.
--                  Receives a client as argument and must return a boolean.
--                  Clients matching the predicate are included. Example:               • >
--
--         -- Never request typescript-language-server for formatting
--         vim.lsp.buf.format {
--           filter = function(client) return client.name ~= "tsserver" end
--         }
--
-- <
--                • async boolean|nil If true the method won't block.
--                  Defaults to false. Editing the buffer while formatting
--                  asynchronous can lead to unexpected changes.
--                • id (number|nil): Restrict formatting to the client with
--                  ID (client.id) matching this field.
--                • name (string|nil): Restrict formatting to the client with
--                  name (client.name) matching this field.
--                • range (table|nil) Range to format. Table must contain
--                  `start` and `end` keys with {row, col} tuples using (1,0)
--                  indexing. Defaults to current selection in visual mode
--                  Defaults to `nil` in other modes, formatting the full
--                  buffer
function vim.lsp.format(options) end

-- Constructs an error message from an LSP error object.
--- @return any # (string) The formatted error message
function vim.lsp.format_rpc_error() end

-- Formats the current buffer.
--- @see https://microsoft.github.io/language-server-protocol/specification#textDocument_formatting
--- @param options any # (table|nil) Can be used to specify FormattingOptions. Some
--                unspecified options will be automatically derived from the
--                current Neovim options.
function vim.lsp.formatting(options) end

-- Formats the current buffer by sequentially requesting formatting from
-- attached clients.
--
-- Useful when multiple clients with formatting capability are attached.
--
-- Since it's synchronous, can be used for running on save, to make sure
-- buffer is formatted prior to being saved. {timeout_ms} is passed on to the
-- |vim.lsp.client| `request_sync` method. Example:
-- ```lua
--
--  vim.api.nvim_command[[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
--
-- ```
--- @param options any # (table|nil) `FormattingOptions` entries
--- @param timeout_ms any # (number|nil) Request timeout
--- @param order any # (table|nil) List of client names. Formatting is
--                   requested from clients in the following order: first all
--                   clients that are not in the `order` list, then the
--                   remaining clients in the order as they occur in the
--                   `order` list.
function vim.lsp.formatting_seq_sync(options, timeout_ms, order) end

-- Performs |vim.lsp.buf.formatting()| synchronously.
--
-- Useful for running on save, to make sure buffer is formatted prior to
-- being saved. {timeout_ms} is passed on to |vim.lsp.buf_request_sync()|.
-- Example:
--
--
-- ```lua
--
--  autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
--
-- ```
--- @see |vim.lsp.buf.formatting_seq_sync|
--- @param options any # (table|nil) with valid `FormattingOptions` entries
--- @param timeout_ms any # (number) Request timeout
function vim.lsp.formatting_sync(options, timeout_ms) end

-- Return all lenses for the given buffer
--- @param bufnr any # (number) Buffer number. 0 can be used for the current buffer.
--- @return any # (table) (`CodeLens[]`)
function vim.lsp.get(bufnr) end

-- Returns indentation size.
--- @see |shiftwidth|
--- @param bufnr any # (number|nil): Buffer handle, defaults to current
--- @return any # (number) indentation size
function vim.lsp.get_effective_tabstop(bufnr) end

-- Returns the log filename.
--- @return any # (string) log filename
function vim.lsp.get_filename() end

-- Gets the current log level.
--- @return any # (string) current log level
function vim.lsp.get_level() end

-- Get the diagnostic namespace associated with an LSP client
-- |vim.diagnostic|.
--- @param client_id any # (number) The id of the LSP client
function vim.lsp.get_namespace(client_id) end

-- |lsp-handler| for the method "textDocument/hover"
-- ```lua
--
--  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
--    vim.lsp.handlers.hover, {
--      -- Use a sharp border with `FloatBorder` highlights
--      border = "single"
--    }
--  )
--
-- ```
--- @param config any # (table) Configuration table.
--               • border: (default=nil)
--                 • Add borders to the floating window
--                 • See |nvim_open_win()|
function vim.lsp.hover(_, result, ctx, config) end

-- Lists all the implementations for the symbol under the cursor in the
-- quickfix window.
--- @param options any # (table|nil) additional options
--                • on_list: (function) handler for list results. See
--                  |lsp-on-list-handler|
function vim.lsp.implementation(options) end

-- Lists all the call sites of the symbol under the cursor in the |quickfix|
-- window. If the symbol can resolve to multiple items, the user can pick one
-- in the |inputlist|.
function vim.lsp.incoming_calls() end

-- Jumps to a location.
--- @param location any # (table) (`Location`|`LocationLink`)
--- @param offset_encoding any # (string) utf-8|utf-16|utf-32 (required)
--- @param reuse_win any # (boolean) Jump to existing window if buffer is
--                        already opened.
--- @return any # `true` if the jump succeeded
function vim.lsp.jump_to_location(location, offset_encoding, reuse_win) end

-- List workspace folders.
function vim.lsp.list_workspace_folders() end

-- Returns the items with the byte position calculated correctly and in
-- sorted order, for display in quickfix and location lists.
--
-- The result can be passed to the {list} argument of |setqflist()| or
-- |setloclist()|.
--- @param locations any # (table) list of `Location`s or `LocationLink`s
--- @param offset_encoding any # (string) offset_encoding for locations
--                        utf-8|utf-16|utf-32
--- @return any # (table) list of items
function vim.lsp.locations_to_items(locations, offset_encoding) end

-- Helper function to return nested values in language server settings
--- @param settings any # a table of language server settings
--- @param section any # a string indicating the field of the settings table
--- @return any # (table or string) The value of settings accessed via section
function vim.lsp.lookup_section(settings, section) end

-- Gets a new ClientCapabilities object describing the LSP client
-- capabilities.
function vim.lsp.make_client_capabilities() end

-- Creates a table with sensible default options for a floating window. The
-- table can be passed to |nvim_open_win()|.
--- @param width any # (number) window width (in character cells)
--- @param height any # (number) window height (in character cells)
--- @param opts any # (table, optional)
--               • offset_x (number) offset to add to `col`
--               • offset_y (number) offset to add to `row`
--               • border (string or table) override `border`
--               • focusable (string or table) override `focusable`
--               • zindex (string or table) override `zindex`, defaults to 50
--- @return any # (table) Options
function vim.lsp.make_floating_popup_options(width, height, opts) end

-- Creates a `DocumentFormattingParams` object for the current buffer and
-- cursor position.
--- @see https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_formatting
--- @param options any # (table|nil) with valid `FormattingOptions` entries
--- @return any # `DocumentFormattingParams` object
function vim.lsp.make_formatting_params(options) end

-- Using the given range in the current buffer, creates an object that is
-- similar to |vim.lsp.util.make_range_params()|.
--- @param start_pos any # number[]|nil {row, col} mark-indexed position.
--                        Defaults to the start of the last visual selection.
--- @param end_pos any # number[]|nil {row, col} mark-indexed position.
--                        Defaults to the end of the last visual selection.
--- @param bufnr any # (number|nil) buffer handle or 0 for current,
--                        defaults to current
--- @param offset_encoding any # "utf-8"|"utf-16"|"utf-32"|nil defaults to
--                        `offset_encoding` of first client of `bufnr`
--- @return any # { textDocument = { uri = `current_file_uri` }, range = { start =
--     `start_position`, end = `end_position` } }
function vim.lsp.make_given_range_params(start_pos, end_pos, bufnr, offset_encoding) end

-- Creates a `TextDocumentPositionParams` object for the current buffer and
-- cursor position.
--- @see https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocumentPositionParams
--- @param window any # number|nil: window handle or 0 for current,
--                        defaults to current
--- @param offset_encoding any # (string) utf-8|utf-16|utf-32|nil defaults to
--                        `offset_encoding` of first client of buffer of
--                        `window`
--- @return any # `TextDocumentPositionParams` object
function vim.lsp.make_position_params(window, offset_encoding) end

-- Using the current position in the current buffer, creates an object that
-- can be used as a building block for several LSP requests, such as
-- `textDocument/codeAction`, `textDocument/colorPresentation`,
-- `textDocument/rangeFormatting`.
--- @param window any # number|nil: window handle or 0 for current,
--                        defaults to current
--- @param offset_encoding any # "utf-8"|"utf-16"|"utf-32"|nil defaults to
--                        `offset_encoding` of first client of buffer of
--                        `window`
--- @return any # { textDocument = { uri = `current_file_uri` }, range = { start =
--     `current_position`, end = `current_position` } }
function vim.lsp.make_range_params(window, offset_encoding) end

-- Creates a `TextDocumentIdentifier` object for the current buffer.
--- @see https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocumentIdentifier
--- @param bufnr any # number|nil: Buffer handle, defaults to current
--- @return any # `TextDocumentIdentifier`
function vim.lsp.make_text_document_params(bufnr) end

-- Create the workspace params
--- @param added any #
--- @param removed any #
function vim.lsp.make_workspace_params(added, removed) end

-- Sends a notification to the LSP server.
--- @param method any # (string) The invoked LSP method
--- @param params any # (table|nil): Parameters for the invoked LSP method
--- @return any # (bool) `true` if notification could be sent, `false` if not
function vim.lsp.notify(method, params) end

-- |lsp-handler| for the method `textDocument/codeLens`
function vim.lsp.on_codelens(err, result, ctx, _) end

-- |lsp-handler| for the method "textDocument/publishDiagnostics"
--
-- See |vim.diagnostic.config()| for configuration options. Handler-specific
-- configuration can be set using |vim.lsp.with()|:
-- ```lua
--
--  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--    vim.lsp.diagnostic.on_publish_diagnostics, {
--      -- Enable underline, use default values
--      underline = true,
--      -- Enable virtual text, override spacing to 4
--      virtual_text = {
--        spacing = 4,
--      },
--      -- Use a function to dynamically turn signs off
--      -- and on, using buffer local variables
--      signs = function(namespace, bufnr)
--        return vim.b[bufnr].show_signs == true
--      end,
--      -- Disable a feature
--      update_in_insert = false,
--    }
--  )
--
-- ```
--- @param config any # (table) Configuration table (see |vim.diagnostic.config()|).
function vim.lsp.on_publish_diagnostics(_, result, ctx, config) end

-- Shows contents in a floating window.
--- @param contents any # (table) of lines to show in window
--- @param syntax any # (string) of syntax to set for opened buffer
--- @param opts any # (table) with optional fields (additional keys are passed
--                 on to |vim.api.nvim_open_win()|)
--                 • height: (number) height of floating window
--                 • width: (number) width of floating window
--                 • wrap: (boolean, default true) wrap long lines
--                 • wrap_at: (number) character to wrap at for computing
--                   height when wrap is enabled
--                 • max_width: (number) maximal width of floating window
--                 • max_height: (number) maximal height of floating window
--                 • pad_top: (number) number of lines to pad contents at top
--                 • pad_bottom: (number) number of lines to pad contents at
--                   bottom
--                 • focus_id: (string) if a popup with this id is opened,
--                   then focus it
--                 • close_events: (table) list of events that closes the
--                   floating window
--                 • focusable: (boolean, default true) Make float focusable
--                 • focus: (boolean, default true) If `true`, and if
--                   {focusable} is also `true`, focus an existing floating
--                   window with the same {focus_id}
--- @return any # bufnr,winnr buffer and window number of the newly created floating
--     preview window
function vim.lsp.open_floating_preview(contents, syntax, opts) end

-- Lists all the items that are called by the symbol under the cursor in the
-- |quickfix| window. If the symbol can resolve to multiple items, the user
-- can pick one in the |inputlist|.
function vim.lsp.outgoing_calls() end

-- Parses snippets in a completion entry.
--- @param input any # (string) unparsed snippet
--- @return any # (string) parsed snippet
function vim.lsp.parse_snippet(input) end

-- Previews a location in a floating window
--
-- behavior depends on type of location:
-- • for Location, range is shown (e.g., function definition)
-- • for LocationLink, targetRange is shown (e.g., body of function
--   definition)
--- @param location any # a single `Location` or `LocationLink`
--- @return any # (bufnr,winnr) buffer and window number of floating window or nil
function vim.lsp.preview_location(location, opts) end

-- Performs |vim.lsp.buf.code_action()| for a given range.
--- @param context any # (table|nil) `CodeActionContext` of the LSP specification:
--                  • diagnostics: (table|nil) LSP`Diagnostic[]` . Inferred from the current position if not provided.
--                  • only: (table|nil) List of LSP `CodeActionKind`s used to
--                    filter the code actions. Most language servers support
--                    values like `refactor` or `quickfix`.
--- @param start_pos any # ({number, number}, optional) mark-indexed position.
--                  Defaults to the start of the last visual selection.
--- @param end_pos any # ({number, number}, optional) mark-indexed position.
--                  Defaults to the end of the last visual selection.
function vim.lsp.range_code_action(context, start_pos, end_pos) end

-- Formats a given range.
--- @param options any # Table with valid `FormattingOptions` entries.
--- @param start_pos any # ({number, number}, optional) mark-indexed position.
--                  Defaults to the start of the last visual selection.
--- @param end_pos any # ({number, number}, optional) mark-indexed position.
--                  Defaults to the end of the last visual selection.
function vim.lsp.range_formatting(options, start_pos, end_pos) end

-- Lists all the references to the symbol under the cursor in the quickfix
-- window.
--- @see https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_references
--- @param context any # (table) Context for the request
--- @param options any # (table|nil) additional options
--                • on_list: (function) handler for list results. See
--                  |lsp-on-list-handler|
function vim.lsp.references(context, options) end

-- Refresh the codelens for the current buffer
--
-- It is recommended to trigger this using an autocmd or via keymap.
--
--
-- ```lua
--   autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
--
-- ```
function vim.lsp.refresh() end

-- Remove the folder at path from the workspace folders. If {path} is not
-- provided, the user will be prompted for a path using |input()|.
function vim.lsp.remove_workspace_folder(workspace_folder) end

-- Rename old_fname to new_fname
--- @param opts any # (table)
function vim.lsp.rename(old_fname, new_fname, opts) end

-- Sends a request to the LSP server and runs {callback} upon response.
--- @param method any # (string) The invoked LSP method
--- @param params any # (table|nil) Parameters for the invoked LSP
--                              method
--- @param callback any # (function) Callback to invoke
--- @param notify_reply_callback any # (function|nil) Callback to invoke as soon as
--                              a request is no longer pending
--- @return any # (bool, number) `(true, message_id)` if request could be sent, `false`
--     if not
function vim.lsp.request(method, params, callback, notify_reply_callback) end

-- Creates a normalized object describing LSP server capabilities.
--- @param server_capabilities any # (table) Table of capabilities supported by the
--                            server
--- @return any # (table) Normalized table of capabilities
function vim.lsp.resolve_capabilities(server_capabilities) end

-- Run the code lens in the current line
function vim.lsp.run() end

-- Store lenses for a specific buffer and client
--- @param lenses any # (table) of lenses to store (`CodeLens[] | null`)
--- @param bufnr any # (number)
--- @param client_id any # (number)
function vim.lsp.save(lenses, bufnr, client_id) end

-- Checks whether the language servers attached to the current buffer are
-- ready.
--- @return any # `true` if server responds.
function vim.lsp.server_ready() end

-- Sets formatting function used to format logs
--- @param handle any # (function) function to apply to logging arguments, pass
--               vim.inspect for multi-line formatting
function vim.lsp.set_format_func(handle) end

-- Sets the current log level.
--- @param level any # (string or number) One of `vim.lsp.log.levels`
function vim.lsp.set_level(level) end

-- Replaces text in a range with new text.
--
-- CAUTION: Changes in-place!
--- @param lines any # (table) Original list of strings
--- @param A any # (table) Start position; a 2-tuple of {line, col} numbers
--- @param B any # (table) End position; a 2-tuple of {line, col} numbers
--- @param new_lines any # A list of strings to replace the original
--- @return any # (table) The modified {lines} object
function vim.lsp.set_lines(lines, A, B, new_lines) end

-- Checks whether the level is sufficient for logging.
--- @param level any # (number) log level
--- @return any # (bool) true if would log, false if not
function vim.lsp.should_log(level) end

-- |lsp-handler| for the method "textDocument/signatureHelp". The active
-- parameter is highlighted with |hl-LspSignatureActiveParameter|.
-- ```lua
--
--  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
--    vim.lsp.handlers.signature_help, {
--      -- Use a sharp border with `FloatBorder` highlights
--      border = "single"
--    }
--  )
--
-- ```
--- @param config any # (table) Configuration table.
--               • border: (default=nil)
--                 • Add borders to the floating window
--                 • See |vim.api.nvim_open_win()|
function vim.lsp.signature_help(_, result, ctx, config) end

-- Converts markdown into syntax highlighted regions by stripping the code
-- blocks and converting them into highlighted code. This will by default
-- insert a blank line separator after those code block regions to improve
-- readability.
--
-- This method configures the given buffer and returns the lines to set.
--
-- If you want to open a popup with fancy markdown, use
-- `open_floating_preview` instead
--- @param contents any # (table) of lines to show in window
--- @param opts any # dictionary with optional fields
--                 • height of floating window
--                 • width of floating window
--                 • wrap_at character to wrap at for computing height
--                 • max_width maximal width of floating window
--                 • max_height maximal height of floating window
--                 • pad_top number of lines to pad contents at top
--                 • pad_bottom number of lines to pad contents at bottom
--                 • separator insert separator after code block
--- @return any # width,height size of float
function vim.lsp.stylize_markdown(bufnr, contents, opts) end

-- Converts symbols to quickfix list items.
--- @param symbols any # DocumentSymbol[] or SymbolInformation[]
function vim.lsp.symbols_to_items(symbols, bufnr) end

-- Turns the result of a `textDocument/completion` request into
-- vim-compatible |complete-items|.
--- @see |complete-items|
--- @param result any # The result of a `textDocument/completion` call, e.g. from
--               |vim.lsp.buf.completion()|, which may be one of
--               `CompletionItem[]`, `CompletionList` or `null`
--- @param prefix any # (string) the prefix to filter the completion items
--- @return any # { matches = complete-items table, incomplete = bool }
function vim.lsp.text_document_completion_list_to_complete_items(result, prefix) end

-- Removes empty lines from the beginning and end.
--- @param lines any # (table) list of lines to trim
--- @return any # (table) trimmed list of lines
function vim.lsp.trim_empty_lines(lines) end

-- Accepts markdown lines and tries to reduce them to a filetype if they
-- comprise just a single code block.
--
-- CAUTION: Modifies the input in-place!
--- @param lines any # (table) list of lines
--- @return any # (string) filetype or 'markdown' if it was unchanged.
function vim.lsp.try_trim_markdown_code_blocks(lines) end

-- Jumps to the definition of the type of the symbol under the cursor.
--- @param options any # (table|nil) additional options
--                • reuse_win: (boolean) Jump to existing window if buffer is
--                  already open.
--                • on_list: (function) handler for list results. See
--                  |lsp-on-list-handler|
function vim.lsp.type_definition(options) end

-- Lists all symbols in the current workspace in the quickfix window.
--
-- The list is filtered against {query}; if the argument is omitted from the
-- call, the user is prompted to enter a string on the command line. An empty
-- string means no filtering is done.
--- @param query any # (string, optional)
--- @param options any # (table|nil) additional options
--                • on_list: (function) handler for list results. See
--                  |lsp-on-list-handler|
function vim.lsp.workspace_symbol(query, options) end

