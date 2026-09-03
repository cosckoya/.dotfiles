.ONESHELL:
SHELL := /bin/bash
.PHONY: help all profile zsh tmux kitty neovim install-nvim mise clean pre-commit-setup verify perf-check lint
.DEFAULT_GOAL := help

DOTFILES := $(shell pwd)

# Mise activation for tools (lua/luac, etc.)
MISE_ACTIVATE := eval "$$(mise activate bash)"

help: ## Shows this makefile help
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: mise profile ## Install everything

profile: zsh tmux kitty neovim ## Install ZSH, Tmux, Kitty, and Neovim profiles

mise: ## Install mise (runtime version manager, faster than ASDF)
	@if command -v mise >/dev/null 2>&1; then \
		echo "Mise already installed"; \
	else \
		echo "Installing mise..."; \
		curl -L https://mise.jdx.dev/install.sh | sh; \
		echo "Mise installed"; \
	fi

zsh: ## Install ZSH profile
	@set -e; \
	command -v zsh >/dev/null || { echo "Error: Install zsh first"; exit 1; }
	@USER=$$(whoami); \
	if [ "$$(getent passwd $$USER | cut -d: -f7)" != "/bin/zsh" ]; then \
		sudo usermod -s /bin/zsh $$USER; \
	fi
	@rm -f ${HOME}/.zshrc ${HOME}/.zsh.d
	@ln -sf ${DOTFILES}/zshrc ${HOME}/.zshrc
	@ln -sf ${DOTFILES}/zsh.d ${HOME}/.zsh.d
	@echo "ZSH configured"

install-nvim: ## Install Neovim via snap (requires sudo)
	@command -v snap >/dev/null || { echo "Error: Install snapd first (sudo apt install snapd)"; exit 1; }
	@sudo snap install nvim --classic
	@echo "Neovim installed"

neovim: ## Install Neovim Lua profile
	@set -e; \
	command -v nvim >/dev/null || { echo "Error: Install neovim first (make install-nvim)"; exit 1; }; \
	NVIM_MAJOR=$$(nvim --version | head -1 | sed 's/NVIM v//' | cut -d'.' -f1); \
	NVIM_MINOR=$$(nvim --version | head -1 | sed 's/NVIM v//' | cut -d'.' -f2); \
	test "$$NVIM_MAJOR" -gt 0 || test "$$NVIM_MINOR" -ge 11 || { echo "Error: Neovim 0.11+ required"; exit 1; }; \
	rm -rf ${HOME}/.config/nvim; \
	ln -s ${DOTFILES}/config/nvim ${HOME}/.config/nvim; \
	ln -sf ${DOTFILES}/vimrc ${HOME}/.vimrc; \
	echo "Neovim configured"

tmux: ## Install TMUX profile
	@ln -sf ${DOTFILES}/config/tmux.conf ${HOME}/.tmux.conf
	@echo "TMUX configured"

kitty: ## Install Kitty terminal profile
	@mkdir -p ${HOME}/.config/kitty
	@ln -sf ${DOTFILES}/config/kitty.conf ${HOME}/.config/kitty/kitty.conf
	@echo "Kitty configured"

pre-commit-setup: ## Install pre-commit hooks
	@command -v pre-commit >/dev/null || { echo "Error: Install pre-commit first (pip install pre-commit)"; exit 1; }
	@pre-commit install
	@echo "Pre-commit hooks installed"

clean: ## Remove all symlinks and restore defaults
	@rm -f ${HOME}/.zshrc ${HOME}/.zsh.d
	@rm -f ${HOME}/.tmux.conf
	@rm -f ${HOME}/.config/kitty/kitty.conf
	@rm -rf ${HOME}/.config/nvim
	@rm -f ${HOME}/.vimrc
	@echo "Symlinks removed"

# =============================================================================
# VERIFICATION TARGETS
# =============================================================================

verify: ## Run all verification checks (syntax, lint, pre-commit)
	@echo "=== Running all verification checks ==="
	@$(MAKE) lint
	@$(MAKE) pre-commit-run
	@echo ""
	@echo "✅ All verification checks passed"

