#!/usr/bin/env zsh

xsetroot -xcf /usr/share/icons/DMZ96/cursors/left_ptr 16
xrdb -merge /home/j/.Xresources

xautolock -locker slock -time 10 &

xbanish &

autocutsel -fork &
autocutsel -selection PRIMARY -fork &

ibus-daemon &
compton -b -C --vsync drm --shadow-exclude 'bounding_shaped' --no-fading-openclose
/usr/lib/notify-osd/notify-osd &
$HOME/bin/conky_bar.sh &

exec herbstluftwm
