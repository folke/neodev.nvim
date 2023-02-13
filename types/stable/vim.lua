---@meta

---@type uv
vim.loop = {}

vim = require("vim.shared")
vim = require("vim.uri")
vim = require("vim.inspect")
vim = require("vim._editor")

vim.diagnostic = require("vim.diagnostic")
vim.filetype = require("vim.filetype")
vim.F = require("vim.F")
vim.fs = require("vim.fs")
vim.health = require("vim.health")
vim.highlight = require("vim.highlight")
vim.inspect = require("vim.inspect")
vim.keymap = require("vim.keymap")
vim.lsp = require("vim.lsp")
vim.treesitter = require("vim.treesitter")
vim.treesitter.highlighter = require("vim.treesitter.highlighter")
vim.treesitter.query = require("vim.treesitter.query")
vim.treesitter.language = require("vim.treesitter.language")
vim.ui = require("vim.ui")

---@type table<string,any>
vim.g = {}
---@type table<string,any>
vim.v = {}
---@type table<number,table<string, any>>
vim.b = {}
---@type table<number,table<string, any>>
vim.w = {}
---@type table<number,table<string, any>>
vim.t = {}
