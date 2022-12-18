#! /bin/bash

# killall polybar

if [[ $(hostname -s) = zver ]]; 
then
    MONITOR="DP-0"   polybar main &
    MONITOR="DP-2"   polybar main &
    MONITOR="DP-4"   polybar main &
    MONITOR="HDMI-0" polybar main &
elif [[ $(hostname -s) = mihailo-framework ]]; 
then
    MONITOR="eDP-1"   polybar main
    MONITOR="DP-3-1"  polybar main
fi

