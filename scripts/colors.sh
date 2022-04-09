#!/bin/bash

# fail early
set -euo pipefail

for i in {0..255} ; do
    printf "\x1b[38;5;${i}mcolor${i}\n"
done

