# mattman  .dotfiles/zsh/zshrc.sh

# init zprezto:zshrc
zprezto_file=${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshrc
source "$zprezto_file"


# for more details: `man zshoptions`
unsetopt SHARE_HISTORY       # don't share history across shells
                             # equiv: setopt no_share_history

#setopt AUTO_CD              # Auto changes to a directory without typing cd.
#setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
#setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
#setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
#setopt PUSHD_TO_HOME        # Push to home directory when no argument is given.
#setopt CDABLE_VARS          # Change directory to a path stored in a variable.
#setopt AUTO_NAME_DIRS       # Auto add variable-stored paths to ~ list.
#setopt MULTIOS              # Write to multiple descriptors.
#setopt EXTENDED_GLOB        # Use extended globbing syntax.
setopt CLOBBER              # Unset then Use >! and >>! to bypass.


# Key bindings
bindkey \^u backward-kill-line


unalias rm
unalias cp
unalias mv

[[ -f ~/.zsh.aliases ]] && source ~/.zsh.aliases
[[ -f ~/.zsh.local ]] && source ~/.zsh.local

