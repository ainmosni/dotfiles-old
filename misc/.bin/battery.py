#!/usr/bin/env python3
#
# A battery indicator blocklet script for i3blocks

from subprocess import check_output

status = check_output(['acpi'], universal_newlines=True)
state = status.split(": ")[1].split(", ")[0]
commasplitstatus = status.split(", ")
percentleft = int(commasplitstatus[1].rstrip("%\n"))

FA_LIGHTNING = "\uf0e7"
FA_PLUG = "\uf1e6"

fulltext = "{} ".format(FA_LIGHTNING)
timeleft = ""

if state == "Discharging":
    time = commasplitstatus[-1].split()[0]
    time = ":".join(time.split(":")[0:2])
    timeleft = " ({})".format(time)
else:
    fulltext += " " + FA_PLUG

form = '{}%'
fulltext += form.format(percentleft)
fulltext += timeleft

print(fulltext)
print(fulltext)
