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
ASDF=${HOME}/.asdf/bin/asdf

## Burn, baby, burn
help: ## Shows this makefile help
	@echo ""
	@echo "Klaatu Barata Nitko!"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: profile ## Install Profile, IaC, Cloud and terminal addons
	@echo "Local environment succesfully configured"

## Profile Settings
profile: zsh tmux neovim ## Install ZSH, TMUX and Vim/Neovim plugins and profiles
	@echo "Custom profile ready to rumble. Enjoy!"

zsh: ## Sets ZSH as default Shell, and install ZSH profile and zplug with plugins
	@echo "Setting up ZSH profile" ;\
	sudo sh -c "usermod --shell /bin/zsh ${USER}" ;\
	ln -s -f ${PROFILE}/zshrc ${HOME}/.zshrc
	ln -s -f ${PROFILE}/zsh.d ${HOME}/.zsh.d

neovim: ## Install Vim/Neovim profile and vimplug plugins
	@echo "Setting up NeoVIM" ;\
	mkdir -p ~/.config/nvim ;\
	ln -s -f ${PROFILE}/vimrc ${HOME}/.config/nvim/init.vim ;\
	ln -s -f ${PROFILE}/vimrc ${HOME}/.vimrc

tmux: ## Install TMUX profile
	@echo "Setting up TMUX" ;\
	wget -q https://raw.githubusercontent.com/gpakosz/.tmux/master/.tmux.conf -O ${HOME}/.tmux.conf ;\
	ln -s -f ${PROFILE}/tmux.local ${HOME}/.tmux.conf.local
