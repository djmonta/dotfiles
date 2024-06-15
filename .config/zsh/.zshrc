# .zshrc

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8
# case ${UID} in
# 0)
#    LANG=C
#    ;;
# esac


## Default shell configuration

### The prompt settings {{{
#
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Theme.
# ZSH_THEME='monta'
DEFAULT_USER='monta'
DIRCOLORS_SOLARIZED_ZSH_THEME='256dark'

# sh rc
for f in "${XDG_CONFIG_HOME:-$HOME/.config}"/*.sh; do
  if [[ ! -f "$f".zwc ]] || [[ "$f" -nt "$f".zwc ]]; then
    zcompile "$f"
  fi

  # shellcheck disable=SC1090
  source "$f"
done

# zsh rc
for f in autoload.zsh bindkey.zsh fzf.zsh setopt.zsh zstyle.zsh zinit.zsh .p10k.zsh zalias.zsh; do
  if [[ ! -f "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/"$f".zwc ]] || [[ "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/"$f" -nt "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/"$f".zwc ]]; then
    zcompile "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/"$f"
  fi

  # shellcheck disable=SC1090
  source "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/"$f"
done


## iterm2
source ${ZDOTDIR}/iterm2_shell_integration.zsh

# autoload -Uz promptinit
# promptinit
# zstyle :prompt:pure:path color 032 #bright blue
# zstyle :prompt:pure:prompt:success color 227 #light yellow
source ${HOME}/dotfiles/bin/256colorlib.sh
# Correct prompt
SPROMPT="${COLOR_FG_CC4422}もしかして: %r [y,n,a,e] ->%{${reset_color}%} "
CORRECTION='${COLOR_FG_D70000}もしかして: '
CORRECTION+='${COLOR_FG_0087FF}${STYLE_LINE}%r%{${reset_color}%}'
CORRECTION+=' [y,n,a,e] -> '
SPROMPT=$CORRECTION

# }}

### History configuration {{{
#
# History file
if [[ ! -d "${XDG_STATE_HOME:-$HOME/.local/state}"/zsh ]]; then
  mkdir -m 700 "${XDG_STATE_HOME:-$HOME/.local/state}"/zsh
fi
export HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}"/zsh/history
export HISTSIZE=1000000   # メモリ内の履歴の数
export SAVEHIST=1000000  # 保存される履歴の数

LISTMAX=50       # 補完リストを尋ねる数(0=ウィンドウから溢れる時は尋ねる)
# rootのコマンドはヒストリに追加しない
if [ $UID = 0 ]; then
    unset HISTFILE
    SAVEHIST=0
fi

### Completion configuration {{{
#

# zsh-completions
#  https://github.com/zsh-users/zsh-completions.git
# fpath=(${HOME}/.zsh/functions/Completion/zsh-completions(N-/) ${fpath})

# homebrewでインストールしたコマンドの補完関数 /usr/local 配下
#  http://yonchu.hatenablog.com/entry/20120415/1334506855
fpath=(/usr/local/share/zsh/functions(N-/) /usr/local/share/zsh/site-functions(N-/) ${fpath})
if type brew >/dev/null 2>&1; then
    BREW_PREFIX=$(brew --prefix)
    fpath=($BREW_PREFIX/share/zsh/functions(N-/) $BREW_PREFIX/share/zsh/site-functions(N-/) ${fpath})
fi

# ユーザ固有の補完関数
fpath=(${ZDOTDIR}/functions/Completion ${fpath})


# -u : 安全ではないファイルを補完しようとした場合に警告を表示しない
# -d : .zcompdumpの場所
# compinit -u -d ${HOME}/.zcompdump


# anyenv
if [ -f ${XDG_CONFIG_HOME}/anyenv/bin/anyenv ]; then
    eval "$(anyenv init - --no-rehash)"
fi

# direnv
if [ -x "`which direnv`" ]; then
    eval "$(direnv hook zsh)"
fi

# zoxide
if [ -x "`which zoxide`" ]; then
    eval "$(zoxide init zsh --cmd cd)"
fi

### Complete Messages
# echo "Loading .zshrc completed!! (ZDOTDIR=${ZDOTDIR})"
# echo "Now zsh version $ZSH_VERSION starting!!"

# Print log
# log
# if (which zprof > /dev/null) ;then
#   zprof | less
# fi
