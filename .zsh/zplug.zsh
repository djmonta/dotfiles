zplug "~/.zsh", from:local, use:"<->_*.zsh"

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "mollifier/anyframe"
zplug "marzocchi/zsh-notify"
zplug "b4b4r07/emoji-cli"
zplug "junegunn/fzf-bin", as:command, rename-to:fzf
zplug "b4b4r07/enhancd", use:init.sh
# zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug "wbingli/zsh-wakatime", from:github