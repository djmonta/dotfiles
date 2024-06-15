autoload -Uz colors && colors
autoload -Uz run-help
autoload -Uz add-zsh-hook
if [[ ! -d "$XDG_CACHE_HOME"/zsh ]]; then
  mkdir -m 700 "$XDG_CACHE_HOME"/zsh
fi
autoload -Uz compinit && compinit -d "$XDG_CACHE_HOME"/zsh/compdump
autoload -Uz is-at-least
# URLをコピペしたときに自動でエスケープ
autoload -Uz url-quote-magic

zle -N self-insert url-quote-magic