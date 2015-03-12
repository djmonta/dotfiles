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

if ! type gem >/dev/null 2>&1; then
    echo 'Requirement: gem' 1>&2
    exit 1
fi


echo -n "Install Gem Packages? (y/N) "
read
if [[ "$REPLY" =~ ^[Yy]$ ]]; then

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

fi