#!/bin/bash

trap 'echo Error: $0: stopped' ERR
set -u
set -e

if ! type brew >/dev/null 2>&1; then
    echo 'Requirement: brew' 1>&2
    exit 1
fi

echo 'brew updating...'

brew update
outdated=$(brew outdated)

if [ -n "$outdated" ]; then
    echo 'The following package(s) will upgrade.'
    echo ''
    echo "$outdated"
    echo 'Are you sure?'
    echo 'If you do not want to upgrade, please type Ctrl-c now.'
    echo ''

    # Wait Ctrl-c
    read dummy

    brew upgrade
fi

declare -a TAPS=(
    'argon/mas'
    'rcmdnk/file'
)

for TAP in "${TAPS[@]}"
do
    if brew tap | grep -q "^${TAP}"; then
        echo "Skip: brew tap ${TAP}"
    else
        brew tap $TAP
    fi
done

declare -a BREW_PACKAGES=(
  "mas"
  "brew-file"
  "mackup"
)

for package in "${BREW_PACKAGES[@]}"
do
    if brew list -1 | grep -q "^$(basename $package)"; then
        echo "Skip: brew install ${package}"
    else
        brew install $package
    fi
done