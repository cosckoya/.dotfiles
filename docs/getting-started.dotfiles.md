# Installation & Quick Start

## Prerequisites

**Required:** Linux (Ubuntu 20.04+, Debian 11+)

**Installed locally:** `zsh 5.9+`, `git 2.40+`, `tmux 3.2+`, `make 4.3+`

**Optional (graceful fallback if absent):** `neovim 0.11+`, `kubectl`, `helm`, `docker`, `npm`, `bat`, `fzf`

## Installation

Clone and run the installer. All steps are idempotent — safe to re-run.

```bash
git clone https://github.com/cosckoya/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make all
exec zsh
```

**What happened:**
- ASDF installed to `~/bin/asdf` with `~/.asdf` as data directory
- `zshrc` symlinked to `~/.zshrc`
- `config/tmux.conf` symlinked to `~/.tmux.conf`
- `config/kitty.conf` symlinked to `~/.config/kitty/kitty.conf`
- `config/nvim/` symlinked to `~/.config/nvim/`
- Pre-commit hooks installed (runs on every commit)

## Selective Installation

```bash
make help                # List all available targets
make profile             # ZSH + Tmux + Kitty + Neovim (no ASDF)
make zsh                 # ZSH configuration only
make install-nvim       # Install Neovim via snap (requires sudo)
```

## Verify Performance

ZSH startup should be under 110ms.

```bash
time zsh -ic exit
```

For detailed profiling:

```bash
zsh --startuptime /tmp/zsh.log -i -c exit
sort -k2 -n /tmp/zsh.log | tail -20
```

## First Run Checklist

### 1. Customize Tmux auto-start (optional)

Edit `~/.zsh.d/config.zsh`:

```bash
export TMUX_AUTOSTART_ENABLED="true"    # set to "false" to disable
export TMUX_AUTOSTART_SESSION="dev"     # session name
export TMUX_SKIP_IDE="true"             # skip inside VSCode
export TMUX_SKIP_SSH="false"            # attach in SSH sessions
```

After changes, reload your shell:

```bash
exec zsh
```

### 2. Add language servers (optional)

If you use Python, Lua, or Bash, language servers are pre-configured. On first Neovim launch, Mason installs them automatically.

To add another language server, edit `config/nvim/lua/plugins/lsp.lua`:

```lua
local servers = { "lua-language-server", "pyright", "bash-language-server", "tsserver" }
```

Mason installs `tsserver` on next Neovim launch.

### 3. Test Tmux integration

Start a new terminal session:

```bash
tmux list-sessions          # list all Tmux sessions
tmux attach-session -t dev  # attach to named session
```

### 4. Test Neovim LSP

```bash
nvim test.py
# Type and press C-Space to trigger autocomplete
# Hover over a function name and press K for documentation
```

## Next Steps

- [ZSH Configuration](./zsh.dotfiles.md) — Customize shell behavior
- [Tmux Configuration](./tmux.dotfiles.md) — Learn keybindings
- [Troubleshooting Guide](./troubleshooting.dotfiles.md) — If something breaks