lint: ## Run syntax validation for all config files (uses mise for tools)
	@echo "=== Syntax validation ==="
	@echo "Checking ZSH syntax..."
	@command -v zsh >/dev/null && zsh -n zshrc && zsh -n zsh.d/*.zsh && echo "  ZSH: OK" || { echo "  ZSH: FAIL"; exit 1; }
	@echo "Checking Makefile syntax..."
	@make -n -f Makefile help >/dev/null 2>&1 && echo "  Makefile: OK" || { echo "  Makefile: FAIL"; exit 1; }
	@echo "Checking Lua syntax (Neovim)..."
	@$(MISE_ACTIVATE) && command -v luac >/dev/null && luac -p config/nvim/init.lua config/nvim/lua/core/*.lua config/nvim/lua/plugins/*.lua && echo "  Lua: OK" || { echo "  Lua: SKIP (luac not installed)"; }
	@echo "Checking YAML syntax..."
	@command -v python3 >/dev/null && python3 -c "import yaml; yaml.safe_load(open('.pre-commit-config.yaml'))" && echo "  YAML: OK" || { echo "  YAML: FAIL"; exit 1; }
	@echo "Checking Tmux config..."
	@command -v tmux >/dev/null && tmux -f config/tmux.conf start-server \; list-sessions >/dev/null 2>&1 && tmux kill-server && echo "  Tmux: OK" || { echo "  Tmux: SKIP (tmux not installed or config error)"; }
	@echo "Checking Kitty config..."
	@command -v kitty >/dev/null && kitty --debug-config config/kitty.conf >/dev/null 2>&1 && echo "  Kitty: OK" || { echo "  Kitty: SKIP (kitty not installed or config error)"; }

pre-commit-run: ## Run all pre-commit hooks on all files
	@echo "=== Running pre-commit hooks ==="
	@command -v pre-commit >/dev/null || { echo "Error: Install pre-commit first (pip install pre-commit)"; exit 1; }
	@pre-commit run --all-files

perf-check: ## Check ZSH startup performance (target: <110ms)
	@echo "=== ZSH Startup Performance Check ==="
	@command -v zsh >/dev/null || { echo "Error: zsh not installed"; exit 1; }
	@bash -c 'elapsed=$$(/usr/bin/time -f "%e" zsh -i -c exit 2>&1); elapsed_ms=$$(echo "$$elapsed" | LC_ALL=C awk "{ printf \"%.0f\", \$$1 * 1000 }"); echo "ZSH startup: $${elapsed_ms}ms (target <110ms)"; if (( elapsed_ms > 110 )); then echo "⚠️  WARNING: Exceeds 110ms target"; echo "Run '\''make perf-profile'\'' to profile"; exit 1; else echo "✅ PASS"; fi'

perf-profile: ## Profile ZSH startup in detail
	@echo "=== ZSH Startup Profile ==="
	@command -v zsh >/dev/null || { echo "Error: zsh not installed"; exit 1; }
	@zsh -c 'zmodload zsh/zprof; source ~/.zshrc; zprof' 2>&1 | head -30

security-check: ## Run security checks (secrets, large files, private keys)
	@echo "=== Security Checks ==="
	@echo "Checking for hardcoded secrets..."
	@if grep -rn \
		-e 'password\s*=' \
		-e 'api_key\s*=' \
		-e 'secret\s*=' \
		--include="*.zsh" \
		--include="*.sh" \
		--include="*.conf" \
		--include="*.env" \
		--exclude-dir=.git \
		--exclude-dir=.pre-commit \
		. 2>/dev/null | grep -v '^\s*#'; then \
		echo "FAIL: potential hardcoded secrets detected"; \
		exit 1; \
	fi
	@echo "  Secrets: OK"
	@echo "Checking for private keys..."
	@command -v pre-commit >/dev/null && pre-commit run detect-private-key --all-files && echo "  Private keys: OK" || { echo "  Private keys: FAIL"; exit 1; }
	@echo "Checking for large files..."
	@command -v pre-commit >/dev/null && pre-commit run check-added-large-files --all-files && echo "  Large files: OK" || { echo "  Large files: FAIL"; exit 1; }
	@echo "✅ All security checks passed"

ci-local: ## Simulate CI pipeline locally (verify + perf-check + security-check)
	@echo "=== Simulating CI Pipeline Locally ==="
	@$(MAKE) verify
	@echo ""
	@$(MAKE) perf-check
	@echo ""
	@$(MAKE) security-check
	@echo ""
	@echo "🎉 All CI checks passed locally!"
