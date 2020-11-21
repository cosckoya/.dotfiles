.ONESHELL:
.SHELL := /bin/sh
.PHONY: help
.DEFAULT_GOAL := help
CURRENT_FOLDER=$(shell basename "$$(pwd)")
BOLD=$(shell tput bold)
RED=$(shell tput setaf 1)
RESET=$(shell tput sgr0)

## Global
NAME=profile-generator
VERSION=scratch

## Paths
DOTFILES=${HOME}/.dotfiles

## Versions
ANSIBLE_VERSION:="2.9.10"
HELM_VERSION:="v3.3.0"
KUBECTL_VERSION:="v1.17.3"
MINISHIFT_VERSION:="1.34.2"
TERRAFORM_VERSION:="0.13.5"

## Burn, baby, burn
help: ## Shows this makefile help
	@echo ""
	@echo "Klaatu Barata Nitko!"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: dependencies profile iac cloud addons ## Install Profile, IaC, Cloud and terminal addons
	@echo "Setting up local environment"


## Basic Tools like Python3-Pip, Pre-commit or Profile settings
dependencies: pip pre-commit ## Install Linux package dependencies
	@echo "Installing package dependencies" ;\
	sudo bash -c "apt update -qq &&\
	apt install -qq -y --no-install-recommends \
	wget unzip nmap \
	ca-certificates apt-transport-https lsb-release gnupg" ;\

pip: ## Install Python Pip3
	@echo "Installing Python Pip3" ;\
	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py ;\
	python3 get-pip.py --user ;\
	rm get-pip.py

pre-commit: ## Install Pre-Commit
	@echo "Install Pre-Commit" ;\
	${HOME}/.local/bin/pip3 install pre-commit --user

## Basic Environment
profile: zsh tmux neovim ## Install ZSH, TMUX and Vim/Neovim plugins and profiles
	@echo "Custom profile ready to rumble. Enjoy!"

addons: gh-cli tig git-secret cheat docker-compose asdf hadolint ## Install Addons: tig, asdf, cheat, docker-compose, asdf +More
	@echo "Shell Add-ons enabled. Enjoy!"

## Tools by type
iac: ansible terraform kubernetes ## Install Pip3+Ansible, Terraform and Kubernetes tools
	sudo chown -R ${USER}: ${HOME}/bin ;\
	chmod 755 -R ${HOME}/bin
	@echo "Toolbox ready to be used. Enjoy!"

kubernetes: kubectl kubectx helm helm-repo krew ## Install Kubernetes tools: Kubectl & Helm
	chmod 755 -R ${HOME}/bin
	@echo "Kubernetes tools enabled. Enjoy!"

cloud: aws azure google ## Install AWS-Cli v2, Azure Cli and Google SDK
	@echo "Cloud tools enabled. Enjoy!"

minis: minikube minishift kind ## Install Minikube and Minishift local kubernetes clusters
	@echo "Minis installed. Enjoy!"

tftools: tflint tfdocs tfsec ## Install Terraform local tools: tflint, terraform-docs and
	@echo "Installing / upgrading Terraform tools"

## ---

## Profile
bash: ## Install Bash profile
	@echo "Setting up BASH profile" ;\
	export PATH=$PATH:$HOME/bin:/usr/local/bin:$HOME/bin:$HOME/.local/bin ;\
	ln -s -f ${DOTFILES}/bashrc ${HOME}/.bashrc

zsh: ## Sets ZSH as default Shell, and install ZSH profile and zplug with plugins
	@echo "Setting up ZSH profile" ;\
	sudo sh -c "apt update -qq && apt install -qq -y --no-install-recommends zsh" ;\
	sudo sh -c "usermod --shell /bin/zsh ${USER}" ;\
	ln -s -f ${DOTFILES}/zshrc ${HOME}/.zshrc

neovim: ## Install Vim/Neovim profile and vimplug plugins
	@echo "Setting up NeoVIM" ;\
	sudo bash -c "apt update -qq && apt install -qq -y --no-install-recommends neovim vim" ;\
	mkdir -p ~/.config/nvim ;\
	ln -s -f ${DOTFILES}/vimrc ${HOME}/.config/nvim/init.vim ;\
	ln -s -f ${DOTFILES}/vimrc ${HOME}/.vimrc
	@echo "Vim & NeoVim done!"

tmux: ## Install TMUX profile
	@echo "Setting up TMUX" ;\
	sudo bash -c "apt update -qq && apt install -qq -y --no-install-recommends tmux" ;\
	wget -q https://raw.githubusercontent.com/gpakosz/.tmux/master/.tmux.conf -O ${HOME}/.tmux.conf ;\
	ln -s -f ${DOTFILES}/tmux.local ${HOME}/.tmux.conf.local

## IaC
ansible: ## Install Pip3+Ansible. Set version with `make ansible ANSIBLE_VERSION="2.9.10"` (default version: 2.9.10)
	@echo "Setting up Ansible" ;\
	${HOME}/.local/bin/pip3 install --user ansible==${ANSIBLE_VERSION} ;\
	${HOME}/.local/bin/ansible --version
	@echo "Ansible done!"

terraform: ## Install Terraform. Set version with `make terraform TERRAFORM_VERSION="0.12.28"` (default version: 0.12.28)
	@echo "Setting up HashiCorp Terraform" ;\
	wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -O terraform.zip ;\
	unzip -o terraform.zip -d ${HOME}/bin ;\
	rm terraform.zip ;\
	${HOME}/bin/terraform version
	@echo "Terraform done!"

