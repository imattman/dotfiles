#!/bin/bash

THIS_SCRIPT=$(basename "$0")
THIS_DIR=$(dirname "$0")
BASE_DIR=$(cd "$THIS_DIR" && pwd)


usage() {
  cat <<- EOU
	Usage: $THIS_SCRIPT [OPTIONS]
	
	Install initial packages on a fresh linux (ubuntu) system system.
	
	The default behavior installs a baseline set of packages such as zsh,
	tree, stow, etc.
	
	OPTIONS:
	  -h:  Show this message
	  -l:  Display current gnome key rebinds
	  -c:  Add dnf COPR aux repos
	  -p:  Add apt PPA aux repos
	  -g:  Install apt GUI packages (image viewers, etc.)

EOU
}

configure_gnome_key_rebinds() {
  # use `dconf` or `gsettings`
  # dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:ctrl_modifier']"
  # gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier']"

  # show remappings
  #echo gsettings get org.gnome.desktop.input-sources xkb-options
  gsettings get org.gnome.desktop.input-sources xkb-options
}

add_dnf_coprs() {
  echo "Adding COPR for emacs..."
  sudo dnf copr enable bhavin192/emacs-pretest
}

add_apt_ppas() {
  echo "Adding PPAs..."

  local PPAS="
  # current emacs
  ppa:kelleyk/emacs

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

install_apt_gui_pkgs() {
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
    autoconf \
    automake \
    build-essential \
    libncurses5-dev \
    libffi-dev \
    libssl-dev \
    inotify-tools \
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
    enscript \
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
    watchman \
    dictd \
    dict-gcide

  # kitty \
  #  neovim \
  #  grub-customizer \

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
  -l)
    configure_gnome_key_rebinds
    ;;
  -c)
    add_dnf_coprs
    ;;
  -p)
    add_apt_ppas
    ;;
  -g)
    install_apt_gui_pkgs
    ;;
  *)
    install_pkgs
    setup_flatpak
    ;;
esac


