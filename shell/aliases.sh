# mattman  ~/.dotfiles/shell/aliases.sh
#

alias ls='ls -F'
alias ll='ls -l -h'
alias l='ll'
alias lla='ll -a'

# cd helpers that use fzf
alias fcd='cd_fzf'
alias cdf='cd_fzf'
alias cdw='cd_workspace'
alias cdn='cd_notes'

alias vim='nvim'
alias vim-old='\vim'
alias vimf='edit_fzf vim'

alias today="date '+%Y-%m-%d'"
alias now="date '+%Y-%m-%dT%H:%M:%S%z'"
alias tstamp='now'
alias tstamp-num="date '+%Y%m%d.%H%M%S'"

alias busy='look_busy'

# update local git repos
alias repoup='repos update'

# homebrew
#alias brewup="brew update && brew upgrade && brew cleanup && brew doctor"
alias brewup=update_macos
alias sysup=update_system

# tmux
alias tmux-help="open 'http://tmuxcheatsheet.com/'"

# docker
alias dm='docker-machine'
alias dock='docker'
alias dcomp='docker-compose'
alias dmenv='eval $(docker-machine env)'

# some fun with docker
#alias fishies='docker run -it --rm --name fishies danielkraic/asciiquarium'
alias fishies=ascii_fish

# python
alias venv='python3 -m venv venv && source venv/bin/activate && python3 -m pip install --upgrade pip setuptools wheel && rehash'
alias venv-site='python3 -m venv venv --system-site-packages && source venv/bin/activate && python3 -m pip install --upgrade pip setuptools wheel && rehash'
alias activate='py_activate_virtualenv'
alias simple-httpd.py='py_simple_httpd'

# golang
alias goenv='go env'
alias gorun='go run'
alias gobuild='go build'

# json 
alias jpp='json-pp'
alias jppc='json-ppclip'



