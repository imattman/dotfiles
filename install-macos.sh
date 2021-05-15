#!/bin/sh

# fail early
set -eou pipefail


if [ ! "$(git --version)" ]; then
  echo "Command line tools not found"
  exit 1
fi

if [ ! "$(command -v brew)" ]; then
  echo "Homebrew not found"
  open "https://brew.sh"
  exit 1
fi

CASKS="homebrew/cask-fonts"
PACKAGES="
git
stow
golang
python3
macvim
tree
watch
zsh-completions
"

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

for pkg in $PACKAGES; do
  brew install $pkg
done

for font in $FONTS; do
  brew install --cask $font
done



