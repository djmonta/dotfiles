#******************************************************************************
#
#  .zprofile
#
#  (in $ZDOTDIR : default $HOME)
#
#  initial setup file for only interactive zsh
#  This file is read after .zshenv file is read befere .zshrc when you login.
#  Not read in for subsequent shells.
#  For setting up terminal and global environment characteristics.
#
#******************************************************************************

### Setup only grobal but interactive-use only variables ###
#

## Setup profile (common settings)
if [ -f ${HOME}/dotfiles/.profile ]; then
    source ${HOME}/dotfiles/.profile
fi

## Setup profile profile (chracteristc settings on each OS)
case "${OSTYPE}" in
    # Mac OS X
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


### Complete Messages
# echo "Loading .zprofile completed!! (SHELL=${SHELL})"
