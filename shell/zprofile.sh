# mattman  .dotfiles/zsh/zprofile.sh

# init zprezto:zprofile
zprezto_file=${ZDOTDIR:-$HOME}/.zprezto/runcoms/zprofile
source "$zprezto_file"


export EDITOR=vim
export VISUAL=vim

export WORKSPACE=$HOME/workspace

export GOPATH="$WORKSPACE/go"
which go 2>&1 > /dev/null && export GOROOT=$(go env GOROOT)

# enable history in iEx
export ERL_AFLAGS="-kernel shell_history enabled"


path=(
  $HOME/bin
  $path
  $GOPATH/bin
)

cdpath=(
  $WORKSPACE
  $WORKSPACE/websites
  $GOPATH/src/github.com/imattman
  $GOPATH/src/gitlab.com/imattman
)

