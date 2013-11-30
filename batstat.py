#!/usr/bin/env python -tt
# -*- coding: utf-8 -*-

import subprocess
import re

info = subprocess.check_output("pmset -g batt", shell=True)
percent = int(re.search("(\d+)%", info).group(1))

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
    if percent < 10:
        outstring += ' ⚠'
    outstring += '█░░░░'



if "AC Power" in info:
    outstring += " ☍"


print outstring
