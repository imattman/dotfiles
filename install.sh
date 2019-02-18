#!/usr/bin/env bash
set -e 

base_dir="$(cd $(dirname $0) && pwd)"

prezto_dir="${base_dir}/prezto"
# determine git transport from user info in SSH public key
if [[ -n $(grep 'mattman' $HOME/.ssh/id_rsa.pub ) ]] ; then
  echo "Found 'mattman' in ssh credentials; assuming access to GitHub."
  prezto_repo="git@github.com:imattman/prezto.git"
else
  echo "Did not find 'mattman' in ssh credentials."
  prezto_repo="https://github.com/imattman/prezto.git"
fi
prezto_upstream="https://github.com/sorin-ionescu/prezto"

is_macos=$(uname -s | grep -i 'darwin')
macos_dir="${base_dir}/macos"

function usage() {
  this_script=$(basename $0)

  cat<<EOU
  Usage: $this_script [OPTIONS]
  
  A basic installer my dotfiles.
  
  OPTIONS:
     -h:  Show this message
     -g:  Fetch additional git modules (prezto, mac defaults)
     -l:  Execute Makefile setup script to generate symlinks
     -x:  Execute non-idempotent scripts that should be run only once
          with initial install
EOU
}

function create_dirs() {
  [[ -d $HOME/bin ]] || mkdir -p $HOME/bin
  [[ -d $HOME/workspace ]] || mkdir -p $HOME/workspace
}

function setup_prezto() {
  if [[ ! -e "$prezto_dir" ]] ; then
    echo "Updating prezto..."
    git clone --recursive "$prezto_repo" && \
      cd "$prezto_dir" && \
      git remote add upstream "$prezto_upstream" && \
      git checkout -t origin/mattman_prompt && \
      git status
  else
    echo "Prezto directory already exists: ${prezto_dir}"
  fi
}

function setup_submodules() {
  setup_prezto
}


function setup_once() {
  ${base_dir}/fonts/install.sh

  if [[ -n "$is_macos" ]] ; then
    ${macos_dir}/run-once.sh
    ${macos_dir}/apps-to-install.sh
  fi
}

cd "${base_dir}"

while getopts hglx OPTION
do
  case $OPTION in
    g)  setup_submodules
        opt_set="true"
        ;;
    l)  create_dirs && make
        opt_set="true"
        ;;
    x)  setup_once
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
  setup_submodules
  setup_once

  if [[ -n "$(which stow)" ]] ; then
    cd "$base_dir" && make
  else
    echo "'stow' must be installed before running 'make'"
  fi
fi

