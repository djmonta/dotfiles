#!/bin/bash

set -u

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

setup_osx() {
    [ $(uname -s) != 'Darwin' ] && return

    # Show the ~/Library folder
    chflags nohidden ${HOME}/Library/

    # Mute system audio
    # sudo nvram SystemAudioVolume=%80

    # Setup Homebrew
    confirm_exe 'Homebrewの設定を行いますか？' && ${HOME}/dotfiles/etc/osx/setup_brew.sh
}

create_dotfiles() {
    (
        if [ ! -e ${HOME}/dotfiles ]; then
            cd ${HOME}/
            git clone https://github.com/djmonta/dotfiles.git
        fi
        cd ${HOME}/dotfiles
        git submodule update --init
        [ $? -ne 0 ] && return 1
        git submodule foreach "git checkout master"
    )
}

create_symlink() {
  if [ -e "$2" ]; then
    echo "既にファイルが存在します: $file"
  else
    ln -s "$1" "$2"
    echo "シンボリックリンクを作成しました: $file"
  fi
}

create_dotfiles_symlinks() {
    ## 各種シンボリックリンク作成
    #
    DOT_FILES=(.bash_profile
        .bashrc
        # .config
        .emacs.d
        .gitconfig
        # .gittemplate
        # .gitk
        # .gvimrc
        # .inputrc
        # .ipython
        # .lv
        # .m2
        # .my.cnf
        # .pythonstartup
        # .screenrc
        # .subversion
        .tmux
        .tmux.conf
        # .vim
        # .vimrc
        .zsh)

    for file in ${DOT_FILES[@]}; do
        create_symlink "${HOME}/dotfiles/$file" "${HOME}/$file"
    done

    # For Mac
    if [ $(uname -s) = 'Darwin' ]; then
        ln -s "${HOME}/dotfiles/.MacOSX" "$HOME/.MacOSX"
    fi

    # .zshenv
    ln -s "${HOME}/.zsh/.zshenv" "${HOME}/.zshenv"

    # .gitignore
    ln -s "${HOME}/dotfiles/.gitignore.default" "${HOME}/.gitignore"

    # .dir_colors
    ln -s "${HOME}/dotfiles/Cellar/dircolors-solarized/dircolors.ansi-universal" "${HOME}/.dir_colors"

    # links
    if [ -d "${HOME}/dotfiles.local/links" ]; then
        ln -s "${HOME}/dotfiles.local/links" "${HOME}/links"
    fi
}


## Main --------------------

# Macの設定
#setup_osx

# dotfilesを作成
confirm_exe 'dotfilesを作成しますか？' && create_dotfiles

# シンボリックリンク作成
confirm_exe 'シンボリックリンクを作成しますか？' && create_dotfiles_symlinks

## complete message
echo 'Setup completed!'
