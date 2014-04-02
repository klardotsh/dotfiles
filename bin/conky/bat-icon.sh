#!/usr/bin/env bash

b=`cat /sys/class/power_supply/BATX/status`
l=$(echo  "(`cat /sys/class/power_supply/BATX/charge_now`/`cat /sys/class/power_supply/BATX/charge_full`)*100" | bc -l | cut -d'.' -f1)

[ ${b,,} == "full" ] && echo " Ѹ" && exit
[ ${b,,} == "charging" ] && echo " Ѹ" && exit

[ $l -gt 80 ] && echo "Ѽ" && exit
[ $l -gt 60 ] && echo "ѽ" && exit
[ $l -gt 40 ] && echo "Ѿ" && exit
[ $l -gt 20 ] && echo "ѿ" && exit

echo "Ҁ"

