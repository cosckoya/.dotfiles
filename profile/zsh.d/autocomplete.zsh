# ~/.zshrc file for zsh interactive shells.
# see /usr/share/doc/zsh/examples/zshrc for examples
# Autocompletion
autoload -Uz bashcompinit && bashcompinit
autoload -Uz compinit && compinit

zstyle ':completion:*:*:*:*:*' menu select                                  # select completions with arrow keys
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'                   # case insensitive tab completion
zstyle ':completion:*' group-name ''                                        # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion
zstyle ':completion:*:make:*:targets' call-command true                     # outputs all possible results for make targets
zstyle ':completion:*:make:*' tag-order targets
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*' special-dirs true

if [[ -d $HOME/.asdf ]]; then
  source $HOME/.asdf/asdf.sh && \
  source $HOME/.asdf/completions/asdf.bash && \
  alias asdf='arch -x86_64 asdf'
fi

if [[ -f $(which kubectl) ]]; then source <(kubectl completion zsh); fi                                  # Kubectl
if [[ -d $HOME/.krew/bin ]]; then export PATH="$PATH:$HOME/.krew/bin"; fi                                # Krew
if [[ -f $(which helm) ]]; then source <(helm completion zsh); fi                                        # Helm
if [[ -f $(which kind) ]]; then source <(kind completion zsh); fi                                        # Kind
if [[ -f $(which terraform) ]]; then complete -o nospace -C $(which terraform) terraform; fi             # Terraform
if [[ -f $(which aws) ]]; then complete -C "$HOME/bin/aws_completer" aws; fi                             # AWS
#if [[ -f $(which az) ]]; then source /etc/bash_completion.d/azure-cli; fi                                # Azure
if [[ -d $(brew --prefix)/Caskroom/google-cloud-sdk ]]; then
  source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc" && \
  source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
fi
