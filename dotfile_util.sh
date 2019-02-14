#!/bin/bash
###
# .copier.sh
# This script copies all the dotfiles and vim colors into this folder
# this folder can then be pulled and dotfiles can be manually be installed
# on a comp-by-comp basis

### Variables

files=".bash_profile .bashrc .vimrc .vim .tmux.conf"
backup=backup
dir=~/dotfiles

###

#create backup of current dotfiles
echo "Creating backup folder for dotfiles currently in the home directory"
rm -rf $backup
mkdir -p $backup
echo "backup folder created"

for file in $files; do
    echo "move ~/$file to backup folder $backup/"
    mv ~/$file $dir/$backup/
    echo "Creating symlink from $dir/$file to ~/$file"
    ln -si $dir/$file ~/$file
done

echo "source ~/.bashrc and for convenience"
source ~/.bashrc

echo "Backup and linking complete!"
