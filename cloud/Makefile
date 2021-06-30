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
OS=$(shell uname -s)

## Paths
DOTFILES=${HOME}/.dotfiles
CLOUD=${DOTFILES}/cloud
ASDF=${HOME}/.asdf/bin/asdf

## Burn, baby, burn
help: ## Shows this makefile help
	@echo ""
	@echo "Klaatu Barata Nitko!"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: azure aws google ## Install cloud tools
	@echo "Cloud tools succesfully installed"

## Cloud MGMT tools
azure: ## Install Azure Cli (az)
	@echo "Installing Azure Cli"
ifeq ($(OS), Linux)
	@curl -sL https://aka.ms/InstallAzureCli | bash ;\
	@$(shell az version)
else
	@brew update
	@brew install azure-cli
endif
	@wget -q "https://raw.githubusercontent.com/Azure/azure-cli/dev/az.completion" -O ${DOTFILES}/profile/zsh.d/az.completion
	@echo "Azure Cli done!"

aws: ## Install Amazon AWS-Cli v2
	@echo "Installing AWS Cli"
ifeq ($(OS), Linux)
	@curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	@unzip -qq awscliv2.zip
	@sudo ./aws/install -i ${HOME}/.config/aws-cli -b ${HOME}/bin --update
	@sudo chown -R ${USER}: ${HOME}/bin ${HOME}/.config/aws-cli
	@rm -rf ./aws awscliv2.zip
	@${HOME}/bin/aws --version
else
	@curl -s "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "awscliv2.pkg"
	@sudo installer -pkg awscliv2.pkg -target /
	@rm awscliv2.pkg
	@$(shell which aws) --version
endif
	@echo "AWS cli done!"

google: ## Install Google SDK (glcoud)
	@echo "Setting up glcoud"
	@${ASDF} plugin-add gcloud
	@${ASDF} install gcloud latest
	@${ASDF} global gcloud latest
	@wget -q "https://raw.githubusercontent.com/twistedpair/google-cloud-sdk/master/google-cloud-sdk/completion.zsh.inc" -O ${DOTFILES}/profile/zsh.d/gcp.completion
