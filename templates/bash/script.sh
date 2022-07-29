#!/usr/bin/env bash

# fail early
set -eou pipefail

if [[ -n "${DEBUG:=}" ]]; then
  set -x
fi

THIS_SCRIPT="${0##*/}"
BASE_DIR="$(cd "${0%/*}" && pwd)"


usage() {
  cat <<-EOU
	Usage: $THIS_SCRIPT [OPTIONS] <COMMAND>
	
	Description here...
	
	COMMANDS
	   all      Run all steps
	
	OPTIONS
	   -h      Show this message

EOU
}


process_stdin() {
  while IFS= read -r line;do
    echo "  // ${line}"
  done
}


all() {
  process_stdin
}


if [[ $# -eq 0 ]]; then
  all "$@"
else
  while [[ $# -gt 0 ]]; do
    case "$1" in
      help|-h)
        usage
        exit 0
        ;;
      *)
        "$1" "$@"
        ;;
    esac
    shift
  done
fi

