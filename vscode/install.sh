#!/usr/bin/env bash

set -e

if [[ -n "$DEBUG" ]]; then
  set -x
fi


base_dir="$(cd $(dirname $0) && pwd)"
src_file="settings.json"

dest="$HOME/Library/Application Support/Code/User"

if [[ ! -d "$dest" ]] ; then
  echo "Directory not found: $dest"
  echo
  echo Launch VS Code to initialize config paths before running this.
  exit 1
fi

#echo "copying $src_file to $dest"
#cp "${base_dir}/${src_file}" "$dest"

echo "linking $src_file to $dest"
ln -s "${base_dir}/${src_file}" "$dest"

