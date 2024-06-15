#*******************************************************************************
#
# .bash_profile
#   ログイン時に一度だけ読み込まれる
#
#*******************************************************************************

# env
if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/env.sh ]; then
  # shellcheck source=config/sh/env.sh
  source "${XDG_CONFIG_HOME:-$HOME/.config}"/env.sh
fi

#
# .bashrc 読み込み
#
if [ -f ${HOME}/.bashrc ]; then
    source ${HOME}/.bashrc
fi


## complete message
echo ".bash_profile load completed...($SHELL)"
