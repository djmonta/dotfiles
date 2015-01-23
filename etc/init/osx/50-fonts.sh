#!/bin/bash

trap 'echo Error: $0: stopped' ERR
set -e
set -u


# Copy fonts
{
  pushd $DOTFILES/etc/lib/fonts/; setdiffA=(*); popd
  pushd ~/Library/Fonts/; setdiffB=(*); popd
  setdiff
} >/dev/null

#
# Testing the judgement system
# {{{
if [[ -n ${DEBUG:-} ]]; then echo "$0" && exit 0; fi
#}}}


if (( ${#setdiffC[@]} > 0 )); then
  e_header "Copying fonts (${#setdiffC[@]})"
  for f in "${setdiffC[@]}"; do
    #e_arrow "$f"
    cp "$DOTFILES/etc/lib/fonts/$f" ~/Library/Fonts/
  done
fi