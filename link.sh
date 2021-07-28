#!/bin/bash
set -eu

# [source path] [link_path]
function link_if_not_exists() {
  if [ -e "$2" ]; then
    echo "$2 is already exists. Skipping." >&2
  else
    ln -s "$1" "$2"
  fi
}

if [ ! -e ~/.bashrc_local -a -e ~/.bashrc ]; then
  mv ~/.bashrc ~/.bashrc_local
fi

link_if_not_exists ~/dotfiles/bash/bashrc ~/.bashrc

link_if_not_exists ~/dotfiles/git/gitconfig ~/.gitconfig
link_if_not_exists ~/dotfiles/git/gitignore_global ~/.gitignore_global

link_if_not_exists ~/dotfiles/vim/vimrc ~/.vimrc
link_if_not_exists ~/dotfiles/vim ~/.vim

link_if_not_exists ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
