#! /bin/bash

if [ $# -eq 0 ]; then
    #nohup gnome-terminal --working-directory="$PWD" >&/dev/null
    nohup kitty --directory="$PWD" >&/dev/null &
else
    for (( c=1; c<=$1; c++ )) 
    do
        #nohup gnome-terminal --working-directory="$PWD" >&/dev/null
        nohup kitty --directory="$PWD" >&/dev/null &
    done
fi
