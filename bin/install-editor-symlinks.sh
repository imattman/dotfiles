#!/usr/bin/env bash

if [[ ! -d /usr/local/bin ]] ; then
  echo "/usr/local/bin directory not found"
  exit 1
fi


# VS Code
echo "Adding 'code' command for VS Code"
ln -s "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" /usr/local/bin

# Sublime Text
echo "Adding 'subl' command for Sublime Text"
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin


