#!/usr/bin/env zsh

xsetroot -xcf /usr/share/icons/DMZ96/cursors/left_ptr 16
xrdb -merge /home/j/.Xresources

#systemctl --user start xbanish
#systemctl --user start mplugd

autocutsel -fork &
autocutsel -selection PRIMARY -fork &

ibus-daemon &
compton -b -C --vsync drm --shadow-exclude 'bounding_shaped' --no-fading-openclose
/usr/lib/notify-osd/notify-osd &
$HOME/bin/conky_bar.sh &

xss-lock slock &

herbstluftwm

systemctl --user stop xbanish
systemctl --user stop mplugd
