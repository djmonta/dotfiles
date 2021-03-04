# Last Modified: 2018-03-11 22:42:44
### Introduction {{{
#
#  .zshrc
#
#  (in $ZDOTDIR : default $HOME)
#
#  initial setup file for only interective zsh
#  This file is read after .zprofile file is read.
#
#   zshマニュアル(日本語)
#    http://www.ayu.ics.keio.ac.jp/~mukai/translate/zshoptions.html
#
#   autoload
#    -U : ファイルロード中にaliasを展開しない(予期せぬaliasの書き換えを防止)
#    -z : 関数をzsh-styleで読み込む
#
#   typeset
#    -U 重複パスを登録しない
#    -x exportも同時に行う
#    -T 環境変数へ紐付け
#
#   path=xxxx(N-/)
#     (N-/): 存在しないディレクトリは登録しない。
#     パス(...): ...という条件にマッチするパスのみ残す。
#        N: NULL_GLOBオプションを設定。
#           globがマッチしなかったり存在しないパスを無視する
#        -: シンボリックリンク先のパスを評価
#        /: ディレクトリのみ残す
#        .: 通常のファイルのみ残す
#
#************************************************************************** }}}


## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8
# case ${UID} in
# 0)
#    LANG=C
#    ;;
# esac


## Default shell configuration

### The prompt settings {{{
#

# Theme.
# ZSH_THEME='monta'
DEFAULT_USER='monta'
DIRCOLORS_SOLARIZED_ZSH_THEME='256dark'

# Remove any right prompt from display when accepting a command line.
# This may be useful with terminals with other cut/paste methods.
#setopt transient_rprompt

# Certain escape sequences may be recognised in the prompt string.
# e.g. Environmental variables $WINDOW
setopt prompt_subst

# Certain escape sequences that start with `%' are expanded.
#setopt prompt_percent

# Initialize colors.
# Could use `$fg[red]' to get the code for foreground color red.
autoload -Uz colors
colors

# hook
#  http://d.hatena.ne.jp/kiririmode/20120327/p1
autoload -Uz add-zsh-hook

## prompt theme {{{
# if [ ${TERM} != dumb ]; then
#    if [ -f ${HOME}/.zsh/themes/"$ZSH_THEME".zsh-theme ]; then
#         echo "Loading theme: $ZSH_THEME"
#         source ${HOME}/.zsh/themes/"$ZSH_THEME".zsh-theme
#     else
#         echo "Error: could not load the theme '$ZSH_THEME'"
#     fi
# fi

## tmux prompt
# PROMPT+='$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

## iterm2
source ${ZDOTDIR}/iterm2_shell_integration.zsh

autoload -Uz promptinit
promptinit
zstyle :prompt:pure:path color 032 #bright blue
# zstyle :prompt:pure:prompt:success color 227 #light yellow
source ${HOME}/dotfiles/bin/256colorlib.sh
# Correct prompt
SPROMPT="${COLOR_FG_CC4422}もしかして: %r [y,n,a,e] ->%{${reset_color}%} "
CORRECTION='${COLOR_FG_D70000}もしかして: '
CORRECTION+='${COLOR_FG_0087FF}${STYLE_LINE}%r%{${reset_color}%}'
CORRECTION+=' [y,n,a,e] -> '
SPROMPT=$CORRECTION

# }}}

### Default shell configuration {{{
#

limit coredumpsize 0        # core抑制
umask 022                   # 新しく作られたファイルのパーミッションを 644 に
setopt auto_cd              # 指定したコマンド名がなく、ディレクトリ名と一致した場合 cd する
setopt auto_pushd           # cd - <tab>で履歴表示->表示された番号を押してReturn
setopt pushd_ignore_dups    # ディレクトリスタックに同じディレクトリを追加しないようになる
setopt pushd_to_home        # pushd 引数ナシ == pushd $HOME
setopt correct              # コマンドのスペルチェックをする
setopt correct_all          # コマンドライン全てのスペルチェックをする
setopt no_clobber           # 上書きリダイレクトの禁止
setopt brace_ccl            # {a-c} を a b c に展開する機能を使えるようにする
setopt print_eight_bit      # 8ビットクリーン表示 補完候補リストの日本語表示対応
#setopt auto_name_dirs      # "~$var" でディレクトリにアクセス
#setopt cdable_vars         # 先頭に "~" を付けたもので展開
setopt sh_word_split        # 変数内の文字列分解のデリミタ
setopt list_packed          # compacked complete list display

