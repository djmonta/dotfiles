# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/login.defs
#umask 022

# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi

# keep everything in the log.
P_PROC=`ps aux | grep $PPID | grep sshd | awk '{ print $11 }'`
if [ "$P_PROC" = sshd: ]; then
script ~/log/`date +%Y%m%d-%H%M%S.log`
exit
fi

PATH=/usr/lib/distcc/bin:$PATH
export PERL_CPANM_OPT="--local-lib=~/perl5"
export PATH="/home/monta/perl5/bin:$PATH"
export MODULEBUILDRC="/home/monta/perl5/.modulebuildrc"
export PERL_MM_OPT="INSTALL_BASE=/home/monta/perl5"
export PERL5LIB="/home/monta/perl5/lib/perl5/arm-linux-gnu-thread-multi:/home/monta/perl5/lib/perl5:$PERL5LIB"
export PATH="/home/monta/perl5/bin:$PATH"
export PATH
