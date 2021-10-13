#!/bin/bash

THIS_SCRIPT=$(basename "$0")
THIS_DIR=$(dirname "$0")
BASE_DIR=$(cd "$THIS_DIR" && pwd)



usage() {
  cat<<EOU
  Usage: $THIS_SCRIPT [OPTIONS]

  Install fonts on a debian/ubuntu linux system.

  OPTIONS:
     -h:  Show this message
     -m:  Install Microsoft fonts (presents EULA)

EOU
}


ms_fonts() {
  # keep this as a separate manual install option 
  # because of modal EULA
  echo "Installing MS fonts..."

  sudo apt install -y \
    ttf-mscorefonts-installer
}


std_fonts() {
  echo "Installing fonts..."

  sudo apt install -y \
    fonts-firacode \
    fonts-hack \
    fonts-inconsolata \
    fonts-crosextra-carlito \
    fonts-crosextra-caladea
}


case "$1" in
  -h)
    usage
    exit 1
    ;;
  -m)
    ms_fonts
    ;;
  *)
    std_fonts 
    ;;
esac


