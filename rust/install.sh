#!/usr/bin/env bash
#
# Install Rust build tools

#!/usr/bin/env bash

# fail early
set -eou pipefail

if [[ -n "${DEBUG:=}" ]]; then
  set -x
fi

THIS_SCRIPT="${0##*/}"
BASE_DIR="$(cd "${0%/*}" && pwd)"

RUSTUP_URL="https://sh.rustup.rs"


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


install() {
  precheck

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


