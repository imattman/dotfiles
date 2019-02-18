# mattman  .dotfiles/zsh/zprofile.sh

# init zprezto:zprofile
zprezto_file=${ZDOTDIR:-$HOME}/.zprezto/runcoms/zprofile
source_file "$zprezto_file"

path=(
  $HOME/bin
  $path
)

export EDITOR=vim
export VISUAL=vim

export GOPATH=$HOME/workspace/go
which go 2>&1 > /dev/null && export GOROOT=$(goenv GOROOT)
export PATH=$PATH:$GOPATH/bin


export CDPATH=workspace:$GOPATH/src/github.com/imattman:$GOPATH/src/gitlab.com/imattman

