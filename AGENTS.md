# AGENTS.md — OpenCode Operating Guide

## Repo Identity

**NOT an application.** This is a shared-home dotfiles repo for both OpenCode and Claude Code. Symlinks in `.claude/` and `.config/opencode/` are transparent — edits to `.claude/settings.json` change both tools.

## No CI, Tests, Linters, or Build

There is no local CI/CD, test framework, linter, typechecker, or build step. Verification is manual:

```bash
time zsh -ic exit                  # startup perf (target: <110ms)
zsh -n zshrc                        # syntax check
make help                           # Makefile syntax
pre-commit run --all-files          # all pre-commit hooks
```

## ZSH Startup Performance

Hard constraint: **under 110ms**. Every edit to `*.zsh` or `zshrc` triggers an auto-profile via the PostToolUse hook in `.claude/settings.json`. If you suppress the hook, run manually:

```bash
zsh --startuptime /tmp/zsh.log -i -c exit && sort -k2 -n /tmp/zsh.log | tail -20
```

## Makefile

Idempotent symlink installer. Key targets: `all` (mise + profile), `profile` (ZSH + Tmux + Kitty + Neovim), `zsh`, `tmux`, `kitty`, `neovim`, `install-nvim`, `mise`, `clean`, `pre-commit-setup`.

## Pre-commit

Validates on commit: Makefile syntax, ZSH syntax (`zsh -n`), Lua syntax (`luac -p`), secrets, trailing whitespace, LF line endings, merge conflicts. Runs in CI too.

## Never Commit Runtime Files

Both tools generate temp files. Before any `git add`, check `git status` for:

`.claude/.session` `.claude/.cache` `shell-snapshots/` `file-history/` `sessions/` `cache/` `plans/` `tasks/` `backups/` `.opencode/`

These are covered by `.gitignore`. Do not reintroduce them.

## Settings

- `.claude/settings.json` — authoritative permissions source of truth
- `.claude/settings.local.json` — per-machine preferences only (never put permissions here)
- No `opencode.json` in repo — OpenCode config is at `~/.config/opencode/`

## Language

English only — all responses, code, comments, documentation, commit messages, and development. No exceptions.

## Commit Conventions

Conventional Commits (`feat:`, `fix:`, `docs:`, `refactor:`, `chore:`, `test:`, `perf:`). Committer: `cosckoya`. **Every commit must include** `Co-Authored-By: Roy Batty <roy.batty@cosckoya.bot>`. Push directly (no force-push without permission). Branches: `main` (stable) | `develop` (active).

## ZSH Conventions

- Tool checks: `command -v`, never `which`
- PATH: `[[ -d ~/bin ]] && path=(~/bin $path)`
- Lazy-loading: self-removing completion wrapper functions
- Indentation: 2-space, no tabs
- No commented-out code (delete it)
- No startup-time tool calls without `command -v` guard

## Color Scheme

WCAG AAA (7:1+) on `#100814` background. Drizzt Do'Urden palette. All components (ZSH, Tmux, Kitty, Neovim) share one palette.

## Key Files

| Path | Purpose |
|------|---------|
| `zshrc` | Entry point: module loader + Zinit bootstrap |
| `zsh.d/*.zsh` | 6 single-purpose modules |
| `config/tmux.conf` | Tmux config (native syntax) |
| `config/kitty.conf` | Kitty terminal settings |
| `config/nvim/` | Neovim Lua (lazy.nvim + Mason) |
| `Makefile` | Symlink installer |
| `.pre-commit-config.yaml` | Git hooks |
| `.claude/settings.json` | AI tool permissions |
| `zsh.d/config.zsh` | TMUX_AUTOSTART_* env vars (user editable) |
| `docs/design-system.dotfiles.md` | Design tokens, architecture layers, extensibility contract |

## Source of Truth

`CLAUDE.md` > `docs/*.dotfiles.md` > `rules/`. If docs conflict with executable config (Makefile, CI, pre-commit), trust the executable. Skills reference rules and docs — do not duplicate content.
