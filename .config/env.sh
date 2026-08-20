# shellcheck shell=sh
# Session environment. Sourced from programs.zsh.envExtra (and .profile).

# XDG
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state

export LANG=ja_JP.UTF-8

# Editor / pager
if command -v nvim >/dev/null 2>&1; then
  export EDITOR=nvim
else
  export EDITOR=vim
fi
export PAGER=less
export GIT_EDITOR="$EDITOR"
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc

# Less
if [ ! -d "$XDG_CONFIG_HOME"/less ]; then
  mkdir -m 700 "$XDG_CONFIG_HOME"/less
fi
if [ ! -d "$XDG_CACHE_HOME"/less ]; then
  mkdir -m 700 "$XDG_CACHE_HOME"/less
fi
export LESS='-fiMRfFx4X'
export LESSCHARSET='utf-8'
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
LESS_TERMCAP_mb=$(printf "\e[01;31m")
LESS_TERMCAP_md=$(printf "\e[01;31m")
LESS_TERMCAP_me=$(printf "\e[0m")
LESS_TERMCAP_se=$(printf "\e[0m")
LESS_TERMCAP_so=$(printf "\e[00;44;37m")
LESS_TERMCAP_ue=$(printf "\e[0m")
LESS_TERMCAP_us=$(printf "\e[01;32m")
export LESS_TERMCAP_mb LESS_TERMCAP_md LESS_TERMCAP_me
export LESS_TERMCAP_se LESS_TERMCAP_so LESS_TERMCAP_ue LESS_TERMCAP_us

# fzf defaults: programs.fzf in home.nix (FZF_DEFAULT_* via hm-session-vars)

# Tool config dirs (only when the CLI exists)
if command -v docker >/dev/null 2>&1; then
  export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
fi
if command -v aws >/dev/null 2>&1; then
  export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
  export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
fi

# Language toolchains — append to PATH
export GOPATH="$XDG_DATA_HOME"/go
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node/history
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export TS_NODE_HISTORY="$XDG_DATA_HOME"/ts-node/history
export PATH="$PATH:$GOPATH/bin:$XDG_DATA_HOME/npm/bin"

# User / repo bins — prepend (only if present)
if [ -d "$HOME"/.opencode/bin ]; then
  export PATH="$HOME"/.opencode/bin:"$PATH"
fi
export PATH="$HOME/.local/bin:$HOME/dotfiles/bin:$PATH"

# Homebrew — append so ~/.nix-profile/bin wins for duplicate CLIs
USER_LOCAL=/usr/local
if [ -x /opt/homebrew/bin/brew ]; then
  USER_LOCAL=/opt/homebrew
elif command -v brew >/dev/null 2>&1; then
  USER_LOCAL=$(brew --prefix)
fi
export USER_LOCAL
export PATH="$PATH:$USER_LOCAL/bin:$USER_LOCAL/sbin:$USER_LOCAL/opt/coreutils/libexec/gnubin"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

if [ -f "$USER_LOCAL"/etc/brew-wrap ]; then
  # shellcheck source=/dev/null
  . "$USER_LOCAL"/etc/brew-wrap
fi
if hostname | grep -q "Mac-mini\.local$"; then
  export HOMEBREW_BREWFILE="$XDG_CONFIG_HOME"/brewfile/Brewfile
elif hostname | grep -q "iMac\.local$"; then
  export HOMEBREW_BREWFILE="$XDG_CONFIG_HOME"/brewfile/Brewfile
elif hostname | grep -q "MacBook-Pro\.local$"; then
  export HOMEBREW_BREWFILE="$XDG_CONFIG_HOME"/brewfile/Brewfile.MBP
else
  export HOMEBREW_BREWFILE="$XDG_CONFIG_HOME"/brewfile/Brewfile.MBP
fi
export HOMEBREW_BREWFILE_APPSTORE=1

# iTerm2 (integration sourced from programs.zsh.initContent)
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES
export ITERM2_SQUELCH_MARK=1

# Wakatime / notifier
if [ ! -d "$XDG_CONFIG_HOME"/wakatime ]; then
  mkdir -m 700 "$XDG_CONFIG_HOME"/wakatime
fi
export WAKATIME_HOME="$XDG_CONFIG_HOME"/wakatime
if command -v wakatime-cli >/dev/null 2>&1; then
  export ZSH_WAKATIME_BIN="$(command -v wakatime-cli)"
fi
if command -v terminal-notifier >/dev/null 2>&1; then
  export SYS_NOTIFIER="$(command -v terminal-notifier)"
fi

if [ -d /Applications/Obsidian.app/Contents/MacOS ]; then
  export PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"
fi

export DOWNLOAD_DIR="$HOME"/Downloads

# WSL
if [ -n "${WSL_INTEROP:-}" ] && [ -f "$XDG_CONFIG_HOME"/wsl/env.sh ]; then
  # shellcheck source=/dev/null
  . "$XDG_CONFIG_HOME"/wsl/env.sh
fi
