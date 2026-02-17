---
name: lua-neovim-architecture
description: "Neovim 0.11+ modern Lua configuration. Native LSP, lazy.nvim patterns, modular structure, zero-config plugins."
category: editor-configuration
priority: 85
token_cost_estimate: 4000
---

# Modern Neovim Lua Architecture (2026)

## Architecture Principles

### 1. Entry Point: Minimal init.lua
```lua
-- config/nvim/init.lua
require("config.lazy")        -- Bootstrap lazy.nvim
require("core.options")       -- Editor settings
require("core.keymaps")       -- Custom bindings
require("core.autocmds")      -- Autocommands
```

**Why:** Clear separation of concerns, fast startup, easy to navigate.

### 2. Bootstrap Pattern (lazy.nvim auto-install)
```lua
-- config/nvim/lua/config/lazy.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  defaults = { lazy = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip", "matchit", "matchparen",
        "netrw", "netrwPlugin", "tarPlugin",
        "tohtml", "tutor", "zipPlugin",
      },
    },
  },
})
```

### 3. Plugin Specs (Declarative)
```lua
-- config/nvim/lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,  -- Load immediately
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("config.lsp").setup()
    end,
  },
}
```

### 4. Module Organization
```
config/nvim/
├── init.lua              # Entry point
├── lua/
│   ├── config/
│   │   ├── lazy.lua      # Plugin bootstrap
│   │   ├── lsp.lua       # LSP config
│   │   └── options.lua   # Editor options
│   ├── core/
│   │   ├── options.lua   # vim.opt settings
│   │   ├── keymaps.lua   # Key bindings
│   │   └── autocmds.lua  # Autocommands
│   └── plugins/
│       ├── init.lua      # Plugin list
│       ├── lsp.lua       # LSP plugins
│       ├── completion.lua # nvim-cmp
│       ├── ui.lua        # UI enhancements
│       └── editor.lua    # Editor tools
└── plugin/               # Optional legacy
```

### 5. Native LSP Configuration (Modern)
```lua
-- config/nvim/lua/config/lsp.lua
local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()

local servers = {
  lua_ls = {},
  pyright = {},
  bashls = {},
}

for server, config in pairs(servers) do
  lspconfig[server].setup(vim.tbl_extend("force", {
    capabilities = capabilities,
  }, config))
end
```

**Why:** No CoC or external servers, native integration, better performance.

### 6. Lazy-Loading Strategy
```lua
return {
  -- Load immediately (core tools)
  { "neovim/nvim-lspconfig", lazy = false },
  { "nvim-telescope/telescope.nvim", lazy = false },
  
  -- Load on command
  { "nvim-neotest/neotest", lazy = true, cmd = "Neotest" },
  
  -- Load on filetype
  { "vim-test/vim-test", lazy = true, ft = { "go", "rust", "python" } },
  
  -- Load on keybind
  { "lewis6991/gitsigns.nvim", lazy = true, keys = { "<leader>g" } },
}
```

### 7. Performance Optimization
```lua
-- Disable unused features
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Reduce sync filesystem checks
vim.opt.swapfile = false  # or use undotree
vim.opt.backup = false

-- Use faster grep alternative
if vim.fn.executable("rg") == 1 then
  vim.opt.grepprg = "rg --vimgrep"
end
```

## 2026 Best Practices

### Configuration Files
- **init.lua**: Entry point only (5-10 lines)
- **lazy.lua**: Bootstrap with inline config
- **options.lua**: All vim.opt and vim.g settings
- **keymaps.lua**: All keybindings (organized by mode)
- **autocmds.lua**: All autocommand groups

### Plugin Management
- **One spec per file** in `plugins/` directory
- **Lazy-load everything non-critical**
- **Use `event`, `cmd`, `ft`, `keys` for lazy triggers**
- **Minimize startup impact** (disable netrw, etc.)
- **Keep plugin configs minimal** (defer to setup functions)

### Dependencies
- **Explicit with `dependencies`** key
- **Order doesn't matter** (lazy.nvim handles it)
- **Check `vim.fn.has()` for platform support**

### Error Handling
```lua
-- Safe LSP setup with fallback
local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
  vim.notify("LSP not installed", vim.log.levels.WARN)
  return
end
```

## Anti-Patterns

- Monolithic init.lua (keep it small)
- Synchronous plugin loading for non-essentials
- Hardcoding keybindings without mode consideration
- Missing LSP error handling
- Not using lazy-loading capabilities
- Disabling core performance features unnecessarily
- Complex nested conditionals in configs
- Not organizing plugins by function

## Integration Points

- Works with custom snippets (LuaSnip)
- Compatible with which-key for keybind discovery
- Integrates with fuzzy finders (Telescope)
- Native LSP with Mason for server management
- Statusline integration (lualine, etc.)
