#!/bin/bash

# fail early
set -ou pipefail

THIS_SCRIPT=$(basename "$0")
THIS_DIR=$(dirname "$0")
BASE_DIR=$(cd "$THIS_DIR" && pwd)
REPO_URL="https://github.com/GothenburgBitFactory/taskwarrior.git"
WORKSPACE="${WORKSPACE:-$HOME/workspace}"
CLONE_DIR="$WORKSPACE/taskwarrior"


usage() {
  cat<<EOU
	Usage: $THIS_SCRIPT [subcommand]
	
	Installs *taskwarrior* from source on a fresh linux system.
	
	The default is to execute all of the following subcommands in order:
	
	  deps          installs compile dependencies
	  clone         clones source git repo to \$WORKSPACE
	  build         (re)builds default 'make' target
	  install       installs 'task' binary via taskwarrior make target
	
	If an existing workspace is detected, it will be updated.
	
	  update        updates git repo to latest

	Maintenance commands:

	  clean_cache   removes local nvim cache directories
	  latest        clones, updates repo, builds, and installs latest from source

EOU
}


deps() {
  if [[ $(command -v apt) ]]; then
  echo "Installing dependencies (Ubuntu/Debian)..."
    sudo apt update && \
      sudo apt install -y \
        libgnutls28-dev \
        uuid-dev \
        libdigest-sha3-perl
  fi

  if [[ $(command -v dnf) ]]; then
  echo "Installing dependencies (Fedora/Rocky)..."
    sudo dnf -y install \
      gnutls-devel \
      libuuid-devel \
      sha3sum
  fi
}


clone() {
  echo "Cloning taskwarrior repo to $CLONE_DIR"
  if [[ -d "$CLONE_DIR" ]]; then
    echo "Directory already exists: $CLONE_DIR"
    echo "Attempting 'git pull' to update"
    update
    return
  fi

  cd "$WORKSPACE" && \
    git clone "$REPO_URL" "$CLONE_DIR"
}


update() {
  echo "Updating taskwarrior repo in $CLONE_DIR"
  cd $CLONE_DIR && git pull
}


build() {
  echo "Building taskwarrior in directory $CLONE_DIR"
  cd "$CLONE_DIR" && \
    cmake -DCMAKE_BUILD_TYPE=release . && \
    make clean && \
    make
}

install() {
  echo "Installing task"
  cd "$CLONE_DIR" && \
    sudo make install
}

details() {
  printf "\ntask binary:\n"
  ls -l $(which task)
  printf "\n"
  task --version
}


latest() {
  clone
  build
  install
  details
}


if [[ $# -eq 0 ]]; then
  deps
  clone
  build
  install
  details
else
  for arg in "$@"; do
    case "$arg" in
      -h|--help)
        usage
        exit 1
        ;;
      *)
        "$arg"
        ;;
    esac
  done
fi




