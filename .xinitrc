#!/usr/bin/env zsh

_SYSTEMD_MANGED_SERVICES=(
	"xbanish"
	"compton"
	"notify-osd"
	"autocutsel"
	"autocutsel-primary"
)

xsetroot -xcf /usr/share/icons/DMZ96/cursors/left_ptr 16
xrdb -merge /home/j/.Xresources

systemctl --user start $_SYSTEMD_MANGED_SERVICES

awesome

systemctl --user stop $_SYSTEMD_MANGED_SERVICES
