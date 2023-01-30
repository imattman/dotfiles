#!/usr/bin/env bash
#
# A convenience script for editing commonplace log entries

# fail early
set -euo pipefail

if [[ -n "${DEBUG:=}" ]]; then
  set -x
fi

CM_DIR="${NOTES_ZETTELKASTEN/commonplace}"
CM_ENTRY_FILE="${NOTES_COMMONPLACE_FILE:-$CM_DIR/commonplace-log.md}"
TEMPLATES_DIR="${TEMPLATES_DIR:-$HOME/.dotfiles/templates/zet}"
TEMPLATE_FILE="$TEMPLATES_DIR/commonplace.md"

DATE_CMD="date"
UUID_CMD="uuid"
CM_EDITOR=${VISUAL:-${EDITOR:-}}
EDITOR_OPTS=''  # "+8"

usage() {
  local THIS_SCRIPT="${0##*/}"

  cat<<EOU
Usage: $THIS_SCRIPT [OPTIONS] [date1 [date2 ...]]

A utility for managing commonplace log entries.

Examples:

  # generate standard header with current date
  $THIS_SCRIPT

  # generate header with 'topic' and 'location' prefilled
  TOPIC='some topic' LOCATION='library' $THIS_SCRIPT

OPTIONS:
   -h:  Show this message
   -t:  Supply template argument.  A basic match is performed looking
        for templates that optionally can include "commonplace-" prefix 
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

  if [[ ! -d "$CM_DIR" ]]; then
    echo "Warning: commonplace directory not found: $CM_DIR"
  fi

  if [[ ! $(command -v $CM_EDITOR) ]]; then
    if [[ -z "$CM_EDITOR" ]]; then
      echo "Either \$EDITOR or \$VISUAL must be set."
    else
      echo "$CM_EDITOR editor not found.  Check \$VISUAL and \$EDITOR"
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
  for tfile in "$tmpl" "${tmpl}.md" "commonplace-${tmpl}" "commonplace-${tmpl}.md"; do
    full_path="$TEMPLATES_DIR/${tfile}"
    #echo "  checking for template ${full_path}"
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

datestamp() {
  local day="${1:-today}"

  # strip possible ".md" extension
  day="${day%.md}"

  $DATE_CMD -d "$day" +%Y-%m-%d
}

setup_vars() {
  local day="$1"

  export DATE=$($DATE_CMD -d "$day" +%Y-%m-%d)
  export TIMESTAMP=$($DATE_CMD -d "$day" '+%Y-%m-%dT%H:%M:%S%z')
  export WEEKDAY=$($DATE_CMD -d "$day" +%A)
  export YEAR_DAY=$($DATE_CMD -d "$day" +%j) # 1..366
  export ISO_WEEK=$($DATE_CMD -d "$day" +%V)
  export ISO_YEAR=$($DATE_CMD -d "$day" +%G)
  export TODAY=$($DATE_CMD  +%Y-%m-%d)

  export UUID=''
  if [[ $(command -v $UUID_CMD) ]]; then
    export UUID="$($UUID_CMD -v 1)"
  fi
}


header() {
  local day="$1"
  local template="${2:-$TEMPLATE_FILE}"
  setup_vars "$day"

  #echo "Using template ${template}"
  if [[ ! -f "$template" ]]; then
    echo "Error: template '$template' not found"
    exit 1
  fi

  envsubst < "$template"
}


prepare() {
  local cmfile="$1"
  local isodate="$2"

  header "$isodate" >> "$cmfile"
  echo -n "$cmfile"
}


do_prepare=
do_edit=
cmfile="${CM_ENTRY_FILE}"

while getopts 'fhlpt:' OPTION
do
  case $OPTION in
    f)  cmfile="$OPTARG"
        ;;
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
        exit 0
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
  datestamp=$(datestamp "$day")
  if [[ -n $do_prepare ]]; then
    prepare "$cmfile" "$datestamp"
  else
    header "$datestamp"
  fi

  files="${files} $cmfile"
done

if [[ -n $do_edit ]]; then
  exec $CM_EDITOR $EDITOR_OPTS $files
fi


