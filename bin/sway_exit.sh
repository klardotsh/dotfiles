#!/usr/bin/env sh

if [ -x /bin/systemctl ]; then
	systemctl --user stop waybar
	systemctl --user stop mako
else
	SVDIR=${XDG_CONFIG_HOME}/sv sv stop waybar
	SVDIR=${XDG_CONFIG_HOME}/sv sv stop mako
	SVDIR=${XDG_CONFIG_HOME}/sv sv stop swaybg
fi

swaymsg exit
