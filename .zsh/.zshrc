# Last Modified: 2013/01/15-20:47:57
# users generic .zshrc file for zsh(1)

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
ZSH_THEME='monta'
DEFAULT_USER='monta'

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


## Set prompt.
# if [ ${UID} -eq 0 ]; then
#     # Prompt for "root" user.
#     # Note: su - or sudo -s を行った場合は環境変数が引き継がれない
# #    PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') %B%{${fg[red]}%}%~#%{${reset_color}%}%b "
#     PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') %(!.%F{red}.%F{cyan})%n%f:%{$(pwd|([[ $EUID == 0 ]] && GREP_COLORS='mt=01;31' grep --color=always /|| GREP_COLORS='mt=01;34' grep --color=always /))%${#PWD}G%}%(!.%F{red}.)%#%f "
#     PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
#     SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
#     [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
#         PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
# #    PROMPT="$PROMPT"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
# else
# Prompt for "normal" user.
    # Loading theme
    if [ -f ${HOME}/.zsh/themes/"$ZSH_THEME".zsh-theme ]; then
        echo "Loading theme: $ZSH_THEME"
        source ${HOME}/.zsh/themes/"$ZSH_THEME".zsh-theme
    else
        echo "Error: could not load the theme '$ZSH_THEME'"
    fi
# fi

## Set prompt.
# if [ ${UID} -eq 0 ]; then
#     # Prompt for "root" user (all red characters).
#     # Note: su - or sudo -s を行った場合は環境変数が引き継がれない
#     PROMPT="${reset_color}${fg[red]}[%n@%m:%~]%#${reset_color} "
#     PROMPT2="${reset_color}${fg[red]}%_>${reset_color} "
#     SPROMPT="${reset_color}${fg[red]}%r is correct? [n,y,a,e]:${reset_color} "
# else
#     # Prompt for "normal" user.
#     # Loading theme
#     if [ -f ~/.zsh/themes/"$ZSH_THEME".zsh-theme ]; then
#         echo "Loading theme: $ZSH_THEME"
#         source ~/.zsh/themes/"$ZSH_THEME".zsh-theme
#     else
#         echo "Error: could not load the theme '$ZSH_THEME'"
#     fi
# fi

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

## zsh editor
#
#autoload zed

# }}}

### Keybind configuration {{{
# $ bindkey で現在の割り当てを確認
#
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
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward

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

### History configuration {{{
#
HISTFILE=${HOME}/.zsh_history
HISTSIZE=10000   # メモリ内の履歴の数
SAVEHIST=100000  # 保存される履歴の数
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
#
typeset -U fpath        # 重複パスを登録しない
#  zsh-completions
#   https://github.com/zsh-users/zsh-completions.git
fpath=(${HOME}/.zsh/functions/Completion/zsh-completions(N-/) ${fpath})
# homebrewでインストールしたコマンドの補完関数 http://yonchu.hatenablog.com/entry/20120415/1334506855
# /usr/local 配下
# (N-/): 存在しないディレクトリは登録しない。
fpath=(/usr/local/share/zsh/functions(N-/) /usr/local/share/zsh/site-functions(N-/) ${fpath}) 
if type brew >/dev/null 2>&1; then
    BREW_PREFIX=$(brew --prefix)
    fpath=($BREW_PREFIX/share/zsh/functions(N-/) $BREW_PREFIX/share/zsh/site-functions(N-/) ${fpath})
fi
# ユーザ固有の補完関数
fpath=(${HOME}/.zsh/functions/Completion ${fpath})

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

## cdr <TAB> (最近移動したディレクトリ履歴からcd)
autoload -U chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ":chpwd:*" recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file ${HOME}/.chpwd-recent-dirs
zstyle ":chpwd:*" recent-dirs-max 500
zstyle ":completion:*" recent-dirs-insert both
zstyle ":completion:*:*:cdr:*:*" menu select=2

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


