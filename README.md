<div align="center">

![Dream and Death — The Sandman by Neil Gaiman. Two siblings sit on a park bench feeding pigeons. One is the Lord of Dreams. The other is Death. Neither is in a hurry.](https://raw.githubusercontent.com/cosckoya/.dotfiles/main/img/death.png)

*Dream and Death — The Sandman, Neil Gaiman*

# cosckoya/.dotfiles

**A self-contained, offline-capable Linux terminal environment built for speed.**
ZSH, Tmux, Neovim, and Kitty — unified under a single Makefile and a coherent visual identity.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-Linux-blue.svg)](https://www.linux.org/)
[![Shell](https://img.shields.io/badge/Shell-ZSH%205.9%2B-89e051.svg)](https://www.zsh.org/)
[![Neovim](https://img.shields.io/badge/Neovim-0.11%2B-57A143.svg)](https://neovim.io/)
[![Tmux](https://img.shields.io/badge/Tmux-3.2%2B-1BB91F.svg)](https://github.com/tmux/tmux)

</div>

---

## Quick Start

```bash
git clone https://github.com/cosckoya/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make all       # ASDF + ZSH + Tmux + Kitty + Neovim
exec zsh       # reload shell (~110ms startup)
```

Selective installation:

```bash
make help      # list all targets
make profile   # ZSH + Tmux + Kitty + Neovim (no ASDF)
make zsh       # ZSH only
```

---

## Key Features

- **~110ms ZSH startup** — Zinit turbo mode with staggered async loading (`wait"1"`, `wait"2"`, `wait"3"`); compinit cached and invalidated daily
- **Coherent visual theme** — Drizzt Do'Urden color scheme at WCAG AAA contrast ratios across ZSH prompt, Tmux statusbar, Kitty, and Neovim statusline
- **Contextual right-prompt** — Git branch (vcs_info), Python venv, and Kubernetes context rendered dynamically; falls back to `Klaatu Barada Nitko!` when none are active
- **Modular ZSH** — Six single-purpose modules under `zsh.d/`; every tool check guarded with `command -v` for zero-penalty fallbacks
- **Native LSP in Neovim** — Mason-managed language servers (Lua, Python, Bash) via lazy.nvim with lazy loading; no CoC, no npm/cargo/go runtime dependencies

---

## Tech Stack

| Component | Technology | Version |
|-----------|------------|---------|
| Shell | ZSH + Zinit | 5.9+ |
| Terminal | Kitty | Latest stable |
| Multiplexer | Tmux | 3.2+ |
| Editor | Neovim (Lua) | 0.11+ |
| Runtime manager | mise | Latest |
| Version manager | ASDF | Latest (optional) |
| Plugin manager (nvim) | lazy.nvim | Auto-bootstrapped |
| LSP installer | Mason | Auto-managed |
| Git hooks | pre-commit | 2.x |

---

## Project Structure

```
~/.dotfiles/
├── Makefile                    # Symlink-based installer with color output
├── zshrc                       # Entry point: module loader + Zinit bootstrap
├── zsh.d/
│   ├── config.zsh              # TMUX_AUTOSTART_* variables (user-editable)
│   ├── tools.zsh               # PATH management, editor chain, npm lazy-load
│   ├── alias.zsh               # Aliases and shell functions
│   ├── autocomplete.zsh        # Lazy-loaded kubectl/helm/kind completions
│   ├── tmux.zsh                # Tmux helper functions
│   └── toolbox.zsh             # Utility functions
├── config/
│   ├── tmux.conf               # Tmux 3.4+ native config, 238 lines
│   ├── kitty.conf              # GPU-accelerated terminal settings
│   └── nvim/
│       ├── init.lua            # Entry point: lazy.nvim bootstrap
│       └── lua/
│           ├── core/           # options.lua, keymaps.lua, autocmds.lua
│           └── plugins/        # lsp.lua, completion.lua, ui.lua, editor.lua
├── vimrc                       # Legacy Vim config (compatibility only)
├── .pre-commit-config.yaml     # Hooks: secret scan, YAML/Makefile lint, LF enforcement
├── .github/
│   ├── workflows/              # CI: pre-commit + Trivy filesystem scan
│   ├── SECURITY.md             # Vulnerability disclosure policy
│   ├── dependabot.yml          # Automated dependency updates
│   └── CODEOWNERS              # Review routing
└── img/
    └── death.png               # Drizzt Do'Urden visual asset
```

---

## Usage

### ZSH: Tmux auto-start

All variables live in `zsh.d/config.zsh` and can be overridden in the environment:

```bash
export TMUX_AUTOSTART_ENABLED="true"    # master switch
export TMUX_AUTOSTART_SESSION="dev"     # session name
export TMUX_SKIP_SSH="false"            # attach in SSH sessions
export TMUX_SKIP_IDE="true"             # skip inside VSCode / Emacs
export TMUX_SKIP_DESKTOP="true"         # skip in bspwm, i3, gnome, kde, xfce
```

### Neovim: adding a language server

```lua
-- config/nvim/lua/plugins/lsp.lua
local servers = { 'lua_ls', 'pyright', 'bashls', 'tsserver' }
```

Mason installs the server on next launch. No manual binary management required.

### ZSH: lazy-loading pattern

Heavy completions use a self-removing wrapper to avoid blocking startup:

```zsh
_load_kubectl_completion() {
  source <(kubectl completion zsh)
  unfunction _load_kubectl_completion
  _load_kubectl_completion
}
compdef _load_kubectl_completion kubectl
```

---

## Testing & Verification

```bash
time zsh -ic exit                     # measure startup time (target: <110ms)
zsh --startuptime /tmp/zsh.log -i -c exit && sort -k2 -n /tmp/zsh.log | tail -20
zsh -c 'source ~/.zshrc'              # validate without replacing current shell
tmux source ~/.tmux.conf              # reload tmux config live
pre-commit run --all-files            # run all hooks manually
```

---

## Color Reference

All components share a single palette. Override values are in hex for Kitty/Tmux and 256-color codes for ZSH ANSI sequences.

| Role | Hex | 256-color | Used in |
|------|-----|-----------|---------|
| Background | `#100814` | — | Kitty, Tmux, Neovim |
| Lavender (violet eyes) | `#b19cd9` | 141 | ZSH border, Neovim Normal mode |
| Icy Blue (Twinkle) | `#7ec8e3` | 117 | ZSH hostname, git branch |
| Drow Green | `#5ab897` | 78 | Kubernetes context, Neovim Insert mode |
| Magical Yellow | `#f0c987` | 222 | ZSH separator, fallback RPROMPT |
| Red | `#d35d6e` | 167 | ZSH username |
| Inactive border | `#4a5273` | — | Tmux inactive panes |

---

## Platform Requirements

**Tested:** Ubuntu 20.04+, Debian 11+

**Required:** `zsh 5.9+`, `git 2.40+`, `tmux 3.2+`, `make 4.3+`

**Optional (graceful fallback if absent):** `kubectl`, `helm`, `docker`, `npm`, `bat`, `fzf`, `ripgrep`, `xsel`, `wl-copy`, `pbcopy`

Neovim installation: `make install-nvim` (uses `sudo snap install nvim --classic`)

---

## Contributing

```bash
git checkout -b feature/my-change
# pre-commit validates on commit: syntax, secrets, whitespace, LF endings
git commit -m "feat: description"
```

Open a PR against `main`. One approval required. See `.github/SECURITY.md` for vulnerability reporting.

---

---

## Documentation

Full technical reference organized by user need. Start with [`docs/README.md`](./docs/README.md).

**Getting Started**
- [Installation & Quick Start](./docs/getting-started.dotfiles.md) — Prerequisites, installation steps, first-run checklist

**Configuration**
- [ZSH](./docs/zsh.dotfiles.md) — Modules, environment variables, prompt, Zinit plugins
- [Tmux](./docs/tmux.dotfiles.md) — Keybindings, copy mode, clipboard, color scheme
- [Kitty](./docs/kitty.dotfiles.md) — Font, display settings, layouts, key bindings
- [Neovim](./docs/neovim.dotfiles.md) — Bootstrap, LSP servers, completion, keymaps

**Reference**
- [Architecture Overview](./docs/architecture.dotfiles.md) — Design decisions, performance targets, interactions
- [Color Scheme](./docs/color-scheme.dotfiles.md) — Full palette, WCAG AAA contrast, lore
- [Makefile](./docs/makefile.dotfiles.md) — Targets, symlink mechanics, pre-commit hooks
- [Troubleshooting](./docs/troubleshooting.dotfiles.md) — Common issues and solutions

---

**License:** MIT — see LICENSE
**Maintained by:** Cosckoya | **Repository:** https://github.com/cosckoya/.dotfiles
