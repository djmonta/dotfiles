#
# zsh-syntax-highlighting
#
#  https://github.com/zsh-users/zsh-syntax-highlighting
#
[ -f ${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] \
    || { echo '...skip'; return; }

source ${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#(main brackets pattern cursor)
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)