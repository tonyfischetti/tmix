#!/usr/bin/env python -tt
# -*- coding: utf-8 -*-

import subprocess
import re


AC_POWER = False

system = subprocess.check_output("uname", shell=True).decode("utf-8")
if "Linux" in system:
    com = "upower -i $(upower -e | grep 'BAT')"
    info = subprocess.check_output(com, shell=True)
    info = info.decode("utf-8")
    percent = int(re.search("percentage:\s+(\d+)%", info).group(1))
    # check for AC_POWER
    if re.search("state:\s+charging", info):
        AC_POWER = True
else:
    # mac
    info = subprocess.check_output("pmset -g batt", shell=True)
    info = info.decode("utf-8")
    percent = int(re.search("(\d+)%", info).group(1))
    if "AC Power" in info:
        AC_POWER = True

outstring = ""

if 80 < percent <= 100:
    outstring += '█████'
    if percent == 100:
        outstring += ' ☼'
elif 60 < percent <= 80:
    outstring += '████░'
elif 40 < percent <= 60:
    outstring += '███░░'
elif 20 < percent <= 40:
    outstring += '██░░░'
else:
    outstring += '█░░░░'
    if percent < 10:
        outstring += ' ⚠'



if AC_POWER:
    outstring += " ☍"


print(outstring)
