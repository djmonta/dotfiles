#!/bin/bash

trap 'echo Error: $0: stopped' ERR INT
set -u
set -e

#
# A system that judge if this script is necessary or not
# {{{
[[ ! -f "$(dirname "${BASH_SOURCE}")"/Caskfile ]] && exit
#}}}

#
# Testing the judgement system
# {{{
if [[ -n ${DEBUG:-} ]]; then echo "$0" && exit 0; fi
#}}}

echo -n 'Install Homebrew Cask packages? (y/N) '
read
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"

    if [ `hostname` = Mac-mini\.local$ ]; then
    	bash "$(dirname "${BASH_SOURCE}")"/Caskfile
  	else
    	bash "$(dirname "${BASH_SOURCE}")"/Caskfile.MBA
  	fi
fi
