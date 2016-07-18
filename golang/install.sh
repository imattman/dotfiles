#!/usr/bin/env bash
#
# Install common Go utils & libraries
#

pkg_file='golang-pkg-list.txt'
pkg_file=$(dirname $0)/$pkg_file

# Check for Go binary and $GOPATH
if [[ ! "$(which go)" ]] ; then
  echo "Go binary not found in path"
  exit 1
fi

if [[ -z "$GOPATH" ]] ; then
  echo "\$GOPATH is not set"
  exit 1
fi


echo Installing packages from $pkg_file

cat $pkg_file | grep -v '#' | egrep -v '^\s*$' | \
while read pkg; do
  echo go get -u $pkg
  go get -u  $pkg
done

exit 0
