---@alias window number
---@alias buffer number
---@alias tabpage number
---@alias list any[]
---@alias array any[]
---@alias dictionary table
---@alias object any
---@alias float number
---@alias dictionaryof table
---@alias arrayof any[]

vim = require("vim.shared")
vim = require("vim.uri")
vim = require("vim.inspect")

vim.lsp = require("vim.lsp")
vim.treesitter = require("vim.treesitter")
vim.highlight = require("vim.highlight")
