autoload -Uz colors && colors
autoload -Uz run-help
autoload -Uz add-zsh-hook
if [[ ! -d "$XDG_CACHE_HOME"/zsh ]]; then
  mkdir -m 700 "$XDG_CACHE_HOME"/zsh
fi

# home-manager zsh plugins (order matters)
if [[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/home-manager/zsh-completions.zsh" ]]; then
  source "${XDG_CONFIG_HOME:-$HOME/.config}/home-manager/zsh-completions.zsh"
fi

autoload -Uz compinit && compinit -d "$XDG_CACHE_HOME"/zsh/compdump

autoload -Uz is-at-least
# URLをコピペしたときに自動でエスケープ（fast-syntax より前に bind）
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic