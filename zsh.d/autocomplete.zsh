# Shell completions for tools
# Best practice: Lazy-load completions to avoid startup delay

if (( $+commands[kubectl] )); then
  # Lazy-load kubectl completions
  _load_kubectl_completion() {
    source <(kubectl completion zsh)
    unfunction _load_kubectl_completion
  }
  compdef _load_kubectl_completion kubectl
fi

if (( $+commands[helm] )); then
  # Lazy-load helm completions
  _load_helm_completion() {
    source <(helm completion zsh)
    unfunction _load_helm_completion
  }
  compdef _load_helm_completion helm
fi

if (( $+commands[kind] )); then
  # Lazy-load kind completions
  _load_kind_completion() {
    source <(kind completion zsh)
    unfunction _load_kind_completion
  }
  compdef _load_kind_completion kind
fi

# asdf (completion built-in since v0.16+)
if (( $+commands[asdf] )); then
  # Rosetta 2 workaround for Apple Silicon
  [[ $(uname -m) != "x86_64" ]] && alias asdf='arch -x86_64 asdf'
fi
