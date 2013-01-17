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

# Load all of the config files in ~/oh-my-zsh that end in .zsh
# TIP: Add files you don't want in git to .gitignore
for config_file ($ZDOTDIR/lib/*.zsh); do
	source $config_file
done
