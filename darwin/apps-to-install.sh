#!/bin/bash

# fail early
set -eou pipefail


APP_URLS="
https://brew.sh
https://www.google.com/chrome/

https://www.iterm2.com/
https://code.visualstudio.com/
https://www.sublimetext.com/

https://www.alfredapp.com/
https://1password.com/downloads/
"

while read -r url; do
  if [[ -n "$url" ]]; then
    open "$url"
  fi
done <<< "$APP_URLS"


