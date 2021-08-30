# 💻 lua-dev

Dev setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.

![image](https://user-images.githubusercontent.com/292349/118822916-6af02080-b86d-11eb-9990-942fe9b55541.png)

![image](https://user-images.githubusercontent.com/292349/118823099-9115c080-b86d-11eb-9a68-521c6cb9905a.png)

## ✨ Features

- [EmmyLua](https://github.com/sumneko/lua-language-server/wiki/EmmyLua-Annotations) library for the nvim lua API for:
  - completion
  - hover docs
  - function signatures
- properly configures the `require` path with `lua/?.lua` and `lua/?/init.lua`.
- adds all plugins in `opt` and `start` to the workspace so you get completion for all installed plugins
- properly configure the vim runtime

## ⚡️ Requirements

- Neovim >= 0.5.0
- completion plugin like [nvim-compe](https://github.com/hrsh7th/nvim-compe) or [completion-nvim](https://github.com/nvim-lua/completion-nvim)

## 📦 Installation

Install the plugin with your preferred package manager:

### [packer](https://github.com/wbthomason/packer.nvim)

```lua
use "folke/lua-dev.nvim"
```

### [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'folke/lua-dev.nvim'
```

## ⚙️ Configuration

**lua-dev** comes with the following defaults:

```lua
{
  library = {
    vimruntime = true, -- runtime path
    types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
    plugins = true, -- installed opt or start plugins in packpath
    -- you can also specify the list of plugins to make available as a workspace library
    -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
  },
  -- pass any additional options that will be merged in the final lsp config
  lspconfig = {
    -- cmd = {"lua-language-server"},
    -- on_attach = ...
  },
}
```

## 🚀 Setup

Be aware that this will configure Sumneko to work for Neovim init.lua and plugin development.
This setup is **NOT** intended to be used for any other types of projects.

```lua
local luadev = require("lua-dev").setup({
  -- add any options here, or leave empty to use the default settings
  -- lspconfig = {
  --   cmd = {"lua-language-server"}
  -- },
})

local lspconfig = require('lspconfig')
lspconfig.sumneko_lua.setup(luadev)
```

## ❓ How?

**Neovim** includes a [script](https://github.com/neovim/neovim/blob/master/scripts/gen_vimdoc.py) to generated the nvim docs.
That script also creates message pack files containing all the API metadata in a structured way.
Unfortunately these files are not packaged in the releases.

Using the message pack files, I converted all the API data to [EmmyLua annotations](https://github.com/sumneko/lua-language-server/wiki/EmmyLua-Annotations)
and make them available for the [Sumneko LSP](https://github.com/sumneko/lua-language-server) as a workspace library.

## 🗒️ Limitations

- [x] `vim.fn` functions are currently not part of the EmmyLua library since no message pack files are generated. Implemented using vim-lsp
- function return types are always `any`, since that information is missing

## ⭐ Acknowledgment

- docs for options and functions are based on the work of [vim-lsp](https://github.com/prabirshrestha/vim-lsp)
