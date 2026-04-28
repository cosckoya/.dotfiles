# Neovim Configuration

Lua-based configuration using lazy.nvim plugin manager and Mason for LSP server installation. Requires Neovim 0.11+. Symlinked from `config/nvim/` to `~/.config/nvim/`.

No external runtime dependencies (no npm/cargo/go required at startup).

## Bootstrap

`init.lua` auto-installs lazy.nvim from GitHub on first launch. Lazy.nvim then installs plugins on-demand.

Loading order:
```
init.lua
  ├── core/options.lua
  ├── core/keymaps.lua
  ├── core/autocmds.lua
  └── lazy.setup(plugins)
      ├── lsp.lua (Mason + LSP setup)
      ├── completion.lua (nvim-cmp + LuaSnip)
      ├── ui.lua (theme + which-key)
      └── editor.lua (Telescope + other editors)
```

First launch: plugins may take 10–20 seconds to install and compile.

## Core Settings

| Setting | Value | Purpose |
|---------|-------|---------|
| Leader key | `<Space>` | Prefix for custom keybindings |
| Line numbers | On | Show line numbers |
| Color column | 90 | Vertical guide at column 90 |
| Indentation | 2 spaces | Tab width and indent |
| Clipboard | `unnamedplus` | Use system clipboard |
| Search | Case insensitive, but smart-case | Search behavior |

## Language Servers

Mason auto-installs servers. Currently configured:

| Server | Filetypes |
|--------|-----------|
| lua-language-server | Lua |
| pyright | Python |
| bash-language-server | Bash, sh |

Servers are enabled only when a matching file is opened (lazy activation).

### LSP Keybindings

| Binding | Action |
|---------|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | List references |
| `K` | Hover documentation |
| `C-k` | Signature help |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `[d` / `]d` | Previous/next diagnostic |

## Adding a Language Server

Edit `config/nvim/lua/plugins/lsp.lua`:

```lua
local servers = { "lua-language-server", "pyright", "bash-language-server", "tsserver" }
```

Add the Mason package name to the list. Mason installs it on next Neovim launch.

Then add configuration block:

```lua
vim.lsp.config("tsserver", {
  cmd = { mason_bin .. "/typescript-language-server", "--stdio" },
  root_markers = { "package.json", "tsconfig.json", ".git" },
  capabilities = capabilities,
  on_attach = on_attach,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "typescript",
  callback = function() vim.lsp.enable("tsserver") end,
})
```

## Completion

nvim-cmp with LuaSnip. Triggered automatically while typing.

| Binding | Action |
|---------|--------|
| `C-Space` | Trigger completion |
| `<Tab>` / `<S-Tab>` | Select next/previous |
| `<CR>` | Accept selection |
| `<C-e>` | Cancel completion |

## Theme

Default: tokyonight (dark). Set in `lazy.nvim` install config in `init.lua`.

To change theme, edit `init.lua`:

```lua
install = {
  missing = true,
  colorscheme = { "dracula" },  -- change theme name
}
```

## Troubleshooting

**LSP not working?**
```bash
nvim --version                          # verify 0.11+
:MasonInstall <server-name>             # manually install server
:LspInfo                                # check LSP status
```

**Completion not triggering?**
```bash
:checkhealth cmp                        # check completion health
```

**Plugins not installing?**
Delete cache and try again:
```bash
rm -rf ~/.local/share/nvim/lazy
nvim
```

**Slow startup?**
```bash
:profile start /tmp/nvim.log
:profile func *
# edit a file to trigger operations
:profile stop
# examine /tmp/nvim.log
```
