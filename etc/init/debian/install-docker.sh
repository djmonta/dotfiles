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

		sudo sh -c "echo deb http://http.debian.net/debian wheezy-backports main > /etc/apt/sources.list/wheezy-backports.list"

		sudo apt-get update
        sudo apt-get install -t wheezy-backports linux-image-amd64
        wget -qO - https://get.docker.com/ | sh

fi