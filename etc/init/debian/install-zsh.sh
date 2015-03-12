#!/bin/bash

trap 'echo Error: $0: stopped' ERR INT
set -u
set -e

echo -n "Install zsh and emacs from sid? (y/N) "
read
if [[ "$REPLY" =~ ^[Yy]$ ]]; then

    sudo -v

    while true
    do
        sudo -n true
        sleep 60;
        kill -0 "$$" || exit
    done 2>/dev/null &

		sudo sh -c "echo deb http://ftp.de.debian.org/debian sid main > /etc/apt/sources.list.d/sid.list"

		sudo apt-get update
		sudo apt-get -y install -t sid zsh
        sudo apt-get -y install -t sid emacs24-nox

fi