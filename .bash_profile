# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/login.defs
#umask 022

# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi


# PATH settings
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin
# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi

export PATH=/usr/local/bin:$PATH

if [ -d /usr/local/opt/ruby/bin/ruby ]; then
	export PATH=/usr/local/opt/ruby/bin:$PATH
fi