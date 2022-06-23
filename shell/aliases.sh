# mattman  ~/.dotfiles/shell/aliases.sh
#


alias ls='ls -F'
alias ll='ls -l -h'
alias l='ll'
alias lla='ll -a'

# cd helpers that use fzf
alias fcd='cd_fzf'
alias cdf='cd_fzf'
alias cdn='cd_notes'
alias cdr='cd_repos'
alias cdw='cd_workspace'

# journal tools
alias jnb='jn_branch'
alias jnf='jn_fzf'
alias jns='jn_search'

alias v='nvim'
alias nv='nvim'
alias nvim-latest='~/.dotfiles/linux/install-neovim-from-src.sh latest'
#alias vim='nvim'
alias vimf='edit_fzf vim'

# I always forget this
alias ssh-agent-list-keys='ssh-add -L'

# taskwarrior
alias t='task'
alias tls='task ls'
alias tadd='task add'

alias cnvim="$EDITOR ~/.config/nvim/init.lua"
alias cvim="$EDITOR ~/.vim/vimrc"
alias ctmux="$EDITOR ~/.dotfiles/tmux/tmux.conf"
alias crepos="$EDITOR ~/.config/repo-tools/repos.cfg"
alias cjn="$EDITOR ~/.config/jn-tools/jn.toml"
alias ctask="$EDITOR ~/.config/task/taskrc"

alias nf='neofetch'

# override term color -- can be workaround in tmux
alias vimc='TERM=xterm-256color vim'

# linux stuff I forget
alias boot_history='sudo journalctl --list-boots'
alias timezone_cfg='sudo timedatectl status'


alias today=datestamp
alias tomorrow='datestamp tomorrow'
alias yesterday='datestamp yesterday'
alias dstamp=datestamp

alias now=timestamp
alias tstamp=timestamp
alias tstampn=timestampn
alias tsn=timestampn
alias tsisosec=timestamp_isosec

alias lo='exit'
alias po='sudo poweroff'

alias busy='look_busy'

# update local git repos
alias repoup='repos update'

# 'cheat' cli + cheatsheets
alias cht='cheat'

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
alias yaegi='rlwrap yaegi'
alias go-interpreter='rlwrap yaegi'

# json 
alias jpp='json-pp'
alias jppc='json-ppclip'



