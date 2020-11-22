
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit snippet "${ZDOTDIR}/utils.zsh"

zinit ice wait"!0" blockf silent
zinit light "zsh-users/zsh-completions"

zinit ice wait"!0" silent atinit"zpcompinit; zpcdreplay"
zinit light "zsh-users/zsh-syntax-highlighting"

zinit ice as"command" mv"fzf-* -> fzf" junegunn/fzf-bin
zinit light "mollifier/anyframe"

zinit ice wait"!0" silent pick"init.sh" "b4b4r07/enhancd"

zinit ice as"command" mv"zsh-gomi -> gomi" "b4b4r07/zsh-gomi"

zinit light "pinelibg/dircolors-solarized-zsh"

zinit light-mode for \
    pick"async.zsh" src"pure.zsh" \
                sindresorhus/pure

zinit ice pick"wakatime.plugin.zsh" "sobolevn/wakatime-zsh-plugin"

### End of Zinit's installer chunk
