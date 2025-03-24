if command -v asdf >/dev/null 2>&1; then
  #source <(asdf completion zsh)
  if [[ $(uname -m) != "x86_64" ]]; then
    alias asdf='arch -x86_64 asdf'
  fi
fi

if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
fi

if command -v helm >/dev/null 2>&1; then
  source <(helm completion zsh)
fi

if command -v kind >/dev/null 2>&1; then
  source <(kind completion zsh)
fi
