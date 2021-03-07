#*******************************************************************************
#
#  .profile
#
#    環境変数などの設定(OS共通, bash/zsh共通)
#
#*******************************************************************************

#
# LANG
#
export LANG=ja_JP.UTF-8
# case ${UID} in
#     0)
#         # rootユーザの場合
#         # http://news.mynavi.jp/column/zsh/024/index.html
#         LANG=C
#         ;;
# esac


case "${TERM}" in
    xterm*|screen*)
        ;;
esac

#
# history setting
#
HISTSIZE=10000              # ヒストリに保存するコマンド(メモリ)
HISTFILESIZE=100000         # ヒストリに保存するコマンド(ファイル)
HISTCONTROL=ignoredups      # 入力が最後のヒストリと一致する場合は記録しない
HISTTIMEFORMAT='%Y-%m-%d %T '
export HISTSIZE HISTFILESIZE HISTCONTROL HISTTIMEFORMAT


#
# PAGER
#
export PAGER=less

# lessのデフォルトオプションを設定
#  -F or --quit-if-one-screen  1画面で表示できる場合はそのままコマンド終了
#  -R ANCIエスケープシーケンスを解釈(主にカラー表示を有効に)
#  -X, --no-init 終了後に画面をクリアしない
#  -i, --ignore-case 検索時に大文字小文字を区別しない
#  -xn, --tabs=n タブストップをn文字に
#  --LONG-PROMPT プロンプトを詳細表示に
#  -P プロンプトのフォーマットを変更
#export LESS='-R -X -i -x4 -P ?f%f:(stdin).  ?lb%lb?L/%L..  [?eEOF:?pb%pb\%..]'
# export LESS='-R -X -i -x4 --LONG-PROMPT'

#export JLESSCHARSET=utf-8
# export JLESSCHARSET=japanese-utf-8
# export LESSCHARSET=utf-8
#export GIT_PAGER="lv -c -l"
export GIT_PAGER="less -F"

#
# grep
#
# オプション
#  -i 大文字小文字を区別しない
#  -n 各行の先頭にファイルの行番号を表示します
#  -H ファイル名を表示
#  -E オプションは、拡張正規表現を使用する場合に指定
#     fgrep 正規表現を使わない検索
#     egrep 正規表現を使った検索 -E と同じ
#  -R, -r, --recursive ディレクトリを再帰的にたどる
#  -I バイナリ検索除外
#  -w 単語マッチ
#  --color=[WHEN]
#     always: パイプ使用時に強制的にカラーコードをつける
#     auto : 出力先に応じて判断 - パイプ時などはカラーコードをつけない
#     never : カラーコードOFF
#  --directories=skip ディレクトリを無視
#
# GREP_OPTIONS
#   他コマンドで使用しているgrepにも影響が出るため注意
# GREP_OPTIONS="-I --directories=skip --color=auto"
# export GREP_OPTIONS

# 検索ワードを色付け
#    1:bold
#   37:フォアグランドを白
#   41:バックグラウンドを赤
export GREP_COLOR='1;37;41'


#
# BLOCKSIZE
#  df・du コマンドなどが参照するブロックサイズ(デフォルト512バイト)
#  k: 1キロバイト単位
#
export BLOCKSIZE=k


#
# tree
#  文字コード、ロケールを設定
export TREE_CHARSET='UTF-8'
export LC_CTYPE='ja_JP.UTF-8'


#
# DropBox
#
export DROPBOX=${HOME}/Dropbox

#
# Emacs Term Configuration
#
if [ "$EMACS" ];then
  export TERM=xterm-256color
fi

#
# Github GPG
#
# In order for gpg to find gpg-agent, gpg-agent must be running, and there must be an env
# variable pointing GPG to the gpg-agent socket. This little script, which must be sourced
# in your shell's init script (ie, .bash_profile, .zshrc, whatever), will either start
# gpg-agent or set up the GPG_AGENT_INFO variable if it's already running.

# Add the following to your shell init to set up gpg-agent automatically for every shell
# if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
    # source ~/.gnupg/.gpg-agent-info
    # export GPG_AGENT_INFO
# else
    # eval $(gpg-agent --daemon)
# fi

### Complete Messages
# echo "Loading .profile completed!!"
