#!/bin/bash

trap 'echo Error: $0: stopped' ERR
set -u
set -e

if ! type gem >/dev/null 2>&1; then
    echo 'Requirement: gem' 1>&2
    exit 1
fi

declare -a GEM_PACKAGES=(
  #"homesick"
)

for package in "${GEM_PACKAGES[@]}"
do
    if gem list | grep -q "^$(basename $package)"; then
        echo "Skip: gem install ${package}"
    else
        gem install $package
    fi
done