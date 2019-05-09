# mattman .dotfiles/shell/bashrc.sh


#
# Environment
#
PATH=$PATH:/usr/local/bin
PATH=~/bin:$PATH
export PATH

EDITOR=vim

#
# Development
#

# GoLang
export GOPATH=$HOME/workspace/go
export PATH=$PATH:$GOPATH/bin


#
# Shell refinements
#
[[ -f ~/.bash.aliases ]] && source ~/.bash.aliases
[[ -f ~/.bash.functions ]] && source ~/.bash.functions

export CDPATH=workspace:$GOPATH/src/github.com/imattman:$GOPATH/src/gitlab.com/imattman



if [[ -f ~/.bash.prompt ]] ; then 
  source ~/.bash.prompt
else
  #cd wrapper function
  function cd {
    builtin cd $@  # call builtin
    __set_prompt   # execute function
  }

  function __set_prompt {
    #saving pwd as a var
    local pwd=$(pwd)
    #  local gover=$(go version | cut -d' ' -f 3)

    #setting colors as local vars
    local B="\[\033[0;34m\]"
    local G="\[\033[0;32m\]"
    local Y="\[\033[0;33m\]"
    local W="\[\033[0;37m\]"
    local R="\[\033[0;31m\]"
    local NONE="\[\033[0m\]"

    if [[ "$pwd/" == "$HOME/" ]] ; then
      PS1="[$B\u$G@$W\h $R Home $NONE]\n\$ "
      #  elif [[ -n $GOPATH && "$pwd/" =~ "$GOPATH/" ]] ; then
      #      PS1="[$B\u$G@$W\h $Y\w $R($gover$(__git_ps1 "|%s")) $NONE]\n\$ "
    else
      #      PS1="[$B\u$G@$W\h $Y\w $R($(__git_ps1 "$s"))$NONE] \n\$ "
      PS1="[$B\u$G@$W\h $Y\w $R $NONE] \n\$ "
    fi
    export PS1
  }

  __set_prompt
fi



