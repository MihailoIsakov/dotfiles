#! /bin/bash

killall polybar

if [[ $(hostname -s) = zver ]]; 
then
    MONITOR="DP-1"   polybar main &
    MONITOR="DP-2"   polybar main &
    MONITOR="DP-3"   polybar main &
    MONITOR="HDMI-1" polybar main &
elif [[ $(hostname -s) = framework ]]; 
then
    MONITOR="eDP-1"   polybar main
fi

