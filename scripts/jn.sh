#!/usr/bin/env bash

# fail early
set -euo pipefail

if [[ -n "${DEBUG:=}" ]]; then
  set -x
fi

JOURNAL_BASE="${NOTES_JOURNAL:-$HOME/Notes/journal}"
JOURNAL_DIR="$JOURNAL_BASE/daily"
TEMPLATES_DIR="$JOURNAL_BASE/templates"
TEMPLATE_FILE="$TEMPLATES_DIR/daily.md"
CONFIG_FILE="$XDG_CONFIG_HOME/jn-tools/jn.env"
CONFIG_FILE_DEFAULT="$JOURNAL_BASE/config/jn.env"

# diet values initialized in precheck function after loading config
DIET=''
DIET_MODULO=''
DIET_MODULO_OFFSET=''
DIET_DEFAULT='keto'
DIET_FAST='fasting'

DATE_CMD="date"
UUID_CMD="uuid"
JN_EDITOR=${VISUAL:-${EDITOR:-}}
EDITOR_OPTS=('-c /pounds' '-c nohl' '-c normal $')

usage() {
  local THIS_SCRIPT="${0##*/}"

  cat<<EOU
Usage: $THIS_SCRIPT [OPTIONS] <date-1> [<date-2>...]

A utility for creating and editing personal journal files.

Dates can be supplied in formats recoginzed by the gnu 'date'
command.  Defaults to 'today' if no date argument is supplied.

Examples:

  # open a journal entry for today
  $THIS_SCRIPT

  # open journal entries for several days
  $THIS_SCRIPT 2020-09-01 yesterday today

  # list journal file path from 5 days ago
  $THIS_SCRIPT -l "5 days ago"


OPTIONS:
   -h:  Show this message
   -l:  List derived journal file paths without opening editor
   -p:  Prepare header of journal files.  Can be used without edit.
   -t:  Supply template argument.  A basic match is performed looking
        for templates that optionally can include "daily-" prefix 
        and ".md" suffix

EOU
}

precheck() {
  if [[ -r "$CONFIG_FILE" ]]; then
    source "$CONFIG_FILE"
  elif [[ -r "$CONFIG_FILE_DEFAULT" ]]; then
    source "$CONFIG_FILE_DEFAULT"
  fi

  DIET="${JN_DIET:-}"
  DIET_DEFAULT="${JN_DIET_DEFAULT:-$DIET_DEFAULT}"
  DIET_FAST="${JN_DIET_FAST:-$DIET_FAST}"
  DIET_MODULO="${JN_DIET_MODULO:-}"
  DIET_MODULO_OFFSET="${JN_DIET_MODULO_OFFSET:-0}"

  DIET_MON="${JN_DIET_MON:-$DIET_DEFAULT}"
  DIET_TUE="${JN_DIET_TUE:-$DIET_DEFAULT}"
  DIET_WED="${JN_DIET_WED:-$DIET_DEFAULT}"
  DIET_THU="${JN_DIET_THU:-$DIET_DEFAULT}"
  DIET_FRI="${JN_DIET_FRI:-$DIET_DEFAULT}"
  DIET_SAT="${JN_DIET_SAT:-$DIET_DEFAULT}"
  DIET_SUN="${JN_DIET_SUN:-$DIET_DEFAULT}"

  if [[ $(uname -s | grep -i darwin) ]]; then
    DATE_CMD=gdate

    if [[ ! $(command -v gdate) ]]; then
      echo "'gdate' not found. Install gnu coreutils"
      echo "  brew install coreutils"
      exit 1
    fi
  fi

  if [[ ! -d "$JOURNAL_DIR" ]]; then
    echo "Journal directory not found: $JOURNAL_DIR"
    exit 1
  fi

  if [[ ! $(command -v $JN_EDITOR) ]]; then
    if [[ -z "$JN_EDITOR" ]]; then
      echo "Either \$EDITOR or \$VISUAL must be set."
    else
      echo "$JN_EDITOR editor not found.  Check \$VISUAL and \$EDITOR"
    fi
    exit 1
  fi

  if [[ ! $(command -v envsubst) ]]; then
    echo "'envsubst' command not found"
    echo 1
  fi

  if [[ ! -d "$TEMPLATES_DIR" ]]; then
    echo "Templates directory not found; check $TEMPLATES_DIR and \$TEMPLATES"
    exit 1
  fi

  if [[ ! $(command -v $UUID_CMD) ]]; then
    echo "Warning: 'uuid' command not found"
  fi

  return 0
}

