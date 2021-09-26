#!/usr/bin/env bash

pushd $(pwd)
cd ~/.Trash

# turn off the user immutable flag & remove
[[ -n $(ls) ]] && \
  chflags nouchg * && \
  echo rm -rf *

popd
