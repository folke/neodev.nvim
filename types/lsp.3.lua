--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Jumps to the definition of the type of the symbol under the
-- cursor.
function vim.lsp.type_definition() end

-- Lists all symbols in the current workspace in the quickfix
-- window.
--- @param query any #(string, optional)
function vim.lsp.workspace_symbol(query) end

