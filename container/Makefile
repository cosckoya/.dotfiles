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

## Versions
HELM_VERSION:="v3.3.0"
KUBECTL_VERSION:="v1.17.3"

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
kubernetes: kubectl kubectx helm helm-repo krew ## Install Kubernetes tools: Kubectl & Helm
	@echo "Kubernetes tools enabled."

docker: docker-compose dive ## Install Docker tools: compose, dive
	@echo "Docker tools enabled."

minis: minikube minishift kind ## Install Minikube and Minishift local kubernetes clusters
	@echo "Minis installed."

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
	${HOME}/bin/minishift version
	@echo "Minishift done!"

kind: ## Install Kind (Kubernetes on docker)
	@echo "Installing Kind" ;\
	wget -q https://storage.googleapis.com/k8s-staging-kind/latest/kind-linux-amd64 -O ${HOME}/bin/kind ;\
	chmod u+x ${HOME}/bin/kind ;\
	${HOME}/bin/kind version
	@echo "Kind done!"
