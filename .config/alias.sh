#*******************************************************************************
# Last Modified: 2015-10-26 22:39:26
# .alias
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
#*******************************************************************************

#
# 基本エイリアス ----------------------------------------------
#
alias where="command -v"
alias jl="jobs -l"

# Exit
alias cl='clear'
alias quit='exit';

#
# ls
#  Macではglsを使用
#
#  Common option
#    -l 詳細な情報の表示
#    -a 隠しファイルを表示
#    -h サイズをkB, MB, GBとかで表示
#    -d ディレクトリ自体の情報を表示
#    -t ファイルの変更日時でソート(古い順:最新が上にくる)
#    -r 逆順ソート
#    -F ファイルタイプを示す文字を表示
#        * 実行可能ファイル
#        / ディレクトリ
#        @ シンボリックリンク
#
#  Mac ls only
#    -G ls:カラー有効
#    -v 非印字文字を強制表示
#    -T タイムスタンプを年月日時分秒まで表示
#
#  GNU ls only
#    -G : グループを非表示。
#    -v : natural sort of (version) numbers within text (gls only)
#    --time-style=STYLE : タイムスタンプの表示スタイル (gls only)
#    --show-control-chars : Show non graphic characters as-is.
#    --width=COL : Assume screen width instead of current value.
#
case "${OSTYPE}" in
freebsd*|darwin*)
    if type gls > /dev/null 2>&1; then
        alias ls='gls -aFhv --color=auto --show-control-chars'
        alias ll='ls -l --time-style=long-iso'
    else
        alias ls='ls -aFGhv'
        alias ll='ls -lT'
    fi
    ;;
linux*)
    alias ls='ls -aFh --color=auto'
    alias ll='ls -l'
    ;;
esac

alias lld='ls -d'
alias llt='ll -rt'
alias lll='ll | less'

# source $(dirname $(gem which colorls))/tab_complete.sh
# alias lc='colorls -A'

#
# cd
#  -P シンボリックリンクをたどらず実ディレクトリに移動
#  -L シンボリックリンクをたどったディレクトリに移動
#
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cdp='cd -P'
alias cdl='cd -L'


#
# pwd
#  -P シンボリックリンクをたどらず実ディレクトリを表示
#  -L シンボリックリンクをたどったディレクトリを表示
alias pwd='pwd -P'


#
# df du
#
alias df='df -h'
alias du='du -h'
alias dus='du -s'


#
# mv rm cp
#  確認つきファイル操作
#  rm, mv, cp などのあぶない操作を確認つきにする
#
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -ir'

alias mvi='mv -i'
alias rmi='rm -i'
alias cpi='cp -ir'


#
# cp
#  -p コピー元の所有者、所有者・グループ・アクセス権・アクセス時刻などを維持
#  -a コピー元の所有者などの属性、パーミッション 、ディレクトリ構造、
#     シンボリックリンクなど、「コピー可能なファイルでコピー可能なものを、
#     可能な限りコピー元の情報をそのままるコピーする」-dpR と同じ
alias cpa='cp -a'


#
# grep
#  -i 大文字小文字を区別しない
#  -n 各行の先頭にファイルの行番号を表示します
#  -H ファイル名を表示
#  -E オプションは、拡張正規表現を使用する場合に指定
#     fgrep 正規表現を使わない検索
#     egrep 正規表現を使った検索 -E と同じ
#  -R, -r, --recursive ディレクトリを再帰的にたどる
#  -I バイナリ検索除外(--binary-files=without-match)
#  -w 単語マッチ
#  --color=[WHEN]
#     always: パイプ使用時に強制的にカラーコードをつける
#     auto : 出力先に応じて判断 - パイプ時などはカラーコードをつけない
#     never : カラーコードOFF
#  --directories=recurse grep対象にディレクトリを指定し場合再帰grep(ver2.5.4 or later)
#  -q, --quiet, --silent 通常の出力を抑止
#  -s, --no-messages ファイルが存在しないことや読み込みできないことを示すエラーメッセージを抑止
#
#  環境変数GREP_OPTIONSにデフォルトオプションを設定
#
#  e.g.
#   & grep -r searchword --include'*.txt' .
#
if grep --help 2> /dev/null | grep -q -- --exclude-dir; then
    # svn/gitディレクトリを無視
    alias grep='grep -niE --exclude-dir=.svn --exclude-dir=.git'
else
    alias grep='grep -niE'
fi
alias grepr='grep -R'


#
# find
#
#alias find=gfind
alias findbig='find . -type f -exec ls -s {} \; | sort -n -r | head -5'
alias findmod='find . -type f -mmin -10'

#  e.g.
#   find -name '*' -exec grep -n 'name' {} /dev/null ¥;
#   find . -name \*.c -print0 | xargs -0 grep hogehoge /dev/null
#   find . -name "*hoge" -type f | grep -v '\.svn' | xargs grep piyopiyo
#   find . -name \( -name "*.c" -o -name "*.cpp" -o -name "*.h" \) | xargs grep hoge
#
# xargs -0 :  空白と改行ではなくヌル文字 (``\0'') を区切りとするように xargs に指示
#             find(1) の -print0 とともに使用
# -print0   :  デリミタ文字 (シングルクォート 、ダブルクォート、バックスラッシュ 、
#              スペース、タブ、改行) が含まれるファイル名でも正常に動くHL
#
# ディレクトリ名やファイル名にスペースを含んでいる場合、 find と xargs を
# そのまま実行すると、スペースの前後で別々にxargsの引数として処理され、
# 正常に動作しない。
# そこで、スペースを区切り文字にするのではなく(null)を区切り文字にするとで
# 問題なく正常に動作できる


