# Shell completions for tools

# Kubernetes tools
command -v kubectl >/dev/null 2>&1 && source <(kubectl completion zsh)
command -v helm >/dev/null 2>&1 && source <(helm completion zsh)
command -v kind >/dev/null 2>&1 && source <(kind completion zsh)

# asdf (completion built-in since v0.16+)
if command -v asdf >/dev/null 2>&1; then
  # Rosetta 2 workaround for Apple Silicon
  [[ $(uname -m) != "x86_64" ]] && alias asdf='arch -x86_64 asdf'
fi
