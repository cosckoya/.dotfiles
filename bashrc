## .bashrc file

export PATH=$HOME/bin:/usr/local/bin:$PATH
export TOOLKIT=$HOME/.cosckoya
export DOTFILES=$TOOLKIT/dotfiles

# HISTORY #
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
HISTFILE=~/.bash_history
HISTTIMEFORMAT="%y/%m/%d - %H:%M:%S "

# EDiTOR
alias vi=vim
export EDITOR=vi

# WIN #
shopt -s checkwinsize
shopt -s histappend

# TERM #
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# PROMPT
# Icons: ◉ ⊙ Ǝ Ṍ ȭ ỡ Œ ☠ の ❆ ☢ ⚓ ☥ ☘ ♠ ♣ ☆ ☽ ☾☆ ❯ ⏀ ☭
export PS1="\[\e[32m\]\u\[\e[m\]\[\e[15m\]♠\[\e[m\]\[\e[1;31m\]\h\[\e[m\]\[\033[01;34m\]\w\[\033[00m\]> "
#export PS1="\[\e[7;30;42m\]\u\[\e[m\]\[\e[1;33;40m\]☿\[\e[m\]\[\e[7;30;41m\]\h\[\e[m\]\[\e[0;35;40m\]\w\[\e[m\]> "
#unset color_prompt force_color_prompt

export GOPATH=$(go env GOPATH)
export JAVA_HOME=/usr/java/default
export PATH=$PATH:$HOME/.local/bin:$JAVA_HOME/bin:$(go env GOPATH)/bin

# ALIAS #
alias ls='ls -la --color'
alias gitea='git add . && git commit -m "updated $(date)" && git push origin master'
alias gitlog='git log --pretty=oneline --abbrev-commit'

