<div align="center">

<img src="./img/death.png" alt="Dotfiles"/>

# Modern Linux Dotfiles

### *Your terminal. Supercharged.*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-Linux-blue.svg)](https://www.linux.org/)
[![Shell](https://img.shields.io/badge/Shell-ZSH-89e051.svg)](https://www.zsh.org/)

</div>

---

## About

Production-ready dotfiles for Linux development environments. Self-contained, offline-capable, and optimized for performance.

**Why these dotfiles?**

- **One Command Setup** - `make all` and you're done
- **Lightning Fast** - ~110ms ZSH startup (92% faster than typical configs)
- **Zero Dependencies** - Works completely offline after installation
- **Linux First** - Optimized for Ubuntu/Debian systems
- **Modular** - Install only what you need

---

## Quick Start

```bash
# Clone and install
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make all

# Restart your shell
exec zsh
```

**Selective installation:** Use `make help` to see all available targets.

---

## What's Inside

| Component | Description |
|-----------|-------------|
| **ZSH** | ~110ms startup with Zinit turbo mode, lazy-loaded completions, Drizzt Do'Urden colors |
| **Tmux** | Vi-mode, clipboard integration, Drizzt Do'Urden theme (238 lines, optimized from 1889) |
| **Neovim** | Lua-based with lazy.nvim, native LSP (Mason), nvim-cmp, Telescope |
| **Kitty** | GPU-accelerated terminal with Drizzt Do'Urden theme (drow cavern palette) |
| **ASDF** | Universal version manager |

---

## Requirements

**Tested on:** Ubuntu 20.04+, Debian 11+

**Minimum versions:** ZSH 5.9+, Git 2.40+, Tmux 3.2+, Neovim 0.10+, Make 4.3+

**Optional:** kubectl, helm, docker, xclip, ripgrep, fzf

---

## Project Structure

```
~/.dotfiles/
├── Makefile                    # Installation orchestrator
├── zshrc                       # ZSH entry point
├── zsh.d/                      # Modular ZSH config (6 files)
│   ├── config.zsh             # User variables (tmux auto-start, etc.)
│   ├── tools.zsh              # PATH, editor, npm lazy-loading
│   ├── alias.zsh              # Command aliases
│   ├── autocomplete.zsh       # Lazy-loaded completions
│   ├── tmux.zsh               # Tmux helpers
│   └── toolbox.zsh            # Utilities
└── config/
    ├── nvim/                  # Neovim Lua config (lazy.nvim, LSP, cmp)
    ├── tmux.conf              # Tmux 3.4+ native syntax
    └── kitty.conf             # Kitty terminal settings
```

---

## Key Features

### Performance Optimizations
- **ZSH**: Async plugin loading (Zinit turbo mode), compinit caching, lazy completions
- **Tmux**: Native 3.4+ syntax, minimal status updates, optimized rendering
- **Neovim**: Lazy plugin loading, native LSP (no external servers)

### Smart Tmux Auto-Start
Automatically starts tmux when appropriate, intelligently skips in:
- IDE/VSCode terminals
- SSH sessions (configurable)
- Desktop environments (GNOME, KDE, i3, etc.)

Configure in `zsh.d/config.zsh`:
```bash
export TMUX_AUTOSTART_ENABLED="true"
export TMUX_SKIP_IDE="true"
export TMUX_SKIP_DESKTOP="true"
```

### Dynamic Prompt (RPROMPT) - Drizzt Do'Urden
Context-aware right prompt showing:
- Git branch (icy blue from Twinkle) - only in git repos
- Python virtualenv (lavender violet eyes)
- Kubernetes context (drow magic green)
- Fallback message when no context (magical yellow)

### Offline Capable
All plugins cached locally. ASDF uses binary installation (no compilation). Works without internet after initial setup.

---

## Configuration

**Theme:** Drizzt Do'Urden - Complete visual coherence across all components with matching powerline styles. Deep purple cavern (#100814), lavender eyes (#b19cd9), and icy blue accents (#7ec8e3). WCAG AAA contrast ratios.
**ZSH modules:** Edit files in `zsh.d/` for aliases, completions, or tools
**Tmux:** Modify `config/tmux.conf` for keybindings and appearance
**Neovim:** Lua modules in `config/nvim/lua/` (core settings, plugins, LSP)
**Kitty:** Terminal settings in `config/kitty.conf`

---

## Contributing

Contributions are welcome! Submit a Pull Request.

---

## License

MIT License - see LICENSE file for details.

---

## Acknowledgments

Built for the Linux community. Special thanks to [Zinit](https://github.com/zdharma-continuum/zinit), [Lazy.nvim](https://github.com/folke/lazy.nvim), [Tokyo Night](https://github.com/folke/tokyonight.nvim), and [Kitty](https://sw.kovidgoyal.net/kitty/).

---

<div align="center">

**The riddle of steel**

[Report Bug](https://github.com/yourusername/dotfiles/issues) · [Request Feature](https://github.com/yourusername/dotfiles/issues)

</div>
