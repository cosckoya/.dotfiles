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

## Paths
DOTFILES=${HOME}/.dotfiles
CLOUD=${DOTFILES}/cloud

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
	sudo sh -c "apt-get update -qq && apt-get install -qq -y --no-install-recommends google-cloud-sdk" ;\
	gcloud version
	@echo "GCloud SDK done!"
