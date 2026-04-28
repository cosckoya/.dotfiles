.ONESHELL:
SHELL := /bin/bash
.PHONY: help all profile zsh tmux kitty neovim install-nvim mise clean pre-commit-setup
.DEFAULT_GOAL := help

OS := $(shell uname -s | tr '[:upper:]' '[:lower:]')
DOTFILES := $(shell pwd)

help: ## Shows this makefile help
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: mise profile ## Install everything

profile: zsh tmux kitty neovim ## Install ZSH, Tmux, Kitty, and Neovim profiles

mise: ## Install mise (runtime version manager, faster than ASDF)
	@command -v mise >/dev/null || { \
		echo "Installing mise..."; \
		curl -L https://mise.jdx.dev/install.sh | sh; \
		echo "Mise installed"; \
	} || echo "Mise already installed"

zsh: ## Install ZSH profile
	@set -e; \
	command -v zsh >/dev/null || { echo "Error: Install zsh first"; exit 1; }
ifeq ($(OS), linux)
	@USER=$$(whoami); \
	if [ "$$(getent passwd $$USER | cut -d: -f7)" != "/bin/zsh" ]; then \
		sudo usermod -s /bin/zsh $$USER; \
	fi
endif
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
