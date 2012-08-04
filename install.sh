#!/bin/bash
############################
# install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/homefiles
# Based upon michaeljsmalley's
############################

########## Variables

dir=~/homefiles
files="vimrc vim bashrc beetsconfig tmux.conf"
x_files="Xdefaults xinitrc xbindkeysrc xmonad"
code_repos_file="coderepos"
code_repos_dir=~/code/

##########

# change to the homefiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

if [ "$1" = '--with-x' ]; then
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

##########
old_dir=`pwd`
cd $code_repos_dir
while read line
do
  echo "Cloning $line"
  git clone $line
done < "$dir/$code_repos_file"
cd $old_dir
