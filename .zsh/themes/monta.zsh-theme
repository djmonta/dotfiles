### Introduction {{{
#
#  Set prompt for zsh
#
#  PROMPT  : 通常のプロンプト
#  PROMPT2 : forやwhile文使用時の複数行入力プロンプト
#  RPROMPT : 右側に表示されるプロンプト, 入力が被ると自動的に消える
#  SPROMPT : 入力ミス時のコマンド訂正プロンプト
#
#  コマンド訂正プロンプト
#   y: 訂正コマンドを実行
#   n: 入力したコマンドが実行
#   a: 実行を中断 abort
#   e: コマンドライン編集 edit
#
#  プロンプト文字列
#    %% : %文字
#    %# : #文字(一般ユーザなら %，スーパユーザなら #)
#    %l : tty名
#    %M : ホスト名（全部）
#    %m : ホスト名（最初のドットまで）
#    %n : ユーザ名
#    %? : 直前のコマンドの終了値($?)
#    %d : カレントディレクトリ(フルパス, 省略なし）
#    %/ : カレントディレクトリ(フルパス)
#    %~ : 同上,ただし~記号などで可能な限り短縮する
#    %1~ or %1/ : カレントディレクトリ(ベースネーム)
#    %h or %! : Current history event number.
#    %l : The line (tty) the user is logged in on
#    %B : 太字開始
#    %b : 太字解除
#    %(1j,(%j),) : 実行中のジョブ数が1つ以上ある場合ジョブ数を表示
#
#    %{%(?.$fg[white].$fg[red])%}
#     直前の終了ステータスに応じてプロンプトの色が変化(0:白, 0以外:赤)
#     http://blog.8-p.info/2009/01/red-prompt
#
#    %D{%Y/%m/%d %H:%M:%S} : 時間表示(年/月/日 時:分:秒)
#
#    %(5~,%-2~/.../%2~,%~)%<space> : 長いディレクトリ名を省略表示
#
#    $WINDOW : screen 実行時のスクリーン番号
#
########################################################################### }}}

## For zsh-vcs-prompt (vcs_super_info)
# if [ -f ~/.zsh/zsh-vcs-prompt/zshrc.sh ]; then
#     source ~/.zsh/zsh-vcs-prompt/zshrc.sh
#     ## Enable caching.
#     ZSH_VCS_PROMPT_ENABLE_CACHING='true'
#     ZSH_VCS_PROMPT_GIT_FORMATS_USING_PYTHON="${ZSH_VCS_PROMPT_GIT_FORMATS}"
#     ZSH_VCS_PROMPT_GIT_FORMATS+='!'
#     ZSH_VCS_PROMPT_GIT_ACTION_FORMATS+='!'
# fi


## PROMPT/RPROMT/SPROMPT

# Symbols
PROMPT_NORMAL_SYMBOL="♪ "
PROMPT_ERROR_SYMBOL="✘ "

DEFAULT_PROMPT='%{${reset_color}%}'
#DEFAULT_PROMPT+='%{${fg_bold[yellow]}%}$(_client_ip)%{${reset_color}%}'
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
DEFAULT_PROMPT+="%{${fg_bold[yellow]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]')%{${reset_color}%} "
#DEFAULT_PROMPT+='[%{${fg_bold[magenta]}%}${WINDOW:+"#$WINDOW "}$([ -n "$TMUX" ] && tmux display -p "#I-#P ")%{${reset_color}%}'
DEFAULT_PROMPT+='[%{${fg[cyan]}%}%n%{${reset_color}%}%{${fg[yellow]}%}❖ %{${reset_color}%}%{${fg[green]}%}%m%{${reset_color}%}'
DEFAULT_PROMPT+='%{${fg_bold[red]}%}%(1j,(%j),)%{${reset_color}%}'
DEFAULT_PROMPT+=':%~%{${reset_color}%}]%(?.%{${fg[blue]}%}${PROMPT_NORMAL_SYMBOL}.%{${fg[red]}%}${PROMPT_ERROR_SYMBOL}) %{${reset_color}%}'

