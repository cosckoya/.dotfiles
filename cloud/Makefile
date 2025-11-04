.ONESHELL:
SHELL := /bin/bash
.PHONY: help all terraform checkov trivy terraform-docs tfsec
.DEFAULT_GOAL := help
CURRENT_FOLDER := $(shell basename "$$(pwd)")
BOLD := $(shell tput bold)
RED := $(shell tput setaf 1)
GREEN := $(shell tput setaf 2)
YELLOW := $(shell tput setaf 3)
RESET := $(shell tput sgr0)

## Global
NAME := cloud
VERSION := scratch
OS := $(shell uname | tr '[:upper:]' '[:lower:]')
ARCH := $(shell uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$$/arm64/')

## Paths
DOTFILES := ${HOME}/.dotfiles
CLOUD := ${DOTFILES}/cloud

## Burn, baby, burn
help: ## Shows this makefile help
	@echo ""
	@echo "Klaatu Barata Nikto!"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: check-asdf terraform checkov trivy terraform-docs ## Install all cloud tools
	@echo "$(BOLD)$(GREEN)Cloud tools installed!$(RESET)"

check-asdf: ## Check if asdf is installed
	@command -v asdf >/dev/null 2>&1 || { echo "$(RED)Error: asdf is not installed. Please run 'make asdf' from the root directory.$(RESET)"; exit 1; }

## terraform
terraform: check-asdf ## Install Terraform
	@echo "$(BOLD)Installing Terraform$(RESET)"
	@set -e; \
	asdf plugin add terraform 2>/dev/null || true; \
	asdf install terraform latest; \
	asdf set --home terraform latest; \
	echo "$(GREEN)Terraform installed$(RESET)"

checkov: check-asdf ## Install Checkov
	@echo "$(BOLD)Installing Checkov$(RESET)"
	@set -e; \
	asdf plugin add checkov 2>/dev/null || true; \
	asdf install checkov latest; \
	asdf set --home checkov latest; \
	echo "$(GREEN)Checkov installed$(RESET)"

terraform-docs: check-asdf ## Install Terraform-docs
	@echo "$(BOLD)Installing Terraform-docs$(RESET)"
	@set -e; \
	asdf plugin add terraform-docs 2>/dev/null || true; \
	asdf install terraform-docs latest; \
	asdf set --home terraform-docs latest; \
	echo "$(GREEN)Terraform-docs installed$(RESET)"

tfsec: check-asdf ## Install TFSec
	@echo "$(BOLD)Installing TFSec$(RESET)"
	@set -e; \
	asdf plugin add tfsec 2>/dev/null || true; \
	asdf install tfsec latest; \
	asdf set --home tfsec latest; \
	echo "$(GREEN)TFSec installed$(RESET)"

trivy: check-asdf ## Install Trivy
	@echo "$(BOLD)Installing Trivy$(RESET)"
	@set -e; \
	asdf plugin add trivy 2>/dev/null || true; \
	asdf install trivy latest; \
	asdf set --home trivy latest; \
	echo "$(GREEN)Trivy installed$(RESET)"
