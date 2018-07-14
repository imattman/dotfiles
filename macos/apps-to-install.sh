#!/usr/bin/env bash

set -e

# OSX
OPEN='open'

APP_URLS="
https://www.google.com/chrome/
https://www.dropbox.com/

https://www.iterm2.com/
https://code.visualstudio.com/
https://www.sublimetext.com/

https://www.alfredapp.com/

https://1password.com/downloads/
https://www.omnigroup.com/omnifocus
"

while read -r url; do
  if [[ -n "$url" ]]; then
    $OPEN "$url"
  fi
done <<< "$APP_URLS"


