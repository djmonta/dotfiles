#!/bin/bash

trap 'echo Error: $0: stopped' ERR INT
set -u
set -e

echo -n 'Install Homebrew/Cask/MAS Application now? (y/N) '
read
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  	export HOMEBREW_CASK_OPTS="--appdir=/Applications"

  	if hostname | grep -q "Mac-mini\.local$" ; then
  		export HOMEBREW_BREWFILE=${HOME}/.brewfile/Brewfile
  	elif hostname | grep -q "iMac\.local$" ; then
  		export HOMEBREW_BREWFILE=${HOME}/.brewfile/Brewfile  	
	elif hostname | grep -q "MacBook-Pro\.local$" ; then
		export HOMEBREW_BREWFILE=${HOME}/.brewfile/Brewfile.MBP
	else
  		export HOMEBREW_BREWFILE=${HOME}/.brewfile/Brewfile.MBP
	fi

	brew file install
fi
