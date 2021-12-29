#!/bin/bash
# setup.sh backs up existing home directory dotfiles into a specified directory
# and creates symlinks to the common dotfiles in this repo to the home directory.
# It also attempts to install utilities that I would manually install later
# anyway.
# More env-specific dotfiles and configs, like i3 and rc.conf, are not automatically
# linked as they may not be needed in every environment. They can be added to
# the FILES list if symlinks are desired.

set -x

FILES=".bash_profile .bashrc .scripts .vimrc .vim .tmux.conf"
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
