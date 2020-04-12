#!/usr/bin/env bash

# fail early
set -eou pipefail

if [[ -n "${DEBUG:=}" ]]; then
  set -x
fi


base_dir="$(cd $(dirname $0) && pwd)"
src_file="settings.json"

dest="$HOME/Library/Application Support/Code/User"
dest_file="${dest}/${src_file}"

if [[ ! -d "$dest" ]] ; then
  echo "Directory not found: $dest"
  echo
  echo Launch VS Code to initialize config paths before running this.
  exit 1
fi

#echo "copying $src_file to $dest"
#cp "${base_dir}/${src_file}" "$dest"

if [[ -e "$dest_file" ]]; then
  dest_backup="${dest_file}.bak"
  echo "moving old config to $dest_backup"
  mv "$dest_file" "$dest_backup"
fi

echo "linking $src_file to $dest"
ln -s "${base_dir}/${src_file}" "$dest_file"

