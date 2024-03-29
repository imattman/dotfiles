#!/usr/bin/env bash

# fail early
set -eou pipefail

if [[ -n "${DEBUG:=}" ]]; then
  set -x
fi

THIS_SCRIPT=$(basename "$0")
THIS_DIR=$(dirname "$0")
BASE_DIR=$(cd "$THIS_DIR" && pwd)

PLATFORM="$(uname -s | tr A-Z a-z)"

WORKSPACE_DIR="${WORKSPACE:-${HOME}/workspace}"
NOTES_DIR="${NOTES:-${HOME}/Documents/Notes}"
XDG_CONFIG_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
XDG_LOCAL_BIN="${XDG_LOCAL_BIN:-$HOME/.local/bin}"
XDG_LOCAL_SCRIPTS="${XDG_LOCAL_SCRIPTS:-$HOME/.local/scripts}"
SCRIPTS_DIR="${XDG_LOCAL_SCRIPTS}"

PREZTO_REPO='https://github.com/sorin-ionescu/prezto'
PREZTO_DIR="${HOME}/.zprezto"
PREZTO_PROMPT_SRC="${BASE_DIR}/shell/prompt_mattman_setup.prezto"
PREZTO_PROMPT_DEST="${PREZTO_DIR}/modules/prompt/functions/prompt_mattman_setup"

INIT_PRINTED=''       # flat to print only once
export CMD_PREFIX=''  # set to 'echo' when dry-run


usage() {
  cat<<EOU
  Usage: $THIS_SCRIPT <COMMAND>

  A basic installer for my dotfiles.

  COMMANDS:
     help:    Show this message
     init:    Set up user workspace, prezto, and other directories
     server:  Install OS-specific packages and user workspace (no fonts)
     all:     Install everything (default)

  OPTIONS:
     -n:      Do not execute actions (dry run)
EOU
}


setup_os() {
  case "$PLATFORM" in
    darwin)
      $CMD_PREFIX $THIS_DIR/darwin/install.sh
      ;;
    linux)
      $CMD_PREFIX $THIS_DIR/linux/install.sh
      ;;
    *)
      echo "Unrecognized platform: '$PLATFORM'"
      exit 1
  esac
}


create_dirs() {
  for dir in "$XDG_CONFIG_DIR" "$XDG_DATA_HOME" "$XDG_LOCAL_BIN" \
    "$WORKSPACE_DIR" "$NOTES_DIR" ; do
    if [[ ! -d "$dir" ]] ; then
      $CMD_PREFIX mkdir -p "$dir"
    else
      echo "$dir already exists"
    fi
  done
}


setup_prezto() {
  if [[ ! -e "$PREZTO_DIR" ]] ; then
    echo "Prezto dir: ${PREZTO_DIR}"
    $CMD_PREFIX git clone --recursive "$PREZTO_REPO" "$PREZTO_DIR"
  else
    echo "Prezto directory already exists: ${PREZTO_DIR}"
  fi

  if [[ ! -e "$PREZTO_PROMPT_DEST" ]] ; then
    echo "Linking mattman prompt..."
    $CMD_PREFIX ln -s "$PREZTO_PROMPT_SRC" "$PREZTO_PROMPT_DEST"
  fi
}


setup_fonts() {
  $CMD_PREFIX $PLATFORM/install-fonts.sh
}


init() {
  if [[ -z "$INIT_PRINTED" ]]; then
    echo "Working from $BASE_DIR"
    echo
  fi

  cd "$BASE_DIR"
  INIT_PRINTED='true'
}


basic() {
  init
  create_dirs
  setup_prezto

  if [[ -n "$(command -v stow)" ]] ; then
    cd "$BASE_DIR" && $CMD_PREFIX make
  else
    echo "'stow' must be installed before running 'make'"
  fi
}

server() {
  init
  setup_os
  basic
}

all() {
  init
  setup_os
  basic
  setup_fonts
}



for cmd in "$@"
do
  case $cmd in
    init|quick|basic|dirs)
        basic
        ;;
    server)
        server
        ;;
    all|full)
        all
        ;;
    -n)
        CMD_PREFIX='echo'
        shift # consume arg
        ;;
    -h|help|*)
        usage
        exit 0
        ;;
  esac
done

if [[ $# -eq 0 ]]; then
  all
fi


