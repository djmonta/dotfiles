#!/bin/bash

trap 'echo Error: $0: stopped' ERR
set -u
set -e

if ! type pip >/dev/null 2>&1; then
    echo 'Requirement: pip' 1>&2
    exit 1
fi

declare -a PIP_PACKAGES=(
  "powerline-status"
  "psutil"
)

for package in "${PIP_PACKAGES[@]}"
do
    if pip list | grep -q "^$(basename $package)"; then
        echo "Skip: pip install ${package}"
    else
        pip install --user $package
    fi
done