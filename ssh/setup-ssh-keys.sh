#!/bin/sh
#
# SSH key setup helper

# halt on errors
set -eu


THIS_SCRIPT="$(basename "$0")"
THIS_DIR="$(dirname "$0")"
BASE_DIR="$(cd "$THIS_DIR" && pwd)"


if [ $# -gt 0 ]; then
  ssh_email="$1"
else
  ssh_email=${SSH_EMAIL:-${EMAIL:-}}
fi


if [ -z "$ssh_email" ]; then
  echo 'Email address must be supplied as an argument or set via environment $SSH_EMAIL'
  exit 1
fi



# generate new key pair
# use newer alternative to RSA
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -C "${ssh_email}"
#ssh-keygen -t rsa -b 4096 -C "${ssh_email}"

# copy over ssh config
[[ -f ~/.ssh/config ]] && mv ~/.ssh/config ~/.ssh/config.prev
cp "${BASE_DIR}/config" ~/.ssh/config

# add private key to agent
#eval "$(ssh-agent -s)"
ssh-add -K $(ls ~/.ssh/id_* | grep -v '.pub$')


