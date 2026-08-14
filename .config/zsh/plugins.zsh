# HM zsh plugin paths (home.nix) + load order (this file).
# home.packages: zsh-completions, zsh-fast-syntax-highlighting, zsh-autosuggestions

_zsh_plugin_paths="${XDG_CONFIG_HOME:-$HOME/.config}/home-manager/zsh-plugin-paths.zsh"
[[ -f "$_zsh_plugin_paths" ]] && source "$_zsh_plugin_paths"
unset _zsh_plugin_paths

# Before compinit (called from autoload.zsh).
zsh_plugins_setup_completions() {
  [[ -n ${ZSH_COMPLETIONS_DIR:-} ]] && fpath=(${ZSH_COMPLETIONS_DIR} $fpath)
}

# After 256colorlib + url-quote-magic (first precmd).
zsh_plugins_load_deferred() {
  add-zsh-hook -d precmd zsh_plugins_load_deferred

  if (( $+functions[zicompinit] )); then
    ZINIT[COMPINIT_OPTS]=-C
    zicompinit
    zicdreplay
  fi

  if [[ -n ${ZSH_FSH_DIR:-} ]]; then
    typeset -g ZERO="${ZSH_FSH_DIR}/fast-syntax-highlighting.plugin.zsh"
    fpath=(${ZSH_FSH_DIR} $fpath)
    source "${ZSH_FSH_DIR}/fast-syntax-highlighting.plugin.zsh"
  fi

  [[ -n ${ZSH_AUTOSUGGESTIONS:-} ]] && source "${ZSH_AUTOSUGGESTIONS}"
}

add-zsh-hook precmd zsh_plugins_load_deferred
