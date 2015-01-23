#!/bin/bash

trap 'echo Error: $0: stopped' ERR
set -e
set -u

#
# Testing the judgement system
# {{{
if [[ -n ${DEBUG:-} ]]; then echo "$0" && exit 0; fi
#}}}


printf "Copying fonts ..."
for f in $DOTFILES/etc/lib/fonts/*; do
  cp "$f" ~/Library/Fonts/
done
printf "done!\n"