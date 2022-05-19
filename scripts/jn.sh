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

DATE_CMD="date"
UUID_CMD="uuid"
JN_EDITOR=${VISUAL:-${EDITOR:-}}
EDITOR_OPTS="+8"

usage() {
  local THIS_SCRIPT="$(basename $0)"

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
  $DATE_CMD -d "$1" +%Y-%m-%d
}

date_path() {
  $DATE_CMD -d "$1" "+%Y/%m"
}

setup_vars() {
  local isodate="$1"

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

  DIET=''
  case "$(echo "$WEEKDAY" | tr [A-Z] [a-z])" in
    mon*|wed*|fri*)
      DIET='fasting'
      ;;
    *)
      DIET='keto'
      ;;
  esac
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

  echo -n "$jnfile"
}


do_prepare=true
do_edit=true

while getopts 'hlpt:' OPTION
do
  case $OPTION in
    l)  do_edit=''
        do_prepare=''
        ;;
    p)  do_prepare=true
        do_edit=''
        ;;
    t)  tmpl="$OPTARG"
        verify_template "$tmpl"
        ;;
    h|?)
        usage
        exit 1
        ;;
  esac
done

shift $((OPTIND - 1))


precheck
days=("$@")
files=""

# default to 'today'
if [[ ${#days[@]} -eq 0 ]]; then
  days=('today')
fi


for day in "${days[@]}"; do
  isodate=$(isodate "$day")
  jnfile=$(jnfile "$isodate")
  if [[ -n $do_prepare ]]; then
    prepare "$jnfile" "$isodate"
  else
    echo "$jnfile"
  fi

  files="${files} $jnfile"
done

if [[ -n $do_edit ]]; then
  $JN_EDITOR $EDITOR_OPTS $files
fi


