#!/bin/bash

THIS_SCRIPT=$(basename "$0")
THIS_DIR=$(dirname "$0")
BASE_DIR=$(cd "$THIS_DIR" && pwd)
CLONE_DIR="${1:-$WORKSPACE}"

cd "$CLONE_DIR"
git clone https://github.com/Mayccoll/Gogh.git gogh-terminal-themes
cd gogh-terminal-themes/themes


if [[ $(lsb_release -as | grep -i ubuntu) ]]; then
  echo "Detected Ubuntu based system.  Set the following before running install scripts:"
  echo
  echo "  export TERMINAL=gnome-terminal"
  echo
fi

echo "Run desired install scripts:"
echo
echo "  ./dracula.sh"
echo "  ./tomorrow-night-bright.sh"

