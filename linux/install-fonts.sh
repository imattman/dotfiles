#!/bin/bash

THIS_SCRIPT=$(basename "$0")
THIS_DIR=$(dirname "$0")
BASE_DIR=$(cd "$THIS_DIR" && pwd)

TAGS_URL='https://api.github.com/repos/ryanoasis/nerd-fonts/tags'
DOWNLOAD_URL='https://github.com/ryanoasis/nerd-fonts/releases/download'
NERD_FONT_DIR="$WORKSPACE/nerdfonts"
NERD_FONT_LIST="FiraMono.zip  Hack.zip	Inconsolata.zip  JetBrainsMono.zip"

FONT_FILES='Fira Mono Regular Nerd Font Complete Mono.otf
Hack Regular Nerd Font Complete Mono.ttf
Inconsolata Regular Nerd Font Complete Mono.otf
JetBrains Mono Regular Nerd Font Complete Mono.ttf'



usage() {
  cat<<EOU
  Usage: $THIS_SCRIPT [SUBCOMMAND]

  Install fonts on a debian/ubuntu linux system.

  SUBCOMMANDS:

    nerdfonts Downloads and installs select Nerdfonts 
              for user (default)
    fonts     Installs non-nerdfonts via apt
    msfonts   Installs MS fonts with license prompt
    remove    Removes standard fonts


EOU
}


msfonts() {
  # keep this as a separate manual install option 
  # because of modal EULA
  echo "Installing MS fonts..."

  sudo apt install -y \
    ttf-mscorefonts-installer
}


fonts() {
  echo "Installing fonts..."

  sudo apt install -y \
    fonts-firacode \
    fonts-hack \
    fonts-inconsolata \
    fonts-crosextra-carlito \
    fonts-crosextra-caladea
}


remove() {
  echo "Uninstalling fonts..."

  sudo apt remove -y \
    fonts-firacode \
    fonts-hack \
    fonts-inconsolata \
    fonts-crosextra-carlito \
    fonts-crosextra-caladea
}

nerdfonts_version() {
  curl -s "$TAGS_URL" \
    | jq -r '.[0].name'
}

nerdfonts() {
  echo "Downloading nerdfonts to $NERD_FONT_DIR ..."
  cd $WORKSPACE && \
    mkdir -p "$NERD_FONT_DIR" && \
    cd "$NERD_FONT_DIR"

  local version=$(nerdfonts_version)
  local url

  echo "Current nerdfont version: $version"
  for font in $NERD_FONT_LIST; do
    url="$DOWNLOAD_URL/$version/$font"
    curl -SL -O "$url"
  done

  echo "Unzipping files..."
  for f in *.zip; do
    unzip "$f"
  done

  [[ -d ~/.local/share/fonts ]] || mkdir -p ~/.local/share/fonts

  echo "Copying fonts to \$HOME/.local/share/fonts"
  while IFS= read -r font; do
    cp "$font" ~/.local/share/fonts
  done <<< "$FONT_FILES"

  echo "Resetting font cache"
  fc-cache -fv
}


if [[ ! $(which jq) ]]; then
  echo "jq not found in PATH"
  exit 1
fi


if [[ $# -eq 0 ]]; then
  nerdfonts
else
  for arg in "$@"; do
    case "$arg" in
      -h|--help)
        usage
        exit 1
        ;;
      *)
        $@
        ;;
    esac
  done
fi



