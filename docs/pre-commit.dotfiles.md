# Pre-commit Hooks Configuration

Automated validation on every commit. Runs before code is staged, fails fast on first error.

**File:** `.pre-commit-config.yaml`

## Installation

One-time setup:

```bash
pre-commit install              # install hooks into .git/hooks/pre-commit
```

Then commits run hooks automatically. No additional setup needed.

## Manual Usage

```bash
pre-commit run --all-files      # run on all files
pre-commit run --files <file>   # run on specific file
pre-commit autoupdate           # update all hook versions
```

## Hooks Active

### Core File Validation

| Hook | Checks |
|------|--------|
| `check-merge-conflict` | No unresolved `<<<<<<<` markers |
| `check-yaml` | Valid YAML syntax |
| `check-toml` | Valid TOML syntax |
| `check-json` | Valid JSON syntax |

### File Format

| Hook | Fixes |
|------|-------|
| `end-of-file-fixer` | Adds final newline |
| `trailing-whitespace` | Removes trailing spaces |
| `mixed-line-ending` | Enforces LF (Unix) line endings |

### File Safety

| Hook | Checks |
|------|--------|
| `detect-private-key` | No private keys (`.pem`, `.key`, etc.) |
| `check-added-large-files` | No files >1MB (except `img/`) |
| `check-case-conflict` | No case-sensitive filename collisions |

### Executable Permissions

| Hook | Checks |
|------|--------|
| `check-executables-have-shebangs` | Shell scripts start with `#!/bin/bash` or `#!/bin/zsh` |
| `check-shebang-scripts-are-executable` | Scripts with shebangs are executable |

### Shell Linting

| Hook | Tool | Checks |
|------|------|--------|
| `shellcheck` | ShellCheck v0.10+ | Bash/ZSH script errors (warnings shown, not fatal) |

### Markdown Linting

| Hook | Tool | Checks |
|------|------|--------|
| `markdownlint` | markdownlint-cli | Markdown formatting (auto-fixed) |

### Project-Specific

| Hook | Validates |
|------|-----------|
| `makefile-syntax` | `make help` works (catch parse errors) |
| `makefile-lint` | Makefile best practices (graceful skip if checkmake absent) |
| `zsh-syntax` | ZSH scripts parse correctly (`zsh -n`) |
| `lua-syntax` | Lua scripts compile (`luac -p`, skip if luac absent) |

## Bypass (Emergency Only)

```bash
git commit --no-verify          # skip all hooks
```

Not recommended. Hooks catch real issues.

## Configuration Principles (2026)

**Pin to specific versions:** All repos use `rev: <version>`, never `HEAD` or `main`. Prevents breaking changes on commit.

**Type-based filtering:** Use `types: [shell]` instead of regex `files` patterns. More reliable, fewer errors.

**Graceful degradation:** Project hooks (ZSH, Lua, Makefile) skip silently if tools are missing. Non-fatal.

**Fast-fail:** First error stops commit. No accumulation of warnings.

**No emojis:** Messages are plain text, readable in all terminals.

## Common Issues

**Hooks not running?**
```bash
pre-commit install
git config core.hooksPath .git/hooks
```

**Too slow?**
```bash
pre-commit run --from-ref origin/main --to-ref HEAD  # run only on changed files
```

**Want to skip a hook?**
Edit `.pre-commit-config.yaml`, remove hook entry, reinstall:
```bash
pre-commit install
```

**Update all hooks?**
```bash
pre-commit autoupdate
git add .pre-commit-config.yaml
git commit -m "chore: update pre-commit hooks"
```

## Integration with CI/CD

If using GitHub Actions, cache pre-commit environment:

```yaml
- uses: pre-commit/action@v3.0.0
```

This runs hooks on all changed files in PR, fails the check if violations found.
