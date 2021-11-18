# mattman  .dotfiles/zsh/zprofile.sh

# auto launch tmux
AUTO_TMUX="off"
AUTO_TMUX="${AUTO_TMUX:-on}"

if [[ "$AUTO_TMUX" == 'on' ]] && [[ $(command -v tmux) ]] && [[ -n "$PS1" ]] && [[ -z "$TMUX" ]] && [[ ! "$TERM" =~ "tmux" ]] && [[ ! "$TERM" =~ "screen" ]]; then
  #tmux && exit; # detach causes exit
  exec tmux
  #tmux attach || exec tmux new-session
fi

# init zprezto:zprofile
source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zprofile"

export EDITOR=vim
export VISUAL=vim

# configure less not to paginate if less than one page
export LESS="-F -X $LESS"

export PLATFORM="$(uname -s | tr A-Z a-z)"
export SCRIPTS="$HOME/bin"
export WORKSPACE="$HOME/workspace"
export NOTES="$HOME/Notes"
export DOCUMENTS="$HOME/Documents"
export PCLOUD="$HOME/pCloud Drive"

tmpl_candidate_dirs=(
  $WORKSPACE/templates
  $XDG_CONFIG_HOME/templates
  $XDG_DATA_HOME/templates
  $WORKSPACE/Templates
  $HOME/Templates
)

for t in "$tmpl_candidate_dirs[@]"; do
  if [[ -d "$t" ]]; then
    export TEMPLATES="$t"
    break
  fi
done
[[ -z "$TEMPLATES" ]] && "echo \$TEMPLATES not set"


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

## Go
export GOPATH="$WORKSPACE/go"
if [[ $(command -v go) ]]; then
  export GOROOT=$(go env GOROOT)
  #export GOBIN="$XDG_LOCAL_BIN"
  export GOBIN="$GOPATH/bin"
fi

## Elixir
export MIX_HOME="$XDG_CONFIG_HOME/mix"
# enable history in iEx
export ERL_AFLAGS="-kernel shell_history enabled"

## Rust
export CARGO_HOME="$WORKSPACE/rust/cargo"
export RUSTUP_HOME="$WORKSPACE/rust/rustup"
#export CARGO_HOME="$XDG_DATA_HOME/cargo"
#export RUSTUP_HOME="$XDG_DATA_HOME/rustup"


path=(
  $HOME/bin
  $XDG_LOCAL_BIN
  $path
  $GOBIN
  $CARGO_HOME/bin
)


cdpath=(
  $DOCUMENTS
  $NOTES
  $WORKSPACE
  $WORKSPACE/websites
  $GOPATH/src/github.com/imattman
  $GOPATH/src/gitlab.com/imattman
)