#
# history
#
alias h='history 32'
# 全履歴を表示
history_all() { history -E 1 | less; }


#
# chmod
#  644 rw-r--r--  ユーザ専用ファイル
#  755 rwxr-xr-x  ディレクトリ
#
alias 644='chmod 644'
alias 755='chmod 755'


#
# ps
#  a すべてのユーザを対象にする
#  u 実行したユーザを表示
#  x デーモンを表示
#  f fork(フォーク：分岐)-プロセスの親子関係を表示(Mac非対応)
#  w 表示幅をオーバしても改行して表示する
#
alias psa='ps auxw'


#
# top (for FreeBSD/Mac)
#  -o rsize メモリ使用量でソートして表示
#  -o cpu CPU使用率順に表示
#  -O time セカンダリソートを実行時間
#  -u "-o cpu -O time"と同じ
#  -R -F topコマンドの負荷軽減
#
alias topm='top -o rsize'
alias topc='top -R -F -u'


#
# diff
#  -r ディクレクトリの再帰検索
#  -t 入力ファイルでのタブによる位置あわせを保存するため、 出力のタブをスペースに展開
#  -b 空白・タブの数の違いを無視
#  -B 空行の有無を無視
#  -E タブ展開によるスペースの変更を無視する
#  -a テキストファイルとして比較
#  -q 差分があるかどうかだけを報告し詳細を報告しない
#  -u unified diff形式で出力
#
alias diff='diff -tbBE'
alias diffr='diff -rq'


#
# curl
#  -O ファイルはローカルに保存
#  -L リダイレクトを有効
#  --max-redirs=10 リダイレクト回数の上限(デフォルト:50) -Z <回数> と同様
#  -k 安全ではないSSLを許可
#  -f サーバーエラー時に何も出力しない(エラーページなどをDLしない) 代わりににエラー番号22を返す
#  -s プログレスメータやエラーメッセージを出力しない(silent)
#  -S -sと併用、失敗時にエラーメッセージを出力
#  -# プログレスバー表示(DL詳細は見えなくなる)
#  -v 詳細表示
#
alias cur='curl -OLv'

#
# rsync
#  -a 属性、タイムスタンプ等を保存
#  -v 情報の詳細表示
#  -z 転送時に圧縮
#  -u 更新
#
alias rsync='rsync -avzu'

#
# su
#
# -l, - ログイン・シェルを使用してユーザーを切り替える
alias su="su -l"

#
# Japanese env
#  ロケールに関する環境変数をすばやく切替えるためのエイリアス
#
alias utf='export LANG=ja_JP.UTF-8; export LANGUAGE=ja_JP.UTF-8; export LC_ALL=ja_JP.UTF-8'
alias en='export LANG=en; export LANGUAGE=en; export LC_ALL=en'

#
# エイリアス(その他) -----------------------------------------------------
#
#
# iptables
alias liptables='iptables -L -n --line-numbers'

# sudo スーパーユーザへ
alias ssu='sudo -s'

#
# PATH
#
# 改行区切りで表示
alias printpath='echo $PATH | tr ":" "\n"'
# 重複削除
alias organize_path='tr ":" "\n" | uniq | paste -d: -s -'


#
# lv
#
# -c カラー表示対応
# -l 行番号表示
alias lv='lv -cl'


#
# tree
#
# -N 日本語文字化け対応
# -a 隠しファイルも表示
# -I 例外設定(ワイルドカード)
alias tree="tree -N -a -I '.git|.svn'"


#
# ack
#  高機能検索(find + grep)
#  -a 全てのファイルから検索(拡張子無しも含む) ただし--TYPEが無効
#  -i 大文字小文字区別なし
#  --pager 結果を開くPAGER(less,vim)
#  --TYPE or --type=TYPE プログラミング言語に応じたタイプ指定
#      参照：$ ack --help-type
#  --nogroup 検索結果をファイルごとにグループ化しない
#  -f ファイル検索(find)
#  -w 単語検索
#  -G filter 検索対象のファイルパスを正規表現指定
#  -g filter ファイル検索(find)(正規表現)(-f -G に同じ)
#  -C n 一致した行の前後n行を表示
#  -B n 前n行を表示
#  -A n 後n行を表示
#  -l 一致したファイル名のみ出力
#  -L 一致していないファイル名を出力
#  -n 再帰検索しない
#  ※デフォルトオプション: ~/.ackrc
#   e.g.
#    $ ack 'pattern' -G .*\.txt
#    $ ack hoge -G "\.(c|cpp|h)$"
#
# alias acka='ack -a'
# alias ackn='ack -n'


#
# nkf
#  -g 文字コード判定
#  $$: シェル自身のプロセスID
#  >!: 強制上書き
#
# 文字コードを判定
alias nkfg='nkf -g'

#
# imgcat
#
alias imgcat='imgcat --iterm2'

#
# emacsclient
#
# alias emacsc="emacsclient -t -c"

### Complete Messages
# echo "Loading .alias completed!!"

