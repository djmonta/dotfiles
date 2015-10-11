#!/bin/bash

trap 'echo Error: $0: stopped' ERR
set -u
set -e

# Add anyenv to PATH for scripting
export PATH="${HOME}/.anyenv/bin:$PATH"
eval "$(anyenv init -)"
for D in `ls ${HOME}/.anyenv/envs`
do
  export PATH="${HOME}/.anyenv/envs/$D/shims:$PATH" 
done

if ! type pip >/dev/null 2>&1; then
    echo 'Requirement: pip' 1>&2
    exit 1
fi

echo -n "Install pip Packages? (y/N) "
read
if [[ "$REPLY" =~ ^[Yy]$ ]]; then

  declare -a PIP_PACKAGES=(
    "percol"
  )

  for package in "${PIP_PACKAGES[@]}"
  do
      if pip list | grep -q "^$(basename $package)"; then
          echo "Skip: pip install ${package}"
      else
          pip install --user $package
      fi
  done
fi