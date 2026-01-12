# ~/.zshrc file for zsh interactive shells.
# see /usr/share/doc/zsh/examples/zshrc for examples

# Load configuration first
if [[ -f ~/.zsh.d/config.zsh ]]; then
  source ~/.zsh.d/config.zsh
fi

# Tmux auto-start (enabled for optimal workflow)
if command -v tmux >/dev/null 2>&1 && [[ "$TMUX_AUTOSTART_ENABLED" != "false" ]]; then
  if [[ -z "$TMUX" ]]; then
    _skip_tmux=false
    if [[ "$TMUX_SKIP_DESKTOP" == "true" ]] && [[ -n "$DESKTOP_SESSION" ]]; then
      for desktop in ${(s:,:)TMUX_SKIP_DESKTOP_SESSIONS}; do
        [[ "$DESKTOP_SESSION" == "$desktop" ]] && _skip_tmux=true && break
      done
    fi
    if [[ "$TMUX_SKIP_IDE" == "true" ]] && [[ -n "$INSIDE_EMACS" || -n "$VSCODE_PID" ]]; then
      _skip_tmux=true
    fi
    if [[ "$TMUX_SKIP_SSH" == "true" ]] && [[ -n "$SSH_CONNECTION" ]]; then
      _skip_tmux=true
    fi
    if [[ $- == *i* ]] && [[ "$_skip_tmux" == "false" ]]; then
      tmux attach-session -t "${TMUX_AUTOSTART_SESSION:-default}" 2>/dev/null || \
        tmux new-session -s "${TMUX_AUTOSTART_SESSION:-default}"
    fi
    unset _skip_tmux
  fi
fi

# Zinit: https://github.com/zdharma-continuum/zinit
# Initialize with error handling for systems without git
if ! command -v git >/dev/null 2>&1; then
  echo "⚠️  Warning: git is not installed. Skipping Zinit plugin manager."
  echo "Install git to enable plugins: sudo apt install git"
elif [[ ! -d ~/.local/share/zinit/zinit.git ]]; then
  mkdir -p ~/.local/share/zinit
  git clone https://github.com/zdharma-continuum/zinit.git ~/.local/share/zinit/zinit.git 2>/dev/null || {
    echo "⚠️  Warning: Could not clone Zinit. Continuing without plugins."
  }
fi

# Source Zinit only if it exists
if [[ -f ~/.local/share/zinit/zinit.git/zinit.zsh ]]; then
  source ~/.local/share/zinit/zinit.git/zinit.zsh
else
  echo "⚠️  Warning: Zinit not found. Install with: git clone https://github.com/zdharma-continuum/zinit.git ~/.local/share/zinit/zinit.git"
fi

# History - Optimized settings
alias history="history 0"
HIST_STAMPS="yyyy-mm-dd"
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000

# Options - Best practices for performance and usability
setopt autocd                   # cd by typing directory name
setopt auto_list                # automatically list choices on ambiguous completion
setopt auto_menu                # show completion menu on successive tab press
setopt always_to_end            # move cursor to end if word had one match
setopt inc_append_history       # add commands as they are typed, not at shell exit
setopt hist_expire_dups_first   # expire duplicates first
setopt hist_ignore_dups         # do not store duplications
setopt hist_ignore_space        # ignore commands that start with space
setopt hist_verify              # show before executing history commands
setopt share_history            # share hist between sessions
setopt prompt_subst             # enable parameter expansion in prompts

# Tool paths
source ~/.zsh.d/tools.zsh
source ~/.zsh.d/toolbox.zsh

# Alias
source ~/.zsh.d/alias.zsh

# Tmux helpers
source ~/.zsh.d/tmux.zsh

# Prompt Customizations - Tokyo Night color scheme
autoload -Uz vcs_info
autoload -Uz colors && colors
autoload -Uz promptinit && promptinit

# Enable vcs_info with fast git detection
autoload -Uz add-zsh-hook
add-zsh-hook precmd vcs_info

# Tokyo Night colors using RGB codes:
# Blue: #7aa2f7, Cyan: #7dcfff, Green: #9ece6a, Magenta: #bb9af7, Yellow: #e0af68, Red: #f7768e
# Using closest 256-color codes: 111=blue, 117=cyan, 149=green, 141=magenta, 215=yellow, 210=red

