---
name: modern-makefile-design
description: "GNU Make 4.3+ expert. Idempotent targets, color output, dependency management, and installation orchestration."
category: build-automation
priority: 85
token_cost_estimate: 2500
---

# Modern Makefile Design Skill

## 2026 Standards

### 1. Idempotency First
Every target must be safe to run multiple times without side effects.

```makefile
.PHONY: zsh
zsh: ## Install ZSH configuration
	@mkdir -p $(ZSH_DIR)
	@cp zshrc $(HOME)/.zshrc
	@if ! grep -q "zsh" /etc/shells; then \
		echo "/bin/zsh" | sudo tee -a /etc/shells; \
	fi
	@chsh -s /bin/zsh 2>/dev/null || true
	@echo "✓ ZSH configured"
```

**Key patterns:**
- `@mkdir -p` (idempotent create)
- `if ! grep -q` (check before modify)
- `|| true` (suppress harmless errors)
- `@` prefix (suppress command echo)

### 2. Color-Coded Output (2026)
```makefile
# Color definitions
RED     := \033[0;31m
GREEN   := \033[0;32m
YELLOW  := \033[0;33m
BLUE    := \033[0;34m
NC      := \033[0m  # No Color

# Usage
@echo "$(GREEN)✓$(NC) Target completed"
@echo "$(YELLOW)⚠$(NC) Warning message"
@echo "$(BLUE)→$(NC) Processing step"
```

### 3. Help System
```makefile
help: ## Show this help message
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "} {printf "  %-20s %s\n", $$1, $$2}'
	@echo ""
	@echo "Usage: make [target]"
```

### 4. Dependency Management
```makefile
.PHONY: all install-nvim neovim
all: zsh tmux kitty asdf

install-nvim: ## Install Neovim via snap
	@command -v snap >/dev/null || \
		(echo "$(RED)✗$(NC) snap not found"; exit 1)
	@sudo snap install nvim --classic || true

neovim: install-nvim ## Configure Neovim (requires nvim 0.11+)
	@mkdir -p $(NVIM_DIR)
	@cp -r config/nvim/* $(NVIM_DIR)/
	@echo "$(GREEN)✓$(NC) Neovim configured"
```

### 5. Conditional Execution
```makefile
# Check for required tools
check-git:
	@command -v git >/dev/null || \
		(echo "$(RED)✗ Git required$(NC)"; exit 1)

# Check for optional tools
check-fzf:
	@if command -v fzf >/dev/null; then \
		echo "$(GREEN)✓ fzf found$(NC)"; \
	else \
		echo "$(YELLOW)⚠ fzf not installed (optional)$(NC)"; \
	fi
```

### 6. Safe Installation Pattern
```makefile
INSTALL_DIR := $(HOME)/.dotfiles
BACKUP_DIR := $(HOME)/.dotfiles.bak

backup: ## Backup existing config
	@if [ -d "$(INSTALL_DIR)" ]; then \
		cp -r $(INSTALL_DIR) $(BACKUP_DIR).$(shell date +%s); \
		echo "$(GREEN)✓$(NC) Backup created at $(BACKUP_DIR).*"; \
	fi

restore: ## Restore from backup
	@ls -dt $(BACKUP_DIR).* 2>/dev/null | head -1 | \
		xargs -I{} cp -r {} $(INSTALL_DIR)
	@echo "$(GREEN)✓$(NC) Restored from backup"
```

### 7. Variable Organization
```makefile
# Paths
SHELL := /bin/bash
HOME := $(shell echo ~)
ZSH_DIR := $(HOME)/.config/zsh
NVIM_DIR := $(HOME)/.config/nvim
TMUX_CONFIG := $(HOME)/.tmux.conf

# Tools
GIT := $(shell command -v git 2>/dev/null)
ZSH := $(shell command -v zsh 2>/dev/null)
MAKE_VERSION := $(shell make --version | head -1)
```

## 2026 Best Practices Checklist

- [ ] All targets are idempotent
- [ ] Uses `.PHONY` for non-file targets
- [ ] Includes dependency ordering
- [ ] Has comprehensive help system
- [ ] Uses color-coded output
- [ ] Includes safety checks (`command -v`, `-d` checks)
- [ ] Error messages are clear and actionable
- [ ] Backup/restore capability for critical operations
- [ ] No hardcoded paths (use variables)
- [ ] Single responsibility per target
- [ ] Comments explain "why", not "what"

## Anti-Patterns to Avoid

- Unprotected `sudo` commands without checks
- Assuming tools exist without verification
- Creating files without `mkdir -p` first
- Non-idempotent targets (can't run twice safely)
- Complex nested conditionals (use helper functions)
- Hardcoded paths instead of variables
- Missing `.PHONY` declarations
- No error handling or validation

## Integration with Project
- Primary orchestrator for all installations
- Works with both local and CI/CD environments
- Compatible with `sudo` and non-sudo workflows
- Supports offline operation when possible
- Integrates with pre-commit hooks