## Kubernetes
kubectl: ## Install Kubectl. Set version with `make kubectl KUBECTL_VERSION="v1.17.3"` (default version: v1.17.3)
	@echo "Setting up Kubectl" ;\
	wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -O ${HOME}/bin/kubectl ;\
	chmod u+x ${HOME}/bin/kubectl ;\
	${HOME}/bin/kubectl version --client=true --short=true
	@echo "Kubectl done!"

krew: ## Install Krew: Kubectl plugin manager
	@echo "Istall Krew" ;\
	curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.{tar.gz,yaml}" ;\
	tar zxvf krew.tar.gz ;\
	./krew-linux_amd64 install --manifest=krew.yaml --archive=krew.tar.gz ;\
	./krew-linux_amd64 update ;\
	rm krew* LICENSE
	@echo "Krew done!"

kubectx:  ## Install Kubectx and Kubens
	@echo "Setting up Kubectx" ;\
	wget -q https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx -O ${HOME}/bin/kubectx ;\
	wget -q https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens -O ${HOME}/bin/kubens ;\
	chmod u+x ${HOME}/bin/kube*
	@echo "Kubectx and Kubens done!"

helm: ## Install Helm. Set version with `make helm HELM_VERSION="v3.3.0"` (default version: v3.3.0)
	@echo "Setting up Helm" ;\
	wget -q https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -O helm.tar.gz ;\
	tar -xf helm.tar.gz --strip-components=1 -C ${HOME}/bin ;\
	rm helm.tar.gz ${HOME}/bin/LICENSE ${HOME}/bin/README.md ;\
	${HOME}/bin/helm version --short
	@echo "Helm done!"

helm-repo: ## Add Helm repositories
	@echo "Adding & updating some helm repositories:" ;\
	echo "Adding Kubernetes Charts" ;\
	${HOME}/bin/helm repo add stable https://kubernetes-charts.storage.googleapis.com ;\
	${HOME}/bin/helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com ;\
	echo "Adding Nginx Charts" ;\
	${HOME}/bin/helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx ;\
	${HOME}/bin/helm repo update ;\
	echo ""
	${HOME}/bin/helm repo list
	echo ""
	@echo "Helm repositories succesfully added"

## Cloud Cli
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

## Addons
docker-compose: ## Install docker-compose (default version: latest)
	@echo "Installing Docker compose" ;\
	wget -q https://github.com/docker/compose/releases/latest/download/docker-compose-Linux-x86_64 -O ${HOME}/bin/docker-compose ;\
	chmod 755 ${HOME}/bin/docker-compose
	${HOME}/bin/docker-compose -v
	@echo "Docker compose done!"

gh-cli: ## Install Github Cli
	@echo "Install Github Cli" ;\
	wget https://github.com/cli/cli/releases/download/v1.1.0/gh_1.1.0_linux_amd64.deb ;\
	sudo bash -c "dpkg -i ./gh_1.1.0_linux_amd64.deb" ;\
	rm gh_1.1.0_linux_amd64.deb
	@echo "Github cli installed!"

tig: ## Install Tig
	@echo "Installing Tig" ;\
	sudo sh -c "apt update -qq && apt install -qq -y --no-install-recommends tig"
	@echo "Tig done!"

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
	ln -s -f ${DOTFILES}/cheats ${HOME}/.config/cheat/cheatsheets/personal
	@echo "Cheat done!"

asdf: ## Install asdf
	@echo "Installing ASDF" ;\
	rm -rf ${HOME}/.asdf ;\
	git clone https://github.com/asdf-vm/asdf.git ${HOME}/.asdf
	@echo "ASDF done!"

hadolint: ## Install Hadolint
	@echo "Installing Hadolint" ;\
	wget https://github.com/hadolint/hadolint/releases/latest/download/hadolint-Linux-x86_64 -O ${HOME}/bin/hadolint ;\
	chmod u+x ${HOME}/bin/hadolint
	@echo "Hadolint done!"

## Minis
minikube: ## Install Minikube
	@echo "Installing Minikube" ;\
	wget -q https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64 -O ${HOME}/bin/minikube ;\
	chmod 755 ${HOME}/bin/minikube ;\
	${HOME}/bin/minikube version
	@echo "Minikube done!"

minishift: ## Install Minishift. Set version with `make minishift MINISHIFT_VERSION="1.34.3"` (default version: 1.34.3)
	@echo "Install Minishift" ;\
	wget -q https://github.com/minishift/minishift/releases/download/v${MINISHIFT_VERSION}/minishift-${MINISHIFT_VERSION}-linux-amd64.tgz -O minishift.tgz ;\
	tar -xf minishift.tgz  --strip-components=1 -C ${HOME}/bin ;\
	rm minishift.tgz ${HOME}/bin/README.adoc ${HOME}/bin/LICENSE ;\
	${HOME}/bin/minishift version
	@echo "Minishift done!"

kind: ## Install Kind (Kubernetes on docker)
	@echo "Installing Kind" ;\
	wget -q https://storage.googleapis.com/k8s-staging-kind/latest/kind-linux-amd64 -O ${HOME}/bin/kind ;\
	chmod u+x ${HOME}/bin/kind ;\
	${HOME}/bin/kind version
	@echo "Kind done!"

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
