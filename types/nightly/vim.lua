---@meta

vim = {}

vim.F = require("vim.F")
vim.diagnostic = require("vim.diagnostic")
vim.filetype = require("vim.filetype")
vim.fs = require("vim.fs")
vim.health = require("vim.health")
vim.highlight = require("vim.highlight")
vim.inspect = require("vim.inspect").inspect
vim.keymap = require("vim.keymap")
vim.lsp = require("vim.lsp")
vim.treesitter = require("vim.treesitter")
vim.treesitter.highlighter = require("vim.treesitter.highlighter")
vim.ui = require("vim.ui")
vim.uri_from_bufnr = require("vim.uri").uri_from_bufnr
vim.uri_from_fname = require("vim.uri").uri_from_fname
vim.uri_to_bufnr = require("vim.uri").uri_to_bufnr
vim.uri_to_fname = require("vim.uri").uri_to_fname
