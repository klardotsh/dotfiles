#!/usr/bin/env bash

# 13" rMBP
xrandr --output eDP-0 --dpi 227

xrdb -merge ${HOME}/.Xresources

setxkbmap dvorak -option compose:ralt -option ctrl:nocaps &

compton --config ${HOME}/.config/compton/compton.conf &

imlibsetroot -x e -s f ${HOME}/.wallpaper

xautolock -time 10 -locker slock &

synclient PalmDetect=1
synclient TapButton2=3 # Two-Finger Right Click
synclient TapButton3=2 # Three-Finger Middle Click
synclient VertScrollDelta=-90 # Natural Scrolling
synclient HorizScrollDelta=-90 # Natural Scrolling

exec dbus-launch herbstluftwm

