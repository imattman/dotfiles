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
export WORKSPACE="$HOME/workspace"
export SCRIPTS="$HOME/bin"

# GoLang
export GOPATH=$HOME/workspace/go
export PATH=$PATH:$GOPATH/bin

# Elixir
export ERL_AFLAGS="-kernel shell_history enabled"


#
# Shell refinements
#
[[ -f ~/.functions.sh ]] && source ~/.functions.sh
[[ -f ~/.aliases.sh ]] && source ~/.aliases.sh

if [[ -z "$CDPATH" ]]; then
  export CDPATH=workspace:$GOPATH/src/github.com/imattman:$GOPATH/src/gitlab.com/imattman
fi


# system info with bling
[[ -n "$(command -v neofetch)" ]] && neofetch

# delegate to starship for bash prompt config
#   https://github.com/starship/starship
if [[ -n "$(command -v starship)" ]]; then
  eval "$(starship init bash)"
  eval "$(starship completions bash)"
else
  echo "Unable to configure prompt; starship not found."
fi

