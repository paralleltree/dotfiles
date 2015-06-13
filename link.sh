#!/bin/sh

if [ ! -e ~/.bashrc_local -a -e ~/.bashrc ]; then
  mv ~/.bashrc ~/.bashrc_local
fi

ln -s ~/dotfiles/bash/bashrc ~/.bashrc

ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/dotfiles/git/gitignore_global ~/.gitignore_global

ln -s ~/dotfiles/vim/vimrc ~/.vimrc
ln -s ~/dotfiles/vim ~/.vim

ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf

