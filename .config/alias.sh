# shellcheck shell=sh
# Interactive aliases. Sourced from programs.zsh.initContent.

alias where="command -v"
alias jl="jobs -l"
alias cl='clear'
alias quit='exit';

# ls — GNU (Nix/Homebrew gls) vs BSD
case "${OSTYPE}" in
freebsd*|darwin*)
    if type gls > /dev/null 2>&1; then
        alias ls='gls -aFhv --color=auto --show-control-chars'
        alias ll='ls -l --time-style=long-iso'
    elif ls --color=auto / >/dev/null 2>&1; then
        alias ls='ls -aFhv --color=auto --show-control-chars'
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

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cdp='cd -P'
alias cdl='cd -L'
alias pwd='pwd -P'

alias df='df -h'
alias du='du -h'
alias dus='du -s'

alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -ir'
alias cpa='cp -a'

if grep --help 2> /dev/null | grep -q -- --exclude-dir; then
    alias grep='grep -niE --exclude-dir=.svn --exclude-dir=.git'
else
    alias grep='grep -niE'
fi
alias grepr='grep -R'

alias findbig='find . -type f -exec ls -s {} \; | sort -n -r | head -5'
alias findmod='find . -type f -mmin -10'

alias h='history 32'
history_all() { history -E 1 | less; }

alias 644='chmod 644'
alias 755='chmod 755'
alias psa='ps auxw'
alias topm='top -o rsize'
alias topc='top -R -F -u'

alias diff='diff -tbBE'
alias diffr='diff -rq'
alias cur='curl -OLv'
alias rsync='rsync -avzu'
alias su="su -l"

alias utf='export LANG=ja_JP.UTF-8; export LANGUAGE=ja_JP.UTF-8; export LC_ALL=ja_JP.UTF-8'
alias en='export LANG=en; export LANGUAGE=en; export LC_ALL=en'

alias ssu='sudo -s'
alias printpath='echo $PATH | tr ":" "\n"'
alias organize_path='tr ":" "\n" | uniq | paste -d: -s -'

alias tree="tree -N -a -I '.git|.svn'"
alias nkfg='nkf -g'
