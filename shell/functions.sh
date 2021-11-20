#!/bin/bash
# mattman .dotfiles/shell/functions.sh

PLATFORM="$(uname -s | tr '[:upper:]' '[:lower:]')"

if [[ $PLATFORM == 'darwin' ]]; then
  XCLIP='pbcopy'
else
  XCLIP='xclip'
fi

cd_fzf() {
  local root="${1:-$PWD}"
  local depth="${2:-99}"

  if [[ "$root" == '.' ]]; then
    root="$PWD"
  fi

  #local parent=$(dirname "$root")
  #local base=$(basename "$root")
  local dir=$(cd "$root" && fd -t d -d $depth -E "*/pkg/mod/*" . | fzf)

  [[ -n "$dir" ]] && cd "$root/$dir"
}

edit_fzf() {
  local editor="${1:-$EDITOR}"
  local root="${2:-$PWD}"
  if [[ "$root" == '.' ]]; then
    root="$PWD"
  fi

  local file=$(cd "$root" && fd -t f -E "*/pkg/mod/*" . | fzf)

  if [[ -n "$file" ]] ; then
    #echo "$editor $root/$file" 
    [[ -e "$root/$file" ]] && $editor "$root/$file"
  fi
}


cd_workspace() {
  cd_fzf "$WORKSPACE" "$@"
}

cd_notes() {
  cd_fzf "$NOTES" "$@"
}

cd_documents() {
  cd_fzf "$DOCUMENTS" "$@"
}

cd_dropbox() {
  cd_fzf "$DROPBOX" "$@"
}


numfmt() {
  echo "$*" | python3 -c "print('\n'.join('{:,}'.format(int(n)) for n in input().strip().split()))"
}


# usage: pause 'Press [Enter] key to continue...'
pause(){
  printf "$@" && read
}


# pretty-print json
json_pp() {
  jq '.' "$@"
}


# pretty-print json in clipboard and copy back
json_ppclip() {
  if [[ -n "$IS_MACOS" ]]; then
    pbpaste | jq '.' | pbcopy
  else
    # use xsel
    echo "need to set up function with 'xsel'"
  fi
}


# escape json for string usage
json_stringify() {
  jq 'tojson' "$@"
}


# unescape json from string
json_destringify() {
  jq 'fromjson' "$@"
}


# escape chars unsafe for URLs
url_encode() {
  jq '@uri' "$@"
}


# escape HTML entities
html_encode() {
  jq '@html' "$@"
}


new_bash_script() {
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


new_python_script() {
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

py_simple_httpd() {
  local port
  if [[ -n "$1" ]]; then
    port="$1"
    shift
  else
    echo "Defaulting to port 8000.  Specify port as first argument to override."
    echo
    port="8000"
  fi

  python3 -m http.server "$port" "$@"
}

# convenience function for finding and activating python virtual environment
py_activate_virtualenv() {
  # use 'venv' as default directory
  local venv=${1:-venv}

  if [ -f $venv/bin/activate ]; then . $venv/bin/activate;
  elif [ -f ../$venv/bin/activate ]; then . ../$venv/bin/activate;
  elif [ -f ../../$venv/bin/activate ]; then . ../../$venv/bin/activate;
  elif [ -f ../../../$venv/bin/activate ]; then . ../../../$venv/bin/activate;
  fi

  [[ -n "$ZSH_NAME" ]] && rehash
}


look_busy() {
  if [[ -n "$(command -v genact)" ]] ; then
    genact
  else
    echo "install 'genact'"
  fi
}



alias gitlog-no-graph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"
#_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % '"

# git_co_preview - checkout git commit with previews
git_co_preview() {
  local commit
  commit=$( gitlog-no-graph |
    fzf --no-sort --reverse --tiebreak=index --no-multi \
        --ansi --preview="$_viewGitLogLine" ) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# git_preview - git commit browser with previews
git_preview() {
    gitlog-no-graph |
        fzf --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview="$_viewGitLogLine" \
            --exit-0 \
                --header "enter to view, ctrl-y to copy hash, esc to cancel" \
                --bind "enter:execute:$_viewGitLogLine   | less -R" \
                --bind "ctrl-y:execute:$_gitLogLineToHash | $XCLIP" \
                --bind "esc:cancel"
}


# fishies!
ascii_fish() {
  if [[ $(command -v asciiquarium) ]]; then
    asciiquarium
    return
  fi

  if [[ $(command -v docker) ]]; then
    name="fishies-$(date +%s)"
    docker run -it --rm --name "$name" danielkraic/asciiquarium
    return
  fi

  echo "asciiquarium not found"
}


# Displays color gradient, useful for confirming TERM color settings
terminal_gradient() {
  awk 'BEGIN{
    s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
    for (colnum = 0; colnum<77; colnum++) {
        r = 255-(colnum*255/76);
        g = (colnum*510/76);
        b = (colnum*255/76);
        if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", r,g,b;
        printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
        printf "%s\033[0m", substr(s,colnum+1,1);
    }
    printf "\n";
  }'
}
