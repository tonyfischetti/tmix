#!/bin/bash

#  TODO: this needs work
# for example, trim the song name if too long

unamestr=`uname`
outstring=''
if [ "$unamestr" == 'Darwin' ]; then
    itunes=`~/.tmux/iTct.sh`
    bat=`python3 ~/.tmux/batstat.py`
    outstring="$itunes | $bat"
elif [ "$unamestr" == 'Linux' ]; then
    tunes=`~/.tmux/ltunes.pl`
    bat=`python3 ~/.tmux/batstat.py`
    outstring="$tunes | $bat"
fi

echo $outstring
