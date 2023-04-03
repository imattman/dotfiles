#!/usr/bin/env bash

# fail early
set -eou pipefail

if [[ -n "${DEBUG:=}" ]]; then
  set -x
fi

THIS_SCRIPT="${0##*/}"
BASE_DIR="$(cd "${0%/*}" && pwd)"

TAGS_URL='https://api.github.com/repos/ryanoasis/nerd-fonts/tags'
DOWNLOAD_URL='https://github.com/ryanoasis/nerd-fonts/releases/download'
NERD_FONT_DIR="$XDG_LOCAL_HOME/nerdfonts"
FONTS_DEST="$XDG_DATA_HOME/fonts"

# TODO: use array
NERD_FONT_LIST="FiraMono.zip  Hack.zip	Inconsolata.zip  JetBrainsMono.zip"
FONT_FILES='Fira Mono Regular Nerd Font Complete Mono.otf
Hack Regular Nerd Font Complete Mono.ttf
Inconsolata Regular Nerd Font Complete Mono.otf
JetBrains Mono Regular Nerd Font Complete Mono.ttf'



usage() {
  cat <<-EOU
	Usage: $THIS_SCRIPT [SUBCOMMAND]
	
	Install fonts on a debian/ubuntu linux system.
	
	SUBCOMMANDS
	 
	  nerdfonts Downloads and installs select Nerdfonts 
	            for user (default)
	  fonts     Installs non-nerdfonts via apt
	  msfonts   Installs MS fonts with license prompt
	  remove    Removes standard fonts

EOU
}

precheck() {
  if [[ -z "$XDG_DATA_HOME" ]]; then
    echo '$XDG_DATA_HOME not set'
    exit 1
  fi

  if [[ ! $(which jq) ]]; then
    echo "jq not found in PATH"
    exit 1
  fi
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
  cd "${NERD_FONT_DIR%/*}" && \
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

  echo "Copying fonts to $FONTS_DEST ..."
  [[ -d "$FONTS_DEST" ]] || mkdir -p "$FONTS_DEST"

  while IFS= read -r font; do
    cp "$font" "$FONTS_DEST"
  done <<< "$FONT_FILES"

  echo "Resetting font cache"
  fc-cache -fv
}


if [[ $# -eq 0 ]]; then
  precheck
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



