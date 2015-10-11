#!/bin/bash

trap 'echo Error: $0: stopped' ERR INT
set -u
set -e

# if ! type apt >/dev/null 2>&1; then
#     echo 'Requirement: apt' 1>&2
#     exit 1
# fi

declare -a PACKAGES=(
    "dpkg-dev"
    "iptables-persistent"
    "libncurses5-dev"
    "trash-cli"
    "bison"
    "libreadline6-dev"
    "curl"
    "git-core"
    "zlib1g-dev"
    "libssl-dev"
    "libyaml-dev"
    "libsqlite3-dev"
    "sqlite3"
    "libxml2-dev"
    "libxslt1-dev"
    "autoconf"
    "ruby"
    "libbz2-dev"
)

echo -n "Install required packages? (y/N) "
read
if [[ "$REPLY" =~ ^[Yy]$ ]]; then

    sudo -v

    while true
    do
        sudo -n true
        sleep 60;
        kill -0 "$$" || exit
    done 2>/dev/null &

    echo 'apt-get update...'
    sudo apt-get update

    echo 'apt-get upgrade...'
    sudo apt-get -y upgrade

    for package in "${PACKAGES[@]}"
    do
        if dpkg -l | grep -q "^${package}"; then
            echo "Skip: apt-get install ${package}"
        else
            sudo apt-get -y install ${package}
        fi
    done

fi