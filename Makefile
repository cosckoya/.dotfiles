## Global
NAME=profile-generator
VERSION=scratch
SHELL=/bin/sh

## Paths
DOTFILES=${HOME}/.dotfiles

## Versions
ANSIBLE_VERSION:="2.9.10"
HELM_VERSION:="v3.2.4"
KUBECTL_VERSION:="v1.17.3"
TERRAFORM_VERSION:="0.12.28"

.PHONY: help
help: ## Shows this makefile help
	@echo ""
	@echo "Klaatu Barata Nitko!"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

dependencies: pip3 pre-commit ## Installs Linux package dependencies
	@echo "Installing package dependencies" ;\
	sudo bash -c "apt update -qq &&\
		apt install -qq -y --no-install-recommends \
		ca-certificates apt-transport-https lsb-release gnupg\
		unzip" ;\

pip3: ## Install Python Pip3
	@echo "Installing Python Pip3" ;\
	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py ;\
	python3 get-pip.py --user ;\
	rm get-pip.py ;\
	ansible --version

all: dependencies profile iac cloud addons ## Install Profile, IaC, Cloud and terminal addons
	@echo "Setting up local environment"

profile: zsh tmux neovim ## Install ZSH, TMUX and Vim/Neovim plugins and profiles
	@echo "Custom profile ready to rumble. Enjoy!"

iac: ansible terraform kubernetes ## Install Pip3+Ansible, Terraform and Kubernetes tools
	sudo chown -R ${USER}: ${HOME}/bin ;\
	chmod 755 -R ${HOME}/bin
	@echo "Toolbox ready to be used. Enjoy!"

kubernetes: kubectl kubectx helm ## Install Kubernetes tools: Kubectl, Helm and Kubectx
	chmod 755 -R ${HOME}/bin
	@echo "Kubernetes tools enabled. Enjoy!"

cloud: aws azure google ## Install AWS-Cli v2, Azure Cli and Google SDK
	@echo "Cloud tools enabled. Enjoy!"

addons: tig git-secret cheat docker-compose adsf ## Install Addons: tig, asdf, cheat, docker-compose, asdf +More
	@echo "Shell Add-ons enabled. Enjoy!"

# PROFILE

bash: ## Install Bash profile
	@echo "Setting up BASH profile" ;\
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

# TOOLS

ansible: ## Install Pip3+Ansible. Set version with `make ansible ANSIBLE_VERSION="2.9.10"` (default version: 2.9.10)
	@echo "Setting up Ansible" ;\
	pip3 install --user ansible==${ANSIBLE_VERSION} ;\
	ansible --version
	@echo "Ansible done!"

terraform: ## Install Terraform. Set version with `make terraform TERRAFORM_VERSION="0.12.28"` (default version: 0.12.28)
	@echo "Setting up HashiCorp Terraform" ;\
	wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -O terraform.zip ;\
	unzip -o terraform.zip -d ${HOME}/bin ;\
	rm terraform.zip ;\
	terraform version
	@echo "Terraform done!"

kubectl: ## Install Kubectl. Set version with `make kubectl KUBECTL_VERSION="v1.17.3"` (default version: v1.17.3)
	@echo "Setting up Kubectl" ;\
	wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -O ${HOME}/bin/kubectl ;\
	chmod u+x ${HOME}/bin/kubectl ;\
	kubectl version --client=true --short=true
	@echo "Kubectl done!"

helm: ## Install Helm. Set version with `make helm HELM_VERSION="v3.2.4"` (default version: v3.2.4)
	@echo "Setting up Helm" ;\
	wget -q https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -O helm.tar.gz ;\
	tar -xf helm.tar.gz --strip-components=1 -C ${HOME}/bin ;\
	rm helm.tar.gz ${HOME}/bin/LICENSE ${HOME}/bin/README.md ;\
	helm version --short
	@echo "Helm done!"

# CLOUD

azure: ## Install Azure Cli (az)
	@echo "Installing Azure Cli" ;\
	curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash ;\
	az version
	@echo "Azure Cli done!"

aws: ## Install Amazon AWS-Cli v2 (aws)
	@echo "Installing AWS Cli"
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" ;\
	unzip awscliv2.zip ;\
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

# ADDONS

pre-commit: ## Install Pre-Commit
	@echo "Install Pre-Commit" ;\
	pip3 install pre-commit --user ;\
	pre-commit --version

kubectx:  ## Install Kubectx and Kubens
	@echo "Setting up Kubectx" ;\
	wget -q https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx -O ${HOME}/bin/kubectx ;\
	wget -q https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens -O ${HOME}/bin/kubens ;\
	chmod u+x ${HOME}/bin/kube*
	@echo "Kubectx and Kubens done!"

tig: ## Install Tig
	@echo "Installing Tig" ;\
	sudo bash -c "apt update -qq && apt install -qq -y --no-install-recommends tig"
	@echo "Tig done!"

git-secret: ## Install git-secret
	@echo "Installing git-secret. See git-secret.io for more info" ;\
	echo "deb https://dl.bintray.com/sobolevn/deb git-secret main" | sudo tee -a /etc/apt/sources.list ;\
	wget -qO - https://api.bintray.com/users/sobolevn/keys/gpg/public.key | sudo apt-key add - ;\
	sudo bash -c "apt-get update && apt-get install git-secret"
	@echo "git-secret done!"

cheat: ## Install cheat
	@echo "Installing Cheat" ;\
	wget -q https://github.com/cheat/cheat/releases/latest/download/cheat-linux-amd64.gz ;\
	gzip -dc < cheat-linux-amd64.gz > ${HOME}/bin/cheat ;\
	rm cheat-linux-amd64.gz ;\
	chmod 755 ${HOME}/bin/cheat ;\
	mkdir -p ~/.config/cheat/cheatsheets && cheat --init > ~/.config/cheat/conf.yml ;\
	git clone https://github.com/cheat/cheatsheets.git ${HOME}/.config/cheat/cheatsheets/community ;\
	ln -s -f ${DOTFILES}/cheats ${HOME}/.config/cheat/cheatsheets/personal
	@echo "Cheat done!"

asdf: ## Install asdf
	@echo "Installing ASDF" ;\
	git clone https://github.com/asdf-vm/asdf.git ${HOME}/.asdf
	@echo "ASDF done!"

docker-compose: ## Install docker-compose (default version: latest)
	@echo "Installing Docker compose" ;\
	wget -q https://github.com/docker/compose/releases/latest/download/docker-compose-Linux-x86_64 -O ${HOME}/bin/docker-compose ;\
	chmod 755 ${HOME}/bin/docker-compose
	docker-compose -v
	@echo "Docker compose done!"
