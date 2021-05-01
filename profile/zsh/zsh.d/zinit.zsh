# zInit: https://github.com/zdharma/zinit

if [[ ! -d ~/.zinit ]]; then
  git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
fi

source ~/.zinit/bin/zinit.zsh

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit for light-mode \
  zsh-users/zsh-syntax-highlighting \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-completions \
  zsh-users/zsh-history-substring-search

zinit for \
    pick"async.zsh" src"pure.zsh" \
    sindresorhus/pure

zinit ice atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh" nocompile'!'


# ZINIT: Snippets
# Oh-my-zsh
# zinit snippet OMZ::plugins/git/git.plugin.zsh
# zinit snippet OMZ::plugins/tig/tig.plugin.zsh
# zinit snippet OMZ::plugins/kubectl/kubectl.plugin.zsh
# zinit snippet OMZ::plugins/helm/helm.plugin.zsh
# zinit snippet OMZ::plugins/docker/_docker
# zinit snippet OMZ::plugins/minikube/minikube.plugin.zsh
# zinit snippet OMZ::plugins/terraform/terraform.plugin.zsh
# zinit snippet OMZ::plugins/asdf/asdf.plugin.zsh