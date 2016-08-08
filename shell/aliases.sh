# mattman  ~/.dotfiles/shell/aliases.sh

alias more='less'
alias ls='ls -F'
alias ll='ls -l'
alias l='ls'
alias la='ls -a'
alias lla='ls -la'
alias llh='ls -lah'
alias lo='exit'

# vim
alias vim-min='vim -u ~/.vim/vimrc-min'
alias mvim-min='mvim -u ~/.vim/vimrc-min'

# still need this emacs clean up?
alias rm~="rm *~"
alias rm\#="rm \#*"

# Docker stuff
alias dm='docker-machine'
alias dock='docker'
alias dcomp='docker-compose'
alias dmenv='eval $(docker-machine env)'

# GoLang
alias goenv='go env'
alias gorun='go run'
alias gobuild='go build'

# Exercism
alias exer='exercism'


