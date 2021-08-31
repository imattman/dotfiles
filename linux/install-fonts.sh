#!/bin/bash

THIS_SCRIPT=$(basename "$0")
THIS_DIR=$(dirname "$0")
BASE_DIR=$(cd "$THIS_DIR" && pwd)


sudo apt install -y \
  fonts-firacode \
  fonts-hack \
  fonts-inconsolata


