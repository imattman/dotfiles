#!/usr/bin/env bash

# fail early
set -eou pipefail

if [[ -n "${DEBUG:=}" ]]; then
  set -x
fi

THIS_SCRIPT="${0##*/}"
BASE_DIR="$(cd "${0%/*}" && pwd)"

CLONE_BASE="${1:-$XDG_LOCAL_HOME}"
CLONE_DIR="gogh-terminal-themes"


cd "$CLONE_BASE" && \
  git clone https://github.com/Mayccoll/Gogh.git "$CLONE_DIR"


if [[ $(grep -i ubuntu /etc/os-release) ]]; then
  echo "Detected Ubuntu based system.  Set the following before running install scripts:"
  echo
  echo "  export TERMINAL=gnome-terminal"
  echo
fi

echo "Run desired install scripts:"

echo
echo "  cd $CLONE_BASE/$CLONE_DIR/themes"
echo
echo "  ./tomorrow-night-bright.sh"
echo "  ./dracula.sh"

