from i3pystatus import Status

status = Status(standalone=True)


# Brightness
status.register("shell", command="echo ☀;LC_ALL=C printf '%.*f' 0 `xbacklight`", color="#FFFF00")

# Shows pulseaudio default sink volume
#
# Note: requires libpulseaudio from PyPI
status.register("pulseaudio",
    format="♪{volume}",)

# Displays clock like this:
# Tue 30 Jul 11:59:46 PM KW31
#                          ^-- calendar week
status.register("clock",
    #format="%a %-d %b %X KW%V",)
    format=("%T", 'Europe/Belgrade'),
    color="#5555FF")

status.register("clock",
    #format="%a %-d %b %X KW%V",)
    format=("%a %-d %T", 'America/New_York'),
    color="#DDDDFF")



#status.register("shell", command="echo `nvidia-smi | awk '/MiB/{print $9}'`", color="#FFFF88")

status.register("mem", format="{percent_used_mem}%", interval=1, color="#FF66FF")
# Shows the average load of the last minute and the last 5 minutes
# (the default value for format is used)
status.register("load", interval=1)
                #on_leftclick=["htop"])

# Shows your CPU temperature, if you have a Intel CPU
status.register("temp",
    format="{temp:.0f}°C",)

#status.register("shell", command="nvidia-smi | awk '/[0-9]+C/{print $3}'")


# The battery monitor has many formatting options, see README for details

# This would look like this, when discharging (or charging)
# ↓14.22W 56.15% [77.81%] 2h:41m
# And like this if full:
# =14.22W 100.0% [91.21%]
#
# This would also display a desktop notification (via D-Bus) if the percentage
# goes below 5 percent while discharging. The block will also color RED.
# If you don't have a desktop notification demon yet, take a look at dunst:
#   http://www.knopwob.org/dunst/
status.register("battery",
    #format="{status}/{consumption:.2f}W {percentage:.2f}% [{percentage_design:.2f}%] {remaining:%E%hh:%Mm}",
    format="[{percentage_design:.2f}%]{remaining:%E%hh:%Mm}",
    alert=True,
    alert_percentage=5,
    status={
        "DIS": "↓",
        "CHR": "↑",
        "FULL": "=",
    },)

# This would look like this:
# Discharging 6h:51m
status.register("battery",
    #format="{status} {remaining:%E%hh:%Mm}",
    format="{remaining:%E%hh:%Mm}",
    alert=True,
    alert_percentage=5,
    status={
        "DIS":  "Discharging",
        "CHR":  "Charging",
        "FULL": "Bat full",
    },)

# Displays whether a DHCP client is running
#status.register("runwatch",
    #name="DHCP",
    #path="/var/run/dhclient*.pid",)

status.register("shell", command="public_ip.sh", color="#55FF55")

# Shows the address and up/down state of eth0. If it is up the address is shown in
# green (the default value of color_up) and the CIDR-address is shown
# (i.e. 10.10.10.42/24).
# If it's down just the interface name (eth0) will be displayed in red
# (defaults of format_down and color_down)
#
# Note: the network module requires PyPI package netifaces
#status.register("network",
    #interface="eth0",
    #format_up="{v4cidr}",)

# Note: requires both netifaces and basiciw (for essid and quality)
status.register("network",
    interface="wlan0",
    format_up="{essid} {quality:03.0f}% {v4}",)

#status.register("netspeed")
# Shows disk usage of /
# Format:
# 42/128G [86G]
status.register("disk",
    path="/",
    #format="{used}/{total}G [{avail}G]",)
    format="[{avail}G]",)

# LXC Container names and their IPs
# status.register("shell", command="sudo lxc-ls -f | awk '/RUNNING/{print $1, $3}'", color="#5555FF")

# Print trello URGENT board 
#status.register("shell", 
    #command="trello show-cards -b 'Tessier Ashpool' -l 'URGENT - today' | awk '/*/{first = $1; $1 = \"\"; print $0; }'", 
    #on_leftclick=["firefox https://trello.com/b/qgndq5Cc/tessier-ashpool"],
    #color='#FF9900', 
    #interval=100) 

# Important
#status.register("shell", 
    #command="trello show-cards -b 'Tessier Ashpool' -l 'Important - 3 days' | awk '/*/{first = $1; $1 = \"\"; print $0; }'", 
    #on_leftclick=["firefox https://trello.com/b/qgndq5Cc/tessier-ashpool"],
    #color='#994400', 
    #interval=100) 

status.register("shell", 
    command="cat ~/.i3red", 
    color='#FF0000')

#status.register("xkblayout", layouts=["us", "rs(latin)"])

# Shows mpd status
# Format:
# Cloud connected▶Reroute to Remain
#status.register("mpd",
    #format="{title}{status}{album}",
    #status={
        #"pause": "▷",
        #"play": "▶",
        #"stop": "◾",
    #},)

#status.register("pomodoro", sound='/usr/share/sounds/freedesktop/stereo/message.oga')


# trello urgent tasks

status.run()
