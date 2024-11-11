#!/bin/bash

# fail early
set -euo pipefail

# `printf` is broken in BASH 5.2 due to compiler/linker strictness in 
# later versions of GCC.  A fix is expected in BASH 5.3
#
# see: https://unix.stackexchange.com/questions/783623/bash-printf-float-formatting-became-nonsensical-and-random

formatted="$(printf "%.3f\n" 3.14159)"

if [[ $formatted == *"nan"* ]]; then
  echo '`printf` is BROKEN'
  echo "formatted value: $formatted"
  exit 1
else
  echo '`printf` appears to WORK'
  exit 0
fi

