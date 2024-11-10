# Remove any right prompt from display when accepting a command line.
# This may be useful with terminals with other cut/paste methods.
#setopt transient_rprompt

# Certain escape sequences may be recognised in the prompt string.
# e.g. Environmental variables $WINDOW
setopt prompt_subst

# Certain escape sequences that start with `%' are expanded.
#setopt prompt_percent

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

setopt promptcr             # 改行のない出力をプロンプトで上書きするのを防ぐ
watch="all"                 # 全てのユーザのログイン・ログアウトを監視

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
setopt numeric_glob_sort    # 辞書順ではなく数字順に並べる。
setopt auto_remove_slash    # 補完で末尾に補われた / をスペース挿入で自動的に削除

# }}}

## Alias configuration {{{
#
# alias が補完される前に元のコマンドまで転回して✓チェック
setopt complete_aliases     # aliased ls needs if file/dir completions work

# }}}
