#! /bin/bash

spotify=$(xdotool search --onlyvisible --class "spotify")
chrome=$(xdotool search --onlyvisible --class "google-chrome")
echo $chrome
chrome=$(echo $chrome | xargs -n1 xprop -id | grep I3 | cut -d ' ' -f 3)
obsidian=$(xdotool search --onlyvisible --class "obsidian" | head -n 1)
todoist=$(xdotool search --onlyvisible --classname ".*todoist.*")

echo $chrome

if [[ spotify -ne 0 ]]; then
    i3-msg "[class=Spotify] focus, scratchpad show"
elif [[ $1 == "spotify" ]]; then
    i3-msg "focus output DP-4; [instance=spotify] scratchpad show, fullscreen enable;"
fi

if [[ chrome -ne 0 ]]; then
    i3-msg "[class=Google-chrome] focus, scratchpad show"
elif [[ $1 == "google-chrome" ]]; then
    i3-msg "focus output DP-2; [class=Google-chrome] scratchpad show, fullscreen enable;"
fi

if [[ obsidian -ne 0 ]]; then
    i3-msg "[title=\".*obsidian.*\"] focus, scratchpad show;"
    i3-msg "[title=\".*myobs.*\"] focus, scratchpad show;"
elif [[ $1 == "obsidian" ]] ; then
    i3-msg "focus output HDMI-0; [title=\".*obsidian.*\"] scratchpad show, fullscreen enable;"
    i3-msg "focus output DP-4; [title=\".*myobs.*\"] scratchpad show, fullscreen enable;"
fi

if [[ todoist -ne 0 ]]; then
    i3-msg "[instance="todoist"] focus, scratchpad show"
elif [[ $1 == "todoist" ]] ; then
    i3-msg "focus output DP-4; [instance=todoist] scratchpad show, fullscreen enable;"
fi
