#!/usr/bin/env bash
#
# Basic check for xcode installation 
#

if [[ ! "$(xcode-select -p)" ]] ; then
  echo "XCode needs to be installed"
  exit 1
else
  echo "Verifying installation of command line tools..."
  xcode-select --install
fi

exit 0

