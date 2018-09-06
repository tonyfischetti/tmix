#!/usr/bin/python
# -*- coding: utf-8 -*-

import subprocess
import re



AC_POWER = False

system = subprocess.check_output("uname", shell=True).decode("utf-8")
if "Linux" in system:
    com = "acpi"
    info = subprocess.check_output(com, shell=True)
    info = info.decode("utf-8")
    percent = int(re.search(",\s+(\d+)%", info).group(1))
    # check for AC_POWER
    AC_POWER = True
    if re.search("Discharging", info):
        AC_POWER = False
else:
    # mac
    info = subprocess.check_output("pmset -g batt", shell=True)
    info = info.decode("utf-8")
    try:
        percent = int(re.search("(\d+)%", info).group(1))
    except:
        percent = None
    if "AC Power" in info:
        AC_POWER = True

outstring = ""

if percent:
    if 80 < percent <= 100:
        outstring += '█████'
        if percent == 100:
            outstring += ' ☼'
    elif 60 < percent <= 80:
        outstring += '████_'
    elif 40 < percent <= 60:
        outstring += '███__'
    elif 20 < percent <= 40:
        outstring += '██___'
    else:
        outstring += '█____'
        if percent < 10:
            outstring += ' ⚠'
else:
    outstring += ""



if AC_POWER:
    outstring += "   "


print(outstring)
