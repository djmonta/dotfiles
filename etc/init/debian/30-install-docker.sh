#!/bin/bash

trap 'echo Error: $0: stopped' ERR INT
set -u
set -e

echo -n "Install docker (y/N) "
read
if [[ "$REPLY" =~ ^[Yy]$ ]]; then

    sudo -v

    while true
    do
        sudo -n true
        sleep 60;
        kill -0 "$$" || exit
    done 2>/dev/null &

        wget -qO - https://get.docker.com/ | sh

fi