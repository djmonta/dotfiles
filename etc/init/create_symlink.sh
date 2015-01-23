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
        # .ackrc
        # .agignore
        .bash_profile
        .bashrc
        # .config
        .emacs.d
        .gitconfig
        # .gittemplates
        # .gitk
        # .gvimrc
        # .inputrc
        # .ipython
        # .lv
        # .m2
        # .my.cnf
        # .percol.d
        # .pythonstartup
        .screenrc
        .subversion
        .tmux
        .tmux.conf
        # .vim
        # .vimrc
        .zsh
        .zshenv)

    (
        cd "$HOME"

        for file in ${DOT_FILES[@]}; do
            create_symlink "$HOME/dotfiles/$file" "$HOME/$file"
        done

        # .gitignore
        create_symlink "$HOME/dotfiles/.gitignore.default" "$HOME/.gitignore"

        # .dir_colors
        create_symlink "$HOME/dotfiles/Cellar/dircolors-solarized/dircolors.256dark" "$HOME/.dir_colors"

        # links
        create_symlink "$HOME/dotfiles.local/links" "$HOME/links"

        # .tmux-powerlinerc
        create_symlink "$HOME/dotfiles/.tmux/.tmux-powerlinerc.default" "$HOME/.tmux-powerlinerc"
    )
}


## Main --------------------

# シンボリックリンク作成
confirm_exe 'シンボリックリンクを作成しますか？' && create_dotfiles_symlinks

## complete message
echo 'Setup completed!'
