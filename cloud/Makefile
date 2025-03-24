.ONESHELL:
.SHELL := /bin/sh
.PHONY: help
.DEFAULT_GOAL := help
CURRENT_FOLDER=$(shell basename "$$(pwd)")
BOLD=$(shell tput bold)
RED=$(shell tput setaf 1)
RESET=$(shell tput sgr0)

## Global
NAME=cloud
VERSION=scratch
OS=$(shell uname | tr '[:upper:]' '[:lower:]')
ARCH=$(shell uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$$/arm64/')

## Paths
DOTFILES=${HOME}/.dotfiles
CONTAINER=${DOTFILES}/cloud

## Burn, baby, burn
help: ## Shows this makefile help
	@echo ""
	@echo "Klaatu Barata Nikto!"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: terraform checkov trivy terraform-docs
	@echo "Cloud tools installed!"

## terraform
terraform: ## Install Terraform
	asdf plugin-add terraform ;\
	asdf install terraform latest ;\
	asdf global terraform latest

checkov: ## Install CheckOV
	asdf plugin-add checkov ;\
	asdf install checkov latest ;\
	asdf global checkov latest

terraform-docs: ## Install Terraform-docs
	asdf plugin-add terraform-docs ;\
	asdf install terraform-docs latest ;\
	asdf global terraform-docs latest

tfsec: ## Install TFSec
	asdf plugin-add tfsec ;\
	asdf install tfsec latest ;\
	asdf global tfsec latest

trivy: ## Install Trivy
	asdf plugin-add trivy ;\
	asdf install trivy latest ;\
	asdf global trivy latest	
