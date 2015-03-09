## percol select history {{{
#
# https://github.com/mooz/percol#zsh-history-search
function exists { which $1 &> /dev/null }

#if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
#fi

# }}}

## Docker & percol {{{
#
# http://qiita.com/ariarijp/items/2af853d5ba0f98d98bc6
function dkgrep() {
    local PERCOL
    if [[ $1 == "" ]]; then
        PERCOL=percol
    else
        PERCOL="percol --query $1"
    fi
    docker ps -a | ${=PERCOL} | awk '{ print $1 }'
}

function dkkill() {
    local QUERY
    if [[ $1 =~ "^-" ]]; then
        QUERY=""            # options only
    else
        QUERY=$1            # with a query
        [[ $# -gt 0 ]] && shift
    fi
    dkgrep $QUERY | xargs docker kill $*
}


function dkrm() {
    local QUERY
    if [[ $1 =~ "^-" ]]; then
        QUERY=""            # options only
    else
        QUERY=$1            # with a query
        [[ $# -gt 0 ]] && shift
    fi
    dkgrep $QUERY | xargs docker rm $*
}

# }}}