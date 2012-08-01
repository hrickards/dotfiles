#!/bin/bash
############################
# install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
# Based upon michaeljsmalley's
############################

########## Variables

dir=~/dotfiles
files="vimrc vim bashrc beetsconfig tmux.conf"
x_files="Xdefaults xinitrc xbindkeysrc"

##########

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

if [ $1 = '--with-x' ]; then
  files="$files $x_files"
fi

# create symlinks 
for file in $files; do
    echo "Deleting old $file"
    rm -rf ~/.$file
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

# Run vundle
vim +BundleInstall +qall