# Git info - Tokyo Night cyan (#7dcfff)
zstyle ':vcs_info:git:*' formats '%F{117}(%b)%f'
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' nvcsformats ''

# Prompt with Tokyo Night colors: blue border, cyan hostname, yellow separator, red username
PROMPT=$'%F{111}┌──(%F{117}%m%F{215}の%F{210}%n%F{111})\n└─#%{$reset_color%} '

# RPROMPT with git branch + venv + kubectl - Tokyo Night color scheme
# Colors: 117=cyan (git), 141=magenta (venv), 149=green (k8s), 215=yellow (fallback)
_build_rprompt() {
  local -a parts

  # Git branch (Tokyo Night cyan #7dcfff / 117) - only show if vcs_info found a repo
  # Check for both vcs_info_msg_0_ being set AND not empty
  if [[ -n "${vcs_info_msg_0_}" ]]; then
    parts+=("${vcs_info_msg_0_}")
  fi

  # Virtual environment (Tokyo Night magenta #bb9af7 / 141)
  if [[ -n "$VIRTUAL_ENV" ]]; then
    parts+=("%F{141}($(basename $VIRTUAL_ENV))%f")
  fi

  # Kubernetes (Tokyo Night green #9ece6a / 149)
  if [[ -n "$ZSH_KUBECTL_PROMPT" ]]; then
    parts+=("%F{149}($ZSH_KUBECTL_PROMPT)%f")
  fi

  # If we have git/venv or k8s, show them
  if (( ${#parts} > 0 )); then
    echo "${(j: :)parts}"
  else
    # Fallback message when none of the above exist (Tokyo Night yellow #e0af68 / 215)
    echo "%F{215}Klaatu Barada Nitko!%f"
  fi
}

RPROMPT='$(_build_rprompt)'

# Autocompletion - Ultra-fast initialization with error handling
autoload -Uz compinit
# Use -C flag only if dump file exists and is recent
if [[ -f ${HOME}/.zcompdump && ${HOME}/.zcompdump -nt /etc/passwd ]]; then
  compinit -C -i 2>/dev/null || compinit -i 2>/dev/null
else
  compinit -i 2>/dev/null
fi
autoload -Uz bashcompinit && bashcompinit
# Skip _zinit autoload for speed - only load when needed
(( ${+_comps} )) && _comps[zinit]=_zinit

# Zinit Plugins - Optimized with turbo mode (FAST STARTUP MODE)
# Only load plugins if Zinit is available
if command -v zinit >/dev/null 2>&1; then
  # Load ONLY essential plugins with maximum async
  zinit ice wait"1" lucid
  zinit light superbrothers/zsh-kubectl-prompt

  zinit ice wait"2" lucid atload"_zsh_autosuggest_start"
  zinit light zsh-users/zsh-autosuggestions

  zinit ice wait"2" lucid blockf
  zinit light zsh-users/zsh-completions

  zinit ice wait"3" lucid atinit"zicompinit; zicdreplay"
  zinit light zdharma-continuum/fast-syntax-highlighting
fi

# Shell Custom Autocompletions
source ~/.zsh.d/autocomplete.zsh

# Completion settings
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' group-name ''
zstyle ':completion:::::' completer _expand _complete _ignored _approximate
zstyle ':completion:*:make:*:targets' call-command true
zstyle ':completion:*:make:*' tag-order targets
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*' special-dirs true

# Color support - Simplified for speed (check once at startup)
if [[ -x /usr/bin/dircolors ]] || [[ -x /bin/dircolors ]]; then
  if [[ -f ~/.dircolors ]]; then
    eval "$(dircolors -b ~/.dircolors)"
  else
    eval "$(dircolors -b)"
  fi
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias diff='diff --color=auto'
  alias dir='dir --color=auto'
elif [[ -x /usr/bin/gdircolors ]] || [[ -x /bin/gdircolors ]]; then
  if [[ -f ~/.dircolors ]]; then
    eval "$(gdircolors -b ~/.dircolors)"
  else
    eval "$(gdircolors -b)"
  fi
  alias ls='ls -G'
  alias grep='grep -G'
  alias diff='diff -G'
else
  # Fallback for systems without dircolors
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
fi

# Less colors for man pages
export LESS_TERMCAP_mb=$'\E[1;31m'
export LESS_TERMCAP_md=$'\E[1;36m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;33m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_us=$'\E[1;32m'
export LESS_TERMCAP_ue=$'\E[0m'
