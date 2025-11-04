# Makefile Best Practices & Tools

This document outlines the Makefile best practices implemented in this repository and the tools used to enforce them.

## Tools Installed

### 1. **checkmake** - Makefile Linter
A linter for Makefiles that checks for common issues and best practices.

**Installation:**
```bash
make checkmake -C tools
```

**Usage:**
```bash
checkmake Makefile
checkmake --config=.checkmake Makefile
```

**Rules checked:**
- ✅ `.PHONY` declarations
- ✅ Phony targets properly declared
- ✅ Timestamp expansion warnings
- ✅ Escaped dollar signs
- ✅ Portability issues

### 2. **Pre-commit Hooks**
Automated checks run before each commit.

**Installation:**
```bash
make pre-commit -C tools
pre-commit install
```

**Hooks configured:**
1. **makefile-doc** - Auto-generates README documentation from Makefile help
2. **makefile-syntax** - Validates Makefile syntax
3. **checkmake** - Lints Makefiles for best practices
4. Standard code quality checks (trailing whitespace, YAML validation, etc.)

## Best Practices Implemented

### 1. **Variable Assignment**
```makefile
# ✅ Good - Use := for immediate expansion
SHELL := /bin/bash
NAME := myproject
VERSION := $(shell git describe --tags)

# ❌ Bad - Avoid = for performance
SHELL = /bin/bash
```

### 2. **SHELL Declaration**
```makefile
# ✅ Correct
SHELL := /bin/bash

# ❌ Incorrect (dot prefix is wrong)
.SHELL := /bin/bash
```

### 3. **.PHONY Targets**
```makefile
# ✅ Declare all non-file targets
.PHONY: help all clean install test

help: ## Show help
all: build test
clean: ## Clean build artifacts
```

### 4. **.ONESHELL**
```makefile
# ✅ Execute all recipe lines in single shell
.ONESHELL:
SHELL := /bin/bash

target:
	set -e
	echo "Line 1"
	echo "Line 2"
```

### 5. **Error Handling**
```makefile
# ✅ Fail fast on errors
target:
	@set -e; \
	command1; \
	command2; \
	command3

# ✅ Or use .SHELLFLAGS
.SHELLFLAGS := -euo pipefail -c
```

### 6. **Help Documentation**
```makefile
# ✅ Self-documenting Makefiles
help: ## Shows this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	sort | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: ## Install dependencies
build: ## Build the project
test: ## Run tests
```

### 7. **Idempotency**
```makefile
# ✅ Check before installing
install-tool:
	@if command -v tool >/dev/null 2>&1; then \
		echo "Tool already installed"; \
	else \
		wget -q https://example.com/tool; \
		chmod +x tool; \
	fi
```

### 8. **Color Output**
```makefile
# ✅ Use colors for better UX
BOLD := $(shell tput bold)
RED := $(shell tput setaf 1)
GREEN := $(shell tput setaf 2)
YELLOW := $(shell tput setaf 3)
RESET := $(shell tput sgr0)

success:
	@echo "$(GREEN)Success!$(RESET)"

error:
	@echo "$(RED)Error!$(RESET)"
```

### 9. **Prerequisite Checks**
```makefile
# ✅ Verify dependencies before running
check-docker:
	@command -v docker >/dev/null 2>&1 || { \
		echo "$(RED)Error: docker not installed$(RESET)"; \
		exit 1; \
	}

deploy: check-docker
	docker build -t myapp .
```

### 10. **Dynamic Version Fetching**
```makefile
# ✅ Always get latest version
install-tool:
	@LATEST=$$(curl -s https://api.github.com/repos/user/repo/releases/latest | \
		grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/'); \
	wget "https://github.com/user/repo/releases/download/$$LATEST/tool"
```

## Common Issues & Solutions

### Issue 1: `asdf global` is deprecated
**Solution:** Use `asdf set --home` instead
```makefile
# ❌ Old
asdf global nodejs latest

# ✅ New (v0.18+)
asdf set --home nodejs latest
```

### Issue 2: `asdf plugin-add` (with hyphen)
**Solution:** Use `asdf plugin add` (with space)
```makefile
# ❌ Old
asdf plugin-add nodejs

# ✅ New (v0.18+)
asdf plugin add nodejs
```

### Issue 3: Trailing whitespace
**Solution:** Use pre-commit hooks to auto-fix
```yaml
# .pre-commit-config.yaml
- id: trailing-whitespace
```

### Issue 4: Silent failures
**Solution:** Use `set -e` or check exit codes
```makefile
# ✅ Fail on first error
target:
	@set -e; \
	command1; \
	command2
```

## Running Checks

### Manual Checks
```bash
# Check syntax
make -n help

# Lint with checkmake
checkmake Makefile

# Run all pre-commit hooks
pre-commit run --all-files
```

### Automatic Checks
All checks run automatically on:
- Every commit (via pre-commit hooks)
- CI/CD pipelines (if configured)

## Configuration Files

### `.checkmake`
Customize checkmake rules per repository needs.

### `.pre-commit-config.yaml`
Configure pre-commit hooks and their behavior.

## Resources

- [GNU Make Manual](https://www.gnu.org/software/make/manual/)
- [checkmake](https://github.com/checkmake/checkmake)
- [ASDF Documentation](https://asdf-vm.com/)
- [Pre-commit](https://pre-commit.com/)

## Quick Reference

```bash
# Install all tools
make all -C tools

# Check Makefile quality
checkmake Makefile

# Update documentation
pre-commit run makefile-doc --all-files

# Validate all Makefiles
find . -name Makefile -exec make -n -f {} help \; >/dev/null
```