# 複数のリダイレクトやパイプなど、必要に応じて tee や cat の機能が使われる
#  $ < file1  # cat
#  $ < file1 < file2  # 2ファイル同時cat
#  $ < file1 > file3  # file1をfile3へコピー
#  $ < file1 > file3 | cat  # コピーしつつ標準出力にも表示
#  $ cat file1 > file3 > /dev/stdin  # tee
setopt multios

setopt noautoremoveslash    # 最後がディレクトリ名で終わっている場合末尾の / を自動的に取り除かない
setopt no_beep              # beepを鳴らさない
setopt nolistbeep           # beepを鳴らさない
setopt equals               # =command を command のパス名に展開する
setopt no_flow_control      # Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt path_dirs            # コマンド名に / が含まれているとき PATH 中のサブディレクトリを探す
setopt print_exit_value     # 戻り値が 0 以外の場合終了コードを表示する
#setopt xtrace              # コマンドラインがどのように展開され実行されたかを表示するようになる
setopt rm_star_wait         # rm * 時に確認する
setopt notify               # バックグラウンドジョブが終了したら(プロンプトの表示を待たずに)すぐに知らせる
setopt long_list_jobs       # jobsでプロセスIDも出力
setopt auto_resume          # サスペンド中のプロセスと同じコマンド名を実行した場合はリジュームする
#setopt ignore_eof          # Ctrl+D では終了しないようになる（exit, logout などを使う）
REPORTTIME=3                # 実行したプロセスの消費時間が3秒以上かかったら自動的に消費時間の統計情報を表示

# *, ~, ^ の 3 文字を正規表現として扱う
# Match without pattern
#  ex. > rm *~398
#  remove * without a file "398". For test, use "echo *~398"
setopt extended_glob

setopt mark_dirs            # globでパスを生成したときに、パスがディレクトリだったら最後に「/」をつける。

# URLをコピペしたときに自動でエスケープ
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

setopt promptcr             # 改行のない出力をプロンプトで上書きするのを防ぐ
watch="all"                 # 全てのユーザのログイン・ログアウトを監視

typeset -U path PATH        # PATH環境変数の重複エントリを排除

## zsh editor {{{
# autoload zed
# }}}

## Keybind configuration {{{
# $ bindkey で現在の割り当てを確認
source ${HOME}/dotfiles/.zsh/keybind.zsh
# }}}

### History configuration {{{
#
HISTFILE=${HOME}/.zsh_history
HISTSIZE=1000   # メモリ内の履歴の数
SAVEHIST=10000  # 保存される履歴の数
LISTMAX=50       # 補完リストを尋ねる数(0=ウィンドウから溢れる時は尋ねる)
# rootのコマンドはヒストリに追加しない
if [ $UID = 0 ]; then
    unset HISTFILE
    SAVEHIST=0
fi
setopt hist_ignore_all_dups     # 登録済コマンド行は古い方を削除
setopt share_history            # historyの共有
setopt inc_append_history       # add history when command executed.
setopt hist_no_store            # history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_no_functions        # ヒストリから関数定義を取り除く
setopt extended_history         # zsh の開始・終了時刻をヒストリファイルに書き込む
setopt hist_ignore_space        # スペースで始まるコマンドはヒストリに追加しない
setopt append_history           # 履歴を追加 (毎回 .zhistory を作らない)
setopt hist_verify              # ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt bang_hist                # !を使ったヒストリ展開を行う

# }}}

### Completion configuration {{{
#
# 補完関数のパス(fpath)を登録
# (N-/): 存在しないディレクトリは登録しない
typeset -U fpath        # 重複パスを登録しない

# zsh-completions
#  https://github.com/zsh-users/zsh-completions.git
# fpath=(${HOME}/.zsh/functions/Completion/zsh-completions(N-/) ${fpath})

