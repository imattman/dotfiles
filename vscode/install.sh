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
SRC_SNIPPETS="snippets"

DEST_DIR="$HOME/Library/Application Support/Code/User"
DEST_CONFIG="${DEST_DIR}/${SRC_CONFIG}"
DEST_SNIPPETS="${DEST_DIR}/${SRC_SNIPPETS}"
SRC_CONFIG="${BASE_DIR}/${SRC_CONFIG}"
SRC_SNIPPETS="${BASE_DIR}/${SRC_SNIPPETS}"


if [[ ! -d "$DEST_DIR" ]] ; then
  echo "Directory not found: $DEST_DIR"
  echo
  echo Launch VS Code to initialize config paths before running this script.
  exit 1
fi


if [[ -L "$DEST_CONFIG" ]]; then
  echo "Symlink already exists: $DEST_CONFIG"
else
  if [[ -f "$DEST_CONFIG" ]]; then
    dest_backup="${DEST_CONFIG}.bak"
    echo "moving old config to $dest_backup"
    mv "$DEST_CONFIG" "$dest_backup"
  fi

  echo "linking $SRC_CONFIG to $DEST"
  ln -s "${SRC_CONFIG}" "$DEST_CONFIG"
fi


if [[ -L "$DEST_SNIPPETS" ]]; then
    echo "Symlink already exists: $DEST_SNIPPETS"
else
  if [[ -d "$DEST_SNIPPETS" ]]; then
    dest_backup="${DEST_SNIPPETS}.bak"
    echo "moving old snippets to $dest_backup"
    mv "$DEST_SNIPPETS" "$dest_backup"
  fi

  echo "linking $SRC_SNIPPETS to $DEST_SNIPPETS"
  ln -s "$SRC_SNIPPETS" "$DEST_SNIPPETS"
fi


