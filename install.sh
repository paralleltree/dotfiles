#!/bin/sh

./link.sh

# vim
mkdir -p ~/.vim/colors
wget -P ~/.vim/colors https://raw.githubusercontent.com/w0ng/vim-hybrid/master/colors/hybrid.vim
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

