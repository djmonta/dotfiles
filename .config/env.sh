# shellcheck shell=sh
# zmodload zsh/zprof && zprof

# XDG Base Directory
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state

# Editor, pager, less, git editor, wakatime, notifier, download dir: home.sessionVariables in home.nix

# Less / wakatime dirs (mkdir until home.activation covers them)
if [ ! -d "$XDG_CONFIG_HOME"/less ]; then
  mkdir -m 700 "$XDG_CONFIG_HOME"/less
fi
if [ ! -d "$XDG_CACHE_HOME"/less ]; then
  mkdir -m 700 "$XDG_CACHE_HOME"/less
fi
if [ ! -d "$XDG_CONFIG_HOME"/wakatime ]; then
  mkdir -m 700 "$XDG_CONFIG_HOME"/wakatime
fi

# Readline path is set in home.sessionVariables; keep file reference for non-HM shells.
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc

# Git pager: programs.git.delta in home.nix

# fzf defaults live in home.nix (programs.fzf).

# Docker
if command -v docker >/dev/null 2>&1; then
  export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
fi

# AWS CLI
if command -v aws >/dev/null 2>&1; then
  export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
  export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
fi

# Redis
export REDISCLI_HISTFILE="$XDG_DATA_HOME"/redis/rediscli_history
export REDISCLI_RCFILE="$XDG_CONFIG_HOME"/redis/redisclirc

# Rust
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export PATH="$PATH":"$CARGO_HOME"/bin

# Go
export GOPATH="$XDG_DATA_HOME"/go
export PATH="$PATH":"$GOPATH"/bin

# JavaScript / TypeScript
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node/history
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export TS_NODE_HISTORY="$XDG_DATA_HOME"/ts-node/history
export PATH="$PATH":"$XDG_DATA_HOME"/npm/bin

# opencode
export PATH="$HOME"/.opencode/bin:"$PATH"

# Hermes Agent — ensure ~/.local/bin is on PATH
export PATH="$HOME/.local/bin:$PATH"

# export DENO_INSTALL_ROOT="$XDG_DATA_HOME"/deno
# if [ ! -d "$DENO_INSTALL_ROOT" ]; then
#   mkdir -m 700 "$DENO_INSTALL_ROOT"
# fi
# export PATH="$PATH":"$DENO_INSTALL_ROOT"/bin

# export VOLTA_HOME="$XDG_DATA_HOME"/volta
# export PATH="$PATH":"$VOLTA_HOME"/bin

# Wasmtime
# export WASMTIME_HOME="$XDG_DATA_HOME"/wasmtime
# export PATH="$PATH":"$WASMTIME_HOME"/bin

# Wasmer
# export WASMER_DIR="$XDG_DATA_HOME"/wasmer
# export WASMER_CACHE_DIR="$XDG_CACHE_HOME"/wasmer
# export PATH="$PATH:$WASMER_DIR/bin:$WASMER_DIR/globals/wapm_packages/.bin"

USER_LOCAL=/usr/local
if command -v brew > /dev/null 2>&1; then
    USER_LOCAL=$(brew --prefix)
fi
export USER_LOCAL

# PHP
# export PATH="$USER_LOCAL"/opt/php@8.2/bin:"$USER_LOCAL"/opt/php@8.2/sbin:"$PATH"

# Homebrew
export PATH="$USER_LOCAL"/bin:"$USER_LOCAL"/sbin:"$USER_LOCAL"/opt/coreutils/libexec/gnubin:"$PATH"

# HOMEBREW CASK
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# BREW-FILE
if [ -f "$USER_LOCAL"/etc/brew-wrap ];then
  source "$USER_LOCAL"/etc/brew-wrap
fi
if hostname | grep -q "Mac-mini\.local$" ; then
	export HOMEBREW_BREWFILE="$XDG_CONFIG_HOME"/brewfile/Brewfile
elif hostname | grep -q "iMac\.local$" ; then
	export HOMEBREW_BREWFILE="$XDG_CONFIG_HOME"/brewfile/Brewfile
elif hostname | grep -q "MacBook-Pro\.local$" ; then
	export HOMEBREW_BREWFILE="$XDG_CONFIG_HOME"/brewfile/Brewfile.MBP
else
	export HOMEBREW_BREWFILE="$XDG_CONFIG_HOME"/brewfile/Brewfile.MBA
fi
export HOMEBREW_BREWFILE_APPSTORE=1

# iTerm
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES

# Obsidian
export PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"

# wsl
if [ -n "${WSL_INTEROP:-}" ]; then
  if [ -f "$XDG_CONFIG_HOME"/wsl/env.sh ]; then
    # shellcheck source=windows/wsl/.config/wsl/env.sh
    . "$XDG_CONFIG_HOME"/wsl/env.sh
  fi
fi
