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
OS=$(shell uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(shell uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$$/arm64/')

## Paths
DOTFILES=${HOME}/.dotfiles

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
	wget -q https://github.com/asdf-vm/asdf/releases/latest/download/asdf-latest-linux-amd64.tar.gz -O ${HOME}/asdf-linux-amd64.tar.gz ;\
	tar -xzf ${HOME}/asdf-linux-amd64.tar.gz -C ${HOME}/bin ;\
	rm ${HOME}/asdf-linux-amd64.tar.gz
	@echo "ASDF installation completed successfully"
