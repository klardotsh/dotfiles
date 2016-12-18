#!/usr/bin/env zsh

xsetroot -xcf /usr/share/icons/DMZ96/cursors/left_ptr 16
xrdb -merge /home/j/.Xresources

xautolock -locker slock -time 10 &

xbanish &

autocutsel -fork &
autocutsel -selection PRIMARY -fork &

ibus-daemon &

exec herbstluftwm
