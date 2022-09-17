---@meta

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
vim.ui = require("vim.ui")
