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
ASDF=${HOME}/.asdf/bin/asdf

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
	${ASDF} plugin-add terraform ;\
	${ASDF} install terraform latest ;\
	${ASDF} global terraform latest

checkov: ## Install CheckOV
	${ASDF} plugin-add checkov ;\
	${ASDF} install checkov latest ;\
	${ASDF} global checkov latest

terraform-docs: ## Install Terraform-docs
	${ASDF} plugin-add terraform-docs ;\
	${ASDF} install terraform-docs latest ;\
	${ASDF} global terraform-docs latest

tfsec: ## Install TFSec
	${ASDF} plugin-add tfsec ;\
	${ASDF} install tfsec latest ;\
	${ASDF} global tfsec latest

trivy: ## Install Trivy
	${ASDF} plugin-add trivy ;\
	${ASDF} install trivy latest ;\
	${ASDF} global trivy latest	
