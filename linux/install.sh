#!/bin/bash

THIS_SCRIPT=$(basename "$0")
THIS_DIR=$(dirname "$0")
BASE_DIR=$(cd "$THIS_DIR" && pwd)


usage() {
  cat<<EOU
  Usage: $THIS_SCRIPT [OPTIONS]

  Install initial packages on a fresh linux (ubuntu) system system.

  The default behavior is to install a baseline set of packages such as 
  zsh, tree, stow, etc.

  OPTIONS:
     -h:  Show this message
     -i:  Perform intial upgrade of all packages and reboot
     -g:  Install GUI packages (image viewers, etc.)

EOU
}


update_full() {
    echo "Upgrading all packages..."

    sudo apt update && \
    sudo apt full-upgrade -y
}


install_gui_pkgs() {
  echo "Installing GUI packages..."

  sudo apt install -y \
    xsel \
    ulauncher \
    neovim-qt \
    feh \
    imv \
    sxiv \
    sm
}


install_pkgs() {
  echo "Adding PPAs..."

  # use PPA to get current version of Go
  # see: https://github.com/golang/go/wiki/Ubuntu
  sudo add-apt-repository ppa:longsleep/golang-backports
  
  echo "Installing packages..."

  sudo apt update && \
    sudo apt install -y \
    os-prober \
    grub2-common \
    grub-customizer \
    make \
    ansible \
    zsh \
    fish \
    python3 \
    python3-pip \
    stow \
    tree \
    fzf \
    ripgrep \
    htop \
    vim-nox \
    neovim \
    nnn \
    vifm \
    golang-go
  
  #  alacritty \
}


case "$1" in
  -i|init*) 
    update_full
    echo 
    echo "Rebooting..."
    sudo reboot
    ;;
  -h)
    usage
    exit 1
    ;;
  -g)
    install_gui_pkgs
    ;;
  *)
    install_pkgs
    ;;
esac


