#!/bin/sh

MY_DIR="$(cd $(dirname $0); pwd)"

# ~/local
mkdir ~/local
mkdir ~/local/bin

cd ~/local
git clone https://github.com/east301/dotfiles.git

# screen
ln -s ~/local/dotfiles/screen/screenrc ~/.screenrc

# shell
ln -s ~/local/dotfiles/shell/zshrc.zsh ~/.zshrc

# util
ln -s ~/local/dotfiles/util/rpath.py ~/local/bin/rpath.py

# vcs
ln -s ~/local/dotfiles/vcs/change-git-profile.sh ~/local/bin/change-git-profile
ln -s ~/local/dotfiles/vcs/change-hg-profile.sh ~/local/bin/change-hg-profile
