#!/usr/bin/env zsh

_SYSTEMD_MANGED_SERVICES=(
	"xbanish"
	"compton"
	"notify-osd"
	"autocutsel"
	"autocutsel-primary"
	"ibus-daemon"
)

if [[ $(hostname) == "gravity" ]]; then
	xrandr --output HDMI-A-0 --auto --below DisplayPort-2
	setroot -z .wallpaper -z .wallpaper
else
	setroot -z .wallpaper
fi

xsetroot -xcf /usr/share/icons/DMZ96/cursors/left_ptr 16
xrdb -merge /home/j/.Xresources

systemctl --user start $_SYSTEMD_MANGED_SERVICES

i3

systemctl --user stop $_SYSTEMD_MANGED_SERVICES
