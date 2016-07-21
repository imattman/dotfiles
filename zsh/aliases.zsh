###########################################################
# basic shell command refinements
alias more="less"
alias ls="ls -F"
alias ll="ls -l"
alias l="ls"
alias la="ls -a"
alias lla="ls -la"
alias llh="ls -lah"
alias lo="exit"


###########################################################
# aliases to simple scripts and directory changes
alias rm~="rm *~"
alias rm~~="rm *~; rm .*~"
alias rm\#="rm \#*"

###########################################################
#alias emacs2="open /Applications/Emacs.app"
#alias tm="open /Applications/TextMate.app"

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


