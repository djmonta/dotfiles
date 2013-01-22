#******************************************************************************
#
#  .zshenv
#
#  initial setup file for both interactive and noninteractive zsh
#
#  Read config sequence (except /etc/*)
#
#   login shell
#     $ZDOTDIR/.zshenv
#     $ZDOTDIR/.zprofile
#     $ZDOTDIR/.zshrc
#     $ZDOTDIRA/.zlogin
#
#   interactive zsh
#     $ZDOTDIR/.zshenv
#     $ZDOTDIR/.zshrc
#
#   shell scripts
#     $ZDOTDIR/.zshenv
#
#   remoteley noninteractive zsh (e.x ssh hostname command)
#     $ZDOTDIR/.zshenv
#
#   logout:
#     $ZDOTDIR/.zlogout
#     /etc/zlogout
#
#******************************************************************************

### Setup ZDOTDIR
#
# The directory to search for shell startup files (.zshrc, etc).
# If ZDOTDIR is unset, HOME is used instead.
#
ZDOTDIR=${HOME}/.zsh

for config_file ($ZDOTDIR/functions/*.zsh); do
	source $config_file
done

case "${TERM}" in
	# for emacs tramp setting
	dump)
        PROMPT="%n@%‾%(!.#.$)"
        RPROMPT=""
        PS1='%(?..[%?])%!:%‾%# '
        # for tramp to not hang, need the following. cf:
        # http://www.emacswiki.org/emacs/TrampMode
        unsetopt zle
        unsetopt prompt_cr
        unsetopt prompt_subst
        unfunction precmd
        unfunction preexec
        ;;        
esac
