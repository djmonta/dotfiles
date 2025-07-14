autoload -Uz colors && colors
autoload -Uz run-help
autoload -Uz add-zsh-hook
if [[ ! -d "$XDG_CACHE_HOME"/zsh ]]; then
  mkdir -m 700 "$XDG_CACHE_HOME"/zsh
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

fpath=(${HOME}/.docker/completions ${fpath})

# -u : 安全ではないファイルを補完しようとした場合に警告を表示しない
# -d : .zcompdumpの場所
# compinit -u -d ${HOME}/.zcompdump

autoload -Uz compinit && compinit -d "$XDG_CACHE_HOME"/zsh/compdump
autoload -Uz is-at-least
# URLをコピペしたときに自動でエスケープ
autoload -Uz url-quote-magic

zle -N self-insert url-quote-magic