#!/bin/bash

# Copy fonts
{
  pushd $DOTFILES/etc/lib/fonts/; setdiffA=(*); popd
  pushd ~/Library/Fonts/; setdiffB=(*); popd
  setdiff
} >/dev/null

if (( ${#setdiffC[@]} > 0 )); then
  e_header "Copying fonts (${#setdiffC[@]})"
  for f in "${setdiffC[@]}"; do
    e_arrow "$f"
    cp "$DOTFILES/conf/osx/fonts/$f" ~/Library/Fonts/
  done
fi