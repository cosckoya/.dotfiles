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
OS=$(shell uname | tr '[:upper:]' '[:lower:]')
ARCH=$(shell uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$$/arm64/')

## Paths
DOTFILES=${HOME}/.dotfiles
CONTAINER=${DOTFILES}/container

## Burn, baby, burn
help: ## Shows this makefile help
	@echo ""
	@echo "Klaatu Barata Nitko!"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

info: ## Show Arch and OS info
	@echo ""
	@echo $(OS)
	@echo $(ARCH)

all: docker kubernetes minis ## Install Docker & Kubernetes tools
	@echo "Container tools installed!"

## Tools by type
kubernetes: kubectl kubectx helm krew ## Install Kubernetes tools: Kubectl & Helm
	@echo "Kubernetes tools enabled."

docker: docker-ce docker-compose dive ## Install Docker tools: compose, dive
	@echo "Docker tools enabled."

minis: kind ## Install Minikube and Minishift local kubernetes clusters
	@echo "Minis installed."

## Kubernetes
kubectl: ## Install Kubectl
	asdf plugin-add kubectl ;\
	asdf install kubectl latest ;\
	asdf global kubectl latest

helm: ## Install Helm
	asdf plugin-add helm ;\
	asdf install helm latest ;\
	asdf global helm latest

kubectx: ## Install Kubectx
	asdf plugin-add kubectx ;\
	asdf install kubectx latest ;\
	asdf global kubectx latest

krew: ## Install Krew
	asdf plugin-add krew ;\
	asdf install krew latest ;\
	asdf global krew latest

## Docker

docker-ce: ## Install Docker CE
	@echo "Installing Docker CE" ;\
	curl -fsSL https://get.docker.com -o get-docker.sh ;\
	sudo sh -c "sh get-docker.sh" ;\
	rm ./get-docker.sh ;\
	sudo sh -c "usermod -aG docker ${USER}"

docker-compose: ## Install Docker-compose
	@echo "Installing Docker Compose" ;\
	wget -q https://github.com/docker/compose/releases/latest/download/docker-compose-Linux-x86_64 -O ${HOME}/bin/docker-compose ;\
	chmod 755 -R ${HOME}/bin/docker-compose ;\
	${HOME}/bin/docker-compose -v
	@echo "Docker compose done!"

dive: ## Install Dive
	@echo "Installing Dive" ;\
	asdf plugin-add dive ;\
	asdf install dive latest ;\
	asdf global dive latest

kind: ## Install Kind (Kubernetes on docker)
	@echo "Installing Kind" ;\
	asdf plugin-add kind ;\
	asdf install kind latest ;\
	asdf global kind latest
