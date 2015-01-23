DOTFILES_TARGET   := $(wildcard .??*) bin
DOTFILES_DIR      := $(PWD)
DOTFILES_FILES    := $(.bash_profile .bashrc .emacs.d .gitconfig .tmux .tmux.conf .zshenv .zsh .screenrc .subversion)

all: update deploy init

help:
	@echo "make list           #=> List the files"
	@echo "make update         #=> Fetch changes"
	@echo "make deploy         #=> Create symlink"
	@echo "make init           #=> Setup environment"
	@echo "make install        #=> Updating, deploying and initializng"
	@echo "make clean          #=> Remove the dotfiles"
	@echo "make homebrew       #=> Install homebrew without it"
	@echo "make brew           #=> Update brew packages"
	@echo "make cask           #=> Update cask packages"

list:
	@$(foreach val, $(DOTFILES_FILES), ls -dF $(val);)

update:
	git pull origin master
	git submodule init
	git submodule update
	git submodule foreach git pull origin master

deploy:
	@echo 'Start deploy dotfiles current directory.'
	@echo 'If this is "dotdir", curretly it is ignored and copy your hand.'
	@echo ''
	@bash $(DOTFILES_DIR)/etc/init/create_symlink.sh
	# @$(foreach val, $(DOTFILES_FILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	# @bash ln -sfnv $(DOTFILES_DIR)/.gitignore.default $(HOME)/.gitignore
	# @bash ln -sfnv $(DOTFILES_DIR)/Cellar/dircolors-solarized/dircolors.ansi-universal $(HOME)/.dir_colors
	# @bash ln -sfnv $(DOTFILES_DIR)/.tmux/.tmux-powerlinerc.default $(HOME)/.tmux-powerlinerc

init:
	@$(foreach val, $(wildcard ./etc/init/*.sh), bash $(val);)
ifeq ($(shell uname), Darwin)
	@$(foreach val, $(wildcard ./etc/init/osx/*.sh), bash $(val);)

homebrew:
	@bash $(DOTFILES_DIR)/etc/init/osx/20-install_homebrew.sh

brew: homebrew
	@bash $(DOTFILES_DIR)/etc/init/osx/Brewfile

cask: homebrew
	@bash $(DOTFILES_DIR)/etc/init/osx/Caskfile
endif

install: update deploy init
	@exec $$SHELL

clean:
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES_FILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTFILES_DIR)