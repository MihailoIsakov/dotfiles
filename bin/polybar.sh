#! /bin/bash

killall polybar

for MONITOR in $(xrandr -q | grep " connected" | cut -d" " -f1); do
    export MONITOR
    echo $MONITOR
    polybar main &
done
