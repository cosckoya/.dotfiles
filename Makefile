.ONESHELL:
SHELL := /bin/bash
.PHONY: help all profile tools containers asdf
.DEFAULT_GOAL := help
CURRENT_FOLDER := $(shell basename "$$(pwd)")
BOLD := $(shell tput bold)
RED := $(shell tput setaf 1)
GREEN := $(shell tput setaf 2)
YELLOW := $(shell tput setaf 3)
RESET := $(shell tput sgr0)

## Global
NAME := main
VERSION := scratch
OS := $(shell uname -s | tr '[:upper:]' '[:lower:]')
ARCH := $(shell uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$$/arm64/')

## Paths
DOTFILES := ${HOME}/.dotfiles

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

asdf: ## Install asdf (always latest version)
	@echo "$(BOLD)$(GREEN)Installing/Updating ASDF$(RESET)"
	@set -e; \
	ASDF_VERSION=$$(curl -s https://api.github.com/repos/asdf-vm/asdf/releases/latest | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/'); \
	if [ -z "$$ASDF_VERSION" ]; then \
		echo "$(RED)Failed to fetch latest ASDF version$(RESET)"; \
		exit 1; \
	fi; \
	echo "Latest ASDF version: $$ASDF_VERSION"; \
	if command -v asdf >/dev/null 2>&1; then \
		CURRENT_VERSION=$$(asdf version | awk '{print $$1}' | sed 's/v//'); \
		if [ "$$CURRENT_VERSION" = "$$ASDF_VERSION" ]; then \
			echo "$(GREEN)ASDF is already up to date (v$$ASDF_VERSION)$(RESET)"; \
			exit 0; \
		else \
			echo "$(YELLOW)Updating ASDF from v$$CURRENT_VERSION to v$$ASDF_VERSION$(RESET)"; \
		fi; \
	fi; \
	mkdir -p ${HOME}/bin; \
	wget -q "https://github.com/asdf-vm/asdf/releases/download/v$$ASDF_VERSION/asdf-v$$ASDF_VERSION-linux-$(ARCH).tar.gz" -O ${HOME}/asdf-linux.tar.gz; \
	tar -xzf ${HOME}/asdf-linux.tar.gz -C ${HOME}/bin; \
	rm ${HOME}/asdf-linux.tar.gz; \
	echo "$(GREEN)ASDF v$$ASDF_VERSION installation completed successfully$(RESET)"
