#!/bin/bash

RB_VER=2.6.4
ND_VER=10.16.3
PY_VER=3.7.4
PHP_VER=7.2.22

rbenv install -l
echo -n "Which version of ruby to install? (${RB_VER}): "
read ANSWER
if [[ "$ANSWER" != "" ]]; then
	RB_VER="$ANSWER"
fi
rbenv install -f ${RB_VER}
rbenv global ${RB_VER}
rbenv rehash

nodenv install -l
echo -n "Which version of nodejs to install? (${ND_VER}): "
read ANSWER
if [[ "$ANSWER" != "" ]]; then
	ND_VER="$ANSWER"
fi
nodenv install -f ${ND_VER}
nodenv global ${ND_VER}
nodenv rehash

pyenv install -l
echo -n "Which version of python to install? (${PY_VER}): "
read ANSWER
if [[ "$ANSWER" != "" ]]; then
	PY_VER="$ANSWER"
fi
pyenv install -f ${PY_VER}
pyenv global ${PY_VER}
pyenv rehash

phpenv install -l
echo -n "Which version of php to install? (${PHP_VER}): "
read ANSWER
if [[ "$ANSWER" != "" ]]; then
	PHP_VER="$ANSWER"
fi
if [[ $OSTYPE == darwin* ]]; then
	sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /
	PHP_BUILD_CONFIGURE_OPTS="--with-openssl=$(brew --prefix openssl) --with-libxml-dir=$(brew --prefix libxml2)" PHP_BUILD_EXTRA_MAKE_ARGUMENTS=-j4
fi
phpenv install ${PHP_VER}
phpenv global ${PHP_VER}
phpenv rehash
