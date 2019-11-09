#!/usr/bin/env sh

export > ${XDG_RUNTIME_DIR}/sway_services.env

if [ -x /bin/systemctl ]; then
	systemctl --user start waybar
	systemctl --user start mako
elif [ -x /bin/sv ]; then
	SVDIR=${XDG_CONFIG_HOME}/sv sv start swaybg
	SVDIR=${XDG_CONFIG_HOME}/sv sv start waybar
	SVDIR=${XDG_CONFIG_HOME}/sv sv start mako
else
	mako &
	jack_control start
	pulseaudio -d && sleep 1
	waybar &
fi
