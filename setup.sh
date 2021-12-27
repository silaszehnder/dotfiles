#!/bin/bash
# This script copies all the dotfiles and vim colors into this folder
# this folder can then be pulled and dotfiles can be manually be installed
# on a comp-by-comp basis

set -x

FILES=".bash_profile .bashrc .vimrc .vim .tmux.conf"
BACKUP_DIR=~/dotfile-backup
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

mkdir -p $BACKUP_DIR

for FILE in $FILES; do
    mv ~/$FILE $BACKUP_DIR/
    ln -si $SCRIPT_DIR/$FILE ~/$FILE
done

# Install Vundle (Vim plugin manager)
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install tpm (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# GNOME terminal one-dark
bash -c "$(curl -fsSL https://raw.githubusercontent.com/denysdovhan/gnome-terminal-one/master/one-dark.sh)"

source ~/.bashrc
