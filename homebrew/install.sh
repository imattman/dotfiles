#!/usr/bin/env bash
#
# Install Homebrew and some packages
#

pkg_file='brew-formulae-list.txt'
pkg_file=$(dirname $0)/$pkg_file

# Check for Homebrew
if [[ ! "$(which brew)" ]] ; then
  echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  brew doctor
else
  echo "Homebrew already installed"
fi


# some packages I like installed
echo Installing packages from $pkg_file
cat $pkg_file | \
while read pkg; do
  brew install $pkg
done

exit 0
