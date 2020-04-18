#!/usr/bin/env bash
#
# Install Homebrew and some packages
#

# fail early
set -eou pipefail

if [[ -n "${DEBUG:=}" ]]; then
  set -x
fi


THIS_SCRIPT=$(basename "$0")
THIS_DIR=$(dirname "$0")
BASE_DIR=$(cd "$THIS_DIR" && pwd)

PKG_FILES='vscode-extension-list.txt'
INSTALL_PKG="${1:-}"


install_pkgs() {
  local pkg_file="$1"

  echo
  echo "Installing extensions from file $pkg_file"
  sed -e 's/\s*#.*//' -e '/^$/d' < "$pkg_file" | \
  while read pkg; do
    if [[ ! $(code --list-extensions | grep $pkg) ]] ; then
      echo "Installing: $pkg"
      code --install-extension "$pkg"
    else
      echo "# $pkg already installed"
    fi
  done
}


# Check for code command line tool
if [[ ! "$(command -v code)" ]] ; then
  echo "Please install VS Code and make sure 'code' command line tool is your PATH"
  exit 1
fi


if [[ -z "$INSTALL_PKG" ]] ; then
  # no arguments means install everything
  pkgs=""
  for pkg in $PKG_FILES; do
    pkgs="$pkgs $BASE_DIR/$pkg"
  done
else
  pkgs="$*"
fi	
  
for pkg_file in $pkgs; do
  install_pkgs $pkg_file
done


exit 0

