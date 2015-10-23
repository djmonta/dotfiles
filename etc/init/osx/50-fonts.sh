#!/bin/bash

trap 'echo Error: $0: stopped' ERR
set -u
set -e

echo -n 'Install Ricty fonts? (y/N) '
read
if [[ "$REPLY" =~ ^[Yy]$ ]]; then

	if ! type brew >/dev/null 2>&1; then
	    echo 'Requirement: brew' 1>&2
	    exit 1
	fi

	declare -a TAPS=(
	    'sanemat/font'
	)

	for TAP in "${TAPS[@]}"
	do
	    if brew tap | grep -q "^${TAP}"; then
	        echo "Skip: brew tap ${TAP}"
	    else
	        brew tap $TAP
	    fi
	done

  if brew list -1 | grep -q "^ricty"; then
    echo "Skip: brew install ricty"
  else
    brew install --powerline --vim-powerline ricty
    cp -f /usr/local/Cellar/ricty/3.2.4/share/fonts/Ricty*.ttf ~/Library/Fonts/
  fi

fi
