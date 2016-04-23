#!/bin/bash
####################
# install.sh
# This script creates symlinks from the home directory to any desired dotfiles in this directory
####################

# Variables
dir=$(pwd)                              # dotfiles directory
olddir="$(pwd)_old"                     # old dotfiles backup directory
files=$(ls -a -I.git| grep "^\.[a-z]")  # list of files/folders to symlink

# create dotfiles_old
echo -e "Creating $olddir for backup of any existing dotfiles\n\n"
mkdir -p $olddir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
echo "Moving any existing dotfiles in homedir to $olddir directory, then create symlinks"
cd $dir
for file in $files; do
    echo "$file"
    mv ~/$file $olddir
    ln -s $dir/$file ~/$file
done
