#! /bin/sh

killall polybar
MONITOR="DP-1"   polybar main &
MONITOR="DP-2"   polybar main &
MONITOR="DP-3"   polybar main &
MONITOR="HDMI-1" polybar main &

