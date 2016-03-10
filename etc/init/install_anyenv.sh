#!/bin/sh

RB_VER=2.2.3
ND_VER=v0.12.7
PY_VER=2.7.10

echo -n "Install anyenv? (y/N) "
read
if [[ "$REPLY" =~ ^[Yy]$ ]]; then

    # Clone anyenv
    git clone https://github.com/riywo/anyenv ~/.anyenv

    # Add PATH
    export PATH="$HOME/.anyenv/bin:$PATH"

    # Install
    eval "$(anyenv init -)"

    IS_INSTALLED_RB=$(rbenv version | grep ${RB_VER} | wc -l | xargs echo)
    if [ ${IS_INSTALLED_RB} -eq 0 ]; then
        anyenv install -f rbenv
        rbenv install -f ${RB_VER}
        rbenv global ${RB_VER}
        rbenv rehash
    fi

    IS_INSTALLED_ND=$(ndenv version | grep ${ND_VER} | wc -l | xargs echo)
    if [ ${IS_INSTALLED_ND} -eq 0 ]; then
        anyenv install -f ndenv
        ndenv install -f ${ND_VER}
        ndenv global ${ND_VER}
        ndenv rehash
    fi

    IS_INSTALLED_PY=$(pyenv version | grep ${PY_VER} | wc -l | xargs echo)
    if [ ${IS_INSTALLED_PY} -eq 0 ]; then
        anyenv install -f pyenv
        pyenv install -f ${PY_VER}
        pyenv global ${PY_VER}
        pyenv rehash
    fi

fi