# homebrewでインストールしたコマンドの補完関数 /usr/local 配下
#  http://yonchu.hatenablog.com/entry/20120415/1334506855
fpath=(/usr/local/share/zsh/functions(N-/) /usr/local/share/zsh/site-functions(N-/) ${fpath})
if type brew >/dev/null 2>&1; then
    BREW_PREFIX=$(brew --prefix)
    fpath=($BREW_PREFIX/share/zsh/functions(N-/) $BREW_PREFIX/share/zsh/site-functions(N-/) ${fpath})
fi

# fzf completion
if [ -f ${HOME}/.zsh/.fzf.zsh ]; then
    source ${HOME}/.zsh/.fzf.zsh
fi

# ユーザ固有の補完関数
fpath=(${HOME}/.zsh/functions/Completion ${fpath})

source ${ZDOTDIR}/zinit.zsh

autoload -U compinit

# -u : 安全ではないファイルを補完しようとした場合に警告を表示しない
# -d : .zcompdumpの場所
compinit -u -d ${HOME}/.zcompdump

setopt list_packed          # 補完候補リストを詰めて表示
setopt list_types           # auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示
setopt auto_list            # 補完候補が複数ある時に、一覧表示する
#setopt menu_complete       # 一覧表示せずに、すぐに最初の候補を補完
setopt magic_equal_subst    # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt auto_param_keys      # カッコの対応などを自動的に補完する
setopt auto_param_slash     # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt chase_links          # 移動先がシンボリックリンクならば実際のディレクトリに移動する
#setopt chase_dots          # パスに..が含まれる場合実際のディレクトリに移動?
setopt auto_menu            # 補完キー（Tab,  Ctrl+I) を連打するだけで順に補完候補を自動で補完する
setopt complete_in_word     # カーソル位置で補完する。
setopt always_last_prompt   # プロンプトを保持したままファイル名一覧を順次その場で表示(default=on)
setopt glob_complete        # globを展開しないで候補の一覧から補完する。 Ctrl+x g glob展開
setopt hist_expand          # 補完時にヒストリを自動的に展開する。
setopt no_beep              # 補完候補がないときなどにビープ音を鳴らさない。
setopt numeric_glob_sort    # 辞書順ではなく数字順に並べる。
setopt auto_remove_slash    # 補完で末尾に補われた / をスペース挿入で自動的に削除


# sudo用pathを設定
# typeset -T は重複実行できないため一度環境変数を削除する
# (Reloadで失敗しないようにするため)
unset SUDO_PATH
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({/usr/local,/usr,}/sbin(N-/))
export SUDO_PATH
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
# 重複パスを登録しない
typeset -U cdpath
cdpath=($HOME{,/links}(N-/))

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
zstyle ':completion:*' cache-path ${HOME}/.zcompcache


## 補完候補の色分け
if [ -n "$LS_COLORS" ]; then
    # LS_COLORSの色と対応
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi


## Alias configuration {{{
#
# alias が補完される前に元のコマンドまで転回して✓チェック
setopt complete_aliases     # aliased ls needs if file/dir completions work

# }}}

#
# alias設定(共通)
#
if [ -f ${HOME}/dotfiles/.alias ]; then
    source ${HOME}/dotfiles/.alias
fi

#
# alias設定(zsh固有)
#
if [ -f ${HOME}/.zsh/.zalias ]; then
    source ${HOME}/.zsh/.zalias
fi

#
# local固有設定
#
# if [ -f ${HOME}/dotfiles.local/.shrc.local ]; then
#     source ${HOME}/dotfiles.local/.shrc.local
# fi

# }}}


# set terminal title including current directory
#
# case "${TERM}" in
# xterm*|screen*|kterm|kterm-color)
#     precmd() {
#         echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
#     }
#     ;;
# esac

# }}}

## load user .zshrc configuration file
#
# [ -f ${HOME}/.zshrc.mine ] && source ${HOME}/.zshrc.mine

## anyframe
zstyle ":anyframe:selector:" command "fzf --ansi"


## prompt
# prompt pure

### Complete Messages
# echo "Loading .zshrc completed!! (ZDOTDIR=${ZDOTDIR})"
# echo "Now zsh version $ZSH_VERSION starting!!"

# Print log
# log
# if (which zprof > /dev/null) ;then
#   zprof | less
# fi
