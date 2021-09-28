# Matt's dotfiles

## Install

```bash
# configure zsh as default shell
chsh -s $(which zsh)

# clone this git repo
git clone git@github.com:imattman/dotfiles.git ~/.dotfiles

# run install script to configure symlinks and reference prezto
cd .dotfiles
./install.sh
```

## Note

Prezto is a dependency.  Skip prezto instructions for copying config files to
`$HOME`. This is handled differently by using symlinked wrapper files.


