# mattman  .dotfiles/zsh/zprofile.sh

# init zprezto:zprofile
zprezto_file=${ZDOTDIR:-$HOME}/.zprezto/runcoms/zprofile
source "$zprezto_file"

export EDITOR=vim
export VISUAL=vim

export PLATFORM="$(uname -s | tr A-Z a-z)"
export SCRIPTS="$HOME/bin"
export WORKSPACE="$HOME/workspace"
export NOTES="$HOME/Notes"
export DOCUMENTS="$HOME/Documents"
export PCLOUD="$HOME/pCloud Drive"


# MacOS
if [[ "$PLATFORM" == "darwin" ]]; then
  # homebrew on M1 is in a different directory
  if [[ -d /opt/homebrew ]]; then
    path=(
      /opt/homebrew/bin
      /opt/homebrew/sbin
      $path
    )

    fpath=(
      /opt/homebrew/share/zsh/site-functions
      /opt/homebrew/share/zsh-completions
      $fpath
    )
  fi

  # python user bin directory is nonstandard on MacOS
  # prezto seems to handle this. see 'python' in zpreztorc
#  if [[ $(command -v python-user-bin) ]]; then
#    path=(
#      $path
#      $(python-user-bin)
#    )
#  fi
fi

export GOPATH="$XDG_DATA_HOME/go"
if [[ $(command -v go) ]]; then
  export GOROOT=$(go env GOROOT)
  #export GOBIN="$XDG_LOCAL_BIN"
  export GOBIN="$GOPATH/bin"
fi

# enable history in iEx
export ERL_AFLAGS="-kernel shell_history enabled"


path=(
  $HOME/bin
  $XDG_LOCAL_BIN
  $path
  $GOBIN
)


cdpath=(
  $DOCUMENTS
  $NOTES
  $WORKSPACE
  $WORKSPACE/websites
  $GOPATH/src/github.com/imattman
  $GOPATH/src/gitlab.com/imattman
)

