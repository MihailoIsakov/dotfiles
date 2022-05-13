#! /usr/bin/env python 

import i3

workspaces = i3.get_workspaces()
indices = [ws['num'] for ws in workspaces]
minind=1
while minind in indices:
    minind += 1

i3.workspace(str(minind))
