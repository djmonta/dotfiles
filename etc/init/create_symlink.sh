#!/bin/bash

set -u

set_envs() {
    export XDG_CONFIG_HOME="${HOME}/.config"
    export XDG_CACHE_HOME="${HOME}/.cache"
    export XDG_DATA_HOME="${HOME}/.local/share"
    export XDG_STATE_HOME="${HOME}/.local/state"
    DOTDIR="$(cd "$(dirname "$0")" && pwd)"
}

create_xdg_base_directory_if_needed() {
    mkdir -p "$1"
    chmod 700 "$1"
}

create_xdg_base_directories_if_needed() {
    create_xdg_base_directory_if_needed "${HOME}/.config"
    create_xdg_base_directory_if_needed "${HOME}/.cache"
    create_xdg_base_directory_if_needed "${HOME}/.local"
    create_xdg_base_directory_if_needed "${HOME}/.local/share"
    create_xdg_base_directory_if_needed "${HOME}/.local/state"
    create_xdg_base_directory_if_needed "${HOME}/.local/bin"
}

# 実行確認
confirm_exe() {
    echo -n "$1 (y/n) --> "
    read yn
    case $yn in
        y|Y)
            echo '実行します...'
            return 0
            ;;
        *)
            echo '中止しました'
            return 1
            ;;
    esac
}

create_symlink() {
  if [ ! -e "$1" ]; then
    echo "リンク先が存在しません: $1"
  elif [ -e "$2" ]; then
    echo "同名のファイルが既に存在します: $2"
  else
    ln -s "$1" "$2"
    echo "シンボリックリンクを作成しました: $2 -> $1"
  fi
}

create_dotfiles_symlinks() {
    ## 各種シンボリックリンク作成
    #
    DOT_FILES=(
        .bash_profile
        .bashrc
        .gitconfig
        .gittemplate
        .profile
        .vimrc
        .zshenv
        .config/env.sh
        .config/alias.sh
        .config/zsh
        .config/brewfile
        .config/nvim)

    (
        cd "$HOME"

        for file in ${DOT_FILES[@]}; do
            create_symlink "$HOME/dotfiles/$file" "$HOME/$file"
        done

        # .gitignore
        create_symlink "$HOME/dotfiles/.gitignore.default" "$HOME/.gitignore"

        # links
        #create_symlink "$HOME/dotfiles.local/links" "$HOME/links"
    )
}


## Main --------------------
create_xdg_base_directories_if_needed
set_envs

# シンボリックリンク作成
confirm_exe 'シンボリックリンクを作成しますか？' && create_dotfiles_symlinks

## complete message
echo 'Setup completed!'
