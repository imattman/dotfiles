#!/usr/bin/env bash

set -e

base_dir="$(cd $(dirname $0) && pwd)"
completed="${HOME}/.mattman_macos_init_done"


if [[ -f "$completed" ]] ; then
  echo "Setup already completed. See $completed for details."
  exit
fi


echo "Running one-time config..."
${base_dir}/set-defaults.sh
${base_dir}/terminal/install.sh
${base_dir}/xcode/install.sh
${base_dir}/homebrew/install.sh

echo "Set up run $(date)" >> "$completed"


