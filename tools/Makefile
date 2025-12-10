.ONESHELL:
SHELL := /bin/bash
.PHONY: help all tools cheat check-asdf
.DEFAULT_GOAL := help
CURRENT_FOLDER := $(shell basename "$$(pwd)")
BOLD := $(shell tput bold)
RED := $(shell tput setaf 1)
GREEN := $(shell tput setaf 2)
YELLOW := $(shell tput setaf 3)
RESET := $(shell tput sgr0)

## Global
NAME := tools
VERSION := scratch

## Paths
DOTFILES := ${HOME}/.dotfiles
TOOLS := ${DOTFILES}/tools
ASDF := $(shell command -v asdf 2>/dev/null || echo "${HOME}/.asdf/bin/asdf")

## Burn, baby, burn
help: ## Shows this makefile help
	@echo ""
	@echo "Klaatu Barata Nitko!"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: check-asdf tools ## Install linux tools
	@echo "$(BOLD)$(GREEN)All tools installed!$(RESET)"

check-asdf: ## Check if asdf is installed
	@command -v asdf >/dev/null 2>&1 || { echo "$(RED)Error: asdf is not installed. Please run 'make asdf' from the root directory.$(RESET)"; exit 1; }

tools: cheat ## Install Linux tools
	@echo "$(BOLD)$(GREEN)Shell Add-ons enabled. Enjoy!$(RESET)"

## Tools
cheat: check-asdf ## Install cheat
	@echo "$(BOLD)Setting up Cheats$(RESET)"
	@set -e; \
	${ASDF} plugin add cheat 2>/dev/null || true; \
	${ASDF} install cheat latest; \
	${ASDF} set cheat latest; \
	rm -rf ${HOME}/.config/cheat; \
	mkdir -p ${HOME}/.config/cheat/cheatsheets; \
	cheat --init > ${HOME}/.config/cheat/conf.yml; \
	if [ ! -d ${HOME}/.config/cheat/cheatsheets/community ]; then \
		git clone https://github.com/cheat/cheatsheets.git ${HOME}/.config/cheat/cheatsheets/community; \
	fi; \
	ln -s -f ${TOOLS}/cheats ${HOME}/.config/cheat/cheatsheets/personal; \
	echo "$(GREEN)Cheat installed$(RESET)"
