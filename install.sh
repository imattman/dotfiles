#!/usr/bin/env bash
set -e 

base_dir="$(cd $(dirname $0) && pwd)"
is_macos=$(uname -s | grep -i 'darwin')
macos_dir="${base_dir}/macos"

workspace_dir="${WORKSPACE:-${HOME}/workspace}"

prezto_repo='https://github.com/sorin-ionescu/prezto'
prezto_dir="${HOME}/.zprezto"
prezto_prompt_src="${base_dir}/shell/prompt_mattman_setup.prezto"
prezto_prompt_dest="${prezto_dir}/modules/prompt/functions/prompt_mattman_setup"

font_repo='https://github.com/powerline/fonts'
font_dir="${workspace_dir}/fonts"



function usage() {
  this_script=$(basename $0)

  cat<<EOU
  Usage: $this_script [OPTIONS]
  
  A basic installer my dotfiles.
  
  OPTIONS:
     -h:  Show this message
     -f:  Set up additional fonts
     -z:  Set up Prezto for zsh
     -h:  Fetch additional git modules (prezto, mac defaults)
     -h:  Execute Makefile setup script to generate symlinks
     -h:  Execute non-idempotent scripts that should be run only once
          with initial install
EOU
}

function create_dirs() {
  [[ -d $HOME/bin ]] || mkdir -p $HOME/bin
  [[ -d $workspace_dir ]] || mkdir -p $workspace_dir
}

function setup_fonts() {
  if [[ ! -d $font_dir ]] ; then
    echo "Downloading fonts..."
    git clone "$font_repo" "$font_dir" && \
      cd "$font_dir" && \
      echo "Installing fonts..." && \
      ./install.sh
  else
    echo "Fonts directory already exists: ${font_dir}"
  fi
}

function setup_prezto() {
  if [[ ! -e "$prezto_dir" ]] ; then
    echo "Prezto dir: ${prezto_dir}"
    git clone --recursive "$prezto_repo" "$prezto_dir"
  else
    echo "Prezto directory already exists: ${prezto_dir}"
  fi

  if [[ ! -e "$prezto_prompt_dest" ]] ; then
    echo "Linking mattman prompt..."
    ln -s "$prezto_prompt_src" "$prezto_prompt_dest"
  fi
}


function setup_once() {
  ${base_dir}/fonts/install.sh

  if [[ -n "$is_macos" ]] ; then
    ${macos_dir}/run-once.sh
    ${macos_dir}/apps-to-install.sh
  fi
}


cd "${base_dir}"

while getopts fhlxz OPTION
do
  case $OPTION in
    f)  setup_fonts
        opt_set="true"
        ;;
    l)  create_dirs && make
        opt_set="true"
        ;;
    x)  setup_once
        opt_set="true"
        ;;
    z)  setup_prezto
        opt_set="true"
        ;;
    h)  usage 
        exit 1
        ;;
    ?)  usage 
        exit 1
        ;;
  esac
done


# run make by default if no args specified 
if [[ -z $opt_set ]] ; then
  create_dirs
  setup_once

  if [[ -n "$(which stow)" ]] ; then
    cd "$base_dir" && make
  else
    echo "'stow' must be installed before running 'make'"
  fi
fi

