# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
     OLD_PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
     SCREEN_TITLE='${debian_chroot:+($debian_chroot)}\033k\033\\';
     PS1="${SCREEN_TITLE}${OLD_PS1}"
#    PS1='\[\033k\033\\\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#    OLD_PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#    SCREEN_TITLE='\033k\033\\';
#    PS1="${SCREEN_TITLE}${OLD_PS1}"
    PS1='${debian_chroot:+($debian_chroot)}\033k\033\\\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export CLICOLOR=1 
export TERM=xterm-color #この2行でカラー表示

# iandeth. - bashにて複数端末間でコマンド履歴(history)を共有する方法 <http://iandeth.dyndns.org/mt/ian/archives/000651.html>
function share_history {
    history -a
    history -c
    history -r
}
PROMPT_COMMAND='share_history'
shopt -u histappend
export HISTSIZE=9999
export PERL_CPANM_OPT="--local-lib=~/perl5"
export PATH="/home/monta/perl5/bin:$PATH"
export MODULEBUILDRC="/home/monta/perl5/.modulebuildrc"
export PERL_MM_OPT="INSTALL_BASE=/home/monta/perl5"
export PERL5LIB="/home/monta/perl5/lib/perl5/arm-linux-gnu-thread-multi:/home/monta/perl5/lib/perl5:$PERL5LIB"
export PATH="/home/monta/perl5/bin:$PATH"
export PATH
