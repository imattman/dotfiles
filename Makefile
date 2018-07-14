# Keep it simple for now...
all:
	# zsh
	[ -f ~/.zprofile ]        || ln -s $(PWD)/shell/zprofile.sh ~/.zprofile
	[ -f ~/.zshrc ]           || ln -s $(PWD)/shell/zshrc.sh ~/.zshrc
	[ -f ~/.zshenv ]          || ln -s $(PWD)/shell/zshenv.sh ~/.zshenv
	[ -f ~/.zsh.functions ]   || ln -s $(PWD)/shell/functions.sh ~/.zsh.functions
	[ -f ~/.zsh.aliases ]     || ln -s $(PWD)/shell/aliases.sh ~/.zsh.aliases
	[ -f ~/.zpreztorc ]       || ln -s $(PWD)/shell/zpreztorc.sh ~/.zpreztorc
	[ -d ~/.zprezto ]         || ln -s $(PWD)/prezto ~/.zprezto
	[ -f ~/.zsh.local ]       || cp $(PWD)/shell/local.sh ~/.zsh.local

	# bash
	[ -f ~/.bash_profile ]    || ln -s $(PWD)/shell/bash_profile.sh ~/.bash_profile
	[ -f ~/.bash.functions ]  || ln -s $(PWD)/shell/functions.sh ~/.bash.functions
	[ -f ~/.bashrc ]          || ln -s $(PWD)/shell/bashrc.sh ~/.bashrc
	[ -f ~/.bash.aliases ]    || ln -s $(PWD)/shell/aliases.sh ~/.bash.aliases
	[ -f ~/.bash.prompt ]     || ln -s $(PWD)/shell/bash-prompt.sh ~/.bash.prompt
	[ -f ~/.bash.local ]      || cp $(PWD)/shell/local.sh ~/.bash.local

	# emacs 
	[ -d ~/.emacs.d ]         || ln -s $(PWD)/emacs.d ~/.emacs.d
	
	# vim
	[ -f ~/.vimrc ]           || ln -s $(PWD)/vim/vimrc ~/.vimrc
	[ -d ~/.vim ]             || ln -s $(PWD)/vim ~/.vim

	# git
	[ -f ~/.gitconfig ]       || ln -s $(PWD)/git/gitconfig.symlink ~/.gitconfig

  # bin scripts
	[ -d ~/bin ]              && stow -v -t ~/bin bin

clean:
	# -L tests symbolic links
	[ -L ~/.bash_profile ]    && unlink ~/.bash_profile
	[ -L ~/.bash.functions ]  && unlink ~/.bash.functions
	[ -L ~/.bashrc ]          && unlink ~/.bashrc
	[ -L ~/.bash.aliases ]    && unlink ~/.bash.aliases
	[ -L ~/.bash.prompt ]     && unlink ~/.bash.prompt
	[ -f ~/.bash.local ]      && echo "leaving ~/.bash.local in place"

	[ -L ~/.zprofile ]        && unlink ~/.zprofile
	[ -L ~/.zshrc ]           && unlink ~/.zshrc
	[ -L ~/.zshenv ]          && unlink ~/.zshenv
	[ -L ~/.zsh.functions ]   && unlink ~/.zsh.functions
	[ -L ~/.zsh.aliases ]     && unlink ~/.zsh.aliases
	[ -L ~/.zprezto ]         && unlink ~/.zprezto
	[ -L ~/.zpreztorc ]       && unlink ~/.zpreztorc
	[ -f ~/.zsh.local ]       && echo "leaving ~/.zsh.local in place"

	[ -L ~/.emacs.d ]         && unlink ~/.emacs.d

	[ -L ~/.vimrc ]           && unlink ~/.vimrc 
	[ -L ~/.vim ]             && unlink ~/.vim 

	[ -L ~/.gitconfig ]       && unlink ~/.gitconfig

	[ -d ~/bin ]              && stow -v -D -t ~/bin bin

.PHONY: all
