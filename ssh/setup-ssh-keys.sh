#!/usr/bin/env bash
#
# SSH key setup helper

# halt on errors
set -eu

base_dir="$(cd $(dirname $0) && pwd)"

ssh_email=${SSH_EMAIL:-$EMAIL}

if [[ -z "$ssh_email" ]]; then
  echo '$SSH_EMAIL or $EMAIL must be set'
  exit 1
fi

# generate new key pair
# use newer alternative to RSA
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -C "${ssh_email}"
#ssh-keygen -t rsa -b 4096 -C "${ssh_email}"

# copy over ssh config
[[ -f ~/.ssh/config ]] && mv ~/.ssh/config ~/.ssh/config.prev
cp "${base_dir}/config" ~/.ssh/config

# add private key to agent
#eval "$(ssh-agent -s)"
ssh-add -K $(ls ~/.ssh/id_* | grep -v '.pub$')

