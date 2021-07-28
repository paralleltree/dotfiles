SHELL := /bin/bash

IGNORED_DOTFILES := .DS_Store .git .gitignore
ALL_DOTFILES := $(wildcard .??*)
LINKING_TARGET_DOTFILES := $(filter-out $(IGNORED_DOTFILES), $(ALL_DOTFILES))
LOCAL_BACKUP_DOTFILES := .bashrc

define USAGE
== make usage ==
help: Print this help.
install: Execute link and init.
link: Make symlinks for dotfiles after executing unlink.
unlink: Remove symlinks for dotfiles.
init: Execute scripts under init directory.
show-targets: Print linkable dotfiles.
endef

export USAGE

.PHONY: help
help:
	@echo "$${USAGE}"

.PHONY: install
install: link init

.PHONY: link
link: unlink
	@$(foreach file, $(LOCAL_BACKUP_DOTFILES), if [ ! -e $(HOME)/$(file)_local -a -e $(HOME)/$(file) ]; then echo Moving $(file) to $(file)_local >&2; mv $(HOME)/$(file){,_local}; fi;)
	@$(foreach file, $(LINKING_TARGET_DOTFILES), ln -sv $(abspath $(file)) $(HOME)/$(file);)

.PHONY: unlink
unlink:
	@$(foreach file, $(LINKING_TARGET_DOTFILES), [ ! -L $(HOME)/$(file) ] || (echo Unlinking $(HOME)/$(file) >&2 && rm -r $(HOME)/$(file));)
	@$(foreach file, $(LOCAL_BACKUP_DOTFILES), if [ -e $(HOME)/$(file)_local ]; then echo Moving $(file)_local to $(file) >&2; mv $(HOME)/$(file){_local,}; fi;)

.PHONY: init
init:
	@$(foreach script, $(wildcard ./init/*.sh), bash $(script);)

.PHONY: show-targets
show-targets:
	@$(foreach file, $(LINKING_TARGET_DOTFILES), echo $(file);)
