# mattman .dotfiles/shell/functions.sh


simple-httpd() {
  python3 -m http.server "$@"
}


# convenience function for finding and activating python virtual environment
activate_virtualenv() {
  # use 'venv' as default directory
  local venv='venv'

  if [[ -n "$1" ]]; then
    venv="$1"
  fi

  if [ -f $venv/bin/activate ]; then . $venv/bin/activate;
  elif [ -f ../$venv/bin/activate ]; then . ../$venv/bin/activate;
  elif [ -f ../../$venv/bin/activate ]; then . ../../$venv/bin/activate;
  elif [ -f ../../../$venv/bin/activate ]; then . ../../../$venv/bin/activate;
  fi
}





