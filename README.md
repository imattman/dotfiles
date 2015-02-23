# mattman dotfiles

## Install
```sh
# Prezto is a dependency
# Important: skip prezto instructions for copying config files to $HOME
#            as differnt wrapper config files are symlinked later.
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

git clone https@github.com:imattman/dotfiles.git ~/.dotfiles

# run install script to configure symlinks and reference prezto
TODO: install script
```

## Credit
Much of this builds on or copies prior works including:
- [Prezto](https://github.com/sorin-ionescu/prezto) for Zsh
- Zach Holman's [dotfiles](https://github.com/holman/dotfiles)
- [Solarized](http://ethanschoonover.com/solarized) color scheme by Ethan Schoonover
- [Sunburst](https://github.com/sickill/vim-sunburst) color scheme adaptation by Marcin Kulik
- The developer friendly [Inconsolata](http://levien.com/type/myfonts/inconsolata.html) font created by [Raph Levien](http://levien.com/)

