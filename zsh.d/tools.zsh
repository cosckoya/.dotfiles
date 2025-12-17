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

# ASDF initialization - using binary installation in $HOME/bin
# The asdf binary is in $HOME/bin (not a symlink)
# Data directory is $HOME/.asdf (shims, plugins, installs)
if [[ -x "$HOME/bin/asdf" ]]; then
  export ASDF_DIR="$HOME/.asdf"
  export ASDF_DATA_DIR="$HOME/.asdf"
  # Add asdf to PATH if not already there
  [[ ":$PATH:" != *":$HOME/bin:"* ]] && export PATH="$HOME/bin:$PATH"
fi

# PATH extensions - Add only if directories exist
typeset -U path
[[ -d "$HOME/bin" ]] && path+=("$HOME/bin")
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
