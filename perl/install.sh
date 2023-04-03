#!/usr/bin/env bash

# fail early
set -eou pipefail

if [[ -n "${DEBUG:=}" ]]; then
  set -x
fi

THIS_SCRIPT="${0##*/}"
BASE_DIR="$(cd "${0%/*}" && pwd)"

USER_PERL_DIR="${1:-$XDG_DATA_HOME/perl5}"

usage() {
  cat <<-EOU
	Usage: $THIS_SCRIPT [OPTIONS]
	
	Set up local lib for perl development
	
	OPTIONS:
	   -h:   show this message
EOU
}

precheck() {
  local fail=''

  if [[ ! $(which perl) ]]; then
    echo "'perl' not found!"
    fail=true
  fi

  # expect local::lib to be installed by default with perl
  if [[ ! $(perl -Mlocal::lib --help) ]]; then
    echo "perl library 'local::lib' not found!"
    echo "  See CPAN for bootstrapping install"
    fail=true
  fi

  if [[ ! $(which cpanm) ]]; then
    echo "'cpanm' not found!"
    echo "   To install on Debian based systems:"
    echo
    echo "   sudo apt install cpanminus"
    fail=true
  fi

  if [[ -n "$fail" ]]; then
    echo
    echo "Verify perl and required modules are installed"
    exit 1
  fi
}

locallib() {
  if [[ -d "$USER_PERL_DIR" ]]; then
    echo "User perl lib directory found: $USER_PERL_DIR"
    
    if [[ -z "${PERL5LIB:-}" ]]; then
      echo "\$PERL5LIB not set!  Verify shell config for perl"
      return 1
    fi

    return 0
  fi

  echo "Setting up perl local::lib ..."
  perl "-I$USER_PERL_DIR" "-Mlocal::lib=$USER_PERL_DIR"

  if [[ -z "$(printenv | grep PERL)" ]]; then
    echo "Reload environment to configure \$PERL_* variables"
  fi
}

install() {
  precheck
  locallib
}


for cmd in "$@"
do
  case $cmd in
    -h|help)
        usage
        exit 0
        ;;
    *)
        "$cmd"
  esac
done

if [[ $# -eq 0 ]]; then
  install
fi


