# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Production-ready dotfiles for Linux development environments. Self-contained, offline-capable, optimized for speed. Target: ZSH startup under 110ms. Unified Drizzt Do'Urden color scheme across ZSH, Tmux, Kitty, Neovim.

Platform: Ubuntu 20.04+, Debian 11+. Required: `zsh 5.9+`, `git 2.40+`, `tmux 3.2+`, `make 4.3+`.

## Installation

```bash
make all          # Everything (ASDF + profile)
make profile      # ZSH + Tmux + Kitty + Neovim
make zsh          # ZSH only
make install-nvim # Neovim 0.11+ via snap
```

## Architecture

**Modular configuration:** Each component is independent. ZSH modules in `zsh.d/` split by function. Configs in `config/` symlinked to system locations. All symlinks (not copies) — changes take effect immediately.

**Performance:** Startup time measured via `time zsh -ic exit`. Every ZSH change must be profiled. Lazy-loading for completions and plugins. Zinit turbo mode. Compinit cache daily. Result: ~110ms.

**Graceful fallbacks:** All tool checks use `command -v` before execution. Missing tools do not block startup. Fallback chain: nvim → vim → nano.

**Contracts:**
- No external runtime dependencies (offline-first)
- All modules optional (can install individually)
- Backward compatible (old configs still work)
- WCAG AAA color contrast throughout

## Documentation

Full technical reference in [`docs/README.md`](./docs/README.md):

- **Getting Started:** Installation, first-run checklist, prerequisites
- **Configuration:** ZSH, Tmux, Kitty, Neovim customization guides
- **Reference:** Architecture, color scheme, Makefile, pre-commit hooks, troubleshooting

Start there for deep dives. CLAUDE.md is guidance only.

## For Claude Code

### Code Style

- **ZSH/Bash:** 2-space indents, guard all tool checks (`command -v`), lazy-load completions
- **Lua:** Native LSP only, lazy.nvim for plugins, minimal config files
- **Makefile:** `.PHONY` targets, `##` comments for help, idempotent operations

### Key Patterns

**Lazy-load wrapper (ZSH):**
```zsh
_load_tool_completion() {
  source <(tool completion zsh)
  unfunction _load_tool_completion
}
compdef _load_tool_completion tool
```

**PATH addition (ZSH):**
```zsh
[[ -d ~/bin ]] && path=(~/bin $path)
```

**Makefile target:**
```makefile
.PHONY: target
target: ## Description
	@command -v tool >/dev/null || { echo "Error"; exit 1; }
	@operation
	@echo "Done"
```

### Performance Rules

- Measure ZSH startup after every change: `time zsh -ic exit`
- Profiling: `zsh --startuptime /tmp/zsh.log -i -c exit && sort -k2 -n /tmp/zsh.log | tail -20`
- Target: under 110ms (measured on Ubuntu 20.04+ with standard tools)
- No startup checks without `command -v` guard
- Lazy-load anything non-essential

### Testing

```bash
time zsh -ic exit                  # measure startup
zsh -c 'source ~/.zshrc'           # validate without reloading
tmux source ~/.tmux.conf           # reload tmux live
make help                          # verify Makefile syntax
pre-commit run --all-files         # run all hooks
```

## Knowledge Architecture

**Single source of truth principle:** All technical detail lives in ONE place only.

### Rules Layer (`~/.claude/rules/stacks/shell.rule.md`)

Project-specific conventions enforced globally:
- ZSH startup performance target: <110ms
- Tool checks: always use `command -v`, never `which`
- PATH additions: use `[[ -d path ]]` checks, not tool lookups
- Lazy-loading pattern: self-removing completion wrapper functions
- Indentation: 2-space, no tabs
- Comments: one-line only for non-obvious logic
- No commented-out code (delete it)
- Testing: profile every ZSH change, validate Makefile, run pre-commit

Mandatory for all shell work in this project.

### Documentation Layer (`docs/*.dotfiles.md`)

Technical reference organized by user need:
- **Getting Started:** Installation, prerequisites, first-run checklist
- **Configuration:** ZSH modules, Tmux keybindings, Kitty fonts, Neovim LSP
- **Reference:** Architecture, color scheme, Makefile targets, pre-commit hooks, troubleshooting

Each document is self-contained and deferenced from skills.

### Skills Layer (lightweight navigation)

Thin wrapper around rules + docs, ~50 lines each:
- `kitty-expert` → defers to `docs/kitty.dotfiles.md`
- `theme-designer` → defers to `docs/color-scheme.dotfiles.md` + color.rule.md
- `precommit-expert` → defers to `docs/pre-commit.dotfiles.md`

Archived: `dotfiles_architect`, `shell_optimizer`, `tmux_specialist`, `makefile_expert` (duplicated content)

### CI/CD Layer

`.github/workflows/ci.yml`: Pre-commit validation on all PRs. Catches violations before merge.

### DRY Principle

Never repeat technical content across rules, docs, and skills. If it's in rules or docs, skills reference it. If it's in docs, CLAUDE.md points to it. This prevents drift and makes maintenance trivial.

## Configuration Variables (ZSH)

Edit `zsh.d/config.zsh`:

```bash
TMUX_AUTOSTART_ENABLED    # true/false
TMUX_AUTOSTART_SESSION    # session name
TMUX_SKIP_SSH             # skip in SSH
TMUX_SKIP_IDE             # skip in VSCode/Emacs
TMUX_SKIP_DESKTOP         # skip in graphical desktops
```

## File Organization

| File | Purpose |
|------|---------|
| `zshrc` | Entry point: module loader + Zinit bootstrap |
| `zsh.d/*.zsh` | Modular config: 6 files, each single responsibility |
| `config/tmux.conf` | Tmux 3.4+ config (238 lines, native syntax) |
| `config/kitty.conf` | Kitty terminal settings |
| `config/nvim/` | Neovim Lua config + lazy.nvim + Mason LSP |
| `Makefile` | Symlink-based installer (idempotent) |
| `.pre-commit-config.yaml` | Git hooks (2026 best practices, system-language hooks only) |
| `docs/` | Full technical reference (9 documents, organized by user need) |
| `.claude/rules/stacks/shell.rule.md` | Project conventions: ZSH startup, tool checks, lazy-loading, testing |
| `.github/workflows/ci.yml` | CI/CD: pre-commit validation on all PRs |

## WCAG AAA Color Compliance

All colors meet 7:1 contrast ratio against `#100814` background. See `docs/color-scheme.dotfiles.md` for full palette and per-component usage.

**Updated:** April 28, 2026
