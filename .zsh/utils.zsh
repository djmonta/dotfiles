##
# cd 履歴を記録
typeset -U chpwd_functions
CD_HISTORY_FILE=${HOME}/.cd_history # cd 履歴の記録先ファイル
function chpwd_record_history() {
    echo $PWD >> ${CD_HISTORY_FILE}
}
chpwd_functions=($chpwd_functions chpwd_record_history)

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
                echo -ne "\ek$(basename "$(pwd)")\e\\"
            else
                echo -ne "\033]0;$(basename "$(pwd)")\007"
            fi
            return 0
        }
        add-zsh-hook precmd _change_terminal_title_precmd_hook
        ;;
    # for emacs tramp setting
    dumb)
        PROMPT="%n@%~%(!.#.$)"
        RPROMPT=""
        PS1='%(?..[%?])%!:%~%# '
        # for tramp to not hang, need the following. cf:
        # http://www.emacswiki.org/emacs/TrampMode
        unsetopt zle
        unsetopt prompt_cr
        unsetopt prompt_subst
        unfunction precmd
        unfunction preexec
        ;;
esac

# }}}

### Misc {{{
#
# Define action when change directory.
chpwd() {
    ls_abbrev
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


### ls & git status when hit Enter {{{
#
# http://qiita.com/yuyuchu3333/items/e9af05670c95e2cc5b4d
function do_enter() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi
    echo
    # ls　↓おすすめ
    ls_abbrev
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo
        echo -e "\e[0;33m--- git status ---\e[0m"
        git status -sb
    fi
    zle reset-prompt
    return 0
}

### docker rmi {{{
#
# https://github.com/b4b4r07/dotfiles/blob/master/.zsh/30_aliases.zsh#L458
docker_rmi() {
    docker images \
        | fzf --reverse --header-lines=1 --multi --ansi \
        | awk '{print $3}' \
        | xargs docker rmi ${1+"$@"}
}
