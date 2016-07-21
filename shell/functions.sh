# mattman  .dotfiles/shell/functions.sh


function source_file() {
  #echo -n "sourcing file $1 " ; if [[ -s "$1" ]] ; then echo "YES"; else echo "NO"; fi
  if [[ -s "$1" ]] ; then
    source "$1"
  fi
}

