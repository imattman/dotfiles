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
  cat<<EOU
  Usage: $THIS_SCRIPT [subcommand]

  Installs *neovim* from source on a fresh linux (Ubuntu) system.

  The default is to execute all of the following subcommands in order:

    deps       installs compile dependencies using 'apt install'
    clone      clones neovim git repo to \$WORKSPACE
    build      builds default 'make' target
    install    installs 'nvim' binary via neovim make target

  If an existing workspace is detected, it will be updated.

    update     updates git repo to latest

EOU
}


deps() {
  echo "Installing dependencies (Ubuntu)..."
  sudo apt update -y && \
    sudo apt install \
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
}


clone() {
  echo "Cloning neovim repo to $CLONE_DIR"
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
  echo "Updating neovim repo in $CLONE_DIR"
  cd $CLONE_DIR && git pull
}


build() {
  echo "Building neovim in directory $CLONE_DIR"
  cd "$CLONE_DIR" && \
    rm -rf build && \
    make
}

install() {
  echo "Installing neovim"
  cd "$CONE_DIR" && \
    sudo make install
}


if [[ $# -eq 0 ]]; then
  deps
  clone
  build
  install
else
  for arg in "$@"; do
    case "$arg" in
      -h|--help)
        usage
        exit 1
        ;;
      *)
        $@
        ;;
    esac
  done
fi




