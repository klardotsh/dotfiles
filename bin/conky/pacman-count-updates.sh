#!/bin/bash

# Depends on a package sync cron job
# I use: /etc/cron.hourly/1pacman
# ping 8.8.8.8 -c 1 >/dev/null && /usr/bin/pacman -Syuw --noconfirm --noprogressbar >/dev/null 2>&1

pkgs=$(/usr/bin/pacman -Qqu | wc -l)

echo "${pkgs}"

