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

PKG_FILE='golang-pkg-list.txt'
PKG_FILE="$THIS_DIR/$PKG_FILE"

GOMOD_FILE='golang-gomod-list.txt'
GOMOD_FILE="$THIS_DIR/$GOMOD_FILE"

# allow package file to be specified as argument
PKG_FILE="${1:-$PKG_FILE}"

GOMOD_PREFIX='env GO111MODULE=on'
CMD_PREFIX=''


install_from_file() {
  local= pkg_file="$1"

  if [[ $(echo $pkg_file | grep -- '-gomod-') ]] ; then
    echo Installing Go module packages from $pkg_file
    CMD_PREFIX="$CMD_PREFIX $GOMOD_PREFIX"
  else
    echo Installing classic packages from $pkg_file
    if [[ -z "$GOPATH" ]] ; then
      echo '$GOPATH is not set'
      exit 1
    fi
  fi

  sed -e 's/\s*#.*//' -e '/^$/d' < "$pkg_file" | \
  while read pkg; do
    echo $CMD_PREFIX go get -v -u $pkg
    $CMD_PREFIX go get -v -u $pkg
    echo
  done
}


# Check for go binary and $GOPATH
if [[ ! "$(command -v go)" ]] ; then
  echo "Go binary not found in path"
  exit 1
fi

install_from_file $PKG_FILE

if [[ $# -eq 0 ]] ; then
  install_from_file $GOMOD_FILE
fi

exit 0