verify_template() {
  local tmpl="$1"
  local full_path

  # partial name may have been supplied
  for tfile in "$tmpl" "daily-${tmpl}" "daily-${tmpl}.md"; do
    full_path="$TEMPLATES_DIR/${tfile}"
    if [[ -f "$full_path" ]]; then
      #echo "Setting template to $full_path"
      TEMPLATE_FILE="$full_path"
      return
    fi
  done

  if [[ ! -f "$full_path" ]]; then
    echo "Template file not found: $tmpl"
    exit 1
  fi
}

isodate() {
  local day="${1:-today}"

  # strip possible ".md" extension
  day="${day%.md}"

  $DATE_CMD -d "$day" +%Y-%m-%d
}

date_path() {
  $DATE_CMD -d "$1" "+%Y/%m"
}

setup_vars() {
  local day="$1"

  export DATE=$($DATE_CMD -d "$day" +%Y-%m-%d)
  export WEEKDAY=$($DATE_CMD -d "$day" +%A)
  export YEAR_DAY=$($DATE_CMD -d "$day" +%j) # 1..366
  export ISO_WEEK=$($DATE_CMD -d "$day" +%V)
  export ISO_YEAR=$($DATE_CMD -d "$day" +%G)
  export TODAY=$($DATE_CMD  +%Y-%m-%d)

  export UUID=''
  if [[ $(command -v $UUID_CMD) ]]; then
    export UUID="$($UUID_CMD -v 1)"
  fi

  if [[ -z "$DIET" ]]; then
    if [[ -n "$DIET_MODULO" ]]; then
      local adjusted_day=$(($YEAR_DAY + $DIET_MODULO_OFFSET))
      local val=$((adjusted_day % $DIET_MODULO))

      case $val in
        0) DIET="$DIET_FAST"
          ;;
        *) DIET="$DIET_DEFAULT"
          ;;
      esac
    else
      case "${WEEKDAY,,}" in
        mon*) DIET="$DIET_MON" ;;
        tue*) DIET="$DIET_TUE" ;;
        wed*) DIET="$DIET_WED" ;;
        thu*) DIET="$DIET_THU" ;;
        fri*) DIET="$DIET_FRI" ;;
        sat*) DIET="$DIET_SAT" ;;
        sat*) DIET="$DIET_SUN" ;;
        *)
          DIET="$DIET_DEFAULT"
          ;;
      esac
    fi
  fi
  export DIET
}


jnfile() {
  local isodate="$1"
  local entry_dir="$(date_path "$isodate")"

  printf "$JOURNAL_DIR/%s/%s.md" "$entry_dir" "$isodate"
}


header() {
  local day="$1"
  local template="${2:-$TEMPLATE_FILE}"
  setup_vars "$day"

  #echo "Using template ${template}"
  if [[ -f "$template" ]]; then
    envsubst < "$template"
  else
    printf -- '---\ndate: "%s"\nweekday: "%s"\nhealth:\n  weight:\n    pounds: \n---\n\n' \
      "$DATE" "$WEEKDAY"
  fi
}


prepare() {
  local jnfile="$1"
  local isodate="$2"

  mkdir -p "$(dirname "$jnfile")"

  if [[ ! -f "$jnfile" ]]; then
    header "$isodate" >> "$jnfile"
  else
    touch "$jnfile"
  fi

#  echo -n "$jnfile"
}


do_prepare=true
do_edit=true

while getopts 'hlpt:' OPTION
do
  case $OPTION in
    l)  do_edit=false
        do_prepare=false
        ;;
    p)  do_prepare=true
        do_edit=false
        ;;
    t)  tmpl="$OPTARG"
        verify_template "$tmpl"
        ;;
    h|?)
        usage
        exit 0
        ;;
  esac
done

shift $((OPTIND - 1))


precheck
days=("$@")
files=()

# default to 'today'
if [[ ${#days[@]} -eq 0 ]]; then
  days=('today')
fi


for day in "${days[@]}"; do
  isodate=$(isodate "$day")
  jnfile=$(jnfile "$isodate")
  if [[ $do_prepare == true ]]; then
    prepare "$jnfile" "$isodate"
  elif [[ $do_edit != true ]]; then
    echo "$jnfile"
  fi

  files+=("$jnfile")
done

if [[ $do_edit == true ]]; then
  cd "$JOURNAL_DIR"
  exec $JN_EDITOR "${EDITOR_OPTS[@]}" "${files[@]}"
fi


