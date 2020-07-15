#              ██▓███   ██▀███   ▒█████    █████▒██▓ ██▓    ▓█████
#             ▓██░  ██▒▓██ ▒ ██▒▒██▒  ██▒▓██   ▒▓██▒▓██▒    ▓█   ▀
#             ▓██░ ██▓▒▓██ ░▄█ ▒▒██░  ██▒▒████ ░▒██▒▒██░    ▒███
#             ▒██▄█▓▒ ▒▒██▀▀█▄  ▒██   ██░░▓█▒  ░░██░▒██░    ▒▓█  ▄
#             ▒██▒ ░  ░░██▓ ▒██▒░ ████▓▒░░▒█░   ░██░░██████▒░▒████▒
#             ▒▓▒░ ░  ░░ ▒▓ ░▒▓░░ ▒░▒░▒░  ▒ ░   ░▓  ░ ▒░▓  ░░░ ▒░ ░
#             ░▒ ░       ░▒ ░ ▒░  ░ ▒ ▒░  ░      ▒ ░░ ░ ▒  ░ ░ ░  ░
#             ░░         ░░   ░ ░ ░ ░ ▒   ░ ░    ▒ ░  ░ ░      ░
#                         ░         ░ ░          ░      ░  ░   ░  ░
#
#   ▄████ ▓█████  ███▄    █ ▓█████  ██▀███   ▄▄▄     ▄▄▄█████▓ ▒█████   ██▀███
#  ██▒ ▀█▒▓█   ▀  ██ ▀█   █ ▓█   ▀ ▓██ ▒ ██▒▒████▄   ▓  ██▒ ▓▒▒██▒  ██▒▓██ ▒ ██▒
# ▒██░▄▄▄░▒███   ▓██  ▀█ ██▒▒███   ▓██ ░▄█ ▒▒██  ▀█▄ ▒ ▓██░ ▒░▒██░  ██▒▓██ ░▄█ ▒
# ░▓█  ██▓▒▓█  ▄ ▓██▒  ▐▌██▒▒▓█  ▄ ▒██▀▀█▄  ░██▄▄▄▄██░ ▓██▓ ░ ▒██   ██░▒██▀▀█▄
# ░▒▓███▀▒░▒████▒▒██░   ▓██░░▒████▒░██▓ ▒██▒ ▓█   ▓██▒ ▒██▒ ░ ░ ████▓▒░░██▓ ▒██▒
#  ░▒   ▒ ░░ ▒░ ░░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒▓ ░▒▓░ ▒▒   ▓▒█░ ▒ ░░   ░ ▒░▒░▒░ ░ ▒▓ ░▒▓░
#   ░   ░  ░ ░  ░░ ░░   ░ ▒░ ░ ░  ░  ░▒ ░ ▒░  ▒   ▒▒ ░   ░      ░ ▒ ▒░   ░▒ ░ ▒░
# ░ ░   ░    ░      ░   ░ ░    ░     ░░   ░   ░   ▒    ░      ░ ░ ░ ▒    ░░   ░
#       ░    ░  ░         ░    ░  ░   ░           ░  ░            ░ ░     ░
# by Cosckoya

## Global
NAME=profile-generator
VERSION=scratch
SHELL=/bin/sh

## PATHS
DOTFILES=${HOME}/.dotfiles

# VERSION
##
ANSIBLE_VERSION:="2.9.10"
## Helm
HELM_VERSION:="v3.2.4"
## Kubectl
KUBECTL_VERSION:="v1.17.3"
## Terraform
TERRAFORM_VERSION:="0.12.28"

###

all: profile iac cloud addons
	@echo "Setting up local environment"

info:
	@echo "Klaatu Barata Nitko!"
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'

profile: zsh tmux neovim
	@echo "Custom profile ready to rumble. Enjoy!"

iac: ansible terraform kubernetes
	sudo chown -R ${USER}: ${HOME}/bin ;\
	chmod 755 -R ${HOME}/bin
	@echo "Toolbox ready to be used. Enjoy!"

kubernetes: kubectl kubectx helm
	chmod 755 -R ${HOME}/bin
	@echo "Kubernetes tools enabled. Enjoy!"

cloud: aws azure google
	@echo "Cloud tools enabled. Enjoy!"

addons: tig git-secret cheat docker-compose
	@echo "Shell Add-ons enabled. Enjoy!"

### PROFILE

bash:
	@echo "Setting up BASH profile" ;\
	ln -s -f ${DOTFILES}/bashrc ${HOME}/.bashrc

zsh:
	@echo "Setting up ZSH profile" ;\
	sudo sh -c "apt update -qq && apt install -qq -y --no-install-recommends zsh" ;\
	sudo sh -c "usermod --shell /bin/zsh ${USER}" ;\
	ln -s -f ${DOTFILES}/zshrc ${HOME}/.zshrc

