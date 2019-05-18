#!/usr/bin/env sh

if [ which systemctl 2&>1 >/dev/null ]; then
	systemctl --user stop waybar
	systemctl --user stop mako
else
	SVDIR=${XDG_CONFIG_HOME}/sv sv stop waybar
	SVDIR=${XDG_CONFIG_HOME}/sv sv stop mako
	SVDIR=${XDG_CONFIG_HOME}/sv sv stop swaybg
fi

swaymsg exit
