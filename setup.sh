#!/bin/sh

MY_DIR="$(cd $(dirname $0); pwd)"

# ~/local
mkdir ~/local
mkdir ~/local/{bin,lib}

cd ~/local
git clone https://github.com/east301/dotfiles.git

# virtualenv for dotfiles
mkdir ~/local/python
python ~/local/dotfiles/dependencies/virtualenv/virtualenv.py ~/local/python/dotfiles
. ~/local/python/dotfiles/bin/activate

# python
mkdir ~/local/lib/python
ln -s ~/local/dotfiles/python/sitecustomize.py ~/local/lib/python/sitecustomize.py
ln -s ~/local/dotfiles/python/startup.py ~/local/lib/python/startup.py

# screen
ln -s ~/local/dotfiles/screen/screenrc ~/.screenrc

# shell
ln -s ~/local/dotfiles/shell/zshrc.zsh ~/.zshrc

# util
ln -s ~/local/dotfiles/util/rpath.py ~/local/bin/rpath.py

# vcs
pip install pyyaml

ln -s ~/local/dotfiles/vcs/change-git-profile.sh ~/local/bin/change-git-profile
ln -s ~/local/dotfiles/vcs/change-hg-profile.sh ~/local/bin/change-hg-profile
