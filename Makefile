# Keep it simple for now...
all:
	# zsh

	# bash
	[ -f ~/.bash_profile ]    || ln -s $(PWD)/shell/bash_profile.sh ~/.bash_profile
	[ -f ~/.bash.functions ]  || ln -s $(PWD)/shell/functions.sh ~/.bash.functions
	[ -f ~/.bashrc ]          || ln -s $(PWD)/shell/bashrc.sh ~/.bashrc
	[ -f ~/.bash.aliases ]    || ln -s $(PWD)/shell/aliases.sh ~/.bash.aliases
	[ -f ~/.bash.prompt ]     || ln -s $(PWD)/shell/bash-prompt.sh ~/.bash.prompt
	[ -f ~/.bash.local ]      || cp $(PWD)/shell/bash-local.sh ~/.bash.local

	# emacs 
	[ -d ~/.emacs.d ]         || ln -s $(PWD)/emacs.d ~/.emacs.d
	
	# vim
	[ -f ~/.vimrc ]           || ln -s $(PWD)/vim/vimrc.symlink ~/.vimrc
	[ -d ~/.vim ]             || ln -s $(PWD)/vim ~/.vim

clean:
	# -L tests symbolic links
	[ -L ~/.bash_profile ] && unlink ~/.bash_profile
	[ -L ~/.bash.functions ] && unlink ~/.bash.functions
	[ -L ~/.bashrc ] && unlink ~/.bashrc
	[ -L ~/.bash.aliases ] && unlink ~/.bash.aliases
	[ -L ~/.bash.prompt ] && unlink ~/.bash.prompt

	[ -f ~/.bash.local ] && echo "leaving ~/.bash.local in place"

	[ -L ~/.emacs.d ] && unlink ~/.emacs.d

	[ -L ~/.vimrc ] && unlink ~/.vimrc 
	[ -L ~/.vim ] && unlink ~/.vim 

.PHONY: all
