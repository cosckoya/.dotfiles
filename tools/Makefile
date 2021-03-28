.ONESHELL:
.SHELL := /bin/sh
.PHONY: help
.DEFAULT_GOAL := help
CURRENT_FOLDER=$(shell basename "$$(pwd)")
BOLD=$(shell tput bold)
RED=$(shell tput setaf 1)
RESET=$(shell tput sgr0)

## Global
NAME=tools
VERSION=scratch

## Paths
DOTFILES=${HOME}/.dotfiles
TOOLS=${DOTFILES}/tools

## Burn, baby, burn
help: ## Shows this makefile help
	@echo ""
	@echo "Klaatu Barata Nitko!"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: tools ## Install linux tools

tools: pre-commit gh-cli tig cheat asdf ## Install Linux tools
	@echo "Shell Add-ons enabled. Enjoy!"

## Tools
pre-commit: ## Install Pre-Commit
	@echo "Install Pre-Commit" ;\
	${HOME}/.local/bin/pip3 install pre-commit --user

tig: ## Install Tig
	@echo "Installing Tig" ;\
	sudo sh -c "apt-get update -qq && apt-get install -qq -y --no-install-recommends tig"
	@echo "Tig done!"

gh-cli: ## Install Github Cli
	@echo "Install Github Cli" ;\
	curl --silent "https://api.github.com/repos/cli/cli/releases/latest" | jq -r '.assets[].browser_download_url' | grep linux_amd64.deb | xargs wget ;\
	sudo sh -c "apt-get install -f ./*.deb" ;\
	rm *.deb* ;\
	gh version
	@echo "Github cli installed!"

cheat: ## Install cheat
	@echo "Installing Cheat" ;\
	wget -q https://github.com/cheat/cheat/releases/latest/download/cheat-linux-amd64.gz ;\
	gzip -dc < cheat-linux-amd64.gz > ${HOME}/bin/cheat ;\
	rm -rf cheat-linux-amd64.gz ${HOME}/.config/cheat ;\
	chmod 755 ${HOME}/bin/cheat ;\
	mkdir -p ${HOME}/.config/cheat/cheatsheets && cheat --init > ${HOME}/.config/cheat/conf.yml ;\
	git clone https://github.com/cheat/cheatsheets.git ${HOME}/.config/cheat/cheatsheets/community ;\
	ln -s -f ${TOOLS}/cheats ${HOME}/.config/cheat/cheatsheets/personal
	@echo "Cheat done!"

asdf: ## Install asdf
	@echo "Installing ASDF" ;\
	rm -rf ${HOME}/.asdf ;\
	git clone https://github.com/asdf-vm/asdf.git ${HOME}/.asdf ;\
	ln -s -f ${TOOLS}/asdf.zsh ${HOME}/.zsh.d/asdf.zsh
	@echo "ASDF done!"
