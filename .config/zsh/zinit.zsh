
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
#zinit light-mode for \
#    zdharma-continuum/zinit-annex-as-monitor \
#    zdharma-continuum/zinit-annex-bin-gem-node \
#    zdharma-continuum/zinit-annex-patch-dl \
#    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# zinit snippet "${ZDOTDIR}/utils.zsh"
zinit snippet "$HOME/.config/zsh/iterm2_shell_integration.zsh"

zinit ice wait"!0" blockf lucid atpull'zinit creinstall -q .'
zinit light "zsh-users/zsh-completions"

zinit light "zsh-users/zsh-autosuggestions"

zinit ice wait"!0" lucid atinit"zpcompinit; zpcdreplay"
zinit light "zdharma-continuum/fast-syntax-highlighting"

zinit light "mollifier/anyframe"

# zinit ice wait"!0" blockf lucid pick"init.sh"
# zinit light "b4b4r07/enhancd"

zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS
zinit light "pinelibg/dircolors-solarized-zsh"

zinit light "marzocchi/zsh-notify"

zinit ice depth=1;
zinit light romkatv/powerlevel10k

zinit ice wait"!0" blockf lucid pick"wakatime.plugin.zsh"
zinit light "sobolevn/wakatime-zsh-plugin"

