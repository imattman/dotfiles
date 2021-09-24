#!/usr/bin/env bash
#
# Install common Python tools & libraries

# fail early
set -eou pipefail

if [[ -n "${DEBUG:=}" ]]; then
  set -x
fi

THIS_SCRIPT=$(basename "$0")
THIS_DIR=$(dirname "$0")
BASE_DIR=$(cd "$THIS_DIR" && pwd)
CMD_PREFIX=''

PIP_FILE='pip-libs.txt'
PIP_FILE="$THIS_DIR/$PIP_FILE"

PIPX_FILE='pipx-libs.txt'
PIPX_FILE="$THIS_DIR/$PIPX_FILE"

# allow package file to be specified as argument
PIPX_FILE="${1:-$PIPX_FILE}"



install_from_file() {
  local cmd="$1"
  local pkg_file="$2"
  local installed=$($cmd list)

  echo Installing $cmd packages from $pkg_file

  sed -e 's/\s*#.*//' -e '/^$/d' < "$pkg_file" | \
  while read -r pkg; do
    if [[ ! $(echo "$installed" | grep $pkg) ]]; then
        echo $CMD_PREFIX $cmd install $pkg
        $CMD_PREFIX $cmd install $pkg
    else
      echo "# $pkg already installed"
    fi
    echo
  done
}

# verify pip is installed
if [[ ! $(python3 -m pip --help) ]]; then
  echo "pip not found!"
  exit 1
fi

# ensure pipx is installed
if [[ ! $(command -v pipx) ]]; then
  echo "pipx not found; installing..."
  python3 -m pip install --user pipx
  python3 -m pipx ensurepath
fi


install_from_file pipx $PIPX_FILE
install_from_file 'python3 -m pip install --user' $PIP_FILE

exit 0


