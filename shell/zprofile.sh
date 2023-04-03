# mattman  .dotfiles/zsh/zprofile.sh

# init zprezto:zprofile
source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zprofile"

export PLATFORM="$(uname -s | tr A-Z a-z)"
export SCRIPTS="$XDG_LOCAL_SCRIPTS"
export WORKSPACE="$HOME/workspace"
export REPOS_CONF_DIR="$WORKSPACE/tools/repo-tools"
export DOCUMENTS="$HOME/Documents"
export NOTES="$HOME/Notes"
export NOTES_JOURNAL="$NOTES/journal"
export NOTES_TECHNOTES="$NOTES/technotes"
export NOTES_ZETTELKASTEN="$NOTES/zettelkasten"
export NOTES_PROJECTS="$NOTES/projects"
export NOTES_TRANSIENT="$NOTES/transient"
export NOTES_TASKS="$NOTES_TRANSIENT/gtd-tasks"
export NOTES_SCRATCHPAD="$NOTES_TRANSIENT/scratchpad"
export NOTES_WORK="$NOTES/work"
export NOTES_MISC="$NOTES/sundry-misc"
export PCLOUD="$HOME/pCloud Drive"
#export ASDF_DIR="$XDG_LOCAL_HOME/asdf"
export ASDF_DIR="$HOME/.asdf"

tmpl_candidate_dirs=(
  $WORKSPACE/templates
  $XDG_CONFIG_HOME/templates
  $XDG_DATA_HOME/templates
  $HOME/.dotfiles/templates
)

for t in "$tmpl_candidate_dirs[@]"; do
  if [[ -d "$t" ]]; then
    export TEMPLATES="$t"
    break
  fi
done
[[ -z "$TEMPLATES" ]] && "echo \$TEMPLATES not set"


#
# MacOS
#
if [[ "$PLATFORM" == "darwin" ]]; then
  # register keys with ssh agent using passphrases stored in Keychain
  # env value required to squash warning message about deprecated flag '-A'
  APPLE_SSH_ADD_BEHAVIOR=macos ssh-add -q -A
  #ssh-add -L

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


if [[ -z "$EDITOR" || "$EDITOR" == "nano" ]]; then
  export EDITOR=vim
  if [[ $(command -v nvim) ]]; then
    export EDITOR=nvim
  fi
fi

if [[ -z "$VISUAL" || "$VISUAL" == "nano" ]]; then
#  if [[ $(command -v gvim) ]]; then
#    export VISUAL=gvim
#  else
    export VISUAL=$EDITOR
#  fi
fi

# configure less not to paginate if less than one page
export LESS="-F -X $LESS"

## Go
export GOPATH="$XDG_DATA_HOME/go"
if [[ $(command -v go) ]]; then
  export GOROOT=$(go env GOROOT)
  #export GOBIN="$XDG_LOCAL_BIN"
  export GOBIN="$GOPATH/bin"
fi

## Elixir
export MIX_HOME="$XDG_DATA_HOME/mix"
# enable history in iEx
export ERL_AFLAGS="-kernel shell_history enabled"

## Rust
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

## NodeJS
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/config"

## Perl
user_perl="$XDG_DATA_HOME/perl5"
if [[ -d "$user_perl" ]]; then
  eval "$(perl -Mlocal::lib=$user_perl)"
#  export PERL_LOCAL_LIB_ROOT="$user_perl"
#  export PERL_MB_OPT="--install_base $user_perl"
#  export PERL_MM_OPT="INSTALL_BASE=$user_perl"
fi


## Taskwarrior
# taskwarrior now supports $XDG_CONFIG_HOME/task/taskrc
#export TASKRC=$XDG_CONFIG_HOME/task/taskrc
#export TASKDATA=$NOTES_TASKS/.task

path=(
  $XDG_LOCAL_BIN
  $XDG_LOCAL_SCRIPTS
  $path
  $GOBIN
  $CARGO_HOME/bin
)


cdpath=(
  $DOCUMENTS
  $WORKSPACE
  $NOTES_TECHNOTES
  $NOTES_ZETTELKASTEN
  $NOTES_JOURNAL
  $NOTES_TRANSIENT
  $NOTES_PROJECTS
  $NOTES_WORK
  $NOTES_MISC
  $NOTES
  $WORKSPACE/websites
  $XDG_LOCAL_HOME
  $HOME
)

