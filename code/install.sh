#!/bin/bash
file=~/dotfiles/code/repos
dir=~/code/

old_dir=`pwd`
cd $dir
while read line
do
  echo "$(tput setaf 2)Repo $line$(tput sgr0)"
  git clone $line 2> /dev/null
done < $file
cd $old_dir
