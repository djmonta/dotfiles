# Setup fzf
# ---------
if [[ ! "$PATH" == *$USR_LOCAL/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$USR_LOCAL/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$USR_LOCAL/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
if [ -f $USR_LOCAL/opt/fzf/shell/key-bindings.zsh ] ; then
  source "$USR_LOCAL/opt/fzf/shell/key-bindings.zsh"
fi
