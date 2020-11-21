.ONESHELL:
.SHELL := /bin/sh
.PHONY: help
.DEFAULT_GOAL := help
CURRENT_FOLDER=$(shell basename "$$(pwd)")
BOLD=$(shell tput bold)
RED=$(shell tput setaf 1)
RESET=$(shell tput sgr0)

## Global
NAME=cloud-tools
VERSION=scratch

## Paths
DOTFILES=${HOME}/.dotfiles

## Versions
ANSIBLE_VERSION:="2.9.10"
TERRAFORM_VERSION:="0.13.5"

## Burn, baby, burn
help: ## Shows this makefile help
	@echo ""
	@echo "Klaatu Barata Nitko!"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: ansible terraform azure aws google ## Install cloud tools
	@echo "Setting up local environment"

## Infrastructure as a code (IaC)
ansible: ## Install Pip3+Ansible. Set version with `make ansible ANSIBLE_VERSION="2.9.10"` (default version: 2.9.10)
	@echo "Setting up Ansible" ;\
	${HOME}/.local/bin/pip3 install --user ansible==${ANSIBLE_VERSION} ;\
	${HOME}/.local/bin/ansible --version
	@echo "Ansible done!"

terraform: ## Install Terraform. Set version with `make terraform TERRAFORM_VERSION="0.13.5"` (default version: 0.13.5)
	@echo "Setting up HashiCorp Terraform" ;\
	wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -O terraform.zip ;\
	unzip -o terraform.zip -d ${HOME}/bin ;\
	rm terraform.zip ;\
	${HOME}/bin/terraform version
	@echo "Terraform done!"

## Cloud Clients
azure: ## Install Azure Cli (az)
	@echo "Installing Azure Cli" ;\
	curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash ;\
	az version
	@echo "Azure Cli done!"

aws: ## Install Amazon AWS-Cli v2 (aws)
	@echo "Installing AWS Cli"
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" ;\
	unzip -qq awscliv2.zip ;\
	sudo ./aws/install -i ${HOME}/.config/aws-cli -b ${HOME}/bin --update ;\
	sudo chown -R ${USER}: ${HOME}/bin ${HOME}/.config/aws-cli ;\
	rm -rf ./aws awscliv2.zip ;\
	${HOME}/bin/aws --version
	@echo "AWS cli done!"

google: ## Install Google SDK (glcoud)
	@echo "Installing Google SDK" ;\
	sudo sh -c "echo 'deb https://packages.cloud.google.com/apt cloud-sdk main' > /etc/apt/sources.list.d/google-cloud-sdk.list" ;\
	curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - ;\
	sudo sh -c "apt update -qq && apt install -qq -y --no-install-recommends google-cloud-sdk"
	@echo "GCloud SDK done!"

# Terraform command line addons
tflint: ## Install / Updrade TFLint util
	@echo "Installing Terraform Linter: tflint" ;\
	wget -q https://github.com/terraform-linters/tflint/releases/latest/download/tflint_linux_amd64.zip ;\
	unzip tflint_linux_amd64.zip ;\
	mv tflint ${HOME}/bin ;\
	rm tflint_linux_amd64.zip ;\
	${HOME}/bin/tflint --version
	@echo "Terraform TFLint installed"

tfdocs: ## Install / Updated Terraform-docs
	@echo "Installing terraform-docs" ;\
	wget -q https://github.com/terraform-docs/terraform-docs/releases/latest/download/terraform-docs-v0.10.1-linux-amd64 -O ${HOME}/bin/terraform-docs ;\
	chmod u+x ${HOME}/bin/terraform-docs ;\
	${HOME}/bin/terraform-docs --version
	@echo "Terraform terraform-docs installed"

tfsec: ## Install / Updated tfsec: Terraform Security Compliance
	@echo "Installing TFSec" ;\
	wget -q https://github.com/liamg/tfsec/releases/latest/download/tfsec-linux-amd64 -O ${HOME}/bin/tfsec ;\
	chmod u+x ${HOME}/bin/tfsec ;\
	${HOME}/bin/tfsec--version
	@echo "Terraform tfsec installed"
