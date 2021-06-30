##
## Autocomplete
##

if [[ -d $HOME/.asdf ]]; then                                                  # asdf
  source $HOME/.asdf/asdf.sh && \
  source $HOME/.asdf/completions/asdf.bash && \
  if [[ $(uname -m) != "x86_64" ]]; then
    alias asdf='arch -x86_64 asdf'
  fi
fi

##
# Cloud
##

if [[ -x $(asdf which gcloud) ]]; then                                         # Google
  source $(asdf which gcloud | awk -F '/bin' '{print $1}')/completion.zsh.inc
fi

if [[ -x $(which aws) ]]; then complete -C $(which aws_completer) aws; fi      # AWS
if [[ -x $(which az) ]]; then source "$HOME/.zsh.d/az.completion"; fi          # Azure

##
# Kubernetes
## 

if [[ -x $(which kubectl) ]]; then source <(kubectl completion zsh); fi        # Kubectl
if [[ -x $(which helm) ]]; then source <(helm completion zsh); fi              # Helm
if [[ -x $(which kind) ]]; then source <(kind completion zsh); fi              # Kind

##
# IaC
##

if [[ -x $(which terraform) ]]; then
  complete -o nospace -C $(which terraform) terraform                          # Terraform
fi
