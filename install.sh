#!/bin/bash

# fail early
set -ou pipefail

if [[ -n "${DEBUG:=}" ]]; then
  set -x
fi

THIS_SCRIPT=$(basename "$0")
THIS_DIR=$(dirname "$0")
BASE_DIR=$(cd "$THIS_DIR" && pwd)

PLATFORM="$(uname -s | tr A-Z a-z)"

WORKSPACE_DIR="${WORKSPACE:-${HOME}/workspace}"
SCRIPTS_DIR="${SCRIPTS:-${HOME}/bin}"
XDG_CONFIG_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}"

PREZTO_REPO='https://github.com/sorin-ionescu/prezto'
PREZTO_DIR="${HOME}/.zprezto"
PREZTO_PROMPT_SRC="${BASE_DIR}/shell/prompt_mattman_setup.prezto"
PREZTO_PROMPT_DEST="${PREZTO_DIR}/modules/prompt/functions/prompt_mattman_setup"


export CMD_PREFIX=''  # set to 'echo' when dry-run

usage() {
  cat<<EOU
  Usage: $THIS_SCRIPT [OPTIONS]

  A basic installer for my dotfiles.

  OPTIONS:
     -h:  Show this message
     -o:  Perform OS-specific set up
     -d:  Set up additional directories and symlinks (see Makefile)
     -p:  Set up Prezto for zsh
     -f:  Set up additional fonts
     -x:  Execute non-idempotent scripts that should be run only once
          with initial install
     -a:  Run all options
     -n:  Do not execute actions (dry run)
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
  if [[ ! -d "$XDG_CONFIG_DIR" ]] ; then
    $CMD_PREFIX mkdir -p "$XDG_CONFIG_DIR"
  else
    echo "$XDG_CONFIG_DIR already exists"
  fi

  if [[ ! -d "$SCRIPTS_DIR" ]] ; then
    $CMD_PREFIX mkdir -p "$SCRIPTS_DIR"
  else
    echo "$SCRIPTS_DIR already exists"
  fi

  if [[ ! -d "$WORKSPACE_DIR" ]] ; then
    $CMD_PREFIX mkdir -p "$WORKSPACE_DIR"
  else
    echo "$WORKSPACE_DIR already exists"
  fi
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


do_setup_os=''
do_create_dirs=''
do_setup_fonts=''
do_setup_prezto=''
opt_set=''

while getopts 'hnaofdpx' OPTION
do
  case $OPTION in
    o)  do_setup_os=1
        opt_set=1
        ;;
    f)  do_setup_fonts=1
        opt_set=1
        ;;
    d)  do_create_dirs=1
        opt_set=1
        ;;
    p)  do_setup_prezto=1
        opt_set=1
        ;;
    x)  do_setup_once=1
        opt_set=1
        ;;
    n)  CMD_PREFIX='echo'
        ;;
    a)  do_create_dirs=1
        do_setup_fonts=1
        do_setup_prezto=1
        do_setup_os=1
        opt_set=1
        ;;
    h)  usage
        exit 1
        ;;
    ?)  usage
        exit 1
        ;;
  esac
done

shift $((OPTIND - 1))

# use defults if no options specified
if [[ -z "$opt_set" ]]; then
  do_create_dirs=1
  do_setup_os=1
  do_setup_fonts=1
  do_setup_prezto=1
fi


echo "Working from $BASE_DIR"
cd "$BASE_DIR"

if [[ -n "$do_setup_os" ]]; then
  setup_os
fi

if [[ -n "$do_create_dirs" ]]; then
  create_dirs

  if [[ -n "$(command -v stow)" ]] ; then
    cd "$BASE_DIR" && $CMD_PREFIX make
  else
    echo "'stow' must be installed before running 'make'"
  fi
fi

if [[ -n "$do_setup_prezto" ]]; then
  setup_prezto
fi

if [[ -n "$do_setup_fonts" ]]; then
  setup_fonts
fi



