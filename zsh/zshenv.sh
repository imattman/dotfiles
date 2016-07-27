# mattman  .dotfiles/zsh/zshenv.sh

if [ -f ~/.zsh.functions ] ; then
  ~/.zsh.functions
else
  function source_file() {
    #echo -n "sourcing file $1 " ; if [[ -s "$1" ]] ; then echo "YES"; else echo "NO"; fi
    if [[ -s "$1" ]] ; then
      source "$1"
    fi
  }

fi

# init zprezto:zshenv
zprezto_file=${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshenv
source_file "$zprezto_file"


