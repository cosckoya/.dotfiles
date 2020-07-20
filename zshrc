# ▒███████▒  ██████  ██░ ██     ██▓███   ██▀███   ▒█████    █████▒██▓ ██▓    ▓█████
# ▒ ▒ ▒ ▄▀░▒██    ▒ ▓██░ ██▒   ▓██░  ██▒▓██ ▒ ██▒▒██▒  ██▒▓██   ▒▓██▒▓██▒    ▓█   ▀
# ░ ▒ ▄▀▒░ ░ ▓██▄   ▒██▀▀██░   ▓██░ ██▓▒▓██ ░▄█ ▒▒██░  ██▒▒████ ░▒██▒▒██░    ▒███
#   ▄▀▒   ░  ▒   ██▒░▓█ ░██    ▒██▄█▓▒ ▒▒██▀▀█▄  ▒██   ██░░▓█▒  ░░██░▒██░    ▒▓█  ▄
# ▒███████▒▒██████▒▒░▓█▒░██▓   ▒██▒ ░  ░░██▓ ▒██▒░ ████▓▒░░▒█░   ░██░░██████▒░▒████▒
# ░▒▒ ▓░▒░▒▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒   ▒▓▒░ ░  ░░ ▒▓ ░▒▓░░ ▒░▒░▒░  ▒ ░   ░▓  ░ ▒░▓  ░░░ ▒░ ░
# ░░▒ ▒ ░ ▒░ ░▒  ░ ░ ▒ ░▒░ ░   ░▒ ░       ░▒ ░ ▒░  ░ ▒ ▒░  ░      ▒ ░░ ░ ▒  ░ ░ ░  ░
# ░ ░ ░ ░ ░░  ░  ░   ░  ░░ ░   ░░         ░░   ░ ░ ░ ░ ▒   ░ ░    ▒ ░  ░ ░      ░
#   ░ ░          ░   ░  ░  ░               ░         ░ ░          ░      ░  ░   ░  ░
# .zshrc by Cosckoya

# History
HIST_STAMPS="yyyy-mm-dd"
HISTFILE=$HOME/.histfile
HISTSIZE=1000
SAVEHIST=1000

# PATHS
export PATH=$PATH:$HOME/bin:/usr/local/bin:$HOME/.local/bin
export MANPATH=$MANPATH:/usr/local/man
export LANG=en_US.UTF-8

## GOLANG
if [ -d "$GOPATH" ]; then
  export PATH="$GOPATH/bin:$PATH"
elif [[ $commands[go] ]]; then
  export PATH="$(go env GOPATH)/bin:$PATH"
fi

# EDITOR
export VISUAL='vi'

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="$VISUAL"
else
  export EDITOR="$VISUAL"
fi

# ALIAS
alias vi='nvim'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# ZPLUGINS
## Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

## Essential
source ~/.zplug/init.zsh

## Plugins
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3

# Oh my ZSH
zplug "plugins/git",  from:oh-my-zsh, as:plugin
zplug "plugins/tig",  from:oh-my-zsh, as:plugin
zplug "plugins/kubectl",  from:oh-my-zsh, as:plugin
zplug "plugins/docker",  from:oh-my-zsh, as:plugin
zplug "plugins/minikube",  from:oh-my-zsh, as:plugin
zplug "plugins/terraform",  from:oh-my-zsh, as:plugin
zplug "plugins/z",  from:oh-my-zsh, as:plugin
zplug "plugins/asdf", from:oh-my-zsh, as:plugin

# Install packages that have not been installed yet
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi

zplug load

# Zstyle!
autoload -Uz vcs_info
autoload -U colors && colors
autoload -U promptinit && promptinit
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
export PROMPT="%{${fg[green]}%}%m%{${fg[yellow]}%}の%{${fg[red]}%}%n %{${fg[blue]}%}%2~ \$vcs_info_msg_0_❯ "
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
zstyle ':vcs_info:*' enable git

# AUTOCOMPLETE
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit
complete -C "$HOME/bin/aws_completer" aws
source /etc/bash_completion.d/azure-cli
source /etc/bash_completion.d/gcloud
source <(helm completion zsh)
source $HOME/.asdf/asdf.sh && source $HOME/.asdf/completions/asdf.bash
