#!/usr/bin/env bash

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
     -i:  Perform intial upgrade of dist packages and reboot

EOU
}


update_dist() {
    echo "Upgrading all dist packages..."

    sudo apt update && \
    sudo apt full-upgrade -yy
  # sudo apt dist-upgrade -yy
}


install_pkgs() {
  echo "Adding PPAs..."

  # use PPA to get current version of Go
  # see: https://github.com/golang/go/wiki/Ubuntu
  sudo add-apt-repository ppa:longsleep/golang-backports
  
  
  echo "Installing packages..."

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
    xclip \
    stow \
    tree \
    fzf \
    ripgrep \
    vim \
    neovim \
    neovim-qt \
    feh \
    imv \
    sxiv \
    nnn \
    vifm \
    htop \
    golang-go \
  
  #  alacritty \
}


case "$1" in
  -i|init*) 
    update_dist
    echo 
    echo "Rebooting..."
    sudo reboot
    ;;
  -h)
    usage
    exit 1
    ;;
  *)
    install_pkgs
    ;;
esac


