# Tool initialization and PATH setup

# Auto-start tmux (except in bspwm desktop environment)
[[ "$DESKTOP_SESSION" != "bspwm" ]] && ! tmux has-session 2>/dev/null && tmux

# Editor configuration
if command -v nvim >/dev/null 2>&1; then
  export VISUAL='nvim'
  export EDITOR="$VISUAL"
  alias vi='nvim'
fi

# PATH extensions
[[ -d "$GOPATH" ]] && export PATH="$PATH:$GOPATH/bin"
command -v npm >/dev/null 2>&1 && export PATH="$PATH:$(npm get prefix)/bin"
command -v asdf >/dev/null 2>&1 && export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
