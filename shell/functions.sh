#!/bin/bash
# mattman .dotfiles/shell/functions.sh

PLATFORM="$(uname -s | tr '[:upper:]' '[:lower:]')"

if [[ $PLATFORM == 'darwin' ]]; then
  XCLIP='pbcopy'
  DATE_CMD='gdate'
else
  XCLIP='xclip'
  DATE_CMD='date'
fi


function set-xterm-color() {
  export TERM=xterm-256color
}

function datestamp() {
  local format='+%Y-%m-%d'

  if [[ -n "$1" ]]; then
    $DATE_CMD -d "$1" "$format"
  else
    $DATE_CMD "$format"
  fi
}

function timestamp() {
  local format='+%Y-%m-%d-%H%M%S'

  if [[ -n "$1" ]]; then
    $DATE_CMD -d "$1" "$format"
  else
    $DATE_CMD "$format"
  fi
}

function timestamp_utc() {
  local format='+%Y-%m-%d-%H%M%S'

  if [[ -n "$1" ]]; then
    $DATE_CMD -u -d "$1" "$format"
  else
    $DATE_CMD -u "$format"
  fi
}

function timestamp_isosec() {
  local format='+%Y%m%d%H%M%S'

  if [[ -n "$1" ]]; then
    $DATE_CMD -d "$1" "$format"
  else
    $DATE_CMD "$format"
  fi
}

cd_fzf() {
  local root="${1:-$PWD}"
  local depth="${2:-4}"

  if [[ "$root" == '.' ]]; then
    root="$PWD"
  fi

  #local parent=$(dirname "$root")
  #local base=$(basename "$root")
  local dir
  if [[ $(command -v fd) ]]; then
    dir=$(cd "$root" && fd -t d -d $depth -E "*/pkg/mod/*" . | fzf)
  else
    #dir=$(cd "$root" && find . -type d -maxdepth $depth | fzf)
    dir=$(cd "$root" && find . -maxdepth $depth -type d | fzf)
  fi

  [[ -n "$dir" ]] && cd "$root/$dir"
}

edit_fzf() {
  local editor="${1:-$EDITOR}"
  local root="${2:-$PWD}"
  if [[ "$root" == '.' ]]; then
    root="$PWD"
  fi

  local fname
  if [[ $(command -v fd) ]]; then
    fname=$(cd "$root" && fd -t f -E "*/pkg/mod/*" . | fzf --preview 'cat {}' --border )
  else
    fname=$(cd "$root" && find . -type f -name "*.md" | fzf --preview 'cat {}' --border )
  fi

  if [[ -n "$fname" ]] ; then
    #echo "$editor $root/$fname"
    [[ -e "$root/$fname" ]] && $editor "$root/$fname"
  fi
}

repos_config_env() {
  local cfg="${1:-list}"

  local repo_cfg_dir="${REPOS_CONF_DIR:-$WORKSPACE/tools/repo-tools}"
  local -a options=("all" "std" "min" "server" "clear")

  case "$cfg" in
    ls|list|-h|-l)
      for cf in "${options[@]}"; do
        echo "$cf"
      done
      ;;
    all)
      export REPOS_CONFIG="$repo_cfg_dir/repos-all.cfg"
      ;;
    std)
      export REPOS_CONFIG="$repo_cfg_dir/repos-std.cfg"
      ;;
    min)
      export REPOS_CONFIG="$repo_cfg_dir/repos-min.cfg"
      ;;
    server)
      export REPOS_CONFIG="$repo_cfg_dir/repos-server.cfg"
      ;;
    clear|none|-c)
      unset REPOS_CONFIG
      echo "\$REPOS_CONFIG cleared"
      ;;
    *)
      echo "Unknown option '$cfg'"
      ;;
  esac

  if [[ -n "$REPOS_CONFIG" ]]; then
    echo "\$REPOS_CONFIG $REPOS_CONFIG"
  fi
}

jn() {
  # look for 'jn' in PATH (ignores this function)
  local jnpath=$(whence -p jn)
  if [[ -n "$jnpath" ]]; then
    "$jnpath" "$@"
  elif [[ $(whence -p jn.sh) ]]; then
    jn.sh "$@"
  fi
}

jn_branch() {
  cd "$NOTES_JOURNAL" || return 1
  local day="${1:-today}"
  local date="$(datestamp "$day")"

  local branch="$(git rev-parse --abbrev-ref HEAD)"
  if [[ $branch != "main" && $branch != "master" ]]; then
    echo "WARNING: repo is currently on branch $branch"
  fi

  git checkout -b "entry-${date}"
  #jn.sh "$date"
}

