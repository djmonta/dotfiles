#
# cdd
#
#  http://m4i.hatenablog.com/entry/2012/01/26/064329
#  https://github.com/m4i/cdd
#
#  screen/tmuxのカレントディレクトリに移動など
#  $ cdd
#  $ cdd <tab>
#  $ cdd add <name> <dir>
#  $ cdd delete <name> <dir>
#

[ -f ${HOME}/.zsh/cdd/cdd ] || { echo '...skip'; return; }

source ${HOME}/.zsh/cdd/cdd

[ -f ${HOME}/.cdd ] || touch ${HOME}/.cdd