#!/usr/bin/env bash

THIS_SCRIPT=$(basename "$0")
THIS_DIR=$(dirname "$0")
BASE_DIR=$(cd "$THIS_DIR" && pwd)

case "$1" in
  init*) 
    echo "Performing system update and reboot.."
    sudo apt update && \
    sudo apt full-upgrade -yy
  # sudo apt dist-upgrade -yy

    echo
    echo "Rebooting..."
    sudo reboot
    ;;
  h)
    echo "$THIS_SCRIPT [init]"
    exit 1
    ;;
  *)
    echo "Installing packages..."
    ;;
esac


# current version of Go from PPA
# see: https://github.com/golang/go/wiki/Ubuntu
sudo add-apt-repository ppa:longsleep/golang-backports


sudo apt update && \
  sudo apt install -yy \
  os-prober \
  grub2-common \
  grub-customizer \
  ansible \
  gnome-tweaks \
  gnome-sushi \
  zsh \
  fish \
  stow \
  tree \
  fzf \
  ripgrep \
  vim \
  neovim \
  neovim-qt \
  feh \
  htop \
  golang-go \

#  alacritty \




