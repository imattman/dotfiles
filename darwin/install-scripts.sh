#!/bin/bash

# fail early
set -ou pipefail

if [[ -n "${DEBUG:=}" ]]; then
  set -x
fi

THIS_SCRIPT=$(basename "$0")
THIS_DIR=$(dirname "$0")
BASE_DIR=$(cd "$THIS_DIR" && pwd)
BIN_DIR="$HOME/.local/bin"


install() {
  pushd "$BASE_DIR"
  stow -v -t "$BIN_DIR" scripts
  popd
}

uninstall() {
  pushd "$BASE_DIR"
  stow -D -t "$BIN_DIR" scripts
  popd
}


action=${1:-install}

$action


