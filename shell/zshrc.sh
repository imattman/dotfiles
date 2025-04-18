# mattman  .dotfiles/zsh/zshrc.sh

# init zprezto:zshrc
source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshrc"


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
setopt PROMPT_CR            # add \r before prompt
setopt PROMPT_SP            # preserve partial line before prompt ('%' marker)


# override tmux to show color
#[[ -n "$TMUX" ]] && export TERM="xterm-256color"
#[[ -n "$TMUX" && -z "$GIT_EDITOR" ]] && export GIT_EDITOR=vimc



# Key bindings
bindkey \^u backward-kill-line


unalias rm
unalias cp
unalias mv

# asdf config and completions
if [[ -f "$ASDF_DIR/asdf.sh" ]]; then
  source "$ASDF_DIR/asdf.sh"

  fpath=("$ASDF_DIR/completions" $fpath)
fi


[[ -f ~/.aliases.sh ]] && source ~/.aliases.sh
[[ -f ~/.functions.sh ]] && source ~/.functions.sh
#[[ -f ~/.zsh.local ]] && source ~/.zsh.local

autoload -Uz compinit && compinit

# automatically launch tmux
AUTO_TMUX="${AUTO_TMUX:-off}"

if [[ "$AUTO_TMUX" == 'on' ]] && [[ $(command -v tmux) ]] && [[ -n "$PS1" ]] && [[ -z "$TMUX" ]] && [[ ! "$TERM" =~ "tmux" ]] && [[ ! "$TERM" =~ "screen" ]]; then
  tmux && echo "pausing before exit..." && sleep 1.5 && exit
fi


