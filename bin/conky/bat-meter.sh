#!/bin/bash

b=`cat /sys/class/power_supply/BATX/status`
l=$(echo  "(`cat /sys/class/power_supply/BATX/charge_now`/`cat /sys/class/power_supply/BATX/charge_full`)*100" | bc -l | cut -d'.' -f1)

[ $l -gt 85 ] && echo ӱӱӱӱӱ && exit
[ $l -gt 65 ] && echo ӱӱӱӱӰ && exit
[ $l -gt 50 ] && echo ӱӱӱӰӰ && exit
[ $l -gt 40 ] && echo ӱӱӰӰӰ && exit
[ $l -gt 20 ] && echo ӱӰӰӰӰ && exit
echo "\f7ӰӰӰӰӰ\fr" && exit

