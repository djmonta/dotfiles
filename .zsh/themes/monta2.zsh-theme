source ${HOME}/dotfiles/bin/256colorlib.sh

CURRENT_BG='NONE'
SEGMENT_SEPARATOR='⮀'

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
function prompt_segment() {
    local bg fg
    [[ -n $1 ]] && bg="$1"
    [[ -n $2 ]] && fg="$2"
    if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
        eval echo -n ' ${COLOR_BG_'"$bg"'}''${COLOR_FG_'"${CURRENT_BG}"'}'"$SEGMENT_SEPARATOR"'${COLOR_FG_'"$fg"'} '
        # echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
    else
        eval echo -n '${COLOR_BG_'"$1"'}''${COLOR_FG_'"$2"'} '
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

# Status:
# - was there an error
# - am I root
# - are there background jobs?
function prompt_status() {

    if [[ $RETVAL -eq 0 ]]; then
        prompt_segment FFFFFF 000000 " %# "
    else
        prompt_segment FF0000 FFFFFF " %# "
    fi

    if [[ $UID -eq 0 ]]; then
        prompt_segment default default "⚡"
    fi
    # [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="${COLOR_FG_FF0000}⚙"

}

# End the prompt, closing any open segments
function prompt_end() {
    if [[ -n $CURRENT_BG ]]; then
        eval echo -n ' ${STYLE_DEFAULT}${COLOR_FG_'"${CURRENT_BG}"'}'"${SEGMENT_SEPARATOR}"
    # else
    #     echo -n " "
    fi
    echo -n "%{${reset_color}%}"
    CURRENT_BG=''
    # echo -n $CURRENT_BG
}

# For tmux-powerline
function prompt_tmux_powerline() {
    TMUX_POWERLINE_PROMPT_INFO='$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
    eval echo -n "${TMUX_POWERLINE_PROMPT_INFO}"
}

## Main prompt
function build_prompt() {
    RETVAL=$?
    prompt_ssh
    prompt_dir
    prompt_git
    prompt_status
    prompt_end
    prompt_tmux_powerline
}

PROMPT='$(build_prompt) '