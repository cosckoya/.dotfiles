.ONESHELL:
.SHELL:=/bin/sh
.PHONY: help all profile tools containers
.DEFAULT_GOAL:=help
CURRENT_FOLDER=$(shell basename "$$(pwd)")
BOLD=$(shell tput bold)
RED=$(shell tput setaf 1)
RESET=$(shell tput sgr0)

## Global
NAME=main
VERSION=scratch
OS=$(shell uname -s)

## Paths
DOTFILES=${HOME}/.dotfiles
ASDF=${HOME}/.asdf/bin/asdf

## Burn, baby, burn
help: ## Shows this makefile help
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: asdf profile tools containers ## Install everything

profile: ## Install ZSH, Tmux, and Neovim profiles
	$(MAKE) all -C profile

tools: ## Install tools
	$(MAKE) all -C tools

containers: ## Install Docker & Kubernetes tools
	$(MAKE) all -C container

asdf: ## Install asdf
	@echo "Installing ASDF"
	rm -rf ${HOME}/.asdf
	git clone https://github.com/asdf-vm/asdf.git ${HOME}/.asdf || (echo "$(RED)Error: Cloning ASDF failed.$(RESET)" && exit 1)
	@echo "ASDF installation completed successfully"