jn_fzf_search() {
  local subdir="${1:-}"
  local root
  local fname

  if [[ "$subdir" == "." ]]; then
    root="$PWD"
  else
    root="$NOTES_JOURNAL/daily/$subdir"
  fi

  cd "$root" || return 1

  RG_PREFIX="rg --column --line-number --no-heading --color=always --sort=path --smart-case "
  #RG_PREFIX="rg -l --no-heading --color=always --smart-case "
  INITIAL_QUERY=""
  fname=$(FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'" fzf \
    --bind "change:reload:$RG_PREFIX {q} || true" \
    --ansi --phony --query "$INITIAL_QUERY" \
    --delimiter=: --layout=reverse \
    --preview 'nl {1}' --border  --color 'bg:#222222,preview-bg:#333333')

  [[ -z "$fname" ]] && return 1

  fname="$(echo $fname | cut -d: -f 1)"
  #echo "\$fname is $fname"
  [[ -e "$root/$fname" ]] && jn $(basename $fname .md)
}

jn_fzf_list() {
  local subdir="${1:-}"
  local root

  if [[ "$subdir" == "." ]]; then
    root="$PWD"
  else
    root="$NOTES_JOURNAL/daily/$subdir"
  fi

  local fname
  if [[ $(command -v fd) ]]; then
    fname=$(cd "$root" && fd -t f . | fzf --layout=reverse \
      --preview 'cat {}' --border \
      --color 'bg:#222222,preview-bg:#333333')
  else
    fname=$(cd "$root" && find . -type f -name "*.md" | fzf --layout=reverse \
      --preview 'cat {}' --border \
      --color 'bg:#222222,preview-bg:#333333')
  fi

  if [[ -n "$fname" ]] ; then
    #echo "$editor $root/$fname"
    #[[ -e "$root/$fname" ]] && $EDITOR "$root/$fname"
    [[ -e "$root/$fname" ]] && jn $(basename $fname .md)
  fi
}


cd_repos() {
  dir=$(repos ls -d | fzf)

  [[ -n "$dir" ]] && cd "$root/$dir"
}

cd_workspace() {
  cd_fzf "$WORKSPACE" "$@"
}

cd_notes() {
  cd_fzf "$NOTES" "$@"
}

cd_journal() {
  cd_fzf "$NOTES_JOURNAL" "$@"
}

cd_documents() {
  cd_fzf "$DOCUMENTS" "$@"
}

pathadd() {
  local dir="${1:-$PWD}"
  export PATH="$PATH:$dir"
}

numfmt() {
  local numfmt_bin=$(whence -p numfmt)
  # use gnu 'numfmt' if available
  if [[ -n "$numfmt_bin" ]]; then
    "$numfmt_bin" --grouping "$@"
  else
    echo "$*" | python3 -c "print('\n'.join('{:,}'.format(int(n)) for n in input().strip().split()))"
  fi
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


update_linux() {
  # Ubuntu / Debian
  if [[ $(command -v apt) ]]; then
    local upgrade='upgrade'
    for arg in "$@"; do
      case "$arg" in
        full|system|all)
            upgrade='full-upgrade'
            echo "Performing full upgrade."
            ;;
      esac
    done

    echo "Updating apt packages..."
    sudo apt update && \
      sudo apt "$upgrade" -y

    echo "Removing old packages..."
    sudo apt autoremove -y

    if [[ -f /var/run/reboot-required ]]; then
      printf "\n*** Reboot is required ***\n\n"
      ls -l /var/run/reboot*
    fi

  # Arch
  elif [[ $(command -v pacman) ]]; then
    echo "Updating pacman packages..."
    sudo pacman -Syyu

    echo "Removing unused packages..."
    sudo pacman -Qdtq | sudo pacman -Rs -

  # Fedora
  elif [[ $(command -v dnf) ]]; then
    echo "Updating dnf packages..."
    sudo dnf -y upgrade

    echo "Removing unused packages..."
    sudo dnf -y autoremove

    if [[ $(which needs-restarting) ]]; then
      # check if reboot is needed
      sudo needs-restarting -r
    else
      echo "Did not find 'needs-restarting' script"
      echo "To install run: 'dnf install dnf-utils'"
    fi
  fi


  if [[ $(command -v flatpak) ]]; then
    echo
    echo "Updating flatpak..."
    flatpak update -y
  fi
}

update_macos() {
  brew update && \
    brew upgrade && \
    brew cleanup && \
    brew doctor
}

update_system() {
  case "$PLATFORM" in
    darwin) update_macos blah "$@"
            ;;
    linux)  update_linux "$@"
            ;;
    *)  echo "Unknown platform '$PLATFORM'"
        return 1
    esac
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


# view docker log for container registered under a name
docker_log_name() {
  local name="${1:-}"
  if [[ -z "$name" ]]; then
    return 1
  fi

  docker logs "$(docker ps -q -f name=$name)"
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

check_cpu_virtualization_enabled() {
  if [[ "$PLATFORM" != "linux" ]]; then
    echo "check only supported on Linux"
    return 1
  fi

  # VMX is the Intel flag
  # SVM is the AMD flag
  if [[ $(grep -c -E "(vmx|svm)" /proc/cpuinfo) -gt 0 ]]; then
    echo "YES"
  else
    echo "NO"
  fi
}


# colorize output of 'go test'
# shamelessly stolen from Jon Calhoun
go_test() {
  go test $* | sed ''/PASS/s//$(printf "\033[32mPASS\033[0m")/'' | sed ''/SKIP/s//$(printf "\033[34mSKIP\033[0m")/'' | sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/'' | sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/'' | GREP_COLOR="01;33" egrep --color=always '\s*[a-zA-Z0-9\-_.]+[:][0-9]+[:]|^'
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
