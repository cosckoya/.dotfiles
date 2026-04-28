# Contributing to .dotfiles

This repository follows 2026 best practices for dotfiles. When contributing, please adhere to these guidelines.

## Branch Naming Convention

- `feat/description` — New feature or enhancement
- `fix/description` — Bug fix
- `docs/description` — Documentation only
- `chore/description` — Maintenance, refactoring, or infrastructure
- `perf/description` — Performance optimization

Example: `feat/add-asdf-node-setup`, `fix/compinit-syntax-error`, `docs/wsl-support`

## Commit Format

Use **Conventional Commits** format:

```
type(scope): short description (under 50 chars)

Longer explanation (if needed). Explain the WHY, not the WHAT — diffs show changes.

Co-Authored-By: Claude <noreply@anthropic.com>
```

Types: `feat`, `fix`, `docs`, `test`, `chore`, `perf`, `refactor`, `style`

Example:
```
fix(zsh): remove duplicate compinit block

Syntax error in zshrc lines 146-149 caused shell parse failures.
Duplicate if/else block with no opening condition deleted.

Verified: zsh -n ~/.zshrc passes.

Co-Authored-By: Claude <noreply@anthropic.com>
```

## Code Review Checklist

Before submitting a pull request, ensure:

### Performance
- [ ] ZSH startup time measured: `time zsh -ic exit` (target: <110ms)
- [ ] If >110ms, explain optimization in PR description
- [ ] Profiling result included if startup time changed: `zsh --startuptime /tmp/zsh.log -i -c exit`

### Testing
- [ ] Pre-commit hooks pass: `pre-commit run --all-files`
- [ ] Shell syntax valid: `zsh -n ~/.zshrc`, `bash -n Makefile`
- [ ] Makefile targets work: `make help`, `make profile` (dry-run where possible)
- [ ] All aliases execute: `alias_name --help` or manual test

### Code Quality
- [ ] Follows `~/.claude/rules/stacks/shell.rule.md` conventions:
  - Tool checks use `command -v`, never `which`
  - PATH additions use `[[ -d path ]]` checks
  - 2-space indentation, no tabs
  - Comments only for non-obvious logic (one line max)
  - No commented-out code (delete it; git preserves history)
- [ ] No emojis in code comments or user-facing messages (ASCII only)
- [ ] No secrets committed (`.env`, credentials, API keys)

### Documentation
- [ ] Applicable `docs/*.dotfiles.md` files updated
- [ ] CLAUDE.md updated if scope/architecture changed
- [ ] New shell functions documented in corresponding module comments
- [ ] Cross-references added to related documentation

### Cross-Platform
- [ ] Tested on Ubuntu 20.04+ (or explain platform-specific reason)
- [ ] Graceful fallback if tool missing (no `command -v` → no error)
- [ ] WCAG AAA color contrast maintained (7:1+) if color changes

## PR Template

```markdown
## Description
Brief explanation of what changed and why.

## Type of Change
- [ ] Feature
- [ ] Bug Fix
- [ ] Documentation
- [ ] Performance Improvement
- [ ] Other: ___

## Performance Impact
- ZSH startup time before: ___ ms
- ZSH startup time after: ___ ms
- Impact: [none / slight improvement / slight regression / significant change]

## Testing
- [ ] Pre-commit hooks pass
- [ ] Shell syntax valid
- [ ] Tested aliases/functions work
- [ ] Profiling: [attach results if startup time changed]

## Checklist
- [ ] Follows shell.rule.md conventions
- [ ] Documentation updated
- [ ] No secrets committed
- [ ] No emojis in code
```

## Code Style Reference

### ZSH/Bash Conventions

**Tool checks (always use `command -v`):**
```zsh
if command -v tool >/dev/null 2>&1; then
  # tool-specific code
else
  # fallback
fi
```

**PATH additions (use directory existence, not tool checks):**
```zsh
typeset -U path
[[ -d ~/bin ]] && path=(~/bin $path)
```

**Lazy-loading completions (self-removing wrapper):**
```zsh
_load_tool_completion() {
  source <(tool completion zsh)
  unfunction _load_tool_completion
}
compdef _load_tool_completion tool
```

**Makefile targets (.PHONY, `##` comments, idempotent):**
```makefile
.PHONY: target
target: ## Description of what this target does
	@command -v tool >/dev/null || { echo "Error"; exit 1; }
	@operation
	@echo "Done"
```

## Running Pre-commit Locally

```bash
# Install
make pre-commit-setup

# Run on all files
pre-commit run --all-files

# Run on specific file
pre-commit run --files zshrc

# Fix auto-fixable issues
pre-commit run --all-files --hook-stage commit
```

## Questions?

Refer to:
- `CLAUDE.md` — Project overview and guidance
- `docs/README.md` — Full technical documentation
- `~/.claude/rules/stacks/shell.rule.md` — Mandatory shell conventions
- `~/.claude/rules/universal/communication.rule.md` — English-only, no emojis policy

---

Thank you for contributing to better dotfiles! 🙌
