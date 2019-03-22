#!/usr/bin/env bash
#
# SSH key setup helper

# halt on errors
set -e

base_dir="$(cd $(dirname $0) && pwd)"

if [[ -n "$SSH_EMAIL" ]]; then
  ssh_email="$SSH_EMAIL"
else
  ssh_email="$EMAIL"
fi

if [[ -z "$ssh_email" ]]; then
  echo '$SSH_EMAIL or $EMAIL must be set'
  exit 1
fi

# copy over ssh config
[[ -f ~/.ssh/config ]] && mv ~/.ssh/config ~/.ssh/config.prev
cp "$base_dir"/config ~/.ssh/config

# generate new key pair
ssh-keygen -t rsa -b 4096 -C "${ssh_email}"

# add private key to agent
#eval "$(ssh-agent -s)"
ssh-add -K $(ls ~/.ssh/id_*rsa* | grep -v '.pub$')

