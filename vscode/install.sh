#!/usr/bin/env bash

# fail early
set -eou pipefail

if [[ -n "${DEBUG:=}" ]]; then
  set -x
fi


THIS_SCRIPT=$(basename "$0")
THIS_DIR=$(dirname "$0")
BASE_DIR=$(cd "$THIS_DIR" && pwd)

SRC_CONFIG="settings.json"
SRC_KEYBINDINGS="keybindings.json"
SRC_SNIPPETS="snippets"

if [[ $(uname -s | grep -i darwin) ]]; then
  CONFIG_BASE="$HOME/Library/Application Support"
else
  CONFIG_BASE="${XDG_CONFIG_HOME:-$HOME/.config}"
fi
DEST_DIR="${CONFIG_BASE}/Code/User"
DEST_CONFIG="${DEST_DIR}/${SRC_CONFIG}"
DEST_KEYBINDINGS="${DEST_DIR}/${SRC_KEYBINDINGS}"
DEST_SNIPPETS="${DEST_DIR}/${SRC_SNIPPETS}"

SRC_CONFIG="${BASE_DIR}/${SRC_CONFIG}"
SRC_KEYBINDINGS="${BASE_DIR}/${SRC_KEYBINDINGS}"
SRC_SNIPPETS="${BASE_DIR}/${SRC_SNIPPETS}"

setup() {
  local src="$1"
  local dest="$2"
  local backup="${2}.bak"
  local dest_base=$(basename "$dest")

  #echo "src:  $src"
  #echo "dest: $dest"
  #echo "dest_base: $dest_base"

  if [[ -L "$dest" ]]; then
    echo "symlink already exists: $dest"
  else
    if [[ -e "$dest" ]]; then
      echo "moving old $dest_base to $backup"
      mv "$dest" "$backup"
    fi

    echo "linking $src to $dest"
    ln -s "$src" "$dest"
  fi
}

if [[ ! -d "$DEST_DIR" ]] ; then
  echo "Directory not found: $DEST_DIR"
  echo
  echo Launch VS Code to initialize config paths before running this script.
  exit 1
fi


setup "$SRC_CONFIG" "$DEST_CONFIG"
setup "$SRC_KEYBINDINGS" "$DEST_KEYBINDINGS"
setup "$SRC_SNIPPETS" "$DEST_SNIPPETS"

