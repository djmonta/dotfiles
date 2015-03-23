#!/bin/bash

trap 'echo Error: $0: stopped' ERR INT
set -u
set -e

echo -n "Install docker from wheezy-backports? (y/N) "
read
if [[ "$REPLY" =~ ^[Yy]$ ]]; then

    sudo -v

    while true
    do
        sudo -n true
        sleep 60;
        kill -0 "$$" || exit
    done 2>/dev/null &

		sudo sh -c "echo deb http://http.debian.net/debian wheezy-backports main > /etc/apt/sources.list"

		sudo apt-get update
		# sudo apt-get -y install -t wheezy-backports zsh
        # sudo apt-get -y install -t wheezy-backports emacs24-nox

fi