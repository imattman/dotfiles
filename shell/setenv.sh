# mattman  .dotfiles/zsh/setenv.sh

# base setenv.sh for non-standard env vars that don't
# really belong in .zprofile

export GOPATH=$HOME/workspace/gocode
export PATH=$PATH:$GOPATH/bin
export CDPATH=workspace:$GOPATH/src/github.com/imattman