## Prediction configuration
#   先方予測機能(学習機能付き)
#
#autoload -U predict-on
#predict-on


# }}}

## Prediction configuration
#
#autoload predict-on
#predict-off


## Alias configuration {{{
#
# alias が補完される前に元のコマンドまで転回して✓チェック
setopt complete_aliases     # aliased ls needs if file/dir completions work

# }}}


### Terminal configuration {{{
#
# ターミナル固有設定
case "${TERM}" in
    kterm*|xterm*|screen*)
        _change_terminal_title_preexec_hook() {
            if [ "$STY" ]; then
                # コマンド実行時にコマンド名をタイトルに設定(screen)
                echo -ne "\ek${1%% *}\e\\"
            fi
        }
        add-zsh-hook preexec _change_terminal_title_preexec_hook

        _change_terminal_title_precmd_hook() {
            if [ "$STY" ]; then
                echo -ne "\ek$(basename $(pwd))\e\\"
            else
                echo -ne "\033]0;$(basename $(pwd))\007"
            fi
            return 0
        }
        add-zsh-hook precmd _change_terminal_title_precmd_hook
        ;;
esac

# }}}


### Misc {{{
#
# Define action when change directory.
chpwd() {
    ls_abbrev
    # cdd
    type _cdd_chpwd >/dev/null 2>&1 && _cdd_chpwd
}
ls_abbrev() {
    # -a : Do not ignore entries starting with ..
    # -C : Force multi-column output.
    # -F : Append indicator (one of */=>@|) to entries.
    local cmd_ls='ls'
    local -a opt_ls
    opt_ls=('-aCF' '--color=always')
    case "${OSTYPE}" in
        freebsd*|darwin*)
            if type gls > /dev/null 2>&1; then
                cmd_ls='gls'
            else
                # -G : Enable colorized output.
                opt_ls=('-aCFG')
            fi
            ;;
    esac

    local ls_result
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

    if [ $ls_lines -gt 10 ]; then
        echo "$ls_result" | head -n 5
        echo '...'
        echo "$ls_result" | tail -n 5
        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
        echo "$ls_result"
    fi
}
# }}}


### Source configuration files {{{
#
# pluginの読み込み
#
if [ -d ~/.zsh/plugins ]; then
    for plugin in ~/.zsh/plugins/*.zsh; do
        if [ -f "$plugin" ]; then
            echo "Loading plugin: ${plugin##*/}"
            source "$plugin"
        fi
    done
fi


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
if [ -f ${HOME}/dotfiles.local/.shrc.local ]; then
    source ${HOME}/dotfiles.local/.shrc.local
fi

# }}}


# set terminal title including current directory
#
case "${TERM}" in
xterm*|screen*|kterm|kterm-color)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac

### Emacs automatically running {{{
#
#  ログイン時に Emacs Daemon を起動する
#

# if [ -x /Applications/Emacs.app/Contents/MacOS/Emacs ]; then
#      /Applications/Emacs.app/Contents/MacOS/Emacs -nw --daemon -q
# fi
if [ `emacs --version | grep 'Emacs 24' | wc -l` = 1 ]
then
   if [ `ps ux | grep emacs\ --daemon | wc -l` = 1 ]
   then
       `emacs --daemon -q`
   else
       echo 'Emacs daemon is already running.'
   fi
else
    echo 'Can not run the daemon in this version of Emacs'
fi

# }}}

## load user .zshrc configuration file
#
[ -f ${HOME}/.zshrc.mine ] && source ${HOME}/.zshrc.mine

##
# pcolor
function pcolor() {
    for ((f = 0; f < 255; f++)); do
        printf "\e[38;5;%dm %3d#\e[m" $f $f
        if [[ $f%8 -eq 7 ]] then
            printf "\n"
        fi
    done
    echo
}


### Complete Messages
echo "Loading .zshrc completed!! (ZDOTDIR=${ZDOTDIR})"
echo "Now zsh version $ZSH_VERSION starting!!"

# Print log
log
