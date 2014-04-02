#!/bin/bash

DEVICE='wlp0s29u1u4u1'

strength=`cat /proc/net/wireless | grep ${DEVICE} | cut -d' ' -f5 | cut -d'.' -f1`

[[ $strength -gt 80 ]] && echo ӱӱӱӱӱ && exit
[[ $strength -gt 70 ]] && echo ӱӱӱӱӰ && exit
[[ $strength -gt 55 ]] && echo ӱӱӱӰӰ && exit
[[ $strength -gt 40 ]] && echo ӱӱӰӰӰ && exit
[[ $strength -gt 25 ]] && echo ӱӰӰӰӰ && exit
echo "\f7ӰӰӰӰӰ\fr" && exit
