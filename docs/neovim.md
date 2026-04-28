# Neovim Configuration

Lua-based Neovim configuration using lazy.nvim for plugin management and Mason for LSP server installation. No external runtime dependencies (no npm/cargo/go required at startup).

**Entry point:** `config/nvim/init.lua` → symlinked to `~/.config/nvim/`

**Requires:** Neovim 0.11+

---

## Bootstrap

`init.lua` auto-installs lazy.nvim on first launch by cloning from GitHub into `~/.local/share/nvim/lazy/lazy.nvim`. Subsequent launches use the cached copy.

Load order:

```
init.lua
├── core/options.lua     editor settings
├── core/keymaps.lua     keybindings
├── core/autocmds.lua    autocommands
└── lazy.setup("plugins")
    ├── plugins/lsp.lua
    ├── plugins/completion.lua
    ├── plugins/ui.lua
    └── plugins/editor.lua
```

---

## Core Options (`lua/core/options.lua`)

| Category | Key settings |
|----------|-------------|
| Leader | `<Space>` (both `mapleader` and `maplocalleader`) |
| Display | Line numbers, color column at 90, cursor line, always-visible sign column |
| Indentation | 2 spaces, `expandtab`, `smartindent` |
| Search | `hlsearch`, `incsearch`, `ignorecase`, `smartcase` |
| Splits | Vertical → right, horizontal → below |
| Clipboard | `unnamedplus` (system clipboard) |
| Completion | `menu,menuone,noselect` |
| Performance | `updatetime=300ms`, `timeoutlen=400ms` |
| Files | UTF-8, unix line endings, no backup files |

---

## LSP (`lua/plugins/lsp.lua`)

Uses Mason for server installation and Neovim 0.11 native LSP API (`vim.lsp.config` + `vim.lsp.enable`).

### Installed servers

| Server | Mason package | Filetypes |
|--------|--------------|-----------|
| lua-language-server | `lua-language-server` | `lua` |
| Pyright | `pyright` | `python` |
| bash-language-server | `bash-language-server` | `sh`, `bash` |

Servers are installed automatically on first launch if not present. Enabled via `FileType` autocommands — only activated when a relevant file is opened.

### LSP keymaps (set in `on_attach`)

| Binding | Action |
|---------|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | References |
| `K` | Hover documentation |
| `C-k` | Signature help |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `[d` / `]d` | Previous/next diagnostic |
| `<leader>d` | Open diagnostic float |

### Diagnostics

Virtual text enabled. Signs:

| Severity | Symbol |
|----------|--------|
| Error | `✘` |
| Warning | `▲` |
| Hint | `⚑` |
| Info | `»` |

---

## Completion (`lua/plugins/completion.lua`)

nvim-cmp with LuaSnip as the snippet engine.

---

## UI (`lua/plugins/ui.lua`)

- **Theme:** tokyonight (set as default install colorscheme in lazy.nvim)
- **which-key:** Displays available keybindings after timeout

---

## Editor (`lua/plugins/editor.lua`)

- **Telescope:** Fuzzy finder for files, buffers, and live grep

---

## lazy.nvim settings

| Setting | Value |
|---------|-------|
| Default lazy | `false` (plugins eager unless marked lazy) |
| Missing plugins | Auto-installed on startup |
| Update checker | Enabled, silent (no notification popup) |
| Cache | Enabled |
| Disabled built-ins | `gzip`, `matchit`, `matchparen`, `netrwPlugin`, `tarPlugin`, `tohtml`, `tutor`, `zipPlugin` |
| UI border | Rounded |

---

## Adding a language server

Edit `config/nvim/lua/plugins/lsp.lua`, add the Mason package name to the `servers` table:

```lua
local servers = { "lua-language-server", "pyright", "bash-language-server", "tsserver" }
```

Add the `vim.lsp.config` block and a `FileType` autocommand. Mason installs the binary on next Neovim launch.

---

## Installation

```bash
make install-nvim   # install Neovim 0.11+ via snap (requires sudo)
make neovim         # symlink config/nvim → ~/.config/nvim
```

First launch clones lazy.nvim and triggers `:MasonInstall` for configured servers automatically.
