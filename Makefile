.ONESHELL:
SHELL := /bin/bash
.PHONY: help all profile zsh tmux kitty neovim tools asdf
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

tools: ## Install development tools
	$(MAKE) all -C tools

asdf: ## Install asdf (always latest version)
	@echo "$(BOLD)$(GREEN)Installing/Updating ASDF$(RESET)"
	@set -e; \
	ASDF_VERSION=$$(curl -s https://api.github.com/repos/asdf-vm/asdf/releases/latest | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/'); \
	if [ -z "$$ASDF_VERSION" ]; then \
		echo "$(RED)Failed to fetch latest ASDF version$(RESET)"; \
		exit 1; \
	fi; \
	echo "Latest ASDF version: $$ASDF_VERSION"; \
	if [ -f ${HOME}/.asdf/asdf.sh ]; then \
		CURRENT_VERSION=$$(${HOME}/.asdf/bin/asdf version 2>/dev/null | awk '{print $$1}' | sed 's/v//'); \
		if [ "$$CURRENT_VERSION" = "$$ASDF_VERSION" ]; then \
			echo "$(GREEN)ASDF is already up to date (v$$ASDF_VERSION)$(RESET)"; \
			exit 0; \
		else \
			echo "$(YELLOW)Updating ASDF from v$$CURRENT_VERSION to v$$ASDF_VERSION$(RESET)"; \
		fi; \
	fi; \
	mkdir -p ${HOME}/.asdf; \
	wget -q "https://github.com/asdf-vm/asdf/releases/download/v$$ASDF_VERSION/asdf-v$$ASDF_VERSION-linux-$(ARCH).tar.gz" -O ${HOME}/asdf-linux.tar.gz; \
	tar -xzf ${HOME}/asdf-linux.tar.gz -C ${HOME}/.asdf --strip-components=1; \
	rm ${HOME}/asdf-linux.tar.gz; \
	if [ ! -d ${HOME}/bin ]; then mkdir -p ${HOME}/bin; fi; \
	ln -sf ${HOME}/.asdf/bin/asdf ${HOME}/bin/asdf; \
	echo "$(GREEN)ASDF v$$ASDF_VERSION installation completed successfully$(RESET)"

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

neovim: ## Install Vim/Neovim profile
	@echo "$(BOLD)Setting up NeoVIM$(RESET)"
	@set -e; \
	mkdir -p ${HOME}/.config/nvim; \
	ln -s -f ${DOTFILES}/vimrc ${HOME}/.config/nvim/init.vim; \
	ln -s -f ${DOTFILES}/vimrc ${HOME}/.vimrc; \
	echo "$(GREEN)NeoVIM configured$(RESET)"

tmux: ## Install TMUX profile
	@echo "$(BOLD)Setting up TMUX$(RESET)"
	@set -e; \
	if ! command -v tmux >/dev/null 2>&1; then \
		echo "$(YELLOW)Warning: tmux is not installed$(RESET)"; \
	fi; \
	ln -s -f ${DOTFILES}/tmux.conf ${HOME}/.tmux.conf; \
	echo "$(GREEN)TMUX configured (unified configuration)$(RESET)"

kitty: ## Install Kitty terminal profile
	@echo "$(BOLD)Setting up Kitty Terminal$(RESET)"
	@set -e; \
	if ! command -v kitty >/dev/null 2>&1; then \
		echo "$(YELLOW)Warning: kitty is not installed$(RESET)"; \
	fi; \
	mkdir -p ${HOME}/.config/kitty/themes; \
	ln -s -f ${DOTFILES}/kitty.conf ${HOME}/.config/kitty/kitty.conf; \
	if [ ! -f ${HOME}/.config/kitty/themes/Royal.conf ]; then \
		echo "$(YELLOW)Downloading Royal theme...$(RESET)"; \
		curl -s https://raw.githubusercontent.com/dexpota/kitty-themes/master/themes/Royal.conf \
			-o ${HOME}/.config/kitty/themes/Royal.conf || echo "$(YELLOW)Theme download optional$(RESET)"; \
	fi; \
	echo "$(GREEN)Kitty configured with Royal theme$(RESET)"
