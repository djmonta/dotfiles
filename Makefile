DOTFILES_TARGET   := $(wildcard .??*) bin
DOTFILES_DIR      := ${HOME}/dotfiles
DOTFILES_FILES    := .bash_profile .bashrc .gitconfig .gitignore .gittemplate .zshenv

.PHONY: all install help list update deploy nix hm darwin init homebrew brew clean

all: update deploy init

install: update deploy init
	@exec $$SHELL

help:
	@echo "make list           -> List the files"
	@echo "make update         -> Fetch changes"
	@echo "make deploy         -> Create symlink"
	@echo "make hm             -> Apply home-manager (standalone)"
	@echo "make darwin         -> Apply nix-darwin + home-manager"
	@echo "make nix            -> Install Determinate Nix if missing"
	@echo "make init           -> Setup environment"
	@echo "make install        -> Updating, deploying and initializng"
	@echo "make clean          -> Remove the dotfiles"
	@echo "make homebrew       -> Install homebrew without it"
	@echo "make brew           -> Update brew/cask/mas packages"

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

NIX := nix --extra-experimental-features 'nix-command flakes'
H := \#

nix:
	@bash $(DOTFILES_DIR)/etc/init/install_nix.sh

hm:
	$(NIX) run $(DOTFILES_DIR)$(H)home-manager -- switch --flake $(DOTFILES_DIR)$(H)monta -b hm-backup

darwin:
	@bash $(DOTFILES_DIR)/bin/darwin-switch

init:
ifeq ($(shell uname), Darwin)
	@$(foreach val, $(wildcard ./etc/init/osx/*.sh), bash $(val);)
endif

ifeq ($(shell uname), Darwin)
homebrew:
	@bash $(DOTFILES_DIR)/etc/init/osx/20-install_homebrew.sh

brew:
	@bash $(DOTFILES_DIR)/etc/init/osx/40-brewfileinstall.sh
endif

clean:
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES_FILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTFILES_DIR)
