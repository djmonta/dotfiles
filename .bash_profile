#*******************************************************************************
#
# .bash_profile
#   ログイン時に一度だけ読み込まれる
#
#*******************************************************************************

#
# profile設定(共通)
#
if [ -f ${HOME}/dotfiles/.profile ]; then
    source ${HOME}/dotfiles/.profile
fi

#
# profile設定(OS固有)
#
case "${OSTYPE}" in
    # Mac(Unix)
    darwin*)
    if [ -f ${HOME}/dotfiles/.profile.osx ]; then
        source ${HOME}/dotfiles/.profile.osx
    fi
    ;;
    # Linux
    linux*)
    if [ -f ${HOME}/dotfiles/.profile.linux ]; then
        source ${HOME}/dotfiles/.profile.linux
    fi
    ;;
esac

#
# .bashrc 読み込み
#
if [ -f ${HOME}/.bashrc ]; then
    source ${HOME}/.bashrc
fi


## complete message
echo ".bash_profile load completed...($SHELL)"
