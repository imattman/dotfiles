# mattman  ~/.dotfiles/shell/bash_profile.sh

[ -f ~/.bash.functions ] && source ~/.bash.functions
[ -f ~/.bashrc ] && source ~/.bashrc
[ -f ~/.bash.local ] && source ~/.bash.local

# uncomment this to erase history
#export HISTSIZE=0

# don't logout until the third CTL-D
export IGNOREEOF=2


