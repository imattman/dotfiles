#!/usr/bin/env bash
#
# Install common Go utils & libraries

# fail early
set -eou pipefail

if [[ -n "${DEBUG:=}" ]]; then
  set -x
fi

THIS_SCRIPT=$(basename "$0")
THIS_DIR=$(dirname "$0")
BASE_DIR=$(cd "$THIS_DIR" && pwd)

PKG_FILE='golang-pkg-get-list.txt'
PKG_FILE="$THIS_DIR/$PKG_FILE"

APP_FILE='golang-app-install-list.txt'
APP_FILE="$THIS_DIR/$APP_FILE"

# allow package file to be specified as argument
PKG_FILE="${1:-$PKG_FILE}"

#GOMOD_PREFIX='env GO111MODULE=on'
GOMOD_PREFIX=''
CMD_PREFIX=''

go_get() {
  install_from_file "get" "$1"
}


go_install() {
  install_from_file "install" "$1"
}


install_from_file() {
  local fetch_type="$1"
  local pkg_file="$2"

  if [[ -z "$GOPATH" ]] ; then
    echo '$GOPATH is not set'
    exit 1
  fi

  echo "[go $fetch_type] processing entries from $pkg_file"

  sed -e 's/\s*#.*//' -e '/^\s*$/d' < "$pkg_file" | \
  while read -r pkg; do
    echo $CMD_PREFIX go $fetch_type $pkg
    $CMD_PREFIX go $fetch_type $pkg
    echo
  done
}


# Check for go binary and $GOPATH
if [[ ! "$(command -v go)" ]] ; then
  echo "Go binary not found in path"
  exit 1
fi

if [[ $# -gt 0 ]]; then
  for fname in "$@"; do
    case "$fname" in
      *install*)
        go_install "$fname"
        ;;
      *get*)
        go_get "$fname"
        ;;
    esac
  done
else
  # delegate dependency managment to respective projects
  #go_get "$PKG_FILE"
  go_install "$APP_FILE"
fi

