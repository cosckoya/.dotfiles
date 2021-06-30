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
ASDF=${HOME}/.asdf/bin/asdf

## Burn, baby, burn
help: ## Shows this makefile help
	@echo ""
	@echo "Klaatu Barata Nitko!"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: tools ## Install linux tools

tools: pre-commit cheat asdf ## Install Linux tools
	@echo "Shell Add-ons enabled. Enjoy!"

## Tools
pre-commit: ## Install Pre-Commit
	@echo "Install Pre-Commit" ;\
	$$(which pip3) install pre-commit --user

cheat: ## Install cheat
	@echo "Setting up Cheats" ;\
	${ASDF} plugin-add cheat ;\
	${ASDF} install cheat latest ;\
	${ASDF} global cheat latest ;\
	rm -rf ${HOME}/.config/cheat ;\
	mkdir -p ${HOME}/.config/cheat/cheatsheets && cheat --init > ${HOME}/.config/cheat/conf.yml ;\
	git clone https://github.com/cheat/cheatsheets.git ${HOME}/.config/cheat/cheatsheets/community ;\
	ln -s -f ${TOOLS}/cheats ${HOME}/.config/cheat/cheatsheets/personal
	@echo "Cheats done!"
