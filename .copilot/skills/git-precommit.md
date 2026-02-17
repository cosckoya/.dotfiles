---
name: git-and-precommit-expertise
description: "Modern pre-commit hooks, git workflows, and code quality automation. 2026 standards with minimal dependencies."
category: version-control
priority: 80
token_cost_estimate: 2200
---

# Git & Pre-Commit Excellence (2026)

## Pre-Commit Framework (Modern Standards)

### 1. Configuration Structure
```yaml
# .pre-commit-config.yaml
default_language_version:
  python: python3.11
default_stages: [commit]

repos:
  # Native pre-commit hooks (no dependencies)
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.5.0
    hooks:
      - id: check-merge-conflict
      - id: end-of-file-fixer
      - id: trailing-whitespace
      - id: check-yaml
      - id: check-added-large-files
        args: ['--maxkb=1024']
        exclude: ^img/
      - id: detect-private-key
      - id: mixed-line-ending
```

### 2. Modern Hooks (2026 Recommended)

#### File Integrity
```yaml
- id: check-merge-conflict     # Prevents merge markers
- id: end-of-file-fixer        # Ensures newline at EOF
- id: trailing-whitespace      # Removes trailing spaces
- id: mixed-line-ending        # Enforces consistent line endings
```

#### Large File Prevention
```yaml
- id: check-added-large-files
  args: ['--maxkb=1024']        # 1MB limit
  exclude: ^img/|\.lock$        # Exceptions
```

#### Security
```yaml
- id: detect-private-key       # Prevents accidental secrets
  stages: [commit]             # Run before commit only
```

#### Language-Specific
```yaml
- repo: https://github.com/shellcheck-py/shellcheck-py
  rev: v0.9.0
  hooks:
    - id: shellcheck
      args: [--severity=warning]
      exclude: ^scripts/legacy/

- repo: https://github.com/adrienverge/yamllint
  rev: v1.33.0
  hooks:
    - id: yamllint
      args: [--relaxed]
```

### 3. Makefile Linting (Optional)
```yaml
- repo: https://github.com/adrienverge/checkmake
  rev: 0.13.0
  hooks:
    - id: checkmake
      stages: [manual]         # Optional: run with `pre-commit run --hook-stage manual`
```

**Note**: `checkmake` is optional; gracefully skip if not installed.

### 4. Skip Configuration
```yaml
# Skip specific hooks per file
# In commit message: [skip: shellcheck]

# Skip specific hooks per repo
exclude: ^(\.git/|\.venv/|node_modules/)

# Skip for specific extensions
types_or: [shell, python]  # Only run on these types
```

## Git Workflow (2026 Standards)

### 1. Commit Message Format
```
<type>(<scope>): <subject>

<body>

<footer>

# Types: feat, fix, refactor, perf, docs, style, test, chore
# Example: feat(zsh): improve lazy-loading performance
```

### 2. Branch Naming
```
feature/description        # New features
fix/description           # Bug fixes
refactor/description      # Code improvements
perf/description          # Performance optimizations
docs/description          # Documentation
```

### 3. Atomic Commits
- One change per commit
- Each commit should work independently
- Write clear, descriptive messages
- Avoid "WIP" commits in main branches

## Integration with Dotfiles Project

### Current Hooks Setup
```yaml
# Located in .pre-commit-config.yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    hooks:
      - check-merge-conflict
      - end-of-file-fixer
      - trailing-whitespace
      - check-yaml
      - check-added-large-files
      - check-case-conflict
      - detect-private-key
      - mixed-line-ending
  
  - repo: https://github.com/adrienverge/checkmake
    hooks:
      - checkmake (optional, graceful skip)
```

### Installation
```bash
# Install pre-commit framework
pip install pre-commit

# Setup hooks in git
pre-commit install

# Run all checks
pre-commit run --all-files

# Run specific hook
pre-commit run end-of-file-fixer --all-files
```

### Validation
```bash
# Test pre-commit setup
pre-commit run --all-files

# Validate specific files
pre-commit run --files zshrc zsh.d/*.zsh

# Skip hooks (when necessary, not recommended)
git commit --no-verify
```

## Anti-Patterns (Don't Do This)

- ❌ Adding too many hooks (slows down commits)
- ❌ Hooks with network dependencies (unreliable)
- ❌ Misconfigured language versions (causes failures)
- ❌ Not excluding generated files (unnecessary noise)
- ❌ Running heavy linters in pre-commit (use CI/CD instead)
- ❌ Ignoring hook failures with --no-verify
- ❌ Not documenting why hooks are skipped

## Best Practices

✅ **Keep hooks fast** (< 5 seconds total)
✅ **Fail fast** (prioritize quick checks first)
✅ **Provide clear error messages** (explain what failed)
✅ **Make fixes automatic** (end-of-file-fixer, trailing-whitespace)
✅ **Document skip instructions** (when hooks need to be bypassed)
✅ **Test locally** (before pushing to main)
✅ **Graceful degradation** (skip if optional tool missing)

## 2026 Optimization

### Token-Efficient Configuration
- Minimal required hooks only
- No redundant checks with CI/CD
- Exclude patterns reduce unnecessary runs
- Optional hooks via `stages: [manual]`

### Performance
- Native hooks: fastest (bash/Python)
- Selective type checking: avoid all files
- Exclude common paths: .git/, node_modules/, .venv/
- Late-stage hooks: use CI/CD for heavy checks

### Maintenance
- Review hooks quarterly
- Remove unused hooks
- Update hook versions regularly
- Monitor for breaking changes
