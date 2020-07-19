zplug "~/.zsh", from:local, use:"<->_*.zsh"

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search"
zplug "mollifier/anyframe"
zplug "marzocchi/zsh-notify"
zplug "junegunn/fzf-bin", as:command, rename-to:fzf
zplug "b4b4r07/emoji-cli"
zplug "b4b4r07/enhancd", use:init.sh
zplug "b4b4r07/zsh-gomi", as:command, use:bin/gomi, rename-to:gomi, on:junegunn/fzf-bin
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
# zplug "joel-porquet/zsh-dircolors-solarized"
zplug "seebi/dircolors-solarized", ignore:"*", as:plugin
zplug "pinelibg/dircolors-solarized-zsh"
# zplug "nmaxcom/nmaxcom-zsh-theme", use:nmaxcom.zsh-theme, as:theme
# zplug "mafredri/zsh-async", from:github
# zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug "sobolevn/wakatime-zsh-plugin", use:wakatime.plugin.zsh, from:github
