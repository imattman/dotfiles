# mattman  ~/.dotfiles/shell/bash_profile.sh

if [ -f ~/.bash.functions ] ; then
  source ~/.bash.functions
else
  function source_file() {
    #echo -n "sourcing file $1 " ; if [[ -s "$1" ]] ; then echo "YES"; else echo "NO"; fi
    if [[ -s "$1" ]] ; then
      source "$1"
    fi
  }
fi

[ -f ~/.bashrc ] && source ~/.bashrc
[ -f ~/.bash.local ] && source ~/.bash.local

# uncomment this to erase history
#export HISTSIZE=0

# don't logout until the third CTL-D
export IGNOREEOF=2


