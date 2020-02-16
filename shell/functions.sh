# mattman .dotfiles/shell/functions.sh

IS_MACOS=$(uname -s | grep -i 'darwin')


simple-httpd() {
  python3 -m http.server "$@"
}


# usage: pause 'Press [Enter] key to continue...'
pause(){
  printf "$@" && read
}


# pretty-print json
json-pp() {
  jq '.' "$@"
}


# pretty-print json in clipboard and copy back
json-ppclip() {
  if [[ -n "$IS_MACOS" ]]; then
    pbpaste | jq '.' | pbcopy
  else
    # use xsel
    echo "need to set up function with 'xsel'"
  fi
}


# escape json for string usage
json-stringify() {
  jq 'tojson' "$@"
}


# unescape json from string
json-destringify() {
  jq 'fromjson' "$@"
}


# escape chars unsafe for URLs
url-encode() {
  jq '@uri' "$@"
}


# escape HTML entities
html-encode() {
  jq '@html' "$@"
}


new-bash-script() {
  local name
  name="${1:-main.sh}"

  if [[ -e "$name" ]] ; then
    echo "$name already exists"
    return 1
  fi

  printf '#!/bin/bash\n\n# fail early\nset -euo pipefail\n\n' > "$name"
  chmod 755 "$name"
  echo "$name created"
}


new-python-script() {
  local name
  name="${1:-main.py}"

  if [[ -e "$name" ]] ; then
    echo "$name already exists"
    return 1
  fi

  printf '#!/usr/bin/env python3\n\n\n' > "$name"
  chmod 755 "$name"
  echo "$name created"
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





