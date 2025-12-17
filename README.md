<div align="center">

<img src="./img/death.png" alt="Dotfiles" width="400"/>

# 🚀 Modern Linux Dotfiles

### *Your terminal. Supercharged.*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-Linux-blue.svg)](https://www.linux.org/)
[![Shell](https://img.shields.io/badge/Shell-ZSH-89e051.svg)](https://www.zsh.org/)
[![Optimized for](https://img.shields.io/badge/Optimized_for-Ubuntu%20%7C%20Debian-DD4814.svg)](https://ubuntu.com/)

</div>

---

## 📖 About

A carefully crafted collection of configuration files that transform your terminal into a powerful, beautiful, and efficient development environment. Built specifically for **Linux users** who want a professional setup without the hassle.

### ✨ Why These Dotfiles?

- **🎯 One Command Setup** - Install everything with `make all`
- **⚡ Lightning Fast** - ~110ms ZSH startup (92% faster than typical configs)
- **🎨 Beautiful by Default** - Modern theme with purple-green palette
- **🔧 Zero Dependencies** - Works completely offline, no npm/cargo/go required
- **🐧 Linux First** - Optimized specifically for Ubuntu and Debian systems
- **📦 Modular Design** - Enable only what you need

---

## 🛠️ What's Inside

| Component | Description | Status |
|-----------|-------------|--------|
| **ZSH** | Modern shell with smart completions & syntax highlighting | ✅ |
| **Tmux** | Terminal multiplexer with vi-mode & clipboard support | ✅ |
| **Neovim** | Lua-based config with LSP, autocompletion & snippets | ✅ |
| **Kitty** | GPU-accelerated terminal with Royal theme | ✅ |
| **ASDF** | Universal version manager for multiple languages | ✅ |

---

## 📋 System Requirements

Tested and optimized for **Ubuntu 20.04+** and **Debian 11+**

| Tool | Version Required | Version Used |
|------|-----------------|--------------|
| **ZSH** | 5.9+ | 5.9 |
| **Git** | 2.40+ | 2.43.0 |
| **Tmux** | 3.2+ | 3.4 |
| **Neovim** | 0.10+ | 0.11.5 |
| **Make** | 4.3+ | 4.3 |
| **Kitty** | 0.32+ | 0.35.2 |

### Optional Tools

| Tool | Purpose | Installation |
|------|---------|--------------|
| **xclip** | Clipboard support for tmux | `sudo apt install xclip` |
| **ripgrep** | Fast search in Neovim | `sudo apt install ripgrep` |
| **wget** | Download resources | `sudo apt install wget` |
| **curl** | API requests | `sudo apt install curl` |

---

## 🚀 Quick Start

```bash
# 1. Clone the repository
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# 2. Install everything (recommended)
make all

# 3. Restart your shell
exec zsh
```

### 🎯 Selective Installation

```bash
make profile      # ZSH + Tmux + Kitty + Neovim configs
make asdf         # ASDF version manager
make zsh          # ZSH configuration only
make tmux         # Tmux configuration only
make neovim       # Neovim configuration only
make kitty        # Kitty terminal configuration
```

View all available commands:
```bash
make help
```

---

## 📁 Project Structure

```
~/.dotfiles/
├── Makefile                    # Installation orchestrator
├── zshrc                       # ZSH entry point
├── zsh.d/                      # Modular ZSH configuration
│   ├── config.zsh             # User-configurable variables
│   ├── tools.zsh              # PATH & tool initialization
│   ├── alias.zsh              # Command aliases
│   ├── autocomplete.zsh       # Lazy-loaded completions
│   ├── tmux.zsh               # Tmux helper functions
│   └── toolbox.zsh            # Utility functions
├── config/
│   ├── nvim/                  # Neovim Lua configuration
│   │   ├── init.lua          # Entry point
│   │   ├── lua/core/         # Core settings
│   │   └── lua/plugins/      # Plugin configurations
│   ├── tmux.conf             # Unified tmux config
│   └── kitty.conf            # Kitty terminal config
└── README.md                  # You are here
```

---

## ⚙️ Configuration Highlights

### ZSH - Blazing Fast Startup
- **~110ms startup time** (vs typical 1200ms)
- Zinit plugin manager with turbo mode
- Lazy-loaded completions for kubectl, helm, kind
- Smart history management (5000 entries)
- Dynamic RPROMPT with git, Python venv, kubectl context

### Tmux - Power User Ready
- **Native 3.4+ syntax** (238 lines, optimized from 1889)
- Vi-mode copy with system clipboard integration
- Purple-green professional color scheme
- Mouse support with kitty optimizations
- Smart window & pane navigation

### Neovim - Modern IDE Experience
- **Lazy.nvim** for fast plugin loading
- **Native LSP** with Mason (Lua, Python, Bash)
- **nvim-cmp** for intelligent autocompletion
- **Telescope** for fuzzy finding
- **LuaSnip** for code snippets
- **Which-Key** for keybinding discovery
- No external dependencies (pure Lua)

### Kitty Terminal
- Royal theme (dark purple palette)
- GPU-accelerated rendering
- Powerline-style tabs
- Background opacity 0.88
- Nerd Font support (JetBrains Mono)

---

## 🎨 Theming

All components share a cohesive **purple-green** color palette:

| Color | Hex | Usage |
|-------|-----|-------|
| Dark Purple | `#442E59` | Backgrounds |
| Medium Purple | `#79658C` | Inactive elements |
| Light Lavender | `#917CA6` | Primary text |
| Dark Teal | `#27403B` | Active borders |
| Gray-Green | `#5D736D` | Highlights |

---

## 🔑 Key Features

### Smart Tmux Auto-Start
Automatically starts tmux when appropriate, but **intelligently skips** in:
- IDE/VSCode terminals
- SSH sessions (optional)
- Desktop environments (GNOME, KDE, i3, etc.)

Configure in `zsh.d/config.zsh`:
```bash
export TMUX_AUTOSTART_ENABLED="true"
export TMUX_SKIP_IDE="true"
export TMUX_SKIP_DESKTOP="true"
```

### Performance Optimizations
- **ZSH**: Async plugin loading, compinit caching
- **Tmux**: Minimal status bar updates, efficient rendering
- **Neovim**: Lazy plugin loading, native LSP

### Offline Capable
- All plugins cached locally
- ASDF binary installation (no compilation)
- Works without internet after initial setup

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

---

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 🙏 Acknowledgments

Built with ❤️ for the Linux community.

Special thanks to:
- [Zinit](https://github.com/zdharma-continuum/zinit) - Lightning fast ZSH plugin manager
- [Lazy.nvim](https://github.com/folke/lazy.nvim) - Modern plugin manager for Neovim
- [Tokyo Night](https://github.com/folke/tokyonight.nvim) - Beautiful color scheme
- [Kitty](https://sw.kovidgoyal.net/kitty/) - The fast, feature-rich terminal emulator

---

<div align="center">

**Made for Linux. Built with passion.**

[Report Bug](https://github.com/yourusername/dotfiles/issues) · [Request Feature](https://github.com/yourusername/dotfiles/issues)

</div>
