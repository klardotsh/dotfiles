#!/usr/bin/env sh

if [ -x /bin/systemctl ]; then
	systemctl --user stop waybar
	systemctl --user stop mako
elif [ -x /bin/sv ]; then
	SVDIR=${XDG_CONFIG_HOME}/sv sv stop waybar
	SVDIR=${XDG_CONFIG_HOME}/sv sv stop mako
	SVDIR=${XDG_CONFIG_HOME}/sv sv stop swaybg
else
	pulseaudio -k
	killall waybar
	killall mako
fi

swaymsg exit
