#!/bin/bash

# fail early
set -ou pipefail

if [[ -n "${DEBUG:=}" ]]; then
  set -x
fi

THIS_SCRIPT=$(basename "$0")
BASE_DIR=$(cd $(dirname "$0") && pwd)


