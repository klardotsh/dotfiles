#!/usr/bin/env sh

export > ${XDG_RUNTIME_DIR}/sway_services.env

if [ -x /bin/systemctl ]; then
	systemctl --user start waybar
	systemctl --user start mako
else
	SVDIR=${XDG_CONFIG_HOME}/sv sv start swaybg
	SVDIR=${XDG_CONFIG_HOME}/sv sv start waybar
	SVDIR=${XDG_CONFIG_HOME}/sv sv start mako
fi
