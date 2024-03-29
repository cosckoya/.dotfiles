.ONESHELL:
.SHELL:=/bin/sh
.PHONY: help all profile tools container iac
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
	@echo "Klaatu Barata Nitko!"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: dependencies profile tools container ## Install everything

profile: ## Install ZSH, Tmux and Neovim profiles
	$(MAKE) all -C profile

tools: ## Install tools
	$(MAKE) all -C tools

container: ## Install Docker & Kubernetes tools
	$(MAKE) all -C container

## Main tasks
dependencies: asdf pip nodejs ## Install Linux package dependencies

nodejs: ## Install NodeJS
	@echo "Installing Nodejs & Yarn"
	${ASDF} plugin-add nodejs
	${ASDF} install nodejs latest
	${ASDF} global nodejs latest
	sudo sh -c "npm install --global yarn"
	sudo sh -c "npm install --global npm"
	$$(which node) --version

pip: ## Install Python Pip3
	@echo "Installing Python Pip3"
	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
	python3 get-pip.py --user
	rm get-pip.py

asdf: ## Install asdf
	@echo "Installing ASDF"
	rm -rf ${HOME}/.asdf
	git clone https://github.com/asdf-vm/asdf.git ${HOME}/.asdf
	@echo "ASDF done!"
