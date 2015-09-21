#!/usr/bin/env bash
#
# Install Homebrew and some packages
#

# Check for Homebrew
if [[ ! "$(which brew)" ]] ; then
  echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  brew doctor
else
  echo "Homebrew already installed"
fi


# some packages I like installed
# TODO: move this list to a separate file?
brew install \
  bison \
  cowsay \
  figlet \
  elixir \
  fortune \
  gradle \
  jq \
  lorem \
  macvim \
  maven \
  nvm \
  openssl \
  rbenv \
  tmux \
  tree \
  watch \


exit 0
