#! /usr/bin/env python3 

import i3ipc

i3 = i3ipc.Connection()


def on_window_focus(i3, e):
    focused = i3.get_tree().find_focused()
    # ws_name = "%s:%s" % (focused.workspace().num, focused.window_class)
    ws_name = "%s:%s" % (focused.workspace().num, focused.name.split()[0])
    i3.command('rename workspace to "%s"' % ws_name)


i3.on("window::focus", on_window_focus)
i3.main()

