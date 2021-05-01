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
IAC=${DOTFILES}/iac
ASDF=${HOME}/.asdf/bin/asdf

## Versions
ANSIBLE_VERSION:="2.9.10"

## Burn, baby, burn
help: ## Shows this makefile help
	@echo ""
	@echo "Klaatu Barata Nitko!"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: ansible tf ## Install IaC tools
	@echo "Setting up IaC tools"

tf: terraform tfdocs tflint tfsec ## Install Terraform +tools
	@echo "Installing Terraform tools"

# Terraform command line addons
ansible: ## Install Pip3+Ansible. Set version with `make ansible ANSIBLE_VERSION="2.9.10"` (default version: 2.9.10)
	@echo "Setting up Ansible" ;\
	${HOME}/.local/bin/pip3 install --user ansible==${ANSIBLE_VERSION} ;\
	${HOME}/.local/bin/ansible --version
	@echo "Ansible done!"

terraform: ## Install Terraform.
	@echo "Setting up HashiCorp Terraform" ;\
	${ASDF} plugin-add terraform ;\
	${ASDF} install terraform latest ;\
	${ASDF} global terraform latest ;\
	$$(which terraform) version
	@echo "Terraform done!"

tfdocs: ## Install Terraform-docs
	@echo "Installing terraform-docs" ;\
	${ASDF} plugin-add terraform-docs ;\
	${ASDF} install terraform-docs latest ;\
	${ASDF} global terraform-docs latest ;\
	$$(which terraform-docs) --version
	@echo "Terraform terraform-docs installed"

tflint: ## Install Tflint
	@echo "Installing Tflint" ;\
	${ASDF} plugin-add tflint ;\
	${ASDF} install tflint latest ;\
	${ASDF} global tflint latest ;\
	$$(which tflint) --version
	@echo "Terraform TFLint installed"

tfsec: ## Install Tfsec
	@echo "Installing TFSec" ;\
	${ASDF} plugin-add tfsec ;\
	${ASDF} install tfsec latest ;\
	${ASDF} global tfsec latest ;\
	$$(which tfsec) --version
	@echo "Terraform tfsec installed"
