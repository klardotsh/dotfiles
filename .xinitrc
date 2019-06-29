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
	${HOME}/.screenlayout/default.sh
	setroot -z .wallpaper -z .wallpaper
	xset -dpms
else
	setroot -z .wallpaper
fi

xsetroot -xcf /usr/share/icons/capitaine-cursors/cursors/left_ptr 16
xrdb -merge /home/j/.Xresources

systemctl --user start $_SYSTEMD_MANGED_SERVICES

i3

systemctl --user stop $_SYSTEMD_MANGED_SERVICES
