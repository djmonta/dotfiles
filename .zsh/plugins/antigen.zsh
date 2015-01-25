ADOTDIR=${HOME}/.zsh/plugins

if [[ -f ${HOME}/.zsh/antigen/antigen.zsh ]]; then
  source ${HOME}/.zsh/antigen/antigen.zsh

	antigen bundle zsh-users/zsh-syntax-highlighting
	antigen bundle zsh-users/zsh-completions
	antigen-bundle marzocchi/zsh-notify

	# Tell antigen that you're done.
	antigen-apply

fi