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

# Install ohmyzsh plugins
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

# OS specific settings
if [[ "$OSTYPE" == "linux-gnu" ]]; then
        # Linux
        echo "Linux";
elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
        ./.osx.sh
elif [[ "$OSTYPE" == "cygwin" ]]; then
        # POSIX compatibility layer and Linux environment emulation for Windows
        echo "Cygwin";
elif [[ "$OSTYPE" == "msys" ]]; then
        # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
        echo "MinGW";
elif [[ "$OSTYPE" == "win32" ]]; then
        # I'm not sure this can happen.
        echo "Windows";
elif [[ "$OSTYPE" == "freebsd"* ]]; then
        # ...
        echo "FreeBSD"
else
        # Unknown.
        echo "Unknown";
fi
