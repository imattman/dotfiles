#!/bin/bash

# fail early
set -ou pipefail

THIS_SCRIPT=$(basename "$0")
THIS_DIR=$(dirname "$0")
BASE_DIR=$(cd "$THIS_DIR" && pwd)
NEOVIM_REPO_URL="https://github.com/neovim/neovim.git"
WORKSPACE="${WORKSPACE:-$HOME/workspace}"
CLONE_DIR="$WORKSPACE/neovim"


usage() {
  cat <<-EOU
	Usage: $THIS_SCRIPT [subcommand]
	
	Installs *neovim* from source on a fresh linux system.
	
	The default is to execute all of the following subcommands in order:
	
	  deps          installs compile dependencies
	  clone         clones source git repo to \$WORKSPACE
	  build         (re)builds default 'make' target
	  install       installs 'nvim' binary via neovim make target
	
	If an existing workspace is detected, it will be updated.
	
	  update        updates git repo to latest

	Maintenance commands:

	  clean_cache   removes local nvim cache directories
	  latest        clones, updates repo, builds, and installs latest from source

EOU
}


deps() {
  if [[ $(command -v apt) ]]; then
  printf "\nInstalling dependencies (Ubuntu/Debian)...\n"
    sudo apt update && \
      sudo apt install -y \
      ninja-build \
      gettext \
      libtool \
      libtool-bin \
      autoconf \
      automake \
      cmake \
      g++ \
      pkg-config \
      unzip \
      curl \
      doxygen
  fi

  if [[ $(command -v dnf) ]]; then
  printf "\nInstalling dependencies (Fedora/Rocky)...\n"
    sudo dnf -y install \
      ninja-build \
      libtool \
      autoconf \
      automake \
      cmake \
      gcc \
      gcc-c++ \
      make \
      pkgconfig \
      unzip \
      patch \
      gettext \
      curl
  fi
}


clone() {
  printf "\nCloning neovim repo to %s\n" "$CLONE_DIR"
  if [[ -d "$CLONE_DIR" ]]; then
    echo "Directory already exists: $CLONE_DIR"
    echo "Attempting 'git pull' to update"
    update
    return
  fi

  cd "$WORKSPACE" && \
    git clone "$NEOVIM_REPO_URL" "$CLONE_DIR"
}


update() {
  printf "\nUpdating neovim repo in %s\n" "$CLONE_DIR"
  cd $CLONE_DIR && git pull
}


build() {
  printf "\nBuilding neovim in directory %s\n" "$CLONE_DIR"
  cd "$CLONE_DIR" && \
    make clean && \
    rm -rf build && \
    make
}

install() {
  printf "\nInstalling 'nvim'\n"
  cd "$CLONE_DIR" && \
    sudo make install
}

details() {
  printf "\nnvim binary:\n"
  ls -l $(which nvim)
  printf "\n"
  nvim --version
}


latest() {
  clone
  build
  install
  details
}

clean_cache() {
  for dir in "$HOME/.local/share/nvim" "$HOME/.config/nvim/plugin"; do
    if [[ -d "$dir" ]]; then
      echo "Removing $dir"
      rm -rf "$dir"
    fi
  done
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



