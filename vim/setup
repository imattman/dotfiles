#!/usr/bin/env bash
#
# Install vim boostrap plugin(s)
#


if [[ ! -d ~/.vim ]] ; then
  echo "~/.vim directory not found"
  exit 1
fi

if [[ -e ~/.vim/autoload/plug.vim ]] ; then
  echo "~/.vim/autoload/plug.vim already exists... skipping installation."
  exit 1
fi

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Starting VIM with command :PlugInstall"
#vim -u ./vimrc-min -c PlugInstall
vim -c "colorscheme slate" -c PlugInstall

exit 0

