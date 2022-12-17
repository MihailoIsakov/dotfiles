#! /bin/bash

killall polybar

if [[ $(hostname -s) = mihailo-thin ]]; 
then
    MONITOR="DP-0"   polybar main &
    MONITOR="DP-2"   polybar main &
    MONITOR="DP-4"   polybar main &
elif [[ $(hostname -s) = framework ]]; 
then
    MONITOR="eDP-1"   polybar main
fi

