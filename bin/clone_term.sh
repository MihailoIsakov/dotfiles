#! /bin/bash

# get PID of active window
PID=$(xdotool getwindowfocus getwindowpid)

# go to last child 
while [[ $(pgrep -P $PID) != "" ]] 
do
    PID=$(pgrep -P $PID)
done

# get childs path
PTH=$(pwdx $PID | cut --delimiter=" " --fields=2)

# open terminal at that path
nohup kitty --directory="$PTH" >&/dev/null &

