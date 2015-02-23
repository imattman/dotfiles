#!/usr/bin/env bash
#
# Based on powerline fonts install script
# [powerline/fonts](https://github.com/powerline/fonts/)

# Set source and target directories
src_fonts_dir=$( cd "$( dirname "$0" )" && pwd )

find_command="find \"$src_fonts_dir\" \( -name '*.[o,t]tf' -or -name '*.pcf.gz' \) -type f -print0"

if [[ $(uname) == 'Darwin' ]]; then
  # MacOS
  font_dir="$HOME/Library/Fonts"
else
  # Linux
  font_dir="$HOME/.fonts"
  mkdir -p $font_dir
fi

# Copy all fonts to user fonts directory
eval $find_command | xargs -0 -I % echo cp "%" "$font_dir"

# Reset font cache on Linux
if [[ -n `which fc-cache` ]]; then
  fc-cache -f $font_dir
fi

echo "Fonts installed to $font_dir"

