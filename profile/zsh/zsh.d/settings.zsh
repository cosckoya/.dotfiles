# History
HIST_STAMPS="yyyy-mm-dd"
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks   # remove superfluous blanks from history items
setopt inc_append_history   # save history entries as soon as they are entered
setopt share_history        # share history between different instances of the shell

# Paths
export PATH=$PATH:$HOME/bin:/usr/local/bin:$HOME/.local/bin
export MANPATH=$MANPATH:/usr/local/man
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
export LANG=en_US.UTF-8

# TMUX
if [ "$TMUX" = "" ]; then tmux; fi

# EDITOR
export VISUAL='vi'
export EDITOR="$VISUAL"
alias vi='nvim'

# Zstyle!
autoload -Uz vcs_info
autoload -U colors && colors
autoload -U promptinit && promptinit
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
zstyle ':vcs_info:*' enable git
PROMPT="%F{113}%m%F{227}の%F{197}%n %{$reset_color%}❯ "   # 魔(demon) 亀 (Kame) 武(Wu) 悟 (Go) の ✯ ☭ ツ ㅎ Æ

# GOLANG
if [ -d "$GOPATH" ]; then
  export PATH="$PATH:$GOPATH/bin"
elif [[ $commands[go] ]]; then
  export PATH="$PATH:$(go env GOPATH)/bin"  
fi