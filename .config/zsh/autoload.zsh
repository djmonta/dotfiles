autoload -Uz colors && colors
autoload -Uz run-help
autoload -Uz add-zsh-hook

if [[ ! -d "$XDG_CACHE_HOME"/zsh ]]; then
  mkdir -m 700 "$XDG_CACHE_HOME"/zsh
fi

# fpath for zsh-completions (compinit: programs.zsh.completionInit)
zsh_plugins_setup_completions

# Homebrew + local completions (before HM completionInit)
fpath=(/usr/local/share/zsh/functions(N-/) /usr/local/share/zsh/site-functions(N-/) $fpath)
if (( $+commands[brew] )); then
  BREW_PREFIX=$(brew --prefix)
  fpath=($BREW_PREFIX/share/zsh/functions(N-/) $BREW_PREFIX/share/zsh/site-functions(N-/) $fpath)
fi
_zsh_dir="${${(%):-%N}:A:h}"
fpath=("$_zsh_dir"/functions/Completion(N-/) $fpath)
unset _zsh_dir

autoload -Uz is-at-least
# URLをコピペしたときに自動でエスケープ（fast-syntax より前に bind）
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
