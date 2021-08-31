#!/bin/bash

THIS_SCRIPT=$(basename "$0")
THIS_DIR=$(dirname "$0")
BASE_DIR=$(cd "$THIS_DIR" && pwd)

sudo apt update
sudo apt install docker.io

sudo usermod -aG docker $USER
sudo systemctl enable --now docker

echo "Log out for the group change to take effect"

