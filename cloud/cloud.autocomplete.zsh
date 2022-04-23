##
## Cloud Autocomplete
##

# GCLOUD
if [[ -x $(asdf which gcloud) ]]; then                                         # Google
  source $(asdf which gcloud | awk -F '/bin' '{print $1}')/completion.zsh.inc
fi

# AWS
if [[ -x $(which aws) ]]; then complete -C $(which aws_completer) aws; fi      # AWS

# AZURE
if [[ -x $(which az) ]]; then source "$HOME/lib/azure-cli"; fi                 # Azure
