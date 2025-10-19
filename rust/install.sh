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

RUSTUP_URL="https://sh.rustup.rs"

APP_FILE="${1:-rust-app-install-list.txt}"
APP_FILE="$THIS_DIR/$APP_FILE"

CMD_PREFIX=''

precheck() {
  local fail=''

  if [[ -z "${CARGO_HOME:-}" ]]; then
    echo "\$CARGO_HOME not set!"
    fail=true
  fi

  if [[ -z "${RUSTUP_HOME:-}" ]]; then
    echo "\$RUSTUP_HOME not set!"
    fail=true 
  fi

  if [[ -n "$fail" ]]; then
    echo
    echo "Verify shell environment is properly configured"
    exit 1
  fi
}


install_rustup() {
  # install rust:
  # - most defaults
  # - do not modify PATH (assumed aleady in .dotfiles)
  # - skip confirmation prompt
  curl --proto '=https' --tlsv1.2 -sSf \
    "$RUSTUP_URL" \
    | sh -s -- --no-modify-path -y
}

install_from_file() {
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
    echo "'cargo' binary not found in path"
    echo "Installing via 'rustup' ..."
    echo
    install_rustup
  else
    echo "'cargo' binary found in path."
  fi

  install_from_file "$1"
}


if [[ $# -eq 0 ]]; then
  install "$APP_FILE"
else
  "$@"
fi


