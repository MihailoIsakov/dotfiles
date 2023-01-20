#! /bin/bash

# Take a screenshot
# scrot /tmp/screen_locked.png
gnome-screenshot -f /tmp/screen_locked.png

# Pixellate it 10x
mogrify -scale 10% -scale 1000% /tmp/screen_locked.png

#corrupter /tmp/screen_locked.png /tmp/screen_corrupted.png

# Lock screen displaying this image.
i3lock -i /tmp/screen_locked.png
#i3lock -i /tmp/screen_corrupted.png

# Turn the screen off after a delay.
sleep 60; pgrep i3lock && xset dpms force off
