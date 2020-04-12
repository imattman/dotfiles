#!/usr/bin/env bash

# fail early
set -eou pipefail

if [[ -n "${DEBUG:=}" ]]; then
  set -x
fi

THIS_SCRIPT=$(basename "$0")
THIS_DIR=$(dirname "$0")
BASE_DIR=$(cd "$THIS_DIR" && pwd)

IS_MACOS=$(uname -s | grep -i 'darwin')
MACOS_DIR="${BASE_DIR}/macos"

WORKSPACE_DIR="${WORKSPACE:-${HOME}/workspace}"
SCRIPTS_DIR="${SCRIPTS:-${HOME}/bin}"

PREZTO_REPO='https://github.com/sorin-ionescu/prezto'
PREZTO_DIR="${HOME}/.zprezto"
PREZTO_PROMPT_SRC="${BASE_DIR}/shell/prompt_mattman_setup.prezto"
PREZTO_PROMPT_DEST="${PREZTO_DIR}/modules/prompt/functions/prompt_mattman_setup"

FONT_REPO='https://github.com/powerline/fonts'
FONT_DIR="${WORKSPACE_DIR}/fonts"

export CMD_PREFIX=''  # set to 'echo' when dry-run


usage() {
  cat<<EOU
  Usage: $THIS_SCRIPT [OPTIONS]
  
  A basic installer for my dotfiles.
  
  OPTIONS:
     -h:  Show this message
     -d:  Set up additional directories and symlinks (see Makefile)
     -p:  Set up Prezto for zsh
     -f:  Set up additional fonts
     -x:  Execute non-idempotent scripts that should be run only once
          with initial install
     -a:  Run all options
     -n:  Do not execute actions (dry run)
EOU
}

create_dirs() {
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

setup_fonts() {
  if [[ ! -d "$FONT_DIR" ]] ; then
    echo "Downloading fonts..."
    $CMD_PREFIX git clone "$FONT_REPO" "$FONT_DIR" && \
      ($CMD_PREFIX cd "$FONT_DIR" && \
      echo "Installing fonts..." && \
      $CMD_PREFIX ./install.sh)
  else
    echo "Fonts directory already exists: ${FONT_DIR}"
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


setup_once() {
  #"${BASE_DIR}"/fonts/install.sh

  if [[ -n "$IS_MACOS" ]] ; then
   $CMD_PREFIX "${MACOS_DIR}"/run-once.sh
   $CMD_PREFIX "${MACOS_DIR}"/apps-to-install.sh
  fi
}


do_create_dirs=''
do_setup_fonts=''
do_setup_prezto=''
do_setup_once=''
opt_set=''

while getopts 'hnafdpx' OPTION
do
  case $OPTION in
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
        do_setup_once=1
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
  # default options include everything but setup_once
  do_create_dirs=1
  do_setup_fonts=1
  do_setup_prezto=1

  do_setup_once=''
fi


echo "Working from $BASE_DIR"
cd "$BASE_DIR"

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

if [[ -n "$do_setup_once" ]]; then
  setup_once
fi


