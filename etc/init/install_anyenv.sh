#!/bin/bash

echo -n "Install anyenv? (y/N) "
read REPLY
if [[ "$REPLY" =~ ^[Yy]$ ]]; then

	# Clone anyenv
	git clone https://github.com/anyenv/anyenv ~/.anyenv

	# Add PATH
	export PATH="$HOME/.anyenv/bin:$PATH"

	# Install
	eval "$(anyenv init -)"
	anyenv install --init

	IS_INSTALLED_RB=$(rbenv version | grep ${RB_VER} | wc -l | xargs echo)
	if [ ${IS_INSTALLED_RB} -eq 0 ]; then
		anyenv install -f rbenv
	fi
	IS_INSTALLED_ND=$(nodenv version | grep ${ND_VER} | wc -l | xargs echo)
	if [ ${IS_INSTALLED_ND} -eq 0 ]; then
		anyenv install -f nodenv
	fi
	IS_INSTALLED_PY=$(pyenv version | grep ${PY_VER} | wc -l | xargs echo)
	if [ ${IS_INSTALLED_PY} -eq 0 ]; then
		anyenv install -f pyenv
	fi
	IS_INSTALLED_PHP=$(phpenv version | grep ${PY_VER} | wc -l | xargs echo)
	if [ ${IS_INSTALLED_PHP} -eq 0 ]; then
		anyenv install -f phpenv
	fi

fi

exec $SHELL -l
