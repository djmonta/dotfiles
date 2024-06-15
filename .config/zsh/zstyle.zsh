# sudo時の補完対象の設定
zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH"

# 補完候補がない場合の曖昧検索
#  m:{a-z}={A-Z}: 大文字小文字無視
#  r:|[._-]=*: 「.」「_」「-」の前にワイルドカード「*」があるものとして補完
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'

# 補完候補を矢印キーで選択
#  select=n: 補完候補がn以上なければすぐに補完
zstyle ':completion:*:default' menu select=1

# 詳細な情報を使う。
zstyle ':completion:*' verbose true

## cd
# カレントディレクトリに候補がない場合のみ cdpath 上のディレクトリを候補にする
zstyle ':completion:*:cd:*' tag-order local-directories path-directories
# 親ディレクトリから補完時にカレントディレクトリ表示しない (e.g. cd ../<TAB>):
zstyle ':completion:*:cd:*' ignore-parents parent pwd ..

# 補完方法毎にグループ化し、グループ名に説明を付加
#  %F...%f : カラー
#  %B...%b : 太字
#  %U...%u : 下線
#  %d      : 補完候補の説明(ラベル)
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%B%d:%b'
zstyle ':completion:*:options' description 'yes'

# manのセクション番号を表示
zstyle ':completion:*:manuals' separate-sections true

# 補完方法の設定:指定した順番に実行
#  _oldlist 前回の補完結果を再利用
#  _complete: 補完
#  _match: globを展開しないで候補の一覧から補完
#  _history: ヒストリのコマンドから補完
#  _ignored: 補完候補にださないと指定したものもから補完
#  _approximate: 似ている候補を補完
#  _correct: 綴り修正(入力を終えた部分のみ修正)
#  _prefix: カーソル以降を無視してカーソル位置までで補完
#  _list, expand, etc
zstyle ':completion:*' completer \
    _oldlist _complete _match _history _ignored _approximate _prefix

## 補完キャッシュの設定
# 一部のコマンドライン定義は、展開時に時間のかかる処理を行う
# apt-get, dpkg (Debian), rpm (Redhat), urpmi (Mandrake), perlの-Mオプション,
# bogofilter (zsh 4.2.1以降), fink, mac_apps (MacOS X)(zsh 4.2.2以降)
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/compdump

## 補完候補の色分け
if [ -n "$LS_COLORS" ]; then
    # LS_COLORSの色と対応
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

# notification
zstyle ':notify:*' command-complete-timeout 10
zstyle ':notify:*' activate-terminal yes
zstyle ':notify:*' always-notify-on-failure yes
zstyle ':notify:*' error-title "Failed"
zstyle ':notify:*' error-icon "${ZDOTDIR}/themes/icon-error.png"
zstyle ':notify:*' error-sound "Funk"
zstyle ':notify:*' success-title "Success"
zstyle ':notify:*' success-icon "${ZDOTDIR}/themes/icon-success.png"
zstyle ':notify:*' success-sound "Glass"

## anyframe
zstyle ":anyframe:selector:" command "fzf --ansi"