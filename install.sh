#!/usr/bin/env bash

set -e

dotbot_dir="dotbot"
prezto_dir="prezto"
config="dotbot-conf.yaml"

base_dir="$(cd $(dirname $0) && pwd)"

function usage() {
  cat<<EOU
  Usage: $0 [OPTIONS]
  
  A basic installer my dotfiles.
  
  OPTIONS:
     -h:  Show this message
     -f:  Fetch git submodules
     -l:  Execute dotbot setup script to generate symlinks
     -x:  Execute non-idempotent scripts that should be run only once
          with initial install
EOU
}

function fetch_submodules() {
  echo "Updating dotbot..."
  git submodule update --init --recursive "${dotbot_dir}"

  echo "Updating prezto..."
  git submodule update --init --recursive "${prezto_dir}"
}

function run_dotbot() {
  echo "Executing dotbot..."
  "${base_dir}/dotbot/bin/dotbot" -d "${base_dir}" -c "${config}" "${@}"
}

function execute_init() {
  osx/set-defaults.sh
  fonts/install.sh
  osx-terminal/install.sh
}

cd "${base_dir}"

while getopts hflx OPTION
do
  case $OPTION in
    l)  run_dotbot
        opt_set="true"
        ;;
    u)  fetch_submodules
        opt_set="true"
        ;;
    x)  execute_init 
        opt_set="true"
        ;;
    h)  usage 
        exit 1
        ;;
    ?)  usage 
        exit 1
        ;;
  esac
done


# run dotbot by default if no args specified 
[[ -n $opt_set ]] || echo run_dotbot

