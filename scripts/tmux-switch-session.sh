#!/bin/bash

# fail early
set -euo pipefail

tmux_switch_to_session() {
    session="$1"
    if [[ $tmuxsessions = *"$session"* ]]; then
        tmux switch-client -t "$session"
    fi
}

choice_in_pane() {
    tmuxsessions=$(tmux list-sessions -F "#{session_name}")
    choice=$(sort -rfu <<< "$tmuxsessions" \
      | fzf-tmux \
      | tr -d '\n')
    
    tmux_switch_to_session "$choice"
}

choice_in_menu() {
  tmux list-sessions -F '#S' \
    | awk 'BEGIN {ORS=" "} {print $1, NR, "\"switch-client -t", $1 "\""}' \
    | xargs tmux display-menu -T "Switch-session"
}


choice_in_menu

