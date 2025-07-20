#!/usr/bin/env bash

# Prints the current disk, CPU, and RAM usage.

storageUsage="$(df | awk '/\/rw$/{print($5)}')"
[[ "$storageUsage" = "" ]] && storageUsage="$(df | awk '/\/$/{print($5)}')"
echo -n " $storageUsage "

# TODO: Improve somehow to avoid the sleep, and improve readability
cpuUsage="$(awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else printf "%.0f%", ($2+$4-u1)*100/(t-t1)}' <(grep 'cpu ' /proc/stat) <(sleep 1; grep 'cpu ' /proc/stat))"
echo -n " $cpuUsage "

ramUsage="$(free | awk '/Mem/{ printf("%.1f%", ($3/$2)*100) }')"
echo -n "󰍛 $ramUsage"
