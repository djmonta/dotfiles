#!/bin/bash

trap 'echo Error: $0: stopped' ERR INT
set -u
set -e

if brew commands -1 | grep -q "^file"; then
	echo -n 'Install Homebrew/Cask/MAS Application now? (y/N) '
	read
	if [[ "$REPLY" =~ ^[Yy]$ ]]; then
	  export HOMEBREW_CASK_OPTS="--appdir=/Applications"

	  if hostname | grep -q "Mac-mini\.local$" ; then
	  	export HOMEBREW_BREWFILE=${HOME}/.brewfile/Brewfile
		else
	  	export HOMEBREW_BREWFILE=${HOME}/.brewfile/Brewfile.MBA
		fi

	  brew file install
		cp -f /usr/local/Cellar/ricty/3.2.4/share/fonts/Ricty*.ttf ~/Library/Fonts/
	fi
else
	echo 'Requirement: brew-file' 1>&2
  exit 1
fi
