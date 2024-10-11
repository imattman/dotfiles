# mattman  ~/.dotfiles/shell/aliases.sh
#


alias ls='ls -F'
alias ll='ls -l -h'
alias l='ll'
alias lla='ll -a'
# list single column by size
alias lt='ls -1 -S -s -h -F'

alias _='sudo'
alias e='${(z)EDITOR}'
alias v='${(z)VISUAL:-${(z)EDITOR}}'
alias ge='${(z)VISUAL:-${(z)EDITOR}}'
alias p='${(z)PAGER}'
alias b='${(z)BROWSER}'

alias diffu="diff --unified"
alias type='type -a'

# cd helpers that use fzf
alias fcd='cd_fzf'
alias cdf='cd_fzf'
alias cdn='cd_notes'
alias cdr='cd_repos'
alias cdw='cd_workspace'

# distrobox
alias dbox='distrobox'

# repos tools
alias repos-config-env='repos_config_env'

# journal & daybook tools
alias jnbr='jn_branch'
alias jnf='jn_fzf_list'
alias jns='jn_fzf_search'
alias jnconf='e $XDG_CONFIG_HOME/jn-tools/jn.env'
alias dbkbr='dbk_branch'
alias dbkf='dbk_fzf_list'
alias dbks='dbk_fzf_search'

# linux conveniences
# pretty print mounted drives
alias mounts="mount | awk '{ printf \"%s\t%s\n\",\$1,\$3; }' | grep -E '^/dev/' | sort | column -t"

# reload font cache (use after adding files to ~/.local/share/fonts)
alias font-reload-cache="fc-cache -fv"


# zettelkasten tools
#alias vocab='vocab_fzf_list'
#alias vocabf='vocab_fzf_list'
#alias vocs='vocab_fzf_search'
#alias vocabs='vocab_fzf_search'

# exercism
alias exc='exercism'

alias nvim-latest='~/.dotfiles/linux/install-neovim-from-src.sh latest'
#alias vim='nvim'
#alias vimf='edit_fzf vim'

# I always forget this
alias ssh-agent-list-keys='ssh-add -L'

# taskwarrior
alias t='task'
alias tls='task ls'
alias tasks='task items'
alias tadd='task add'

# elixir
alias iexm='iex -S mix'

# shortcuts to edit various config files
alias cnvim="$EDITOR ~/.config/nvim/init.lua"
alias cvim="$EDITOR ~/.vim/vimrc"
alias ctmux="$EDITOR ~/.dotfiles/tmux/tmux.conf"
alias crepos="$EDITOR ~/.config/repo-tools/repos.cfg"
alias cjn="$EDITOR ~/.config/jn-tools/jn.toml"
alias ctask="$EDITOR ~/.config/task/taskrc"

alias nf='neofetch'

# linux stuff I forget
alias boot_history='sudo journalctl --list-boots'
alias timezone_cfg='sudo timedatectl status'


alias today=datestamp
alias tomorrow='datestamp tomorrow'
alias yesterday='datestamp yesterday'
alias dstamp=datestamp

alias now=timestamp
alias tstamp=timestamp
alias tstamputc=timestamp_utc
alias tsisosec=timestamp_isosec

# git habits
alias git-fix-date=git-date-fix
alias git-rebase-author-date='git rebase --committer-date-is-author-date'
alias lg='lazygit'

# calendar with week starting Monday
alias cal-euro='ncal -M -b'

alias lo='exit'
alias po='sudo poweroff'

# fun & antics
alias fishies=ascii_fish
alias busy='look_busy'

# update local git repos
alias repoup='repos update'

# 'cheat' cli + cheatsheets
alias cht='cheat'

# homebrew
alias brewup=update_macos
alias sysup=update_system

# tmux
alias tmux-help="open 'http://tmuxcheatsheet.com/'"


# docker
alias d='docker'
alias dock='docker'
alias dc='docker-compose'
alias dcompose='docker-compose'
alias dmenv='eval $(docker-machine env)'
alias dlog-name='docker_log_name'
alias dlog='docker_log_name'

# quick n' dirty MySQL testing via docker
# TODO: move these to more robust script
alias mysql-docker-eph-server='docker run --rm -d -p 3306:3306 --name=mysql-ephemeral -e MYSQL_ROOT_PASSWORD=tiger mysql'
alias mysql-docker-eph-server-stop='docker stop mysql-ephemeral'
alias mysql-docker-eph-client='docker exec -it mysql-ephemeral mysql -u root --password=tiger'

# python
alias venv='python3 -m venv venv && source venv/bin/activate && python3 -m pip install --upgrade pip setuptools wheel && rehash'
alias venv-site='python3 -m venv venv --system-site-packages && source venv/bin/activate && python3 -m pip install --upgrade pip setuptools wheel && rehash'
alias activate='py_activate_virtualenv'
alias simple-httpd.py='py_simple_httpd'

# go
alias goenv='go env'
alias gorun='go run'
alias go-test='go_test'
alias gobuild='go build'
alias yaegi='rlwrap yaegi'
alias go-interpreter='rlwrap yaegi'

# rust
alias rust-book='rustup doc --book'
alias rust-ref='rustup doc --reference'
alias rust-example='rustup doc --rust-by-example'

# json 
alias jpp='json-pp'
alias jppc='json-ppclip'



