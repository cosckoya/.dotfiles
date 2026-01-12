---
name: precommit-expert
description: Expert in pre-commit framework for git hooks, code quality validation, security scanning, and automated checks. Use when setting up pre-commit hooks, configuring linters, or implementing automated code quality gates.
---

# Pre-commit Expert Skill

Specialist in the pre-commit framework for automated code quality, security, and consistency checks.

## Core Capabilities

### Hook Configuration
- Writing `.pre-commit-config.yaml` configurations
- Selecting appropriate hooks for different languages
- Configuring hook execution order and dependencies
- Managing hook versions and updates
- Creating custom local hooks

### Standard Hook Categories

#### Code Quality
- **Formatting**: black, prettier, shfmt, terraform fmt
- **Linting**: flake8, eslint, shellcheck, yamllint, hadolint
- **Type Checking**: mypy, typescript
- **Import Sorting**: isort, organize-imports

#### Security
- **Secret Scanning**: gitleaks, detect-secrets, detect-aws-credentials
- **Dependency Scanning**: safety, pip-audit
- **Container Security**: trivy, checkov
- **SAST**: bandit, semgrep

#### Documentation
- **Markdown**: markdownlint, markdown-toc
- **Comments**: pydocstyle, jsdoc
- **Auto-generation**: terraform-docs, helm-docs

#### Git Hygiene
- **File Checks**: check-added-large-files, check-merge-conflict
- **Commit Messages**: commitizen, commitlint
- **Branch Protection**: check-branch-name
- **Whitespace**: trailing-whitespace, end-of-file-fixer, mixed-line-ending

#### Infrastructure as Code
- **Terraform**: tflint, tfsec, terraform-validate
- **Ansible**: ansible-lint
- **Kubernetes**: kubeval, kube-linter
- **Docker**: hadolint, dockerfile-lint

## Configuration Patterns

### Basic Setup
```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.5.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files
      - id: check-merge-conflict
```

### Shell/Bash Projects
```yaml
repos:
  - repo: https://github.com/shellcheck-py/shellcheck-py
    rev: v0.9.0.6
    hooks:
      - id: shellcheck
        args: ['-x']  # Follow sourced files

  - repo: https://github.com/scop/pre-commit-shfmt
    rev: v3.7.0-1
    hooks:
      - id: shfmt
        args: ['-i', '2', '-ci', '-sr']  # 2-space indent, switch cases, redirect
```

### Security-Focused
```yaml
repos:
  - repo: https://github.com/gitleaks/gitleaks
    rev: v8.18.0
    hooks:
      - id: gitleaks

  - repo: https://github.com/Yelp/detect-secrets
    rev: v1.4.0
    hooks:
      - id: detect-secrets
        args: ['--baseline', '.secrets.baseline']

  - repo: https://github.com/aquasecurity/trivy
    rev: v0.48.0
    hooks:
      - id: trivy-docker
      - id: trivy-config
```

### Infrastructure as Code
```yaml
repos:
  - repo: https://github.com/antonbabenko/pre-commit-terraform
    rev: v1.83.6
    hooks:
      - id: terraform_fmt
      - id: terraform_validate
      - id: terraform_tfsec
      - id: terraform_docs

  - repo: https://github.com/ansible/ansible-lint
    rev: v6.22.1
    hooks:
      - id: ansible-lint
```

### Custom Local Hooks
```yaml
repos:
  - repo: local
    hooks:
      - id: makefile-check
        name: Validate Makefile targets
        entry: make check
        language: system
        pass_filenames: false

      - id: no-debug-comments
        name: Check for debug comments
        entry: 'grep -rn "DEBUG\|FIXME\|XXX" --include="*.sh" --include="*.zsh"'
        language: system
        pass_filenames: false

      - id: zsh-syntax
        name: Check ZSH syntax
        entry: zsh -n
        language: system
        files: \.zsh$
```

## Integration Patterns

### Makefile Integration
```makefile
.PHONY: install-pre-commit
install-pre-commit: ## Install pre-commit hooks
	@command -v pre-commit &> /dev/null || pip install pre-commit
	@pre-commit install --install-hooks
	@pre-commit install --hook-type commit-msg
	@echo "✓ Pre-commit hooks installed"

.PHONY: pre-commit-update
pre-commit-update: ## Update pre-commit hooks to latest versions
	@pre-commit autoupdate
	@echo "✓ Pre-commit hooks updated"

.PHONY: pre-commit-run
pre-commit-run: ## Run pre-commit on all files
	@pre-commit run --all-files

.PHONY: pre-commit-clean
pre-commit-clean: ## Clean pre-commit cache
	@pre-commit clean
	@echo "✓ Pre-commit cache cleaned"
```

