### Introduction {{{
#
# .zalias
#
#   zsh固有alias
#
#   現在設定されているaliasを調べる
#    $ alias [コマンド名]
#   typeコマンドでもaliasが表示される
#    $ type [-a] <コマンド名>
#   aliasを無効にして実行
#    $ \cmd
#   alias/シェル関数を無視して実行
#    $ command cmd
#   全てのシェル変数を表示
#    $ declare
#   関数の名前/定義を表示
#    $ declare -f <関数名>
#
########################################################################### }}}

### Basic aliases {{{
#
# 設定ファイルのリロード
alias reload='exec zsh -l'

# pushd/popd
alias pd="pushd"
alias po="popd"

# history時間表示
alias history="history -i"

# fpathを表示
alias printfpath='echo $fpath | tr " " "\n"'

# vc command completion
compdef _command vc

# }}}

### Global aliases {{{
#
# 標準出力を表示しない
alias -g NL='> /dev/null'
# 標準出力/標準エラー出力を表示しない
alias -g NLL='> /dev/null 2>&1'
# 標準出力を標準エラー出力へ
alias -g ER='1>&2'

alias -g G='| grep'
alias -g L='| $PAGER'
alias -g W='| wc'
alias -g H='| head'
alias -g T='| tail'
alias -g S='| sed'
alias -g V='| vim -R -'

# }}}

### Aliases according to extensions {{{
#
zsh_pager(){
    $(zsh_commandselector "${PAGER} lv less more cat") ${@+"$@"}
}

zsh_wevbbrowser(){
    $(zsh_commandselector "chrome firefox opera konqueror epiphany less") ${@+"$@"}
}

zsh_imageviewer(){
    $(zsh_commandselector "gthumb imageviewer gqview kview eog display") ${@+"$@"}
}

zsh_audioplayer() {
    $(zsh_commandselector "amarok audacious beep-media-player xmms2 xmms noatun") ${@+"$@"}
}

zsh_movieplayer() {
    $(zsh_commandselector "svlc gmplayer totem xine realplay") ${@+"$@"}
}

zsh_extracter() {
    $(zsh_commandselector "aunpack extract") ${@+"$@"}
}

zsh_commandselector() {
    for command in $(echo ${1}); do
        if type "${command}" > /dev/null 2>&1; then
            echo "${command}"
            break
        fi
    done
}

set_aliases_for_ext() {
    local target
    # Pagerで開く
    for target in java c h C cpp txt xml; do
        alias -s ${target}=zsh_pager
    done

    # ブラウザで開く
    for target in html xhtml; do
        alias -s ${target}=zsh_wevbbrowser
    done

    # 画像を開く
    for target in gif jpg jpeg png bmp; do
        alias -s ${target}=zsh_imageviewer
    done

    # 音楽ファイルを開く
    for target in mp3 m4a ogg; do
        alias -s ${target}=zsh_audioplayer
    done

    # 動画ファイルを開く
    for target in mpg mpeg avi mp4v; do
        alias -s ${target}=zsh_movieplayer
    done

    # アーカイブ解凍
    for target in gz tgz zip lzh bz2 tbz Z tar arj xz; do
        alias -s ${target}=zsh_extracter
    done
}
set_aliases_for_ext
# }}}

### Source configuration files {{{
#
# OS固有のalias設定
case "${OSTYPE}" in
    # Mac(Unix)
    darwin*)
    alias rm='trash -F'
    #alias rm='gomi'
    ;;
    # Linux
    linux*)
    #alias rm='rmtrash'
    #alias rm='gomi_linux_amd64'
    ;;
esac

# }}}


### Complete Messages
# echo "Loading .zalias completed!!"

