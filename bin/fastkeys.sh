#! /bin/bash 

# Since fastkeys.sh needs to be run every time a keyboard is plugged in, 
# put the following line into /etc/udev/rules.d/iris_keyboard.rules:
#   ATTRS{idVendor}=="cb10", ATTRS{idProduct}=="2256", RUN+="/usr/bin/su mihailo -c \"DISPLAY=:0 XAUTHORITY=/home/mihailo/.Xauthority /home/mihailo/bin/fastkeys.sh"

# faster keyboard
xset r rate 180 60

