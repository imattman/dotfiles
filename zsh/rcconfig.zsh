# mattman  .dotfiles/zsh/rcconfig.zsh
#
# configures paths, etc. for use in other rc files
#
#
# [[ -s ${ZDOTDIR:-$HOME}/.dotfiles/zsh/rcconfig.zsh ]] && source ${ZDOTDIR:-$HOME}/.dotfiles/zsh/rcconfig.zsh


zshdots_dir=${ZDOTDIR:-$HOME}/.dotfiles/zsh
localrc_dir=${LOCALRCDIR:-$HOME/.localrc}

rc_dirs=($zshdots_dir $localrc_dir)


function source_file() {
  #echo -n "sourcing file $1 " ; if [[ -s "$1" ]] ; then echo "YES"; else echo "NO"; fi

  if [[ -s "$1" ]] ; then
    source "$1"
  fi
}

