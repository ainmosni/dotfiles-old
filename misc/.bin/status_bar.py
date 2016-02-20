# -*- coding: utf-8 -*-

import subprocess

from i3pystatus import Status
from i3pystatus.updates import pacman, cower

status = Status(standalone=True)

# Displays clock like this:
# Tue 30 Jul 11:59:46 PM KW31
#                          ^-- calendar week
status.register("clock",
    format="%Y-%m-%d %X",)

status.register("weather",
                format="Berlin: {current_temp}",
                colorize=True,
                location_code="GMXX0007")
# Shows the average load of the last minute and the last 5 minutes
# (the default value for format is used)
status.register("load")

# Shows your CPU temperature, if you have a Intel CPU
status.register("temp",
    format="{temp:.0f}°C",)

# The battery monitor has many formatting options, see README for details

# Shows the address and up/down state of eth0. If it is up the address is shown in
# green (the default value of color_up) and the CIDR-address is shown
# (i.e. 10.10.10.42/24).
# If it's down just the interface name (eth0) will be displayed in red
# (defaults of format_down and color_down)
#
# Note: the network module requires PyPI package netifaces
#status.register("network",
    #interface="eno1",
    #format_up="{v4cidr}",)

# Has all the options of the normal network and adds some wireless specific things
# like quality and network names.
#
# Note: requires both netifaces and basiciw
status.register("network",
    interface="wlp4s0",
    format_up="{interface} -- {v4cidr} -- {essid} {quality_bar}%",)

# Shows disk usage of /
# Format:
# 42/128G [86G]
status.register("disk",
    path="/",
    format="{used}/{total}G [{avail}G]",)

status.register("pulseaudio")

status.register("updates",
                format="Updates: {count}",
                format_no_updates="No updates",
                backends = [pacman.Pacman(), cower.Cower()])

status.run()

