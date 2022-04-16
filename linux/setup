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
     -p:  Add apt PPAs
     -g:  Install GUI packages (image viewers, etc.)

EOU
}


update_full() {
    echo "Upgrading all packages..."

    sudo apt update && \
    sudo apt full-upgrade -y
}


add_ppas() {
  echo "Adding PPAs..."

  local PPAS="
  # current python
  ppa:deadsnakes/ppa

  # current golang
  # see: https://github.com/golang/go/wiki/Ubuntu
  ppa:longsleep/golang-backports
  "


  echo "$PPAS" | sed -e 's/\s*#.*//' -e '/^\s*$/d' | \
  while read -r ppa; do
    sudo add-apt-repository -y "$ppa"
  done
  
}

install_gui_pkgs() {
  echo "Installing GUI packages..."

  sudo apt install -y \
    xsel \
    ulauncher \
    feh \
    imv \
    sxiv \
    sm

  # currently install neovim from source
    #neovim-qt \
}

pandoc() {
  sudo apt update && \
    sudo apt install -y \
    pandoc \
    texlive-latex-base \
    texlive-fonts-recommended \
    texlive-extra-utils \
    texlive-latex-extra
}

install_pkgs() {
  echo "Installing packages..."

  sudo apt update && \
    sudo apt install -y \
    os-prober \
    grub2-common \
    grub-customizer \
    autoconf \
    automake \
    build-essential \
    libncurses5-dev \
    libffi-dev \
    libssl-dev \
    tmux \
    make \
    ansible \
    stow \
    jq \
    zsh \
    vim-nox \
    python3 \
    python3-dev \
    python3-venv \
    python3-pip \
    python-is-python3 \
    tree \
    fzf \
    ripgrep \
    htop \
    uuid \
    neofetch \
    nnn \
    vifm \
    golang-go \
    fish \
    entr \
    watchman

  # kitty \
  #  neovim \

  if [[ ! $(which cal) ]]; then
    # 'ncal' required for '/usr/bin/cal' on PoPOS
    sudo apt install -y ncal
  fi

  
  #  alacritty \
}

setup_flatpak() {
  echo "Adding flathub repo..."
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
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
  -p)
    add_ppas
    ;;
  -g)
    install_gui_pkgs
    ;;
  *)
    install_pkgs
    setup_flatpak
    ;;
esac


