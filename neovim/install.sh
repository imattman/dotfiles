#!/usr/bin/env bash
#
# Install astronvim and bootstrap
#

# fail early
set -eou pipefail

if [[ -n "${DEBUG:=}" ]]; then
  set -x
fi

THIS_SCRIPT="${0##*/}"
BASE_DIR="$(cd "${0%/*}" && pwd)"

CONFIG="$HOME/.config/nvim"
CONFIG_OLD="${CONFIG}.$(date '+%Y-%m-%d')"


usage() {
  cat <<-EOU
	Usage: $THIS_SCRIPT [OPTIONS] <COMMAND>
	
	Setup script for neovim + AstroNvim
	
	COMMANDS
	  all              Run all steps

	  backup           Backup existing nvim config
	  check_astro_cfg  Verify AstroNvim config found under ~/.config
	  clone_astro      Clone AstroNvim to ~/.config/nvim
	  purge            Purge old nvim cache files
	  setup            Run initial setup with PackerSync
	
	OPTIONS
	  -h      Show this message

EOU
}

backup() {
  if [[ -d $CONFIG ]] ; then
    echo "Moving existing nvim config to $CONFIG_OLD"
    mv "$CONFIG" "$CONFIG_OLD"
  fi
}

check_astro_cfg() {
  if [[ ! -d $HOME/.config/astronvim ]]; then
    echo "Warning: astronvim config not found under $HOME/.config/astronvim"
    exit 1
  fi
}

clone_astro() {
  echo "Cloning AstroNvim config..."
  git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
}


purge() {
  echo "Purging old nvim cache..."

  for dir in "$HOME/.local/share/nvim" "$HOME/.config/nvim/plugin"; do
    if [[ -d "$dir" ]]; then
      echo "Removing $dir"
      rm -rf "$dir"
    fi
  done
}

setup() {
  echo "Initializing nvim config with PackerSync"
  # nvim +PackerSync
  nvim  --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

}

all() {
  backup
  check_astro_cfg
  clone_astro
  purge
  setup
}



for cmd in "$@"
do
  case $cmd in
    -h|help)
        usage
        exit 0
        ;;
    *)
      "$cmd"
      ;;
  esac
done

if [[ $# -eq 0 ]]; then
  all
fi


