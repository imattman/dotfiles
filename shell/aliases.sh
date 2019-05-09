# mattman  ~/.dotfiles/shell/aliases.sh

alias ls='ls -F'
alias l='ls -l'
alias ll='ls -l'
alias lla='ls -la'
alias llh='ls -lah'

alias timestamp="date '+%Y%m%d-%H%M%S'"
alias tsshort="date '+%Y%m%d%H%M%S'"
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
alias activate='activate_virtualenv'
alias venv='activate_virtualenv'

# golang
alias goenv='go env'
alias gorun='go run'
alias gobuild='go build'



