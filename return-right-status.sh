#!/bin/bash

unamestr=`uname`
outstring=''
if [ "$unamestr" == 'Darwin' ]; then
    itunes=`~/.tmux/iTct.sh`
    bat=`python ~/.tmux/batstat.py`
    outstring="$itunes | $bat"
elif [ "$unamestr" == 'Linux' ]; then
    tunes=`~/.tmux/ltunes.pl`
    bat=`python3 ~/.tmux/batstat.py`
    outstring="$tunes | $bat"
fi

echo $outstring
