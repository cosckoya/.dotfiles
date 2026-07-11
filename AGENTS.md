# AGENTS.md — OpenCode Operating Guide

## Repo Identity

**NOT an application.** This is a shared-home dotfiles repo for both OpenCode and Claude Code. Symlinks in `.claude/` and `.config/opencode/` are transparent.

## No CI, Tests, Linters, or Build

There is no local CI/CD, test framework, linter, typechecker, or build step. Verification is manual:

```bash
time zsh -ic exit                  # startup perf (target: <110ms)
zsh -n zshrc                        # syntax check
make help                           # Makefile syntax
pre-commit run --all-files          # all pre-commit hooks
```

## ZSH Startup Performance

Hard constraint: **under 110ms**. Every edit to `*.zsh` or `zshrc` triggers an auto-profile via the PostToolUse hook in `opencode.jsonc`. If you suppress the hook, run manually:

```bash
zsh --startuptime /tmp/zsh.log -i -c exit && sort -k2 -n /tmp/zsh.log | tail -20
```

## Makefile

Idempotent symlink installer. Key targets: `all` (mise + profile), `profile` (ZSH + Tmux + Kitty + Neovim + OpenCode), `zsh`, `tmux`, `kitty`, `neovim`, `install-nvim`, `mise`, `opencode`, `clean`, `pre-commit-setup`.

## Pre-commit

Validates on commit: Makefile syntax, ZSH syntax (`zsh -n`), Lua syntax (`luac -p`), secrets, trailing whitespace, LF line endings, merge conflicts. Runs in CI too.

## Never Commit Runtime Files

Both tools generate temp files. Before any `git add`, check `git status` for:

`.claude/.session` `.claude/.cache` `shell-snapshots/` `file-history/` `sessions/` `cache/` `plans/` `tasks/` `backups/` `.opencode/`

These are covered by `.gitignore`. Do not reintroduce them.

## Settings

- **OpenCode**: `config/opencode/opencode.jsonc` (repo) → `~/.config/opencode/opencode.jsonc` (symlink)
- **Claude Code**: `.claude/settings.json` (repo) — kept for compatibility
- **Local overrides**: `.claude/settings.local.json` — per-machine only

## Language

English only — all responses, code, comments, documentation, commit messages, and development. No exceptions.

## Commit Conventions

Conventional Commits (`feat:`, `fix:`, `docs:`, `refactor:`, `chore:`, `test:`, `perf:`). Committer: `cosckoya`. **Every commit must include** `Co-Authored-By: Roy Batty <roy.batty@cosckoya.bot>`. Push directly (no force-push without permission). Branches: `main` (stable) | `develop` (active).

## Architecture

**Modular configuration:** Each component is independent. ZSH modules in `zsh.d/` split by function. Configs in `config/` symlinked to system locations. All symlinks (not copies) — changes take effect immediately.

**Performance:** Startup time measured via `time zsh -ic exit`. Every ZSH change must be profiled. Lazy-loading for completions and plugins. Zinit turbo mode. Compinit cache daily. Result: ~110ms.

**Graceful fallbacks:** All tool checks use `command -v` before execution. Missing tools do not block startup. Fallback chain: nvim → vim → nano.

**Contracts:**
- No external runtime dependencies (offline-first)
- All modules optional (can install individually)
- Backward compatible (old configs still work)
- WCAG AAA color contrast throughout

## Mandatory Rules

All work in this project MUST follow these rules (in `config/opencode/rules/`):

| Rule | Purpose |
|------|---------|
| `shell.rule.md` | Tool checks, PATH, lazy-loading, indentation, testing |
| `color.rule.md` | WCAG AAA contrast, Drizzt Do'Urden palette |
| `markdown.rule.md` | Documentation format standards |
| `communication.rule.md` | English-only, no emojis in docs |
| `git-workflow.rule.md` | Branch strategy, commit format, PR workflow |

These rules are sourced from `config/opencode/rules/` (in-repo) and are the single source of truth. Skills reference them but do not duplicate them.

## Documentation

Full technical reference in [`docs/README.md`](./docs/README.md):

- **Getting Started:** Installation, first-run checklist, prerequisites
- **Configuration:** ZSH, Tmux, Kitty, Neovim, OpenCode customization guides
- **Reference:** Architecture, color scheme, Makefile, pre-commit hooks, troubleshooting

## Code Style

### ZSH/Bash
- 2-space indents, guard all tool checks (`command -v`), lazy-load completions

### Lua
- Native LSP only, lazy.nvim for plugins, minimal config files

### Makefile
- `.PHONY` targets, `##` comments for help, idempotent operations

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

## Knowledge Architecture

**Single source of truth principle:** All technical detail lives in ONE place only.

### Rules Layer (`config/opencode/rules/`)
Project-specific conventions enforced globally. Mandatory for all work.

### Documentation Layer (`docs/*.dotfiles.md`)
Technical reference organized by user need. Each document is self-contained.

### Skills Layer (`.claude/skills/` — shared with Claude Code)
Thin wrapper around rules + docs. Auto-discovered by both OpenCode and Claude Code.

### CI/CD Layer
`.github/workflows/ci.yml`: Pre-commit validation on all PRs.

### DRY Principle
Never repeat technical content across rules, docs, and skills. If it's in rules or docs, skills reference it. If it's in docs, AGENTS.md points to it.

## Configuration Variables (ZSH)

Edit `zsh.d/config.zsh`:

```bash
TMUX_AUTOSTART_ENABLED    # true/false
TMUX_AUTOSTART_SESSION    # session name
TMUX_SKIP_SSH             # skip in SSH
TMUX_SKIP_IDE             # skip in VSCode/Emacs
TMUX_SKIP_DESKTOP         # skip in graphical desktops
```

## Key Files

| Path | Purpose |
|------|---------|
| `zshrc` | Entry point: module loader + Zinit bootstrap |
| `zsh.d/*.zsh` | 6 single-purpose modules |
| `config/tmux.conf` | Tmux config (native syntax) |
| `config/kitty.conf` | Kitty terminal settings |
| `config/nvim/` | Neovim Lua (lazy.nvim + Mason) |
| `config/opencode/opencode.jsonc` | OpenCode core config |
| `config/opencode/tui.jsonc` | OpenCode TUI theme |
| `config/opencode/rules/` | Mandatory project rules |
| `config/opencode/agents/` | Custom agents |
| `.claude/settings.json` | Claude Code hooks (compat) |
| `.claude/skills/` | Shared skills (both tools) |
| `Makefile` | Symlink installer |
| `.pre-commit-config.yaml` | Git hooks |
| `zsh.d/config.zsh` | TMUX_AUTOSTART_* env vars (user editable) |
| `docs/design-system.dotfiles.md` | Design tokens, architecture layers, extensibility contract |

## Source of Truth

`AGENTS.md` > `config/opencode/rules/` > `docs/*.dotfiles.md`. If docs conflict with executable config (Makefile, CI, pre-commit), trust the executable. Skills reference rules and docs — do not duplicate content.

## WCAG AAA Color Compliance

All colors meet 7:1 contrast ratio against `#100814` background. See `docs/color-scheme.dotfiles.md` for full palette and per-component usage.
