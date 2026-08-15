
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

# zinit snippet "$HOME"/dotfiles/.config/zsh/utils.zsh
zinit snippet "$HOME"/dotfiles/bin/256colorlib.sh

# Still on zinit (no nixpkgs package):
#   pinelibg/dircolors-solarized-zsh, marzocchi/zsh-notify, wakatime-zsh-plugin
# DIRCOLORS_SOLARIZED_ZSH_THEME: plugins.zsh; list-colors: zstyle.zsh
# HM-managed plugins: plugins.zsh

zinit ice atclone'git submodule update --init --recursive' atpull'%atclone'
zinit light "pinelibg/dircolors-solarized-zsh"

zinit light "marzocchi/zsh-notify"

zinit ice wait"!0" blockf lucid pick"wakatime.plugin.zsh"
zinit light "sobolevn/wakatime-zsh-plugin"
