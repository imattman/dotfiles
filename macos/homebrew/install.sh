#!/usr/bin/env bash
#
# Install Homebrew and some packages
#

# fail early
set -euo pipefail
#IFS=$'\n\t'

DEBUG=${DEBUG:-}
if [[ -n "$DEBUG" ]]; then
  set -x
fi

base_dir="$(cd $(dirname $0) && pwd)"
pkg_files='homebrew-formulae-min-list.txt 
           homebrew-formulae-std-list.txt
           homebrew-formulae-extra-list.txt'
install_pkg="${1:-}"


install_pkgs() {
  local pkg_file="$1"

  echo
  echo "Installing packages from file $pkg_file"
  sed -e 's/\s*#.*//' -e '/^$/d' < "$pkg_file" | \
  while read pkg; do
    if [[ ! $(brew list | grep $pkg) ]] ; then
      echo "Installing: $pkg"
      brew install $pkg
    else
      echo "# $pkg already installed"
    fi
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


if [[ -z "$install_pkg" ]] ; then
  # no arguments means install everything
  pkgs=""
  for pkg in $pkg_files; do
    pkgs="$pkgs $base_dir/$pkg"
  done
else
  pkgs="$*"
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

