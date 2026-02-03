#! /bin/bash

# Take a screenshot
# scrot /tmp/screen_locked.png
gnome-screenshot -f /tmp/screen_locked.png

# Pixellate it 10x / corrupt it
# mogrify -scale 10% -scale 1000% /tmp/screen_locked.png
corrupter /tmp/screen_locked.png /tmp/screen_locked.png

# Pause dunst
dunstctl set-paused true

# Lock screen displaying this image.
i3lock -i /tmp/screen_locked.png

# Resume dunst
dunstctl set-paused false

# Turn the screen off after a delay.
sleep 60; pgrep i3lock && xset dpms force off
