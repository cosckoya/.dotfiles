.ONESHELL:
.SHELL := /bin/sh
.PHONY: help
.DEFAULT_GOAL := help
CURRENT_FOLDER=$(shell basename "$$(pwd)")
BOLD=$(shell tput bold)
RED=$(shell tput setaf 1)
RESET=$(shell tput sgr0)

## Global
NAME=main
VERSION=scratch

## Paths
DOTFILES=${HOME}/.dotfiles

## Burn, baby, burn
help: ## Shows this makefile help
	@echo ""
	@echo "Klaatu Barata Nitko!"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: dependencies profile cloud container tools ## Install everything
	@echo "Setting up local environment"

profile: ## Install ZSH, TMUX and Vim/Neovim plugins and profiles
	${MAKE}  all -C profile
	
cloud: ## Install AWS, Azure Cli and Google cli-tools
	${MAKE} all -C cloud

container: ## Install Docker & Kubernetes tools
	${MAKE} all -C container

tools: ## Install tools
	${MAKE} all -C tools

## Basic Tools like Python3-Pip, Pre-commit or Profile settings
dependencies: pip ## Install Linux package dependencies
	@echo "Installing package dependencies" ;\
	sudo bash -c "apt update -qq &&\
	apt install -qq -y --no-install-recommends \
	wget unzip nmap jq curl tree\
	ca-certificates apt-transport-https lsb-release gnupg" ;\

pip: ## Install Python Pip3
	@echo "Installing Python Pip3" ;\
	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py ;\
	python3 get-pip.py --user ;\
	rm get-pip.py


