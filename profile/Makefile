.ONESHELL:
.SHELL := /bin/sh
.PHONY: help
.DEFAULT_GOAL := help
CURRENT_FOLDER=$(shell basename "$$(pwd)")
BOLD=$(shell tput bold)
RED=$(shell tput setaf 1)
RESET=$(shell tput sgr0)

## Global
NAME=profile
VERSION=scratch

## Paths
DOTFILES=${HOME}/.dotfiles
PROFILE=${DOTFILES}/profile

## Burn, baby, burn
help: ## Shows this makefile help
	@echo ""
	@echo "Klaatu Barata Nitko!"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: profile ## Install Profile, IaC, Cloud and terminal addons
	@echo "Local environment succesfully configured"

## Profile Settings
profile: bash zsh tmux neovim ## Install ZSH, TMUX and Vim/Neovim plugins and profiles
	@echo "Custom profile ready to rumble. Enjoy!"

bash: ## Install Bash profile
	@echo "Setting up BASH profile" ;\
	ln -s -f ${PROFILE}/bashrc ${HOME}/.bashrc

zsh: ## Sets ZSH as default Shell, and install ZSH profile and zplug with plugins
	@echo "Setting up ZSH profile" ;\
	sudo sh -c "apt-get update -qq && apt-get install -qq -y --no-install-recommends zsh" ;\
	sudo sh -c "usermod --shell /bin/zsh ${USER}" ;\
	mkdir -p ${HOME}/.zsh.d ;\
	ln -s -f ${PROFILE}/zshrc ${HOME}/.zshrc

neovim: ## Install Vim/Neovim profile and vimplug plugins
	@echo "Setting up NeoVIM" ;\
	sudo sh -c "apt-get update -qq && apt-get install -qq -y --no-install-recommends neovim vim" ;\
	mkdir -p ~/.config/nvim ;\
	ln -s -f ${PROFILE}/vimrc ${HOME}/.config/nvim/init.vim ;\
	ln -s -f ${PROFILE}/vimrc ${HOME}/.vimrc

tmux: ## Install TMUX profile
	@echo "Setting up TMUX" ;\
	sudo sh -c "apt-get update -qq && apt-get install -qq -y --no-install-recommends tmux" ;\
	wget -q https://raw.githubusercontent.com/gpakosz/.tmux/master/.tmux.conf -O ${HOME}/.tmux.conf ;\
	ln -s -f ${PROFILE}/tmux.local ${HOME}/.tmux.conf.local
