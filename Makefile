.ONESHELL:
SHELL := /bin/bash
.PHONY: help all profile zsh tmux kitty neovim install-nvim asdf
.DEFAULT_GOAL := help

OS := $(shell uname -s | tr '[:upper:]' '[:lower:]')
DOTFILES := $(shell pwd)

help: ## Shows this makefile help
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: asdf profile ## Install everything

profile: zsh tmux kitty neovim ## Install ZSH, Tmux, Kitty, and Neovim profiles

asdf: ## Install asdf (always latest version)
	@set -e; \
	ASDF_VERSION=$$(curl -s https://api.github.com/repos/asdf-vm/asdf/releases/latest | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/'); \
	ARCH=$$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$$/arm64/'); \
	test -n "$$ASDF_VERSION" || { echo "Error: Failed to fetch ASDF version"; exit 1; }; \
	mkdir -p ${HOME}/bin ${HOME}/.asdf; \
	wget -q "https://github.com/asdf-vm/asdf/releases/download/v$$ASDF_VERSION/asdf-v$$ASDF_VERSION-linux-$$ARCH.tar.gz" -O /tmp/asdf.tar.gz; \
	tar -xzf /tmp/asdf.tar.gz -C /tmp; \
	mv /tmp/asdf ${HOME}/bin/asdf; \
	chmod +x ${HOME}/bin/asdf; \
	rm -f /tmp/asdf.tar.gz; \
	echo "ASDF v$$ASDF_VERSION installed"

zsh: ## Install ZSH profile
	@set -e; \
	command -v zsh >/dev/null || { echo "Error: Install zsh first"; exit 1; }
ifeq ($(OS), linux)
	@USER=$$(whoami); \
	if [ "$$(getent passwd $$USER | cut -d: -f7)" != "/bin/zsh" ]; then \
		sudo usermod -s /bin/zsh $$USER; \
	fi
endif
	@rm -f ${HOME}/.zshrc ${HOME}/.zsh.d
	@ln -sf ${DOTFILES}/zshrc ${HOME}/.zshrc
	@ln -sf ${DOTFILES}/zsh.d ${HOME}/.zsh.d
	@echo "ZSH configured"

install-nvim: ## Install Neovim via snap (requires sudo)
	@command -v snap >/dev/null || { echo "Error: Install snapd first (sudo apt install snapd)"; exit 1; }
	@sudo snap install nvim --classic
	@echo "Neovim installed"

neovim: ## Install Neovim Lua profile
	@set -e; \
	command -v nvim >/dev/null || { echo "Error: Install neovim first (make install-nvim)"; exit 1; }; \
	NVIM_MAJOR=$$(nvim --version | head -1 | sed 's/NVIM v//' | cut -d'.' -f1); \
	NVIM_MINOR=$$(nvim --version | head -1 | sed 's/NVIM v//' | cut -d'.' -f2); \
	test "$$NVIM_MAJOR" -gt 0 || test "$$NVIM_MINOR" -ge 11 || { echo "Error: Neovim 0.11+ required"; exit 1; }; \
	rm -rf ${HOME}/.config/nvim; \
	ln -s ${DOTFILES}/config/nvim ${HOME}/.config/nvim; \
	ln -sf ${DOTFILES}/vimrc ${HOME}/.vimrc; \
	echo "Neovim configured"

tmux: ## Install TMUX profile
	@ln -sf ${DOTFILES}/config/tmux.conf ${HOME}/.tmux.conf
	@echo "TMUX configured"

kitty: ## Install Kitty terminal profile
	@mkdir -p ${HOME}/.config/kitty
	@ln -sf ${DOTFILES}/config/kitty.conf ${HOME}/.config/kitty/kitty.conf
	@echo "Kitty configured"
