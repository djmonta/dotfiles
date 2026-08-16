#!/bin/bash

trap 'echo Error: $0: stopped' ERR INT
set -u
set -e

if command -v nix >/dev/null 2>&1; then
  exit 0
fi

if [[ -n ${DEBUG:-} ]]; then
  echo "$0"
  exit 0
fi

echo -n 'Install Determinate Nix? (Y/n) '
read -r REPLY
if [[ "${REPLY}" =~ ^[Nn]$ ]]; then
  echo 'Skip Nix'
  exit 0
fi

# Flakes are enabled by default. --no-confirm skips the second prompt
# (this script already asked); sudo may still prompt.
curl -fsSL https://install.determinate.systems/nix | sh -s -- install --no-confirm

if [[ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
  # shellcheck disable=SC1091
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi
