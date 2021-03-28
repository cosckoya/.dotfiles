.ONESHELL:
.SHELL := /bin/sh
.PHONY: help
.DEFAULT_GOAL := help
CURRENT_FOLDER=$(shell basename "$$(pwd)")
BOLD=$(shell tput bold)
RED=$(shell tput setaf 1)
RESET=$(shell tput sgr0)

## Global
NAME=containers
VERSION=scratch

## Paths
DOTFILES=${HOME}/.dotfiles
CONTAINER=${DOTFILES}/container
ASDF=${HOME}/.asdf/bin/asdf

## Burn, baby, burn
help: ## Shows this makefile help
	@echo ""
	@echo "Klaatu Barata Nitko!"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: docker kubernetes minis ## Install Docker & Kubernetes tools
	chmod 755 -R ${HOME}/bin
	@echo "Container tools installed!"

## Tools by type
kubernetes: kubectl kubectx helm krew ## Install Kubernetes tools: Kubectl & Helm
	@echo "Kubernetes tools enabled."

docker: docker-compose dive ## Install Docker tools: compose, dive
	@echo "Docker tools enabled."

minis: minikube minishift kind ## Install Minikube and Minishift local kubernetes clusters
	@echo "Minis installed."

## Kubernetes
kubectl: ## Install Kubectl
	@echo "Setting up Kubectl" ;\
	${ASDF} plugin-add kubectl ;\
	${ASDF} install kubectl latest ;\
	${ASDF} local kubectl latest ;\
	$$(which kubectl) version --client=true --short=true
	@echo "Kubectl done!"

helm: ## Install Helm
	@echo "Setting up Helm" ;\
	${ASDF} plugin-add helm ;\
	${ASDF} install helm latest ;\
	${ASDF} local helm latest ;\
	$$(which helm) version --short ;\
	ln -s -f ${CONTAINER}/helm.zsh ${HOME}/.zsh.d/helm.zsh	
	@echo "Helm done!"

krew: ## Install Krew
	@echo "Istall Krew" ;\
	curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.{tar.gz,yaml}" ;\
	tar zxvf krew.tar.gz ;\
	./krew-linux_amd64 install --manifest=krew.yaml --archive=krew.tar.gz ;\
	./krew-linux_amd64 update ;\
	rm krew* LICENSE
	@echo "Krew done!"

kubectx:  ## Install Kubectx
	@echo "Setting up Kubectx" ;\
	${ASDF} plugin-add kubectx ;\
	${ASDF} install kubectx latest ;\
	${ASDF} local kubectx latest
	@echo "Kubectx done!"

## Docker
docker-compose: ## Install Docker-compose
	@echo "Installing Docker Compose" ;\
	wget -q https://github.com/docker/compose/releases/latest/download/docker-compose-Linux-x86_64 -O ${HOME}/bin/docker-compose ;\
	${HOME}/bin/docker-compose -v
	@echo "Docker compose done!"

dive: ## Install Dive
	@echo "Installing Dive" ;\
	curl --silent "https://api.github.com/repos/wagoodman/dive/releases/latest" | jq -r '.assets[].browser_download_url' | grep deb | xargs wget -q - ;\
	sudo sh -c "apt-get install -f ./*.deb" ;\
	rm *.deb* ;\
	dive version
	@echo "Dive Installed"

## Minis
minikube: ## Install Minikube
	@echo "Installing Minikube" ;\
	wget -q https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64 -O ${HOME}/bin/minikube ;\
	chmod 755 ${HOME}/bin/minikube ;\
	${HOME}/bin/minikube version
	@echo "Minikube done!"

minishift: ## Install Minishift
	@echo "Install Minishift" ;\
	curl --silent "https://api.github.com/repos/minishift/minishift/releases/latest" | jq -r '.assets[].browser_download_url' | grep linux-amd64.tgz | xargs wget ;\
	tar -xf minishift*.tgz --strip-components=1 -C ${HOME}/bin ;\
	rm *.tgz* ${HOME}/bin/README.adoc ${HOME}/bin/LICENSE ;\
	ln -s -f ${CONTAINER}/helm.zsh ${HOME}/.zsh.d/helm.zsh ;\
	${HOME}/bin/minishift version
	@echo "Minishift done!"

kind: ## Install Kind (Kubernetes on docker)
	@echo "Installing Kind" ;\
	wget -q https://storage.googleapis.com/k8s-staging-kind/latest/kind-linux-amd64 -O ${HOME}/bin/kind ;\
	chmod u+x ${HOME}/bin/kind ;\
	${HOME}/bin/kind version
	@echo "Kind done!"