### CI/CD Integration
```yaml
# .github/workflows/pre-commit.yml
name: Pre-commit Checks
on: [push, pull_request]

jobs:
  pre-commit:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: '3.11'
      - uses: pre-commit/action@v3.0.0
```

## Advanced Features

### Stage-Specific Hooks
```yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.5.0
    hooks:
      - id: trailing-whitespace
        stages: [commit, push, manual]
      - id: check-added-large-files
        stages: [commit, push]
        args: ['--maxkb=1000']
```

### Language-Specific Environments
```yaml
repos:
  - repo: https://github.com/psf/black
    rev: 23.11.0
    hooks:
      - id: black
        language_version: python3.11
        additional_dependencies: ['click==8.0.0']
```

### File Filtering
```yaml
repos:
  - repo: https://github.com/shellcheck-py/shellcheck-py
    rev: v0.9.0.6
    hooks:
      - id: shellcheck
        files: \.(sh|bash|zsh)$
        exclude: ^(vendor/|third_party/)
```

## Best Practices

### Performance Optimization
- Use `stages` to separate fast vs slow hooks
- Leverage caching with proper `language` settings
- Use `files` regex to limit hook scope
- Consider `pass_filenames: false` for project-wide checks
- Run expensive hooks only on `push` or `manual` stages

### Security Considerations
- Always pin hook versions with `rev:`
- Regularly run `pre-commit autoupdate`
- Use `fail_fast: true` for critical security hooks
- Maintain `.secrets.baseline` for legitimate secrets
- Don't disable security hooks without review

### Team Adoption
- Document why each hook exists
- Provide auto-fix commands where possible
- Keep hook execution time < 10 seconds for commits
- Use `verbose: true` during initial rollout
- Create `make pre-commit-run` for manual execution

### Maintenance
- Review hook updates before applying
- Test hooks in CI/CD pipeline
- Monitor hook execution times
- Remove deprecated or unused hooks
- Keep configuration DRY with YAML anchors

## For This Project

### Recommended Setup for Dotfiles
```yaml
repos:
  # Basic hygiene
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.5.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files
      - id: check-merge-conflict
      - id: mixed-line-ending
        args: ['--fix=lf']

  # Shell quality
  - repo: https://github.com/shellcheck-py/shellcheck-py
    rev: v0.9.0.6
    hooks:
      - id: shellcheck
        files: \.(sh|bash|zsh)$

  - repo: https://github.com/scop/pre-commit-shfmt
    rev: v3.7.0-1
    hooks:
      - id: shfmt
        args: ['-i', '2', '-ci']

  # Security
  - repo: https://github.com/gitleaks/gitleaks
    rev: v8.18.0
    hooks:
      - id: gitleaks

  # Markdown
  - repo: https://github.com/igorshubovych/markdownlint-cli
    rev: v0.38.0
    hooks:
      - id: markdownlint
        args: ['--fix']

  # Custom checks
  - repo: local
    hooks:
      - id: zsh-syntax
        name: ZSH syntax check
        entry: zsh -n
        language: system
        files: \.zsh$

      - id: makefile-check
        name: Makefile syntax check
        entry: make -n
        language: system
        files: Makefile$
        pass_filenames: false
```

### Installation Commands
```bash
# Install pre-commit
make install-pre-commit

# Run on all files to test
make pre-commit-run

# Update to latest versions
make pre-commit-update
```

## Troubleshooting

### Common Issues

**Hooks failing in CI but passing locally**
- Ensure same pre-commit version
- Check for local git config differences
- Verify environment variables

**Slow hook execution**
- Use `pre-commit run --show-diff-on-failure`
- Profile with `time pre-commit run --all-files`
- Consider moving slow checks to CI only

**Hooks modifying files unexpectedly**
- Review auto-fix hooks (shfmt, black, prettier)
- Use `--show-diff-on-failure` to see changes
- Consider running formatters separately first

**Dependency conflicts**
- Use isolated environments per hook
- Pin specific versions in `additional_dependencies`
- Clear cache with `pre-commit clean`

## Resources

- Official docs: https://pre-commit.com/
- Hook repository: https://github.com/pre-commit/pre-commit-hooks
- Supported hooks: https://pre-commit.com/hooks.html
- Community hooks: Search "pre-commit-hooks" on GitHub
