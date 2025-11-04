.ONESHELL:
SHELL := /bin/bash
.PHONY: help all profile zsh tmux neovim
.DEFAULT_GOAL := help
CURRENT_FOLDER := $(shell basename "$$(pwd)")
BOLD := $(shell tput bold)
RED := $(shell tput setaf 1)
GREEN := $(shell tput setaf 2)
YELLOW := $(shell tput setaf 3)
RESET := $(shell tput sgr0)

## Global
NAME := profile
VERSION := scratch
OS := $(shell uname -s)

## Paths
DOTFILES := ${HOME}/.dotfiles
PROFILE := ${DOTFILES}/profile

## Burn, baby, burn
help: ## Shows this makefile help
	@echo ""
	@echo "Klaatu Barata Nitko!"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: profile ## Install Profile, IaC, Cloud and terminal addons
	@echo "$(BOLD)$(GREEN)Local environment successfully configured$(RESET)"

## Profile Settings
profile: zsh tmux neovim ## Install ZSH, TMUX and Vim/Neovim plugins and profiles
	@echo "$(BOLD)$(GREEN)Custom profile ready to rumble. Enjoy!$(RESET)"

zsh: ## Install ZSH profile
	@echo "$(BOLD)Setting up ZSH shell$(RESET)"
	@set -e; \
	if ! command -v zsh >/dev/null 2>&1; then \
		echo "$(RED)Error: ZSH is not installed. Please install it first.$(RESET)"; \
		exit 1; \
	fi
ifeq ($(OS), Linux)
	@if [ "$$(getent passwd ${USER} | cut -d: -f7)" != "/bin/zsh" ]; then \
		echo "Setting ZSH as default shell for user"; \
		sudo usermod --shell /bin/zsh ${USER}; \
	else \
		echo "$(YELLOW)ZSH is already the default shell$(RESET)"; \
	fi
endif
	@rm -f ${HOME}/.zshrc ${HOME}/.zsh.d
	@ln -s -f ${PROFILE}/zshrc ${HOME}/.zshrc
	@ln -s -f ${PROFILE}/zsh.d ${HOME}/.zsh.d
	@echo "$(GREEN)ZSH configured$(RESET)"

neovim: ## Install Vim/Neovim profile and vimplug plugins
	@echo "$(BOLD)Setting up NeoVIM$(RESET)"
	@set -e; \
	mkdir -p ${HOME}/.config/nvim; \
	ln -s -f ${PROFILE}/vimrc ${HOME}/.config/nvim/init.vim; \
	ln -s -f ${PROFILE}/vimrc ${HOME}/.vimrc; \
	echo "$(GREEN)NeoVIM configured$(RESET)"

tmux: ## Install TMUX profile
	@echo "$(BOLD)Setting up TMUX$(RESET)"
	@set -e; \
	if ! command -v tmux >/dev/null 2>&1; then \
		echo "$(YELLOW)Warning: tmux is not installed$(RESET)"; \
	fi; \
	ln -s -f ${PROFILE}/tmux.conf ${HOME}/.tmux.conf; \
	ln -s -f ${PROFILE}/tmux.local ${HOME}/.tmux.conf.local; \
	echo "$(GREEN)TMUX configured$(RESET)"
