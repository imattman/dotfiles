#!/usr/bin/env bash
#
# Install Homebrew and some packages
#

base_dir="$(cd $(dirname $0) && pwd)"
pkg_files='homebrew-formulae-min-list.txt 
           homebrew-formulae-std-list.txt
           homebrew-formulae-extra-list.txt'

function install_pkgs {
  pkg_file="$1"

  echo "Installing packages from file $pkg_file"
  cat $pkg_file | grep -v '#' | egrep -v '^\s*$' | \
    while read pkg; do
    brew install $pkg
  done
}


# Check for Homebrew
if [[ ! "$(which brew)" ]] ; then
  echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  brew doctor
else
  echo "Homebrew already installed"
fi


if [[ -z "$1" ]] ; then
  # no arguments means install everything
  pkgs="$base_dir/$pkg_files"
else
  pkgs="$@"
fi	
  
for pkg_file in $pkgs; do
  install_pkgs $pkg_file
done


exit 0

brew doctor && \
  brew cleanup && \
  brew prune


# install 3rd party apps via casks
brew tap caskroom/versions
# note:  `brew cask search` is now simply `brew search`
#   brew search java
#   brew cask install java8

exit 0
