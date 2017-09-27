#!/bin/bash

RB_VER=2.3.1
ND_VER=6.10.2
PY_VER=2.7.10
PHP_VER=5.6.23

rbenv install -l
echo -n "Which version of ruby to install? (2.3.1): "
read ANSWER
if [[ "$ANSWER" != "" ]]; then
	RB_VER="$ANSWER"
fi
rbenv install -f ${RB_VER}
rbenv global ${RB_VER}
rbenv rehash

nodenv install -l
echo -n "Which version of nodejs to install? (6.10.2): "
read ANSWER
if [[ "$ANSWER" != "" ]]; then
	ND_VER="$ANSWER"
fi
nodenv install -f ${ND_VER}
nodenv global ${ND_VER}
nodenv rehash

pyenv install -l
echo -n "Which version of python to install? (2.7.10): "
read ANSWER
if [[ "$ANSWER" != "" ]]; then
	PY_VER="$ANSWER"
fi
pyenv install -f ${PY_VER}
pyenv global ${PY_VER}
pyenv rehash

phpenv install -l
echo -n "Which version of php to install? (5.6.23): "
read ANSWER
if [[ "$ANSWER" != "" ]]; then
	PHP_VER="$ANSWER"
fi
if [[ $OSTYPE == darwin* ]]; then
	PHP_BUILD_CONFIGURE_OPTS="--with-openssl=$(brew --prefix openssl) --with-libxml-dir=$(brew --prefix libxml2)" PHP_BUILD_EXTRA_MAKE_ARGUMENTS=-j4
fi
phpenv install ${PHP_VER}
phpenv global ${PHP_VER}
phpenv rehash
