#! /usr/bin/env python3 
"""
When the focused screen is on the MONITOR output and the user tries to focus down, 
a keystroke will be sent instead. This keystroke should be caught by synergy. 
Otherwise, the focus should move down as normal.

Issues: 
1. If the focused window is in a vertical stack, the script will still send the
keystroke. The script should be fixed to check if the current window is the bottom one.
2. The script should remove the focus on the previous monitor on a change.
"""

import subprocess
import i3ipc

MONITOR="DP-2"
# Disable Meta+k, press Ctrl+Shift+p, enable back Meta since it's still held down
KEYSTROKE="keyup Super_L keyup k keydown Ctrl keydown Shift key p keyup Ctrl keyup Shift keydown Super_L" 
COMMAND="xdotool " + KEYSTROKE

i3 = i3ipc.Connection()

# get the name of the top right output 
target_output_names = []
workspaces_list= i3.get_workspaces()
for w in workspaces_list:
    if w.output == MONITOR:
        target_output_names.append(w.name)

focused = i3.get_tree().find_focused()

if focused.workspace().name in target_output_names: 
    print("send command")
    # subprocess.Popen(["beep"], stdout=subprocess.PIPE)
    subprocess.Popen(COMMAND.split(), stdout=subprocess.PIPE)

else: 
    print("shift focus normally")
    i3.command('focus down')

