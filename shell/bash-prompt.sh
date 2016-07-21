# mattman  ~/.dotfiles/shell/bash-prompt.sh
#
# prior art borrowed from http://eefret.me/modifying-and-pimping-bash-prompt/


# Wrapper function that is called if cd is invoked
# by the current shell
#
function cd {
    # call builtin cd. change to the new directory
    builtin cd $@
    # call a hook function that can use the new working directory
    # to decide what to do
    __pimp_prompt
}

# Activating git prompt so we can use __git_ps1 func
local_bash_completion_lib='/etc/bash_completion.d/git-prompt'

if [ -f $local_bash_completion_lib ] ; then
  source $local_bash_completion_lib
  complete -o default -o nospace -F _git g
else
  # set up noop function to squash command-not-found errors
  function __git_ps1 {
    local noop="noop"
  }
fi

#Setting other configs
force_color_prompt=yes #force the color prompt
if [ -n "$DISPLAY" -a "$TERM" == "xterm" ]; then
    export TERM=xterm-256color
fi 

function __git_diff {
    git diff --quiet HEAD &>/dev/null 
    [ $? == 1 ] && echo "!"
}

function __pimp_prompt {
    #current location
    local pwd=$(pwd)
    #go version
    local gover=$(go version | cut -d' ' -f 3)
    #symbol, if root '#' if user '>'
    local symb="$"
    if [[ $EUID -eq 0 ]]; then
        local symb="#"
    fi

    #COLORS
    local NONE="\[\033[0m\]" # unset fg
    local K="\[\033[0;30m\]"    # black
    local R="\[\033[0;31m\]"    # red
    local G="\[\033[0;32m\]"    # green
    local Y="\[\033[0;33m\]"    # yellow
    local B="\[\033[0;34m\]"    # blue
    local M="\[\033[0;35m\]"    # magenta
    local C="\[\033[0;36m\]"    # cyan
    local W="\[\033[0;37m\]"    # white
    local EMK="\[\033[1;30m\]" # bold black
    local EMR="\[\033[1;31m\]" # bold red
    local EMG="\[\033[1;32m\]" # bold green
    local EMY="\[\033[1;33m\]" # bold yellow
    local EMB="\[\033[1;34m\]" # bold blue
    local EMM="\[\033[1;35m\]" # bold magenta
    local EMC="\[\033[1;36m\]" # bold cyan
    local EMW="\[\033[1;37m\]" # bold white
    local BGK="\[\033[40m\]" # background black
    local BGR="\[\033[41m\]" # background red
    local BGG="\[\033[42m\]" # background green
    local BGY="\[\033[43m\]" # background yellow
    local BGB="\[\033[44m\]" # background blue
    local BGM="\[\033[45m\]" # background magenta
    local BGC="\[\033[46m\]" # background cyan
    local BGW="\[\033[47m\]" # background white

    #[{# in prompt}:{# in history}] Hour:Minutes [user@host] location
#    local BASE_FORMAT="$EMK[\#:\!]$NONE $G\A$NONE $EMB[\u@\H]$NONE $W\w$NONE"
    local BASE_FORMAT="$G\A$NONE $EMB[\u@\h]$NONE $W\w$NONE"
      PS1="[$B\u$G@$W\h $R Home $NONE]\n\$ "

    #now we define the status dynamically
    if [[ -n $GOPATH && "$pwd/" =~ "$GOPATH/" ]] ; then
        #(GoVersion|GitBranch !)
        local STATUS="$R($gover$(__git_ps1 "|%s")$Y$(__git_diff)$R)"
    else
        #(branch !)
        local STATUS="$R$(__git_ps1 "(%s$Y$(__git_diff)$R)")"
    fi
    #Set PS1 with our format
    export PS1="$BASE_FORMAT $STATUS\n$G$symb "
}

__pimp_prompt

