# Tool initialization and PATH setup - ULTRA FAST
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

# ASDF initialization - only if properly installed
if [[ -f "$HOME/.asdf/asdf.sh" ]]; then
  export ASDF_DIR="$HOME/.asdf"
  . "$ASDF_DIR/asdf.sh"
  if [[ -f "$ASDF_DIR/completions/asdf.bash" ]]; then
    . "$ASDF_DIR/completions/asdf.bash"
  fi
fi

# PATH extensions - Add only if directories exist
typeset -U path
[[ -d "$GOPATH/bin" ]] && path+=("$GOPATH/bin")
[[ -d "$HOME/.asdf/shims" ]] && path=("$HOME/.asdf/shims" $path)
[[ -d "$HOME/bin" ]] && path+=("$HOME/bin")

# NPM lazy-load only when needed (if npm exists)
if command -v npm >/dev/null 2>&1; then
  function npm() {
    unfunction npm
    source <(command npm completion zsh 2>/dev/null || true)
    command npm "$@"
  }
fi
