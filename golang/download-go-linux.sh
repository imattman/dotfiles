#!/bin/bash

# fail early
set -eou pipefail

ARCH="amd64"


current_version() {
  curl -sSL 'https://golang.org/VERSION?m=text'
}

url() {
  local version="${1:-}"
  printf "https://golang.org/dl/%s.linux-%s.tar.gz" "$version" "$ARCH"
}



echo curl -O -L "$(url $(current_version))"

