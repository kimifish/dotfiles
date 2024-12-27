#!/bin/python3
import sys
import os
import re

workdir="/home/kimifish/bin/statusbar/markup.py"
flag="norm"

D_CRIT = 1
D_WARN = 5

grepline = sys.argv[1]
order = sys.argv[2]
output = os.popen('df --output=source,avail')

for line in output:
    if re.search(grepline, line):
        raw_size = line.split()[1]

size = int(raw_size) / 1024 / 1024
if size < 10:
    size = round(size, 1)
else:
    size = int(size)

if size < D_CRIT:
    flag = "crit"
elif size < D_WARN:
    flag = "warn"
size = " " + str(size) + "G"
os.execv(workdir, ['sdf', order, flag, size])