# PROMPT='%(!.%F{red}.%F{cyan})%n%f:%{$(pwd|([[ $EUID == 0 ]] && GREP_COLORS="mt=01;31" grep --color=always /|| GREP_COLORS="mt=01;34" grep --color=always /))%${#PWD}G%}%(!.%F{red}.)%#%f '
# PROMPT2="%{${fg[green]}%}%_%%%{${reset_color}%} "
# [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
#     PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"

# VI_CMD_PROMPT='%{${reset_color}%}'
# VI_CMD_PROMPT+='%{${fg_bold[yellow]}%}$(_client_ip)%{${reset_color}%}'
# VI_CMD_PROMPT+='[%{${fg_bold[magenta]}%}${WINDOW:+"#$WINDOW "}$([ -n "$TMUX" ] && tmux display -p "#I-#P ")%{${reset_color}%}'
# VI_CMD_PROMPT+='%{${fg[yellow]}%}%n%{${reset_color}%}%{${fg[green]}%}❖ %{${reset_color}%}%{${fg[yellow]}%}%m%{${reset_color}%}'
# VI_CMD_PROMPT+='%{${fg_bold[red]}%}%(1j,(%j),)%{${reset_color}%}'
# VI_CMD_PROMPT+=':%~%{${reset_color}%}]%(?.%{${fg[blue]}%}${PROMPT_NORMAL_SYMBOL}.%{${fg[red]}%}${PROMPT_ERROR_SYMBOL}) %{${reset_color}%}'

# For tmux-powerline
TMUX_POWERLINE_PROMPT_INFO='$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
DEFAULT_PROMPT+=$TMUX_POWERLINE_PROMPT_INFO
# VI_CMD_PROMPT+=$TMUX_POWERLINE_PROMPT_INFO

# Left prompt
PROMPT=$DEFAULT_PROMPT

## Right prompt
RPROMPT='%{${reset_color}%}'
# VCS
# RPROMPT+='$(vcs_super_info)'
# Python
# RPROMPT+='%{${fg_bold[magenta]}%}($(_python_type))%{${reset_color}%}'
# Date-time
RPROMPT+='[%{${fg[magenta]}%}%D{%Y/%m/%d %H:%M:%S}%{${reset_color}%}]'

# Correct prompt
SPROMPT='%{${reset_color}%}%{$fg[green]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} '

# PROMPT="$PROMPT"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

# Vi入力モードでPROMPTの色を変える
# http://memo.officebrook.net/20090226.html
# function zle-line-init zle-keymap-select {
#     case $KEYMAP in
#     vicmd)
#         # viコマンドモード
#         PROMPT=${VI_CMD_PROMPT}
#         ;;
#     main|viins)
#         # viインサートモード
#         PROMPT=${DEFAULT_PROMPT}
#         ;;
#     esac
#     zle reset-prompt
# }
# zle -N zle-line-init
# zle -N zle-keymap-select


# SSH
#  http://d.hatena.ne.jp/kakurasan/20070611/p1
function _client_ip() {
    if [ -n "${SSH_CONNECTION}" ]; then
        # Client IP - Client Port - Server IP - Server Port
        echo "${SSH_CONNECTION}" | awk -F\  '{printf "("$1")>"}'
    fi
}

# Python
# function _python_type() {
#     local python_path=$(which python 2> /dev/null)
#     local pytype
#     if [ -z "$python_path" ]; then
#         pytype='none'
#     elif [ "$python_path" = '/usr/bin/python' ]; then
#         pytype='def'
#     elif [ "$python_path" = '/usr/local/bin/python' ]; then
#         pytype='local'
#     elif echo "$python_path" | fgrep -q '/.pythonbrew/'; then
#         if [ -n "$VIRTUAL_ENV" ]; then
#             pytype=$(basename "$VIRTUAL_ENV")
#         else
#             pytype='*py'$(echo "$python_path" | sed 's%.*Python-\([^/]*\)/.*%\1%' | tr -d '.')
#         fi
#     else
#         if [ -n "$VIRTUAL_ENV" ]; then
#             pytype=$(basename "$VIRTUAL_ENV")
#         else
#             pytype=$python_path
#         fi
#     fi
#     echo "$pytype"
# }

