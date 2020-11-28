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
	$(MAKE) all -C profile

cloud: ## Install AWS, Azure Cli and Google cli-tools
	$(MAKE) all -C cloud

container: ## Install Docker & Kubernetes tools
	$(MAKE) all -C container

tools: ## Install tools
	$(MAKE) all -C tools

## Main tasks
dependencies: pip nodejs docker ## Install Linux package dependencies
	@echo "Installing package dependencies" ;\
	sudo sh -c "apt-get update -qq &&\
	apt-get install -qq -y --no-install-recommends \
	wget unzip nmap jq curl tree \
	yarn \
	docker-ce docker-ce-cli containerd.io \
	ca-certificates apt-transport-https lsb-release \
	software-properties-common gnupg-agent gnupg" ;\

nodejs: ## Install NodeJS with Yarn and NPM
	@echo "Installing NodeJS, Yarn and NPM" ;\
	wget install-node.now.sh/lts && sudo bash lts -y && rm lts ;\
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - ;\
	sudo sh -c "echo 'deb https://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list"

pip: ## Install Python Pip3
	@echo "Installing Python Pip3" ;\
	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py ;\
	python3 get-pip.py --user ;\
	rm get-pip.py

docker: ## Install Docker CE
	@echo "Installing Docker CE" ;\
	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - ;\
	sudo sh -c "echo 'deb [arch=amd64] https://download.docker.com/linux/$$(lsb_release -is | tr A-Z a-z) $$(lsb_release -cs) stable' > /etc/apt/sources.list.d/docker-ce.list" ;\
