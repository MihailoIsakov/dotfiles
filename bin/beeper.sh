#! /bin/bash 

while true; do
    second=$(date +%S)
    if [[ $hour -ge 9 ]] && [[ $hour -le 22 ]]; then
        paplay --volume 50000 /usr/share/sounds/freedesktop/stereo/power-unplug.oga
    fi
    sleep 600
done
