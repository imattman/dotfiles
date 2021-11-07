#!/usr/bin/env bash
#
# Install Rust build tools

# fail early
set -eou pipefail

if [[ -n "${DEBUG:=}" ]]; then
  set -x
fi

THIS_SCRIPT=$(basename "$0")
THIS_DIR=$(dirname "$0")
BASE_DIR=$(cd "$THIS_DIR" && pwd)

RUSTUP_URL="https://sh.rustup.rs"


install_rustup() {
  curl --proto '=https' --tlsv1.2 -sSf \
    "$RUSTUP_URL" \
    | sh -s -- --no-modify-path
}


check_env() {
  fail=''

  if [[ -z "${CARGO_HOME:-}" ]]; then
    echo "Value not set for \$CARGO_HOME"
    fail=1
  fi

  if [[ -z "${RUSTUP_HOME:-}" ]]; then
    echo "Value not set for \$RUSTUP_HOME"
    fail=1  
  fi

  if [[ -n "$fail" ]]; then
    echo
    echo "Verify shell environment is properly configured"
    exit 1
  fi
}


install() {
  check_env

  # Check for cargo binary
  if [[ ! "$(command -v cargo)" ]] ; then
    echo "'cargo' binary not found in path"
    echo "Installing via 'rustup' ..."
    echo

    install_rustup
  else
    echo "'cargo' binary found in path.  To update:"
    echo
    echo "  rustup update"
  fi
}


if [[ $# -eq 0 ]]; then
  install
else
  "$@"
fi


