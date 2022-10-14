# 💻 neodev

Dev setup for init.lua and plugin development with full signature help, docs and
completion for the nvim lua API.

![image](https://user-images.githubusercontent.com/292349/118822916-6af02080-b86d-11eb-9990-942fe9b55541.png)

![image](https://user-images.githubusercontent.com/292349/118823099-9115c080-b86d-11eb-9a68-521c6cb9905a.png)

## ✨ Features

- Automatically configures **lua-language-server** for your **Neovim** config, **Neovim** runtime and plugin
  directories
- [Annotations](https://github.com/sumneko/lua-language-server/wiki/Annotations) for completion, hover and signatures of:
  - Vim functions
  - Neovim api functions
  - `vim.opt`
  - [vim.loop](https://github.com/luvit/luv)
- properly configures the `require` path.
- adds all plugins in `opt` and `start` to the workspace so you get completion
  for all installed plugins
- properly configure the vim runtime

## ⚡️ Requirements

- Neovim >= 0.7.0
- completion plugin like [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)

## 📦 Installation

Install the plugin with your preferred package manager:

### [packer](https://github.com/wbthomason/packer.nvim)

```lua
use "folke/neodev.nvim"
```

### [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'folke/neodev.nvim'
```

## ⚙️ Configuration

**neodev** comes with the following defaults:

```lua
{
  library = {
    enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
    -- these settings will be used for your Neovim config directory
    runtime = true, -- runtime path
    types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
    plugins = true, -- installed opt or start plugins in packpath
    -- you can also specify the list of plugins to make available as a workspace library
    -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
  },
  setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
  -- for your Neovim config directory, the config.library settings will be used as is
  -- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
  -- for any other directory, config.library.enabled will be set to false
  override = function(root_dir, options) end,

}
```

## 🚀 Setup

**neodev** will **ONLY** change the **sumneko_lua** settings for:

- your Neovim config directory
- your Neovim runtime directory
- any plugin directory (this is an lsp root_dir that contains a `/lua`
  directory)

For any other `root_dir`, **neodev** will **NOT** change any settings.

```lua
-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
})

-- then setup your lsp server as usual
local lspconfig = require('lspconfig')

-- example to setup sumneko and enable call snippets
lspconfig.sumneko_lua.setup({
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      }
    }
  }
})
```

Example for setting up **neodev** that overrides the settings for `/etc/nixos`

```lua
-- You can override the default detection using the override function
-- EXAMPLE: If you want a certain directory to be configured differently, you can override its settings
require("neodev").setup({
  override = function(root_dir, library)
    if require("neodev.util").has_file(root_dir, "/etc/nixos") then
      library.enabled = true
      library.plugins = true
    end
  end,
})
```

## ❓ How?

**Neovim** includes a
[script](https://github.com/neovim/neovim/blob/master/scripts/gen_vimdoc.py) to
generate the nvim docs. That script also creates message pack files containing
all the API metadata in a structured way. Unfortunately these files are not
packaged in the releases.

Using the message pack files, I converted all the API data to
[EmmyLua annotations](https://github.com/sumneko/lua-language-server/wiki/EmmyLua-Annotations)
and make them available for the
[Sumneko LSP](https://github.com/sumneko/lua-language-server) as a workspace
library.
