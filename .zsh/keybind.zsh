## Keybind configuration {{{
# $ bindkey で現在の割り当てを確認

bindkey -e                      # emacs like keybind
bindkey "^[[1~" beginning-of-line # Home gets to line head
bindkey "^[[4~" end-of-line     # End gets to line end
bindkey "^[[3~" delete-char     # fn + delete の有効
bindkey '^D' delete-char        # delete
bindkey '^T' backward-delete-char # Backspace
bindkey '^U' backward-kill-line # カーソル位置から後方全削除 override kill-whole-line
bindkey '^Y' kill-line          # カーソル位置から前方全削除
# 単語移動
bindkey "^F" forward-word
bindkey "^B" backward-word
bindkey "^W" backward-kill-word # 後方単語削除
bindkey "^C" send-break         # コマンド入力を実行せずに無視して次の行へ
#bindkey "^Q" clear-screen      # クリアスクリーン screenのエスケープとかぶるので割り当てなし
bindkey -r "^O"

# コマンド履歴 ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

# glob(*)によるインクリメンタルサーチ <http://subtech.g.hatena.ne.jp/secondlife/20110222/1298354852>
#bindkey "^R" history-incremental-pattern-search-backward
#bindkey "^S" history-incremental-pattern-search-forward

# reverse menu completion binded to Shift-Tab
#
bindkey "\e[Z" reverse-menu-complete

# ^でcd ..する
# http://shakenbu.org/yanagi/d/?date=20120301
cdup() {
    if [ -z "$BUFFER" ]; then
        echo
        cd ..
        if type precmd > /dev/null 2>&1; then
            precmd
        fi
        local precmd_func
        for precmd_func in $precmd_functions; do
            $precmd_func
        done
        zle reset-prompt
    else
        zle self-insert '^'
    fi
}
zle -N cdup
bindkey '\^' cdup

# 表示されているコマンドをクリップボードへ
#  http://d.hatena.ne.jp/hiboma/20120315/1331821642
pbcopy-buffer(){
    # -r エスケープシーケンスを解釈しない
    # -n 最後に改行を入力しない
    print -rn $BUFFER | pbcopy
    zle -M "pbcopy: ${BUFFER}"
}
zle -N pbcopy-buffer
bindkey '^x^p' pbcopy-buffer

# }}}