# Sourced from programs.zsh.envExtra after env.sh.
# zsh-only path/fpath hygiene (not suitable for plain sh).

typeset -U path PATH
typeset -U fpath

unset SUDO_PATH
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({/usr/local,/usr,}/sbin(N-/))
export SUDO_PATH

typeset -U cdpath
cdpath=($HOME{,/links}(N-/))
