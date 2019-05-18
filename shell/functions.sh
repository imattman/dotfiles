# mattman .dotfiles/shell/functions.sh


simple-httpd() {
  python3 -m http.server "$@"
}

# usage: pause 'Press [Enter] key to continue...'
pause(){
  printf "$*" && read
}


# convenience function for finding and activating python virtual environment
activate_virtualenv() {
  # use 'venv' as default directory
  local venv=${1:-venv}

  if [ -f $venv/bin/activate ]; then . $venv/bin/activate;
  elif [ -f ../$venv/bin/activate ]; then . ../$venv/bin/activate;
  elif [ -f ../../$venv/bin/activate ]; then . ../../$venv/bin/activate;
  elif [ -f ../../../$venv/bin/activate ]; then . ../../../$venv/bin/activate;
  fi
}





