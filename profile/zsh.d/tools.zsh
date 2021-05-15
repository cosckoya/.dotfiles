# Tool paths

# TMUX
if [[ "$TMUX" = "" ]]; then tmux; fi

# EDITOR
if [[ -f $(which nvim) ]]; then
  export VISUAL='vi'
  export EDITOR="$VISUAL"
  alias vi='nvim'
fi

# GOLANG
if [ -d "$GOPATH" ]; then 
  export PATH="$PATH:$GOPATH/bin"
fi 