#!/bin/bash

# fail early
set -eou pipefail

ARCH="amd64"


current_version() {
  curl -sSL 'https://go.dev/VERSION?m=text'
}

url() {
  local version="${1:-}"
  printf "https://go.dev/dl/%s.linux-%s.tar.gz" "$version" "$ARCH"
}


pkg_url="$(url $(current_version))"
echo "Downloading  $pkg_url"

curl -O -L "$(url $(current_version))"

