#! /bin/bash

if [[ $1 != "spotify" ]] ; then         
    i3-msg [instance="spotify"] focus, scratchpad show;
fi

if [[ $1 != "todoist" ]] ; then         
    i3-msg [instance="todoist"] focus, scratchpad show;
fi

if [[ $1 != "google-chrome" ]] ; then         
    i3-msg [instance="google-chrome"] focus, scratchpad show;
fi

if [[ $1 != "obsidian" ]] ; then         
    i3-msg [instance="obsidian"] focus, scratchpad show;
fi

i3-msg "focus output DP-2; [instance="$1"] scratchpad show, fullscreen enable;"

# spotify=$(xdotool search --onlyvisible --class "spotify")
# chrome=$(xdotool search --onlyvisible --class "google-chrome")
# 
# if [[ spotify -ne 0 ]]; then
#     i3-msg "[class=spotify] focus, scratchpad show"
# fi
# 
# if [[ chrome -ne 0 ]]; then
#     i3-msg "[instance='google-chrome'] focus, scratchpad show"
# fi

