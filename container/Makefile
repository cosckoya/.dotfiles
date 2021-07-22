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
	@chmod 755 -R ${HOME}/bin
	@echo "Container tools installed!"

## Tools by type
kubernetes: kubectl kubectx helm kustomize krew oc ## Install Kubernetes tools: Kubectl & Helm
	@echo "Kubernetes tools enabled."

docker: docker-compose dive ## Install Docker tools: compose, dive
	@echo "Docker tools enabled."

minis: minikube minishift kind ## Install Minikube and Minishift local kubernetes clusters
	@echo "Minis installed."

## Kubernetes
kubectl: ## Install Kubectl
	${ASDF} plugin-add kubectl ;\
	${ASDF} install kubectl latest ;\
	${ASDF} global kubectl latest

helm: ## Install Helm
	${ASDF} plugin-add helm ;\
	${ASDF} install helm latest ;\
	${ASDF} global helm latest

kubectx: ## Install Kubectx
	${ASDF} plugin-add kubectx ;\
	${ASDF} install kubectx latest ;\
	${ASDF} global kubectx latest

krew: ## Install Krew
	@echo "Install Krew" ;\
	curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.{tar.gz,yaml}" ;\
	tar zxvf krew.tar.gz ;\
	./krew-linux_amd64 install --manifest=krew.yaml --archive=krew.tar.gz ;\
	./krew-linux_amd64 update ;\
	rm krew* LICENSE
	@echo "Krew done!"

kustomize: ## Install Kustomize
	${ASDF} plugin-add kustomize ;\
	${ASDF} install kustomize latest ;\
	${ASDF} global kustomize latest

## Docker
docker-compose: ## Install Docker-compose
	@echo "Installing Docker Compose" ;\
	wget -q https://github.com/docker/compose/releases/latest/download/docker-compose-Linux-x86_64 -O ${HOME}/bin/docker-compose ;\
	${HOME}/bin/docker-compose -v
	@echo "Docker compose done!"

dive: ## Install Dive
	@echo "Installing Dive" ;\
	${ASDF} plugin-add dive ;\
	${ASDF} install dive latest ;\
	${ASDF} global dive latest

## Minis
minikube: ## Install Minikube
	@echo "Installing Minikube" ;\
	${ASDF} plugin-add minikube ;\
	${ASDF} install minikube latest ;\
	${ASDF} global minikube latest

minishift: ## Install Minishift
	@echo "Installing Minishift" ;\
	${ASDF} plugin-add minishift ;\
	${ASDF} install minishift latest ;\
	${ASDF} global minishift latest

oc: ## Install OC
	@echo "Installing OC" ;\
	${ASDF} plugin-add oc ;\
	${ASDF} install oc latest ;\
	${ASDF} global oc latest

kind: ## Install Kind (Kubernetes on docker)
	@echo "Installing Kind" ;\
	${ASDF} plugin-add kind ;\
	${ASDF} install kind latest ;\
	${ASDF} global kind latest
