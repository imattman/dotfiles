#!/bin/sh

# fail early
set -eou pipefail


if [ -z "$(xcode-select -p)" ]; then
  echo "Command line tools not found"
  sudo xcode-select --install
fi

if [ ! "$(command -v brew)" ]; then
  echo "Homebrew not found"
  open "https://brew.sh"
  exit 1
fi

CASKS="homebrew/cask-fonts"

FONTS="
font-fira-code-nerd-font
font-go-mono-nerd-font
font-hack-nerd-font
font-inconsolata-nerd-font
font-meslo-lg-nerd-font
font-ubuntu-mono-nerd-font
font-ubuntu-nerd-font
"

for cask in $CASKS; do
  brew tap $cask
done

for font in $FONTS; do
  brew install --cask $font
done

