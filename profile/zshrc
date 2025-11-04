# ~/.zshrc file for zsh interactive shells.
# see /usr/share/doc/zsh/examples/zshrc for examples

# Load configuration first
if [[ -f ~/.zsh.d/config.zsh ]]; then
  source ~/.zsh.d/config.zsh
fi

# Tmux auto-start (must be at the beginning)
if command -v tmux >/dev/null 2>&1 && [[ "$TMUX_AUTOSTART_ENABLED" != "false" ]]; then
  # Check we're not already in tmux
  if [[ -z "$TMUX" ]]; then
    _skip_tmux=false

    # Skip if in desktop environment (when TMUX_SKIP_DESKTOP is true)
    if [[ "$TMUX_SKIP_DESKTOP" == "true" ]] && [[ -n "$DESKTOP_SESSION" ]]; then
      # Check if current desktop session is in the skip list
      for desktop in ${(s:,:)TMUX_SKIP_DESKTOP_SESSIONS}; do
        if [[ "$DESKTOP_SESSION" == "$desktop" ]]; then
          _skip_tmux=true
          break
        fi
      done
    fi

    # Skip if in IDE (when TMUX_SKIP_IDE is true)
    if [[ "$TMUX_SKIP_IDE" == "true" ]] && [[ -n "$INSIDE_EMACS" || -n "$VSCODE_PID" ]]; then
      _skip_tmux=true
    fi

    # Skip if in SSH (when TMUX_SKIP_SSH is true)
    if [[ "$TMUX_SKIP_SSH" == "true" ]] && [[ -n "$SSH_CONNECTION" ]]; then
      _skip_tmux=true
    fi

    # Check if terminal is interactive and not skipped
    if [[ $- == *i* ]] && [[ "$_skip_tmux" == "false" ]]; then
      # Attach to existing session or create new one
      tmux attach-session -t "${TMUX_AUTOSTART_SESSION:-default}" 2>/dev/null || \
        tmux new-session -s "${TMUX_AUTOSTART_SESSION:-default}"
    fi

    unset _skip_tmux
  fi
fi

# Zinit: https://github.com/zdharma-continuum/zinit
if [[ ! -d ~/.local/share/zinit/zinit.git ]]; then
  git clone https://github.com/zdharma-continuum/zinit.git ~/.local/share/zinit/zinit.git
fi

# Paths
export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.asdf/shims:$PATH
export MANPATH=/usr/local/man:$MANPATH
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export LANG=en_US.UTF-8

# Initialize Zinit
source $HOME/.local/share/zinit/zinit.git/zinit.zsh

# History
alias history="history 0"
HIST_STAMPS="yyyy-mm-dd"
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=$HISTSIZE

# Options
setopt autocd
setopt auto_list
setopt auto_menu
setopt always_to_end
setopt inc_append_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify

# Tool paths
source ~/.zsh.d/tools.zsh
source ~/.zsh.d/toolbox.zsh

# Alias
source ~/.zsh.d/alias.zsh

# Tmux helpers
source ~/.zsh.d/tmux.zsh

# Autocompletion
autoload -Uz bashcompinit && bashcompinit
autoload -Uz compinit && compinit
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
# Shell Custom Autocompletions
source ~/.zsh.d/autocomplete.zsh

# Zinit Plugins
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

zinit for \
    light-mode \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-completions \
    light-mode \
  zdharma-continuum/fast-syntax-highlighting \
  zdharma-continuum/history-search-multi-word \
    light-mode \
  superbrothers/zsh-kubectl-prompt

# Prompt Customizations
autoload -Uz vcs_info
autoload -U colors && colors
autoload -U promptinit && promptinit
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '(%b)%r'
zstyle ':vcs_info:*' enable git
zstyle ':zsh-kubectl-prompt:' separator '|'

PROMPT=$'%F{032}┌──(%F{120}%m%F{226}の%F{196}%n%F{032})\n└─#%{$reset_color%} '

if [[ -d $HOME/.kube ]]; then
  RPROMPT='%F{092}($ZSH_KUBECTL_PROMPT)%{$reset_color%}'
else
  RPROMPT='%F{226}Klaatu Barada Nitko!'
fi

# Completion settings
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' group-name ''
zstyle ':completion:::::' completer _expand _complete _ignored _approximate
zstyle ':completion:*:make:*:targets' call-command true
zstyle ':completion:*:make:*' tag-order targets
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*' special-dirs true

# Color support
if command -v dircolors >/dev/null 2>&1; then
  if test -r ~/.dircolors; then
    eval "$(dircolors -b ~/.dircolors)"
  else
    eval "$(dircolors -b)"
  fi
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
  alias diff='diff --color=auto'
  alias ip='ip --color=auto'
  export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
  export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
  export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
  export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
  export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
  export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
  export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
  zinit ice atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh" nocompile'!'
  zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
elif command -v gdircolors >/dev/null 2>&1; then
  if test -r ~/.dircolors; then
    eval "$(gdircolors -b ~/.dircolors)"
  else
    eval "$(gdircolors -b)"
  fi
  alias ls='ls -G'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'
  alias grep='grep -G'
  alias fgrep='fgrep -G'
  alias egrep='egrep -G'
  alias diff='diff -G'
  #alias ip='ip'
  export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
  export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
  export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
  export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
  export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
  export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
  export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
  zinit ice atclone"gdircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh" nocompile'!'
  zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
fi
