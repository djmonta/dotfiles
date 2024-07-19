#******************************************************************************
#
#  .zshenv
#
#  initial setup file for both interactive and noninteractive zsh
#
#  Read config sequence (except /etc/*)
#
#   login shell
#     $ZDOTDIR/.zshenv
#     $ZDOTDIR/.zprofile
#     $ZDOTDIR/.zshrc
#     $ZDOTDIRA/.zlogin
#
#   interactive zsh
#     $ZDOTDIR/.zshenv
#     $ZDOTDIR/.zshrc
#
#   shell scripts
#     $ZDOTDIR/.zshenv
#
#   remoteley noninteractive zsh (e.x ssh hostname command)
#     $ZDOTDIR/.zshenv
#
#   logout:
#     $ZDOTDIR/.zlogout
#     /etc/zlogout
#
#******************************************************************************

## performance
# zmodload zsh/zprof && zprof

# env
if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/env.sh ]; then
  # shellcheck source=config/sh/env.sh
  source "${XDG_CONFIG_HOME:-$HOME/.config}"/env.sh
fi

### Setup ZDOTDIR
#
# The directory to search for shell startup files (.zshrc, etc).
# If ZDOTDIR is unset, HOME is used instead.
#
if [ -d "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh ]; then
  ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}"/zsh
fi


typeset -U path PATH        # PATH環境変数の重複エントリを排除

# (N-/): 存在しないディレクトリは登録しない
typeset -U fpath        # 重複パスを登録しない

# sudo用pathを設定
# typeset -T は重複実行できないため一度環境変数を削除する
# (Reloadで失敗しないようにするため)
unset SUDO_PATH
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({/usr/local,/usr,}/sbin(N-/))
export SUDO_PATH


# 重複パスを登録しない
typeset -U cdpath
cdpath=($HOME{,/links}(N-/))

