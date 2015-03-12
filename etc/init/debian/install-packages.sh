#!/bin/bash

trap 'echo Error: $0: stopped' ERR INT
set -u
set -e

if ! type apt >/dev/null 2>&1; then
    echo 'Requirement: apt' 1>&2
    exit 1
fi

echo 'apt-get update...'
apt-get update

echo 'apt-get upgrade...'
apt-get -y upgrade

declare -a PACKAGES=(
    "curl"
    "dpkg-dev"
    "git"
    "iptables-persistent"
    "libncurses5-dev"
    "ruby"
)

echo -n "Install required packages? (y/N) "
read
if [[ "$REPLY" =~ ^[Yy]$ ]]; then

    for package in "${PACKAGES[@]}"
    do
        if dpkg -l | grep -q "^${package}"; then
            echo "Skip: apt-get install ${package}"
        else
            apt-get -y install ${package}
        fi
    done

fi