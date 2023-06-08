##
## Autocomplete
##

if [[ -d $HOME/.asdf ]]; then                                                  # ASDF
  source $HOME/.asdf/asdf.sh && \
  source $HOME/.asdf/completions/asdf.bash && \
  if [[ $(uname -m) != "x86_64" ]]; then
    alias asdf='arch -x86_64 asdf'
  fi
fi

##
# Kubernetes
##

if [[ -x $(which kubectl) ]]; then source <(kubectl completion zsh); fi        # Kubectl
if [[ -x $(which helm) ]]; then source <(helm completion zsh); fi              # Helm
if [[ -x $(which kind) ]]; then source <(kind completion zsh); fi              # Kind
