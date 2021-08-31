#!/bin/bash

THIS_SCRIPT=$(basename "$0")
THIS_DIR=$(dirname "$0")
BASE_DIR=$(cd "$THIS_DIR" && pwd)

sudo apt update
sudo apt install openssh-server

# verify it started
sudo systemctl status ssh

echo "Be sure to check if firewall needs to be updated"
echo "  sudo ufw allow ssh"

