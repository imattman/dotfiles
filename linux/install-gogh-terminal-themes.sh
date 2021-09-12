#!/bin/bash

set -eou pipefail

THIS_SCRIPT=$(basename "$0")
THIS_DIR=$(dirname "$0")
BASE_DIR=$(cd "$THIS_DIR" && pwd)
WORKSPACE="${1:-$WORKSPACE}"
CLONE_DIR="gogh-terminal-themes"


cd "$WORKSPACE"
git clone https://github.com/Mayccoll/Gogh.git "$CLONE_DIR"
cd "${CLONE_DIR}/themes"


if [[ $(grep -i ubuntu /etc/os-release) ]]; then
  echo "Detected Ubuntu based system.  Set the following before running install scripts:"
  echo
  echo "  export TERMINAL=gnome-terminal"
  echo
fi

echo "Run desired install scripts:"

echo
echo "  cd $WORKSPACE/$CLONE_DIR/themes"
echo
echo "  ./dracula.sh"
echo "  ./tomorrow-night-bright.sh"

