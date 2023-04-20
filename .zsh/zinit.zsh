
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit snippet "${ZDOTDIR}/utils.zsh"

zinit ice wait"!0" blockf lucid atpull'zinit creinstall -q .'
zinit light "zsh-users/zsh-completions"

zinit light "zsh-users/zsh-autosuggestions"

zinit ice wait"!0" lucid atinit"zpcompinit; zpcdreplay"
zinit light "zdharma-continuum/fast-syntax-highlighting"

zinit light "mollifier/anyframe"

zinit ice wait"!0" blockf lucid pick"init.sh"
zinit light "b4b4r07/enhancd"

zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS
zinit light "pinelibg/dircolors-solarized-zsh"

# zinit ice wait"!0" blockf lucid pick"bgnotify.plugin.zsh" as"service"
# zinit light "t413/zsh-background-notify"

zinit light "marzocchi/zsh-notify"

zinit light-mode for \
    pick"async.zsh" src"pure.zsh" \
                sindresorhus/pure

zinit ice wait"!0" blockf lucid pick"wakatime.plugin.zsh"
zinit light "sobolevn/wakatime-zsh-plugin"

### End of Zinit's installer chunk
