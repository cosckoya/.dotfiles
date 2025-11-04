.ONESHELL:
SHELL := /bin/bash
.PHONY: help all tools pre-commit cheat checkmake check-asdf
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

all: tools ## Install linux tools
	@echo "$(BOLD)$(GREEN)All tools installed!$(RESET)"

check-asdf: ## Check if asdf is installed
	@command -v asdf >/dev/null 2>&1 || { echo "$(RED)Error: asdf is not installed. Please run 'make asdf' from the root directory.$(RESET)"; exit 1; }

tools: pre-commit cheat checkmake ## Install Linux tools
	@echo "$(BOLD)$(GREEN)Shell Add-ons enabled. Enjoy!$(RESET)"

## Tools
pre-commit: ## Install Pre-Commit
	@echo "$(BOLD)Installing Pre-Commit$(RESET)"
	@set -e; \
	if command -v pre-commit >/dev/null 2>&1; then \
		echo "$(YELLOW)Pre-commit already installed$(RESET)"; \
	else \
		command -v pip3 >/dev/null 2>&1 || { echo "$(RED)Error: pip3 is not installed$(RESET)"; exit 1; }; \
		pip3 install pre-commit --user; \
		echo "$(GREEN)Pre-commit installed$(RESET)"; \
	fi

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

checkmake: ## Install checkmake (Makefile linter)
	@echo "$(BOLD)Installing Checkmake$(RESET)"
	@set -e; \
	if command -v checkmake >/dev/null 2>&1; then \
		echo "$(YELLOW)Checkmake already installed$(RESET)"; \
	else \
		CHECKMAKE_VERSION=$$(curl -s https://api.github.com/repos/checkmake/checkmake/releases/latest | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/'); \
		if [ -z "$$CHECKMAKE_VERSION" ]; then \
			echo "$(RED)Failed to fetch latest checkmake version$(RESET)"; \
			exit 1; \
		fi; \
		mkdir -p ${HOME}/bin; \
		wget -q "https://github.com/checkmake/checkmake/releases/download/$$CHECKMAKE_VERSION/checkmake-$$CHECKMAKE_VERSION.linux.amd64" -O ${HOME}/bin/checkmake; \
		chmod +x ${HOME}/bin/checkmake; \
		echo "$(GREEN)Checkmake $$CHECKMAKE_VERSION installed$(RESET)"; \
	fi
