# Keep it simple for now...
all:
	# XDG_CONFIG_HOME
	[ -d ~/.config ]            && stow -v -t ~/.config config

	# zsh
	[ -f ~/.zshenv ]            || ln -s $(PWD)/shell/zshenv.sh ~/.zshenv
	[ -f ~/.zprofile ]          || ln -s $(PWD)/shell/zprofile.sh ~/.zprofile
	[ -f ~/.zshrc ]             || ln -s $(PWD)/shell/zshrc.sh ~/.zshrc
	[ -f ~/.aliases.sh ]        || ln -s $(PWD)/shell/aliases.sh ~/.aliases.sh
	[ -f ~/.functions.sh ]      || ln -s $(PWD)/shell/functions.sh ~/.functions.sh
	[ -f ~/.zpreztorc ]         || ln -s $(PWD)/shell/zpreztorc.sh ~/.zpreztorc
	[ -f ~/.zsh.local ]         || cp $(PWD)/shell/local.sh ~/.zsh.local

	# bash
	[ -f ~/.bash_profile ]      || ln -s $(PWD)/shell/bash_profile.sh ~/.bash_profile
	[ -f ~/.bashrc ]            || ln -s $(PWD)/shell/bashrc.sh ~/.bashrc
	[ -f ~/.bash.prompt ]       || ln -s $(PWD)/shell/bash-prompt.sh ~/.bash.prompt
	[ -f ~/.bash.local ]        || cp $(PWD)/shell/local.sh ~/.bash.local

	# emacs 
	[ -d ~/.emacs.d ]           || ln -s $(PWD)/emacs.d ~/.emacs.d
	
	# vim
	[ -f ~/.vimrc ]             || ln -s $(PWD)/vim/vimrc ~/.vimrc
	[ -d ~/.vim ]               || ln -s $(PWD)/vim ~/.vim

	# git
	[ -f ~/.gitconfig ]         || ln -s $(PWD)/git/gitconfig ~/.gitconfig
	[ -f ~/.gitignore_global ]  || ln -s $(PWD)/git/gitignore ~/.gitignore_global

	# tmux
	[ -f ~/.tmux.conf ]         || ln -s $(PWD)/tmux/tmux.conf ~/.tmux.conf

  # bin scripts
	[ -d ~/bin ]                && stow -v -t ~/bin bin

clean:
	# -L tests symbolic links
	[ -d ~/.config ]            && stow -v -D -t ~/.config config

	[ -L ~/.zprofile ]          && unlink ~/.zprofile
	[ -L ~/.zshrc ]             && unlink ~/.zshrc
	[ -L ~/.zshenv ]            && unlink ~/.zshenv
	[ -L ~/.aliases.sh ]        && unlink ~/.aliases.sh
	[ -L ~/.functions.sh ]      && unlink ~/.functions.sh
	[ -L ~/.zprezto ]           && unlink ~/.zprezto
	[ -L ~/.zpreztorc ]         && unlink ~/.zpreztorc
	[ -f ~/.zsh.local ]         && echo "leaving ~/.zsh.local in place"

	[ -L ~/.bash_profile ]      && unlink ~/.bash_profile
	[ -L ~/.bashrc ]            && unlink ~/.bashrc
	[ -L ~/.bash.prompt ]       && unlink ~/.bash.prompt
	[ -f ~/.bash.local ]        && echo "leaving ~/.bash.local in place"

	[ -L ~/.emacs.d ]           && unlink ~/.emacs.d

	[ -L ~/.vimrc ]             && unlink ~/.vimrc 
	[ -L ~/.vim ]               && unlink ~/.vim 

	[ -L ~/.gitconfig ]         && unlink ~/.gitconfig
	[ -L ~/.gitignore_global ]  && unlink ~/.gitignore_global

	[ -L ~/.tmux.conf ]         && unlink ~/.tmux.conf

	[ -d ~/bin ]                && stow -v -D -t ~/bin bin

.PHONY: all
