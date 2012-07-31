#!/bin/bash
############################
# install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
# Based upon michaeljsmalley's
############################

########## Variables

dir=~/dotfiles                       # dotfiles directory
files="vimrc vim"                    # list of files/folders to symlink in homedir

##########

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# create symlinks 
for file in $files; do
    echo "Deleting old $file"
    rm -rf ~/.$file
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

# Run vundle
vim +BundleInstall +qall
