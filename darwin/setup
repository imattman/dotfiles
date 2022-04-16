#!/bin/bash

# fail early
set -eou pipefail


if [[ -z "$(xcode-select -p)" ]]; then
  echo "Command line tools not found"
  sudo xcode-select --install && \
    exit 1
fi

if [[ ! "$(command -v brew)" ]]; then
  if [[ -d /opt/homebrew/bin ]]; then
    echo "Adding /opt/homebrew paths to PATH"
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
  fi

  if [[ ! "$(command -v brew)" ]]; then
    echo "Homebrew not found"
    open "https://brew.sh"
    exit 1
  fi
fi

CASKS=""

PACKAGES="
coreutils
zsh-completions
git
jq
stow
tmux
asdf
golang
python3
macvim
neovim
tree
watch
"

for cask in $CASKS; do
  brew tap $cask
done

for pkg in $PACKAGES; do
  brew install $pkg
done

