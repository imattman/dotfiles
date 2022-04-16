# mattman  .dotfiles/zsh/zprofile.sh

# init zprezto:zprofile
source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zprofile"

export PLATFORM="$(uname -s | tr A-Z a-z)"
export SCRIPTS="$XDG_LOCAL_SCRIPTS"
export WORKSPACE="$HOME/workspace"
export DOCUMENTS="$HOME/Documents"
export NOTES="$HOME/Notes"
export NOTES_JOURNAL="$NOTES/journal"
export NOTES_ZETTELKASTEN="$NOTES/zettelkasten"
export NOTES_TASKS="$NOTES/gtd-tasks"
export NOTES_PROJECTS="$NOTES/projects"
export NOTES_INVENTORY="$NOTES/inventory"
export NOTES_RECIPES="$NOTES/recipes"
export NOTES_SCRATCHPAD="$NOTES/scratchpad"
export NOTES_WORK="$NOTES/work"
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


#
# MacOS
#
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


export EDITOR=vim
if [[ $(command -v nvim) ]]; then
  export EDITOR=nvim
fi

#if [[ $(command -v gvim) ]]; then
#  export VISUAL=gvim
#else
  export VISUAL=$EDITOR
#fi

# configure less not to paginate if less than one page
export LESS="-F -X $LESS"

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

## NodeJS
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/config"

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
  $NOTES_ZETTELKASTEN
  $NOTES_JOURNAL
  $NOTES_TASKS
  $NOTES_PROJECTS
  $NOTES_RECIPES
  $NOTES_INVENTORY
  $NOTES_WORK
  $NOTES
  $NOTES_SCRATCHPAD
  $WORKSPACE/websites
  $XDG_LOCAL_HOME
  $GOPATH/src/github.com/imattman
  $GOPATH/src/gitlab.com/imattman
)

