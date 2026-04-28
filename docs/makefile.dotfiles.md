# Makefile Reference

Symlink-based installer. All targets are idempotent — safe to run multiple times.

## Targets

| Target | Description |
|--------|-------------|
| `make help` | Print all targets (auto-generated from `##` comments) |
| `make all` | Install MISE + full profile (ZSH + Tmux + Kitty + Neovim) |
| `make profile` | Install ZSH + Tmux + Kitty + Neovim (no MISE) |
| `make zsh` | Symlink `zshrc` → `~/.zshrc`, `zsh.d/` → `~/.zsh.d/` |
| `make tmux` | Symlink `config/tmux.conf` → `~/.tmux.conf` |
| `make kitty` | Symlink `config/kitty.conf` → `~/.config/kitty/kitty.conf` |
| `make neovim` | Symlink `config/nvim/` → `~/.config/nvim/` |
| `make install-nvim` | Install Neovim 0.11+ via `sudo snap install nvim --classic` |
| `make mise` | Install MISE (runtime version manager for Python, Node, Go, Rust, etc.) |

## Installation Mechanics

All targets use symbolic links, not file copies. Changes to repository files take effect immediately without re-running `make`.

```
Repo file              → Symlink target
────────────────────────────────────────
zshrc                  → ~/.zshrc
zsh.d/                 → ~/.zsh.d
config/tmux.conf       → ~/.tmux.conf
config/kitty.conf      → ~/.config/kitty/kitty.conf
config/nvim/           → ~/.config/nvim
vimrc                  → ~/.vimrc
```

Running `make` again replaces existing symlinks (idempotent).

## MISE Installation

Installs MISE (Rust-based version manager, faster than ASDF) via official installer.

**Location:** `~/.local/bin/mise` (added to `$PATH` automatically)
**Config:** `mise.toml` (ASDF `.tool-versions` compatible)

MISE features:
- 10–100x faster than ASDF (compiled Rust vs shell)
- Drop-in ASDF replacement (reads `.tool-versions`)
- Better UX with modern error messages
- Built-in support for Python, Node, Go, Rust, Ruby, Java, PHP, and 200+ tools
- Async installation for large environments

## Neovim Installation

Two-step process:

```bash
make install-nvim      # install Neovim 0.11+ via snap (requires sudo)
make neovim            # symlink config
```

The `make neovim` target validates that Neovim 0.11+ is installed before creating symlinks.

## Pre-commit Hooks

Configured in `.pre-commit-config.yaml`. Run on every commit to validate:

| Hook | Checks |
|------|--------|
| `check-merge-conflict` | No unresolved conflict markers |
| `end-of-file-fixer` | Files end with newline |
| `trailing-whitespace` | No trailing spaces |
| `check-yaml` | Valid YAML syntax |
| `check-added-large-files` | No large files (except `img/`) |
| `check-case-conflict` | No case-sensitive filename conflicts |
| `detect-private-key` | No private keys committed |
| `mixed-line-ending` | LF line endings enforced |
| `makefile-syntax` | Valid Makefile syntax |
| `checkmake` | Makefile lint (skipped if not installed) |

### Install hooks

```bash
pre-commit install          # one-time setup
pre-commit run --all-files  # run manually on all files
```

Hooks run automatically on `git commit`. To bypass (not recommended):

```bash
git commit --no-verify
```

## Idempotency

All `make` targets are safe to re-run. They:

- Check if symlink exists before creating
- Replace broken symlinks
- Skip operations if prerequisites are missing
- Never modify repository files
- Never delete user files

## Variables

| Variable | Value | Use |
|----------|-------|-----|
| `OS` | `$(uname -s)` lowercased | Conditional logic (Linux-specific setup) |
| `DOTFILES` | `$(pwd)` | Absolute path to repo (used in symlinks) |

## Troubleshooting

**Symlink already exists?**
```bash
make zsh            # replaces existing symlink
ls -l ~/.zshrc      # verify new symlink
```

**Permission denied on make install-nvim?**
```bash
sudo make install-nvim   # require sudo for snap
```

**MISE installation fails?**
```bash
# Check internet connectivity
curl -s https://mise.jdx.dev/install.sh | head -5

# Verify installation
mise --version

# Install specific tool version
mise install python@3.13
```

**Pre-commit hooks not running?**
```bash
pre-commit install                  # install hooks
git commit --allow-empty -m "test"  # test with empty commit
```
