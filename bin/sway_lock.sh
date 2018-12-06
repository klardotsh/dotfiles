#!/usr/bin/env bash

# handle being called from systemd service
if [ -z "$XDG_RUNTIME_DIR" ] && [ -z "$SWAYSOCK"]; then
	uid=$(id -u $USER)
	export XDG_RUNTIME_DIR="/run/user/"$uid"/"
	export SWAYSOCK=$(find $XDG_RUNTIME_DIR -iname sway*sock)
fi

grim -o eDP-1 /home/$USER/.lockscreen.edp.png
grim -o DP-2 /home/$USER/.lockscreen.dp.png
grim -o HDMI-A-1 /home/$USER/.lockscreen.hdmia1.png

convert -blur 0x6 /home/$USER/.lockscreen.edp.png /home/$USER/.lockscreen.edp.png
convert -blur 0x6 /home/$USER/.lockscreen.dp.png /home/$USER/.lockscreen.dp.png
convert -blur 0x6 /home/$USER/.lockscreen.hdmia1.png /home/$USER/.lockscreen.hdmia1.png

swaylock -i eDP-1:/home/$USER/.lockscreen.edp.png -i DP-2:/home/$USER/.lockscreen.dp.png -i HDMI-A-1:/home/$USER/.lockscreen.hdmia1.png
