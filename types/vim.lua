---@alias window number
---@alias buffer number
---@alias tabpage number
---@alias job number
---@alias channel number
---@alias sends number
---@alias blob number
---@alias list any[]
---@alias array any[]
---@alias dictionary table<string, any>
---@alias dict table<string, any>
---@alias object any
---@alias float number
---@alias luaref fun()
---@alias funcref fun()
---@alias none nil
---@alias start number
---@alias stop number
---@alias expr string
---@alias set boolean

vim = require("vim.shared")
vim = require("vim.uri")
vim = require("vim.inspect")

vim.lsp = require("vim.lsp")
vim.treesitter = require("vim.treesitter")
vim.highlight = require("vim.highlight")
vim.diagnostic = require("vim.diagnostic")
vim.ui = require("vim.ui")

-- HACK: hardcode these levels, since there's currently no docs for them
vim.log = {
  levels = {
    TRACE = 0,
    DEBUG = 1,
    INFO = 2,
    WARN = 3,
    ERROR = 4,
  },
}
