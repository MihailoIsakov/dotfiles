from i3pystatus import Status

status = Status(standalone=True)


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
    format=("%a %-d %T", 'America/Phoenix'),
    color="#DDDDFF")

#status.register("shell", command="echo `nvidia-smi | awk '/MiB/{print $9}'`", color="#FFFF88")

status.register("mem", format="{percent_used_mem}%", interval=1, color="#FF66FF")
# Shows the average load of the last minute and the last 5 minutes
# (the default value for format is used)
status.register("load", interval=1)
                #on_leftclick=["htop"])

# Shows your CPU temperature, if you have a Intel CPU
# status.register("temp",
    # format="{temp:.0f}°C",)

#status.register("shell", command="nvidia-smi | awk '/[0-9]+C/{print $3}'")


# Displays whether a DHCP client is running
status.register("runwatch",
    name="DHCP",
    path="/var/run/dhclient*.pid",)

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

#status.register("netspeed")
# Shows disk usage of /
# Format:
# 42/128G [86G]
status.register("disk",
    path="/",
    # format="{used}/{total}G [{avail}G]",)
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

# status.register("pomodoro", sound='/home/mihailo/media/audio/ping.mp3')


# trello urgent tasks

# status.register("shell", command='task active | grep "[0-9]" | awk "{$1=$2=$3=$4=$5=$6=""; printf($0)}"', color="#FFFF88")

status.run()
