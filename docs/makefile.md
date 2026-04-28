# Makefile Reference

Symlink-based installer. Idempotent: safe to run multiple times. All targets use `set -e` so they fail fast on errors.

**File:** `Makefile`

---

## Targets

| Target | Description |
|--------|-------------|
| `make help` | Print all available targets (auto-generated from `##` comments) |
| `make all` | Install ASDF + full profile |
| `make profile` | Install ZSH + Tmux + Kitty + Neovim (no ASDF) |
| `make zsh` | Symlink `zshrc` → `~/.zshrc` and `zsh.d/` → `~/.zsh.d/`; sets ZSH as default shell on Linux |
| `make tmux` | Symlink `config/tmux.conf` → `~/.tmux.conf` |
| `make kitty` | Symlink `config/kitty.conf` → `~/.config/kitty/kitty.conf` |
| `make neovim` | Symlink `config/nvim/` → `~/.config/nvim/`; symlink `vimrc` → `~/.vimrc` |
| `make install-nvim` | Install Neovim via `sudo snap install nvim --classic` |
| `make asdf` | Download and install latest ASDF binary to `~/bin/asdf` |

---

## Installation mechanics

All targets use symbolic links, not file copies. Changes to dotfiles repository files take effect immediately without re-running `make`.

```
Repo file              →  Symlink target
────────────────────────────────────────
zshrc                  →  ~/.zshrc
zsh.d/                 →  ~/.zsh.d
config/tmux.conf       →  ~/.tmux.conf
config/kitty.conf      →  ~/.config/kitty/kitty.conf
config/nvim/           →  ~/.config/nvim
vimrc                  →  ~/.vimrc
```

---

## ASDF installation

Downloads the latest release binary directly from GitHub — no package manager required:

```
https://github.com/asdf-vm/asdf/releases → ~/bin/asdf
```

Architecture is detected from `uname -m` and mapped to the GitHub release naming convention (`x86_64 → amd64`, `aarch64 → arm64`).

---

## Neovim installation requirement

`make neovim` validates that Neovim 0.11+ is installed before creating symlinks. If the version check fails:

```bash
make install-nvim   # install via snap first
make neovim         # then configure
```

---

## Variables

| Variable | Value | Use |
|----------|-------|-----|
| `OS` | `$(uname -s)` lowercased | Conditional shell changes (Linux only) |
| `DOTFILES` | `$(pwd)` | Absolute path to repo root |

---

## Pre-commit hooks

Validated on every commit via `.pre-commit-config.yaml`:

| Hook | What it checks |
|------|---------------|
| `check-merge-conflict` | No unresolved conflict markers |
| `end-of-file-fixer` | Files end with a newline |
| `trailing-whitespace` | No trailing spaces |
| `check-yaml` | Valid YAML syntax |
| `check-added-large-files` | No large binaries (except `img/`) |
| `check-case-conflict` | No case-sensitive filename conflicts |
| `detect-private-key` | No private keys committed |
| `mixed-line-ending` | LF endings enforced |
| `makefile-syntax` | Valid Makefile syntax |
| `checkmake` | Makefile lint (skipped if not installed) |

Install hooks after cloning:

```bash
pre-commit install
```
