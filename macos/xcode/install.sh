#!/usr/bin/env bash
#
# Basic check for xcode installation 
#

xcode_path=$(xcode-select -p)

if [[ -z "$xcode_path" ]] ; then
  echo "XCode needs to be installed"
  xcode-select --install
fi

exit 0

