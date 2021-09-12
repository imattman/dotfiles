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

CASKS=""

PACKAGES="
tmux
git
stow
golang
python3
macvim
neovim
tree
watch
zsh-completions
"

for cask in $CASKS; do
  brew tap $cask
done

for pkg in $PACKAGES; do
  brew install $pkg
done

