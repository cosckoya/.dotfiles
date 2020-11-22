.ONESHELL:
.SHELL:=/bin/sh
.PHONY: help all
.DEFAULT_GOAL:=help
CURRENT_FOLDER=$(shell basename "$$(pwd)")
BOLD=$(shell tput bold)
RED=$(shell tput setaf 1)
RESET=$(shell tput sgr0)

## Global
NAME=main
VERSION=scratch

## Paths
DOTFILES=${HOME}/.dotfiles

## Burn, baby, burn
help: ## Shows this makefile help
	@echo ""
	@echo "Klaatu Barata Nitko!"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: nmapautomator ## Install everything
	@echo "Installing Security tools" ;\
	chmod 755 -R ${HOME}/bin

nmapautomator: ## Install nmapAutomator script (requieres Nmap dependency)
	wget https://raw.githubusercontent.com/21y4d/nmapAutomator/master/nmapAutomator.sh -O ${HOME}/bin/nmapautomator
