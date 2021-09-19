# mattman  .dotfiles/zsh/zprofile.sh

# init zprezto:zprofile
zprezto_file=${ZDOTDIR:-$HOME}/.zprezto/runcoms/zprofile
source "$zprezto_file"


export EDITOR=vim
export VISUAL=vim

export SCRIPTS="$HOME/bin"
export WORKSPACE="$HOME/workspace"
export NOTES="$HOME/Notes"
export DOCUMENTS="$HOME/Documents"
export PCLOUD="$HOME/pCloud Drive"


export GOPATH="$XDG_DATA_HOME/go"
if [[ -n "$(command -v go)" ]]; then
  export GOROOT=$(go env GOROOT)
  #export GOBIN="$XDG_LOCAL_BIN"
fi

# enable history in iEx
export ERL_AFLAGS="-kernel shell_history enabled"


path=(
  $HOME/bin
  $XDG_LOCAL_BIN
  /opt/homebrew/bin
  $path
  $GOPATH/bin
)

cdpath=(
  $WORKSPACE
  $WORKSPACE/websites
  $GOPATH/src/github.com/imattman
  $GOPATH/src/gitlab.com/imattman
)