neovim:
	@echo "Setting up NeoVIM" ;\
	sudo bash -c "apt update -qq && apt install -qq -y --no-install-recommends neovim vim" ;\
	mkdir -p ~/.config/nvim ;\
	ln -s -f ${DOTFILES}/vimrc ${HOME}/.config/nvim/init.vim ;\
	ln -s -f ${DOTFILES}/vimrc ${HOME}/.vimrc
	@echo "Vim & NeoVim done!"

tmux:
	@echo "Setting up TMUX" ;\
	sudo bash -c "apt update -qq && apt install -qq -y --no-install-recommends tmux" ;\
	wget -q https://raw.githubusercontent.com/gpakosz/.tmux/master/.tmux.conf -O ${HOME}/.tmux.conf ;\
	ln -s -f ${DOTFILES}/tmux.local ${HOME}/.tmux.conf.local

### TOOLS

ansible:
	@echo "Setting up Ansible" ;\
	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py ;\
	python3 get-pip.py --user ;\
	pip3 install --user ansible==${ANSIBLE_VERSION} ;\
	rm get-pip.py ;\
	ansible --version
	@echo "Ansible done!"

terraform:
	@echo "Setting up HashiCorp Terraform" ;\
	wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -O terraform.zip ;\
	unzip terraform.zip -d ${HOME}/bin ;\
	rm terraform.zip ;\
	terraform version
	@echo "Terraform done!"

kubectl:
	@echo "Setting up Kubectl" ;\
	wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -O ${HOME}/bin/kubectl ;\
	chmod u+x ${HOME}/bin/kubectl ;\
	kubectl version --client=true --short=true
	@echo "Kubectl done!"

helm:
	@echo "Setting up Helm" ;\
	wget -q https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -O helm.tar.gz ;\
	tar -xf helm.tar.gz --strip-components=1 -C ${HOME}/bin ;\
	rm helm.tar.gz ${HOME}/bin/LICENSE ${HOME}/bin/README.md ;\
	helm version --short
	@echo "Helm done!"

### CLOUD

azure:
	@echo "Installing Azure Cli" ;\
	curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash ;\
	az version
	@echo "Azure Cli done!"

aws:
	@echo "Installing AWS Cli"
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" ;\
	unzip awscliv2.zip ;\
	sudo ./aws/install -i ${HOME}/.config/aws-cli -b ${HOME}/bin --update ;\
	sudo chown -R ${USER}: ${HOME}/bin ${HOME}/.config/aws-cli ;\
	rm -rf ./aws awscliv2.zip ;\
	${HOME}/bin/aws --version
	@echo "AWS cli done!"

google:
	@echo "Installing Google SDK" ;\
	sudo sh -c "echo 'deb https://packages.cloud.google.com/apt cloud-sdk main' > /etc/apt/sources.list.d/google-cloud-sdk.list" ;\
	curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - ;\
	sudo sh -c "apt update -qq && apt install -qq -y --no-install-recommends google-cloud-sdk"
	@echo "GCloud SDK done!"

### ADDONS

kubectx:
	@echo "Setting up Kubectx" ;\
	wget -q https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx -O ${HOME}/bin/kubectx ;\
	wget -q https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens -O ${HOME}/bin/kubens ;\
	chmod u+x ${HOME}/bin/kube*
	@echo "Kubectx and Kubens done!"

tig:
	@echo "Installing Tig" ;\
	sudo bash -c "apt update -qq && apt install -qq -y --no-install-recommends tig"
	@echo "Tig done!"

git-secret:
	@echo "Installing git-secret. See git-secret.io for more info" ;\
	echo "deb https://dl.bintray.com/sobolevn/deb git-secret main" | sudo tee -a /etc/apt/sources.list ;\
	wget -qO - https://api.bintray.com/users/sobolevn/keys/gpg/public.key | sudo apt-key add - ;\
	sudo bash -c "apt-get update && apt-get install git-secret"
	@echo "git-secret done!"

cheat:
	@echo "Installing Cheat" ;\
	wget -q https://github.com/cheat/cheat/releases/latest/download/cheat-linux-amd64.gz ;\
	gzip -dc < cheat-linux-amd64.gz > ${HOME}/bin/cheat ;\
	rm cheat-linux-amd64.gz ;\
	chmod 755 ${HOME}/bin/cheat ;\
	mkdir -p ~/.config/cheat/cheatsheets && cheat --init > ~/.config/cheat/conf.yml ;\
	git clone https://github.com/cheat/cheatsheets.git ${HOME}/.config/cheat/cheatsheets/community ;\
	ln -s -f ${DOTFILES}/cheats ${HOME}/.config/cheat/cheatsheets/personal
	@echo "Cheat done!"

asdf:
	@echo "Installing ASDF" ;\
	git clone https://github.com/asdf-vm/asdf.git ${HOME}/.asdf
	@echo "ASDF done!"

docker-compose:
	@echo "Installing Docker compose" ;\
	wget -q https://github.com/docker/compose/releases/latest/download/docker-compose-Linux-x86_64 -O ${HOME}/bin/docker-compose ;\
	chmod 755 ${HOME}/bin/docker-compose
	docker-compose -v
	@echo "Docker compose done!"
