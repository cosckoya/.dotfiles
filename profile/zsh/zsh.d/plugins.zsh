# Plugins

# Kubectl
if [[ -d $HOME/.kube ]]; then
  zinit load superbrothers/zsh-kubectl-prompt
  zstyle ':zsh-kubectl-prompt:' separator '|'
  RPROMPT='%F{#af00ff%}($ZSH_KUBECTL_PROMPT)%{$reset_color%}'
fi
