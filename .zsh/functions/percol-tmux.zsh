# uu59のメモ | percolでtmuxのペインを選択するやつ
# http://blog.uu59.org/2013-10-25-percol-tmux-select-pane.html

function percol-tmux-select-pane() {
  local selected
  selected=$(tmux list-panes -s -F '#{window_index} #{pane_index} #{pane_title}' | percol)
  local window=$(echo $selected | cut -f1 -d " ")
  local pane=$(echo $selected | cut -f2 -d " ")
  tmux select-window -t $window
  tmux select-pane -t $pane
}
zle -N percol-tmux-select-pane

bindkey '^xw' percol-tmux-select-pane