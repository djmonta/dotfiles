autoload -Uz colors && colors
autoload -Uz run-help
autoload -Uz add-zsh-hook
if [[ ! -d "$XDG_CACHE_HOME"/zsh ]]; then
  mkdir -m 700 "$XDG_CACHE_HOME"/zsh
fi

zsh_plugins_setup_completions

autoload -Uz compinit && compinit -d "$XDG_CACHE_HOME"/zsh/compdump

autoload -Uz is-at-least
# URLをコピペしたときに自動でエスケープ（fast-syntax より前に bind）
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic