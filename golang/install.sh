#!/usr/bin/env bash
#
# Install common Go utils & libraries

# fail early
set -euo pipefail
#IFS=$'\n\t'

DEBUG=${DEBUG:-}
if [[ -n "$DEBUG" ]]; then
  set -x
fi

pkg_file='golang-pkg-list.txt'
pkg_file="$(dirname $0)/$pkg_file"
# allow package file to be specified as argument
pkg_file="${1:-$pkg_file}"

# Check for go binary and $GOPATH
if [[ ! "$(which go)" ]] ; then
  echo "Go binary not found in path"
  exit 1
fi

if [[ -z "$GOPATH" ]] ; then
  echo '$GOPATH is not set'
  exit 1
fi


echo Installing packages from $pkg_file

sed -e 's/\s*#.*//' -e '/^$/d' < "$pkg_file" | \
while read pkg; do
  echo go get -v -u $pkg
  go get -v -u $pkg
  echo
done

exit 0

