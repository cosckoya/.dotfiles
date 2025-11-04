.ONESHELL:
SHELL := /bin/bash
.PHONY: help info all kubernetes docker minis kubectl kubectx helm krew docker-ce docker-compose dive kind check-asdf
.DEFAULT_GOAL := help
CURRENT_FOLDER := $(shell basename "$$(pwd)")
BOLD := $(shell tput bold)
RED := $(shell tput setaf 1)
GREEN := $(shell tput setaf 2)
YELLOW := $(shell tput setaf 3)
RESET := $(shell tput sgr0)

## Global
NAME := containers
VERSION := scratch
OS := $(shell uname | tr '[:upper:]' '[:lower:]')
ARCH := $(shell uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$$/arm64/')

## Paths
DOTFILES := ${HOME}/.dotfiles
CONTAINER := ${DOTFILES}/container

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

all: check-asdf docker kubernetes minis ## Install Docker & Kubernetes tools
	@echo "$(BOLD)$(GREEN)Container tools installed!$(RESET)"

check-asdf: ## Check if asdf is installed
	@command -v asdf >/dev/null 2>&1 || { echo "$(RED)Error: asdf is not installed. Please run 'make asdf' from the root directory.$(RESET)"; exit 1; }

## Tools by type
kubernetes: kubectl kubectx helm krew ## Install Kubernetes tools: Kubectl & Helm
	@echo "$(BOLD)$(GREEN)Kubernetes tools enabled.$(RESET)"

docker: docker-ce docker-compose dive ## Install Docker tools: compose, dive
	@echo "$(BOLD)$(GREEN)Docker tools enabled.$(RESET)"

minis: kind ## Install Minikube and Minishift local kubernetes clusters
	@echo "$(BOLD)$(GREEN)Minis installed.$(RESET)"

## Kubernetes
kubectl: check-asdf ## Install Kubectl
	@echo "$(BOLD)Installing Kubectl$(RESET)"
	@set -e; \
	asdf plugin add kubectl 2>/dev/null || true; \
	asdf install kubectl latest; \
	asdf set --home kubectl latest; \
	echo "$(GREEN)Kubectl installed$(RESET)"

helm: check-asdf ## Install Helm
	@echo "$(BOLD)Installing Helm$(RESET)"
	@set -e; \
	asdf plugin add helm 2>/dev/null || true; \
	asdf install helm latest; \
	asdf set --home helm latest; \
	echo "$(GREEN)Helm installed$(RESET)"

kubectx: check-asdf ## Install Kubectx
	@echo "$(BOLD)Installing Kubectx$(RESET)"
	@set -e; \
	asdf plugin add kubectx 2>/dev/null || true; \
	asdf install kubectx latest; \
	asdf set --home kubectx latest; \
	echo "$(GREEN)Kubectx installed$(RESET)"

krew: check-asdf ## Install Krew
	@echo "$(BOLD)Installing Krew$(RESET)"
	@set -e; \
	asdf plugin add krew 2>/dev/null || true; \
	asdf install krew latest; \
	asdf set --home krew latest; \
	echo "$(GREEN)Krew installed$(RESET)"

## Docker

docker-ce: ## Install Docker CE
	@echo "$(BOLD)Installing Docker CE$(RESET)"
	@set -e; \
	if command -v docker >/dev/null 2>&1; then \
		echo "$(YELLOW)Docker already installed$(RESET)"; \
	else \
		curl -fsSL https://get.docker.com -o get-docker.sh; \
		sudo sh get-docker.sh; \
		rm ./get-docker.sh; \
		sudo usermod -aG docker ${USER}; \
		echo "$(GREEN)Docker CE installed. Please log out and back in for group changes to take effect.$(RESET)"; \
	fi

docker-compose: ## Install Docker-compose
	@echo "$(BOLD)Installing Docker Compose$(RESET)"
	@set -e; \
	mkdir -p ${HOME}/bin; \
	wget -q https://github.com/docker/compose/releases/latest/download/docker-compose-Linux-x86_64 -O ${HOME}/bin/docker-compose; \
	chmod 755 ${HOME}/bin/docker-compose; \
	${HOME}/bin/docker-compose version; \
	echo "$(GREEN)Docker compose done!$(RESET)"

dive: check-asdf ## Install Dive
	@echo "$(BOLD)Installing Dive$(RESET)"
	@set -e; \
	asdf plugin add dive 2>/dev/null || true; \
	asdf install dive latest; \
	asdf set --home dive latest; \
	echo "$(GREEN)Dive installed$(RESET)"

kind: check-asdf ## Install Kind (Kubernetes on docker)
	@echo "$(BOLD)Installing Kind$(RESET)"
	@set -e; \
	asdf plugin add kind 2>/dev/null || true; \
	asdf install kind latest; \
	asdf set --home kind latest; \
	echo "$(GREEN)Kind installed$(RESET)"
