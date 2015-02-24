# mattman dotfiles

## Install
```sh
# configure Zsh as default shell
chsh -s $(which zsh)

# recursive clone to get submodules
git clone --recursive https://github.com/imattman/dotfiles.git ~/.dotfiles

# run install script to configure symlinks and reference prezto
cd .dotfiles
```

## Note
Prezto is a dependency.  
Skip prezto instructions for copying config files to $HOME this is handled differently by using symlinked wrapper files

## Credit
Much of this builds on or copies prior works including:
- [Prezto](https://github.com/sorin-ionescu/prezto) for Zsh
- [Dotbot](https://github.com/anishathalye/dotbot) bootstrap tool
- Zach Holman's [dotfiles](https://github.com/holman/dotfiles)
- [Solarized](http://ethanschoonover.com/solarized) color scheme by Ethan Schoonover
- [Sunburst](https://github.com/sickill/vim-sunburst) color scheme adaptation by Marcin Kulik
- [Inconsolata](http://levien.com/type/myfonts/inconsolata.html) font created by [Raph Levien](http://levien.com/)

