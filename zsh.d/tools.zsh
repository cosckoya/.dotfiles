# Tool initialization and PATH sep - ULTRA FAST
# Avoid command checks at startup, use path directly

# Editor configuration - use nvim if available, fallback to vim
if command -v nvim >/dev/null 2>&1; then
  export VISUAL='nvim'
  export EDITOR="$VISUAL"
  alias vi='nvim'
elif command -v vim >/dev/null 2>&1; then
  export VISUAL='vim'
  export EDITOR="$VISUAL"
  alias vi='vim'
else
  export VISUAL='nano'
  export EDITOR="$VISUAL"
fi

# PATH extensions - Add only if directories exist
typeset -U path
[[ -d "$HOME/bin" ]] && path+=("$HOME/bin")
[[ -d "$GOPATH/bin" ]] && path+=("$GOPATH/bin")
[[ -d "$HOME/.local/bin" ]] && path=("$HOME/.local/bin" $path)
[[ -d "$HOME/.opencode/bin" ]] && path+=("$HOME/.opencode/bin")

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# NPM lazy-load only when needed (if npm exists)
if command -v npm >/dev/null 2>&1; then
  function npm() {
    unfunction npm
    source <(command npm completion zsh 2>/dev/null || true)
    command npm "$@"
  }
fi
