
unamestr=`uname`
outstring=''
if [ "$unamestr" == 'Darwin' ]; then
    itunes=`~/.tmux/iTct.sh`
    bat=`python ~/.tmux/batstat.py`
    outstring="$itunes | $bat"
elif [ "$unamestr" == 'Linux' ]; then
    outstring=`python ~/.tmux/batstat.py`
fi

echo $outstring
