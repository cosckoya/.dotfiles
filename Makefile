.ONESHELL:
SHELL := /bin/bash
.PHONY: help all profile zsh tmux kitty neovim install-nvim asdf
.DEFAULT_GOAL := help
CURRENT_FOLDER := $(shell basename "$$(pwd)")
BOLD := $(shell tput bold)
RED := $(shell tput setaf 1)
GREEN := $(shell tput setaf 2)
YELLOW := $(shell tput setaf 3)
RESET := $(shell tput sgr0)

## Global
NAME := main
VERSION := scratch
OS := $(shell uname -s | tr '[:upper:]' '[:lower:]')
ARCH := $(shell uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$$/arm64/')
USER := $(shell whoami)

## Paths
DOTFILES := $(shell pwd)

## Burn, baby, burn
help: ## Shows this makefile help
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: asdf profile ## Install everything
	@echo "$(BOLD)$(GREEN)All installation completed successfully$(RESET)"

profile: zsh tmux kitty neovim ## Install ZSH, Tmux, Kitty, and Neovim profiles
	@echo "$(BOLD)$(GREEN)Profile installation completed$(RESET)"

# tools: ## Install development tools
# 	$(MAKE) all -C tools
# Note: tools/ directory removed, target disabled

asdf: ## Install asdf (always latest version)
	@echo "$(BOLD)$(GREEN)Installing/Updating ASDF$(RESET)"
	@set -e; \
	ASDF_VERSION=$$(curl -s https://api.github.com/repos/asdf-vm/asdf/releases/latest | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/'); \
	if [ -z "$$ASDF_VERSION" ]; then \
		echo "$(RED)Failed to fetch latest ASDF version$(RESET)"; \
		exit 1; \
	fi; \
	echo "Latest ASDF version: $$ASDF_VERSION"; \
	if [ -f ${HOME}/bin/asdf ]; then \
		CURRENT_VERSION=$$(${HOME}/bin/asdf version 2>/dev/null | awk '{print $$1}' | sed 's/v//'); \
		if [ "$$CURRENT_VERSION" = "$$ASDF_VERSION" ]; then \
			echo "$(GREEN)ASDF is already up to date (v$$ASDF_VERSION)$(RESET)"; \
			exit 0; \
		else \
			echo "$(YELLOW)Updating ASDF from v$$CURRENT_VERSION to v$$ASDF_VERSION$(RESET)"; \
		fi; \
	fi; \
	mkdir -p ${HOME}/bin ${HOME}/.asdf; \
	echo "Downloading ASDF v$$ASDF_VERSION..."; \
	wget -q "https://github.com/asdf-vm/asdf/releases/download/v$$ASDF_VERSION/asdf-v$$ASDF_VERSION-linux-$(ARCH).tar.gz" -O /tmp/asdf-linux.tar.gz; \
	tar -xzf /tmp/asdf-linux.tar.gz -C /tmp; \
	mv /tmp/asdf ${HOME}/bin/asdf; \
	chmod +x ${HOME}/bin/asdf; \
	rm -f /tmp/asdf-linux.tar.gz; \
	echo "$(GREEN)ASDF v$$ASDF_VERSION installed successfully$(RESET)"; \
	echo "Binary location: ${HOME}/bin/asdf"; \
	echo "Data directory: ${HOME}/.asdf"

zsh: ## Install ZSH profile
	@echo "$(BOLD)Setting up ZSH shell$(RESET)"
	@set -e; \
	if ! command -v zsh >/dev/null 2>&1; then \
		echo "$(RED)Error: ZSH is not installed. Please install it first.$(RESET)"; \
		exit 1; \
	fi
ifeq ($(OS), linux)
	@if [ "$$(getent passwd ${USER} | cut -d: -f7)" != "/bin/zsh" ]; then \
		echo "Setting ZSH as default shell for user"; \
		sudo usermod -s /bin/zsh ${USER}; \
	else \
		echo "$(YELLOW)ZSH is already the default shell$(RESET)"; \
	fi
endif
	@rm -f ${HOME}/.zshrc ${HOME}/.zsh.d
	@ln -s -f ${DOTFILES}/zshrc ${HOME}/.zshrc
	@ln -s -f ${DOTFILES}/zsh.d ${HOME}/.zsh.d
	@echo "$(GREEN)ZSH configured$(RESET)"

install-nvim: ## Install Neovim via snap (requires sudo)
	@echo "$(BOLD)Installing Neovim via snap$(RESET)"
	@if ! command -v snap >/dev/null 2>&1; then \
		echo "$(RED)Error: snapd is not installed$(RESET)"; \
		echo "Install with: sudo apt install snapd"; \
		exit 1; \
	fi; \
	sudo snap install nvim --classic; \
	nvim --version | head -1; \
	echo "$(GREEN)Neovim installed successfully$(RESET)"

neovim: ## Install Neovim Lua profile
	@echo "$(BOLD)Setting up NeoVIM (Lua)$(RESET)"
	@set -e; \
	if ! command -v nvim >/dev/null 2>&1; then \
		echo "$(RED)Error: Neovim is not installed$(RESET)"; \
		echo "$(YELLOW)Install with: make install-nvim$(RESET)"; \
		exit 1; \
	fi; \
	NVIM_MAJOR=$$(nvim --version | head -1 | sed 's/NVIM v//' | cut -d'.' -f1); \
	NVIM_MINOR=$$(nvim --version | head -1 | sed 's/NVIM v//' | cut -d'.' -f2); \
	if [ "$$NVIM_MAJOR" -eq 0 ] && [ "$$NVIM_MINOR" -lt 11 ]; then \
		echo "$(RED)Error: Neovim 0.11+ required (found $$(nvim --version | head -1))$(RESET)"; \
		echo "$(YELLOW)Update with: make install-nvim$(RESET)"; \
		exit 1; \
	fi; \
	rm -rf ${HOME}/.config/nvim; \
	ln -s ${DOTFILES}/config/nvim ${HOME}/.config/nvim; \
	ln -s -f ${DOTFILES}/vimrc ${HOME}/.vimrc; \
	echo "$(GREEN)NeoVIM Lua configured$(RESET)"; \
	echo "$(YELLOW)Run 'nvim' to auto-install plugins via lazy.nvim (first launch may take a moment)$(RESET)"

tmux: ## Install TMUX profile
	@echo "$(BOLD)Setting up TMUX$(RESET)"
	@set -e; \
	if ! command -v tmux >/dev/null 2>&1; then \
		echo "$(YELLOW)Warning: tmux is not installed$(RESET)"; \
	fi; \
	ln -s -f ${DOTFILES}/config/tmux.conf ${HOME}/.tmux.conf; \
	echo "$(GREEN)TMUX configured (unified configuration)$(RESET)"

kitty: ## Install Kitty terminal profile
	@echo "$(BOLD)Setting up Kitty Terminal$(RESET)"
	@set -e; \
	if ! command -v kitty >/dev/null 2>&1; then \
		echo "$(YELLOW)Warning: kitty is not installed$(RESET)"; \
	fi; \
	mkdir -p ${HOME}/.config/kitty; \
	ln -s -f ${DOTFILES}/config/kitty.conf ${HOME}/.config/kitty/kitty.conf; \
	echo "$(GREEN)Kitty configured with Tokyo Night theme$(RESET)"
