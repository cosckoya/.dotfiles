.ONESHELL:
.SHELL:=/bin/sh
.PHONY: help all profile cloud container tools
.DEFAULT_GOAL:=help
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

profile: ## Install ZSH, Tmux and Neovim profiles
	$(MAKE) all -C ${DOTFILES}/profile

cloud: ## Install AWS, Azure Cli and Google cli-tools
	$(MAKE) all -C ${DOTFILES}/cloud

container: ## Install Docker & Kubernetes tools
	$(MAKE) all -C ${DOTFILES}/container

tools: ## Install tools
	$(MAKE) all -C ${DOTFILES}/tools

## Main tasks
dependencies: pip ## Install Linux package dependencies
	@echo "Installing package dependencies" ;\
	sudo sh -c "apt update -qq &&\
	apt install -qq -y --no-install-recommends \
	wget unzip nmap jq curl tree \
	ca-certificates apt-transport-https lsb-release gnupg" ;\

pip: ## Install Python Pip3
	@echo "Installing Python Pip3" ;\
	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py ;\
	python3 get-pip.py --user ;\
	rm get-pip.py


