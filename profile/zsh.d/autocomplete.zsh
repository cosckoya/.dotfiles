# Autocomplete

if [[ -d $HOME/.asdf ]]; then                                                                            # asdf
  source $HOME/.asdf/asdf.sh && \
  source $HOME/.asdf/completions/asdf.bash && \
  if [[ $(uname -m) != "x86_64" ]]; then
    alias asdf='arch -x86_64 asdf'
  fi
fi

if [[ -f $(which gcloud) ]]; then                                                                        # Google
  source /etc/bash_completion.d/gcloud
elif [[ -d $(brew --prefix)/Caskroom/google-cloud-sdk ]]; then
  source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc" && \
  source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
fi

if [[ -x $(which kubectl) ]]; then source <(kubectl completion zsh); fi                                  # Kubectl
if [[ -x $(which helm) ]]; then source <(helm completion zsh); fi                                        # Helm
if [[ -x $(which kind) ]]; then source <(kind completion zsh); fi                                        # Kind
if [[ -x $(which terraform) ]]; then complete -o nospace -C $(which terraform) terraform; fi             # Terraform
if [[ -x $(which aws) ]]; then complete -C "$HOME/bin/aws_completer" aws; fi                             # AWS
if [[ -x $(which az) ]]; then source /etc/bash_completion.d/azure-cli; fi                                # Azure