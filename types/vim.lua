---@alias window number
---@alias buffer number
---@alias tabpage number
---@alias list any[]
---@alias array any[]
---@alias dictionary table<string, any>
---@alias object any
---@alias float number
---@alias luaref fun()

vim = require("vim.shared")
vim = require("vim.uri")
vim = require("vim.inspect")

vim.lsp = require("vim.lsp")
vim.treesitter = require("vim.treesitter")
vim.highlight = require("vim.highlight")
