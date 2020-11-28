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
TOOLS=${DOTFILES}/tools

## Versions
ANSIBLE_VERSION:="2.9.10"
TERRAFORM_VERSION:="0.13.5"

## Burn, baby, burn
help: ## Shows this makefile help
	@echo ""
	@echo "Klaatu Barata Nitko!"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: iac tftools addons ## Install all tools
	@echo "Setting up local environment"

iac: ansible terraform ## Install Ansible & Terraform tools
	sudo chown -R ${USER}: ${HOME}/bin ;\
	chmod 755 -R ${HOME}/bin
	@echo "Toolbox ready to be used. Enjoy!"

addons: gh-cli tig git-secret cheat asdf hadolint ## Install Addons: tig, asdf, cheat, hadolint
	@echo "Shell Add-ons enabled. Enjoy!"

tftools: tflint tfdocs tfsec ## Install Terraform local tools: tflint, terraform-docs and
	@echo "Installing / upgrading Terraform tools"

# Terraform command line addons
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
	curl --silent "https://api.github.com/repos/terraform-docs/terraform-docs/releases/latest" | jq -r '.assets[].browser_download_url' | grep linux-amd64 | xargs wget -O ${HOME}/bin/terraform-docs ;\
	chmod u+x ${HOME}/bin/terraform-docs ;\
	${HOME}/bin/terraform-docs --version
	@echo "Terraform terraform-docs installed"

tfsec: ## Install / Updated tfsec: Terraform Security Compliance
	@echo "Installing TFSec" ;\
	wget -q https://github.com/liamg/tfsec/releases/latest/download/tfsec-linux-amd64 -O ${HOME}/bin/tfsec ;\
	chmod u+x ${HOME}/bin/tfsec ;\
	${HOME}/bin/tfsec--version
	@echo "Terraform tfsec installed"

## Basic Tools
pre-commit: ## Install Pre-Commit
	@echo "Install Pre-Commit" ;\
	${HOME}/.local/bin/pip3 install pre-commit --user

tig: ## Install Tig
	@echo "Installing Tig" ;\
	sudo sh -c "apt-get update -qq && apt-get install -qq -y --no-install-recommends tig"
	@echo "Tig done!"

gh-cli: ## Install Github Cli
	@echo "Install Github Cli" ;\
	curl --silent "https://api.github.com/repos/cli/cli/releases/latest" | jq -r '.assets[].browser_download_url' | grep linux_amd64.deb | xargs wget ;\
	sudo sh -c "apt-get install -f ./*.deb" ;\
	rm *.deb* ;\
	gh version
	@echo "Github cli installed!"

git-secret: ## Install git-secret
	@echo "Installing git-secret. See git-secret.io for more info" ;\
	sudo sh -c "echo 'deb https://dl.bintray.com/sobolevn/deb git-secret main' > /etc/apt/sources.list.d/git-secret.list" ;\
	wget -qO - https://api.bintray.com/users/sobolevn/keys/gpg/public.key | sudo apt-key add - ;\
	sudo sh -c "apt-get update -qq && apt-get install -qq -y --no-install-recommends git-secret"
	@echo "git-secret done!"

cheat: ## Install cheat
	@echo "Installing Cheat" ;\
	wget -q https://github.com/cheat/cheat/releases/latest/download/cheat-linux-amd64.gz ;\
	gzip -dc < cheat-linux-amd64.gz > ${HOME}/bin/cheat ;\
	rm -rf cheat-linux-amd64.gz ${HOME}/.config/cheat ;\
	chmod 755 ${HOME}/bin/cheat ;\
	mkdir -p ${HOME}/.config/cheat/cheatsheets && cheat --init > ${HOME}/.config/cheat/conf.yml ;\
	git clone https://github.com/cheat/cheatsheets.git ${HOME}/.config/cheat/cheatsheets/community ;\
	ln -s -f ${TOOLS}/cheats ${HOME}/.config/cheat/cheatsheets/personal
	@echo "Cheat done!"

asdf: ## Install asdf
	@echo "Installing ASDF" ;\
	rm -rf ${HOME}/.asdf ;\
	git clone https://github.com/asdf-vm/asdf.git ${HOME}/.asdf ;\
	ln -s -f ${TOOLS}/asdf.zsh ${HOME}/.zsh.d/asdf.zsh
	@echo "ASDF done!"

hadolint: ## Install Hadolint
	@echo "Installing Hadolint" ;\
	wget https://github.com/hadolint/hadolint/releases/latest/download/hadolint-Linux-x86_64 -O ${HOME}/bin/hadolint ;\
	chmod u+x ${HOME}/bin/hadolint
	@echo "Hadolint done!"
