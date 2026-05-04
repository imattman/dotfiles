#!/usr/bin/env bash
#
# Install Rust tools & utilities

# fail early
set -eou pipefail

if [[ -n "${DEBUG:=}" ]]; then
  set -x
fi

THIS_SCRIPT="${0##*/}"
THIS_DIR="$(cd "${0%/*}" && pwd)"
PLATFORM="$(uname -s)"
PLATFORM="${PLATFORM,,}"

RUSTUP_URL="https://sh.rustup.rs"

APP_FILE="${1:-rust-app-install-list.txt}"
APP_FILE="$THIS_DIR/$APP_FILE"

CMD_PREFIX=''

precheck() {
  local fail=''

  if [[ -z "${CARGO_HOME:-}" ]]; then
    echo "CARGO_HOME not set!"
    fail=true
  fi

  if [[ -z "${RUSTUP_HOME:-}" ]]; then
    echo "RUSTUP_HOME not set!"
    fail=true
  fi

  if [[ ! "$(command -v rustup)" ]] ; then
    echo "Cannot find 'rustup' in PATH!"
    fail=true
  fi

  if [[ "$PLATFORM" == 'darwin' ]]; then
    if [[ ! "$(command -v rustup-init)" ]] ; then
      echo "Cannot find 'rustup-init' in PATH!"
      fail=true
    fi
  fi


  if [[ "$fail" == true ]]; then
    echo
    echo "Verify environment is properly configured"
    exit 1
  fi
}


install_rustup() {
  # install rust:
  # - most defaults
  # - do not modify PATH (assumed aleady in .dotfiles)
  # - skip confirmation prompt
  curl --proto '=https' --tlsv1.2 -sSf "$RUSTUP_URL" \
    | sh -s -- --no-modify-path -y
}


install_pkgs() {
  local pkg_file="$1"

  echo "Processing entries from $pkg_file"

  sed -e 's/\s*#.*//' -e '/^\s*$/d' < "$pkg_file" | \
  while read -r pkg; do
    echo $CMD_PREFIX cargo install $pkg
    $CMD_PREFIX cargo install $pkg
    echo
  done
}

install() {
  precheck

  # Check for cargo binary
  if [[ ! "$(command -v cargo)" ]] ; then
    rustup-init -y --no-modify-path
    rustup toolchain install stable
  else
    echo "'cargo' binary found in path."
  fi

  install_pkgs "$1"
}


if [[ $# -eq 0 ]]; then
  install "$APP_FILE"
else
  "$@"
fi


