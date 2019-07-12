#!/bin/sh
set -eu

ds=$(date -u +%Y-%m-%dT%H:%M:%S)
dir=dotfiles-$ds
mkdir $dir

files="$0
 ~/.vimrc
 ~/.bash.jack
 ~/.tmux.conf"

for f in $files
do
  dotless=${f#.}
  echo "cp $f $dir/$dotless"
done
# cp ~/.vimrc $dir/vimrc
# cp ~/.bash.jack $dir/bash.jack
# cp ~/.tmux.conf $dir/tmux.conf
