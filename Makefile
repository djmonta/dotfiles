DOTFILES_TARGET   := $(wildcard .??*) bin
DOTFILES_DIR      := ${HOME}/dotfiles
DOTFILES_FILES    := .atom .bash_profile .bashrc .brewfile .config .dir_colors .emacs.d .gitconfig .gitignore .gittemplate .tmux .tmux.conf .zshenv .zsh

all: update deploy anyenv init

help:
	@echo "make list           #=> List the files"
	@echo "make update         #=> Fetch changes"
	@echo "make deploy         #=> Create symlink"
	@echo "make init           #=> Setup environment"
	@echo "make install        #=> Updating, deploying and initializng"
	@echo "make clean          #=> Remove the dotfiles"
	@echo "make homebrew       #=> Install homebrew without it"
	@echo "make brew           #=> Update brew/cask/mas packages"
	# @echo "make cask           #=> Update cask packages"
	@echo "make anyenv         #=> Install anyenv (ruby, node, python)"

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

anyenv:
	@bash $(DOTFILES_DIR)/etc/init/install_anyenv.sh

init:
ifeq ($(shell uname), Darwin)
	@$(foreach val, $(wildcard ./etc/init/osx/*.sh), bash $(val);)
else ifeq ($(shell uname), Linux)
	@$(foreach val, $(wildcard ./etc/init/debian/*.sh), bash $(val);)
endif
	# @$(foreach val, $(wildcard ./etc/init/*.sh), bash $(val);)

ifeq ($(shell uname), Darwin)
homebrew:
	@bash $(DOTFILES_DIR)/etc/init/osx/20-install_homebrew.sh

brew:
	@bash $(DOTFILES_DIR)/etc/init/osx/40-brewfileinstall.sh

# cask:
# 	@bash $(DOTFILES_DIR)/etc/init/osx/Caskfile
endif

install: update deploy init
	@exec $$SHELL

clean:
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES_FILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTFILES_DIR)
