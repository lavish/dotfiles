#!/bin/dash

test $(cat /sys/block/sda/device/unload_heads) -ne 0 && echo "" | dzen2 -fn -*-snap-*-*-*-*-*-*-*-*-*-*-*-* -bg '#c80000' -ta c -w 12 -h 12 -x 1264 -y 4 -p 3

exit 0
