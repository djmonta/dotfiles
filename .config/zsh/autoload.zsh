autoload -Uz colors && colors
autoload -Uz run-help
autoload -Uz add-zsh-hook

if [[ ! -d "$XDG_CACHE_HOME"/zsh ]]; then
  mkdir -m 700 "$XDG_CACHE_HOME"/zsh
fi

# fpath for zsh-completions (compinit: programs.zsh.completionInit)
zsh_plugins_setup_completions

autoload -Uz is-at-least
# URLをコピペしたときに自動でエスケープ（fast-syntax より前に bind）
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
