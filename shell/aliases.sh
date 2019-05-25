# mattman  ~/.dotfiles/shell/aliases.sh

alias ls='ls -F'
alias l='ls -l'
alias ll='ls -l'
alias lla='ls -la'
alias llh='ls -lah'

alias timestamp="date '+%Y%m%d-%H%M%S'"
alias today="date '+%Y-%m-%d'"
alias now="date '+%Y-%m-%d_%H:%M:%S'"

# vim
alias vim-min='vim -u ~/.vim/vimrc-min'
alias mvim-min='mvim -u ~/.vim/vimrc-min'

# still need this emacs clean up?
alias rm~="rm *~"
alias rm\#="rm \#*"

# homebrew
alias brewup="brew update && brew doctor && brew upgrade && brew cleanup && brew doctor"

# docker
alias dm='docker-machine'
alias dock='docker'
alias dcomp='docker-compose'
alias dmenv='eval $(docker-machine env)'

# python
alias venv='python3 -m venv venv && source venv/bin/activate && pip3 install --upgrade pip'
alias pyvenv=venv
alias activate='activate_virtualenv'
alias av='activate_virtualenv'

# golang
alias goenv='go env'
alias gorun='go run'
alias gobuild='go build'



