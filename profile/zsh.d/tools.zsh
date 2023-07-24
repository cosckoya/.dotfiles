# Tool paths

# TMUX
tmux 2>/dev/null || true

# EDITOR
if command -v nvim >/dev/null 2>&1; then
  export VISUAL='vi'
  export EDITOR="$VISUAL"
  alias vi='nvim'
fi

# GOLANG
if [[ -d "$GOPATH" ]]; then
  export PATH="$PATH:$GOPATH/bin"
fi
