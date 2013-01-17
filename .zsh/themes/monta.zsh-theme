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

# 256colorlib.shをスクリプトから生成して動作を高速化・更にzshのプロンプトの色変更にも使用できるようにする - 試験運用中なLinux備忘録 <http://d.hatena.ne.jp/kakurasan/20080705/p1>
# ${HOME}/dotfiles/bin/gen-256colorlib.sh -z > 256colorlib.sh && chmod +x 256colorlib.sh
source ${HOME}/dotfiles/bin/256colorlib.sh

# 定義される変数
#  COLOR_FG_rrggbb : 前景色を#rrggbbに変更
#  COLOR_BG_rrggbb : 背景色を#rrggbbに変更
#  STYLE_DEFAULT   : 色とスタイルをリセット
#  STYLE_BOLD      : 太字
#  STYLE_LINE      : 下線
#  STYLE_NEGA      : 前景色と背景色を入れ替える
#  STYLE_NOLINE    : 下線なし

CURRENT_BG='NONE'
SEGMENT_SEPARATOR='⮀'

## PROMPT/RPROMT/SPROMPT

# DEFAULT_PROMPT='%{${reset_color}%}'
# [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
# DEFAULT_PROMPT+="${COLOR_BG_FFFF00}${COLOR_FG_000000} $(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${COLOR_BG_00AFFF}${COLOR_FG_FFFF00}⮀%{${reset_color}%}"
# DEFAULT_PROMPT+='${STYLE_BOLD}${COLOR_BG_00AFFF}${COLOR_FG_FF0000}%(1j, ⚙,)%{${reset_color}%}'
# DEFAULT_PROMPT+='${COLOR_BG_00AFFF}${COLOR_FG_000000} %~ '
# DEFAULT_PROMPT+='$(prompt_git)%{${reset_color}%}'
# DEFAULT_PROMPT+='%{%(?.${COLOR_BG_FFFFFF}${COLOR_FG_00AFFF}⮀${STYLE_BOLD}${COLOR_FG_000000}${COLOR_BG_FFFFFF} %# .${COLOR_BG_FF0000}${COLOR_FG_00AFFF}⮀${STYLE_BOLD}${COLOR_FG_FFFFFF}${COLOR_BG_FF0000} %# )%}%{${reset_color}%}'
# DEFAULT_PROMPT+='%(?.${COLOR_BG_000000}${COLOR_FG_FFFFFF}⮀.${COLOR_BG_000000}${COLOR_FG_FF0000}⮀)%{${reset_color}%} '

# PROMPT='%(!.%F{red}.%F{cyan})%n%f:%{$(pwd|([[ $EUID == 0 ]] && GREP_COLORS="mt=01;31" grep --color=always /|| GREP_COLORS="mt=01;34" grep --color=always /))%${#PWD}G%}%(!.%F{red}.)%#%f '
# PROMPT2="%{${fg[green]}%}%_%%%{${reset_color}%} "
# [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
#     PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"

# For tmux-powerline
# TMUX_POWERLINE_PROMPT_INFO='$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
# DEFAULT_PROMPT+=$TMUX_POWERLINE_PROMPT_INFO
# VI_CMD_PROMPT+=$TMUX_POWERLINE_PROMPT_INFO

# Left prompt
# PROMPT=$DEFAULT_PROMPT

## Right prompt
# RPROMPT='%{${reset_color}%}'
# VCS
# RPROMPT+='$(vcs_super_info)'
# Python
# RPROMPT+='%{${fg_bold[magenta]}%}($(_python_type))%{${reset_color}%}'
# Date-time
# RPROMPT+='[%{${fg[magenta]}%}%D{%Y/%m/%d %H:%M:%S}%{${reset_color}%}]'

# Correct prompt
SPROMPT="${COLOR_FG_00AF00}%r is correct? [n,y,a,e]:%{${reset_color}%} "

# PROMPT="$PROMPT"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
function prompt_segment() {
    local bg fg
    [[ -n $1 ]] && bg="$1"
    [[ -n $2 ]] && fg="$2"
    if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
        echo -n ' ${COLOR_BG_'"$bg"'}''${COLOR_FG_'"${CURRENT_BG}"'}'"$SEGMENT_SEPARATOR"'${COLOR_FG_'"$fg"'} '
        # echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
    else
        echo -n '${COLOR_BG_'"$1"'}''${COLOR_FG_'"$2"'} '
    fi
    CURRENT_BG="$1"
    [[ -n $3 ]] && echo -n $3
}

# SSH
#  http://d.hatena.ne.jp/kakurasan/20070611/p1
function prompt_ssh() {
    # if [[ -n "${SSH_CONNECTION}" ]]; then
    #     # Client IP - Client Port - Server IP - Server Port
    #     echo "${SSH_CONNECTION}" | awk -F\  '{printf "("$1")>"}'
    # fi
    if [[ -n "${REMOTEHOST}${SSH_CONNECTION}" ]]; then
        prompt_segment FFFF00 000000
        echo -n ${HOST%%.*} | tr '[a-z]' '[A-Z]'
    fi
}

function prompt_dir() {
    prompt_segment 00AFFF 000000 '%~'
    # echo -n $CURRENT_BG
}

# Git: branch/detached head, dirty status
function prompt_git() {
    local ref dirty
    if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    ZSH_THEME_GIT_PROMPT_DIRTY='± '
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
    if [[ -n $dirty ]]; then
        prompt_segment D75F00 FFFFFF
    else
        prompt_segment 00AF00 000000
    fi
    echo -n "${ref/refs\/heads\//⭠ }$dirty"
    fi
    # echo -n $CURRENT_BG
}

# Error or not
# function error_or_not() {
#     local 
#     '%{%(?.'
#     '${COLOR_BG_FFFFFF}${COLOR_FG_00AFFF}⮀${STYLE_BOLD}${COLOR_FG_000000}${COLOR_BG_FFFFFF} %# ${COLOR_BG_000000}${COLOR_FG_FFFFFF}⮀.'
#     '${COLOR_BG_FF0000}${COLOR_FG_00AFFF}⮀${STYLE_BOLD}${COLOR_FG_FFFFFF}${COLOR_BG_FF0000} %# ${COLOR_BG_000000}${COLOR_FG_FF0000}⮀)%}%{${reset_color}%}'

# }


# Status:
# - was there an error
# - am I root
# - are there background jobs?
function prompt_status() {
    local symbols
    symbols=()
    [[ $RETVAL -ne 0 ]] && symbols+="${COLOR_FG_FF0000}✘"
    [[ $UID -eq 0 ]] && symbols+="${COLOR_FG_FF0000}⚡"
    [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="${COLOR_FG_FF0000}⚙"

    [[ -n "$symbols" ]] && prompt_segment 000000 FFFFFF "$symbols"
}

# End the prompt, closing any open segments
function prompt_end() {
    if [[ -n $CURRENT_BG ]]; then
        echo -n ' ${STYLE_DEFAULT}${COLOR_FG_'"${CURRENT_BG}"'}'"${SEGMENT_SEPARATOR}"
    # else
    #     echo -n "%{%k%}"
    fi
    echo -n "%{${reset_color}%}"
    CURRENT_BG=''
    # echo -n $CURRENT_BG
}


## Main prompt
function build_prompt() {
    RETVAL=$?
    prompt_ssh
    prompt_dir
    prompt_git
    prompt_status
    prompt_end
}

PROMPT="$(build_prompt)%{${reset_color}%} "
