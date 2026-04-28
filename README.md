<div align="center">

![Drizzt Do'Urden Terminal Setup](./img/death.png)

# Modern Linux Dotfiles

**Terminal environment crafted for performance and aesthetics.** Production-ready ZSH, Tmux, Neovim, and Kitty configurations optimized for Ubuntu/Debian.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-Linux-blue.svg)](https://www.linux.org/)
[![Shell](https://img.shields.io/badge/Shell-ZSH%205.9%2B-89e051.svg)](https://www.zsh.org/)
[![Neovim](https://img.shields.io/badge/Neovim-0.11%2B-green.svg)](https://neovim.io/)

</div>

---

## Quick Start

```bash
git clone https://github.com/cosckoya/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make all          # Install everything: ASDF + ZSH + Tmux + Kitty + Neovim
exec zsh          # Reload shell (~110ms startup)
```

**Selective Installation:**
```bash
make help         # List all available targets
make profile      # ZSH + Tmux + Kitty + Neovim only
make zsh          # ZSH configuration only
```

---

## Key Features

- **~110ms ZSH startup** — 92% faster than typical configs via Zinit turbo mode and aggressive lazy-loading
- **Unified visual theme** — Drizzt Do'Urden color scheme (WCAG AAA contrast) across ZSH, Tmux, Kitty, and Neovim with coherent powerline styling
- **Offline-capable** — Works completely offline after installation; all plugins and binaries cached locally
- **Modular architecture** — Install only components you need; split configurations enable granular customization
- **Production-ready security** — Pre-commit hooks, secret scanning, Dependabot, branch protection, CI/CD validation

---

## Tech Stack

| Component | Technology | Version | Details |
|-----------|------------|---------|---------|
| Shell | ZSH | 5.9+ | Interactive shell with Zinit async plugin manager |
| Terminal | Kitty | Latest | GPU-accelerated terminal emulator |
| Multiplexer | Tmux | 3.2+ | Session/window management with Vi keybindings |
| Editor | Neovim | 0.11+ | Lua-based config with native LSP, lazy.nvim |
| Version Manager | ASDF | Latest | Universal tool version manager (optional) |
| Hooks | pre-commit | 2.x | Git hooks for code quality and security |
| Prompt | vcs_info + custom | N/A | Dynamic right-prompt with git/venv/k8s context |

---

## Project Structure

```
~/.dotfiles/
├── .github/                          # GitHub configuration
│   ├── workflows/ci.yml              # CI/CD: pre-commit + Trivy scanning
│   ├── SECURITY.md                   # Vulnerability disclosure policy
│   ├── CODEOWNERS                    # Code ownership & review routing
│   ├── dependabot.yml                # Dependency management
│   └── ISSUE_TEMPLATE/               # Issue templates
├── config/
│   ├── nvim/                         # Neovim Lua configuration
│   │   ├── lua/core/                 # Editor options, keymaps, autocmds
│   │   └── lua/plugins/              # LSP, completion, UI, editor plugins
│   ├── tmux.conf                     # Tmux 3.4+ configuration (238 lines)
│   └── kitty.conf                    # Kitty terminal settings
├── zsh.d/                            # Modular ZSH configuration
│   ├── config.zsh                    # User-configurable variables
│   ├── tools.zsh                     # PATH, editor selection, npm lazy-load
│   ├── alias.zsh                     # Command aliases and functions
│   ├── autocomplete.zsh              # Lazy-loaded completions
│   ├── tmux.zsh                      # Tmux helper functions
│   └── toolbox.zsh                   # Utility functions
├── zshrc                             # Main ZSH entry point
├── vimrc                             # Legacy Vim config (backwards compat)
├── Makefile                          # Installation orchestrator
├── CLAUDE.md                         # Claude Code AI guidance
├── .pre-commit-config.yaml           # Pre-commit hooks
├── .copilot-instructions.md          # GitHub Copilot CLI instructions
└── img/                              # Visual assets
```

---

## Usage

### Configure ZSH

Edit variables in `~/.zsh.d/config.zsh`:

```bash
# Disable Tmux auto-start in SSH sessions
export TMUX_SKIP_SSH="true"

# Set default Tmux session name
export TMUX_AUTOSTART_SESSION="dev"

# Skip Tmux in IDE terminals (VSCode, Emacs)
export TMUX_SKIP_IDE="true"
```

Add aliases in `~/.zsh.d/alias.zsh`:

```bash
# Function syntax for better performance
alias ll='ls -lh'
alias grep='grep --color=auto'
```

### Configure Neovim

Edit Lua files in `~/.config/nvim/lua/`:

```lua
-- core/options.lua: Editor settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = 'unnamedplus'

-- plugins/lsp.lua: Add/remove language servers
local servers = { 'lua_ls', 'pyright', 'bashls' }

-- plugins/completion.lua: nvim-cmp settings
-- plugins/ui.lua: Theme and UI enhancements
```

Lazy.nvim bootstraps automatically; plugins install on first use.

### Configure Tmux

Vi-style keybindings and Drizzt theme colors:

```bash
# Split window vertically
tmux split-window -h

# Copy mode (Ctrl+b [) with system clipboard
# Paste (Ctrl+b ])

# Edit ~/.tmux.conf for keybindings and colors
# Uses xsel/wl-copy/pbcopy for clipboard integration
```

### Git Hooks

Pre-commit hooks automatically validate on commit:

```bash
# Stops commits if:
# - Merge conflicts present
# - Private keys found
# - YAML/Makefile syntax invalid
# - Trailing whitespace detected
# - Line endings mixed

# Bypass (not recommended):
git commit --no-verify
```

---

## Testing & Verification

```bash
# Measure ZSH startup performance
time zsh -ic exit

# Validate configuration loading
zsh -c 'source ~/.zshrc'

# Test Tmux configuration
tmux source ~/.tmux.conf

# Reload shell (interactive)
exec zsh

# Run pre-commit hooks manually
pre-commit run --all-files
```

---

## Platform Requirements

**Tested on:** Ubuntu 20.04+, Debian 11+

**Required:**
- ZSH 5.9+
- Git 2.40+
- Tmux 3.2+
- Make 4.3+

**Optional (with fallbacks):**
- Neovim 0.11+ (`make install-nvim` via snap)
- kubectl, helm, docker, npm, asdf, bat, fzf, ripgrep
- xsel, wl-copy, pbcopy (clipboard managers)

---

## Security

Repository configured with GitHub security best practices (2026):

- Secret scanning + push protection enabled
- Dependabot alerts and automatic security updates
- Pre-commit hooks: private key detection, syntax validation
- Branch protection: 1 required review, pre-commit checks
- CI/CD: Trivy filesystem scanning, dependency verification
- Read `.github/SECURITY.md` for vulnerability reporting

**Check security status:**
```bash
gh api /repos/cosckoya/.dotfiles/security_and_analysis | jq '.secret_scanning'
```

---

## Contributing

1. Fork the repository
2. Create feature branch: `git checkout -b feature/improvement`
3. Commit changes (pre-commit validates)
4. Push to branch and open PR against `main`
5. Require 1 approval before merge

See `.github/SECURITY.md` for security vulnerability reporting.

---

## License

MIT License — see LICENSE file

---

## Design Highlights

**Drizzt Do'Urden Theme** — Unified color scheme across all components:
- Background: `#100814` (deep drow cavern, WCAG AAA contrast)
- Primary: Lavender `#b19cd9` (violet eyes), Icy Blue `#7ec8e3` (Twinkle)
- Accent: Drow magic green `#5ab897`, Magical yellow `#f0c987`

**Performance Optimizations:**
- Zinit turbo mode with staggered plugin loading (wait"1", wait"2", wait"3")
- Compinit caching invalidates daily
- Self-removing lazy-loader pattern for heavy completions
- All tool checks guarded by `command -v` for zero-penalty fallbacks
- History size: 5000 (vs 10000 default)

**Modular Architecture:**
- Split ZSH configs by function (config, tools, alias, autocomplete, tmux, toolbox)
- Neovim: core settings + plugin separation (LSP, completion, UI, editor)
- Makefile: symlink installation with color-coded output
- Pre-commit: code quality without breaking workflows

---

**Updated:** April 28, 2026 | **Maintained By:** Cosckoya | **Repository:** https://github.com/cosckoya/.dotfiles
