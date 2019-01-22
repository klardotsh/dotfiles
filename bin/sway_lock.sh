#!/usr/bin/env bash

# handle being called from systemd service
if [ -z "$XDG_RUNTIME_DIR" ] && [ -z "$SWAYSOCK"]; then
	uid=$(id -u $USER)
	export XDG_RUNTIME_DIR="/run/user/"$uid"/"
	export SWAYSOCK=$(find $XDG_RUNTIME_DIR -iname sway*sock)
fi

parallel grim -o {} /home/$USER/.lockscreen.{}.png ::: eDP-1 DP-2 HDMI-A-1

parallel convert -blur 0x6 /home/$USER/.lockscreen.{}.png /home/$USER/.lockscreen.{}.png ::: eDP-1 DP-2 HDMI-A-1

swaylock -i eDP-1:/home/$USER/.lockscreen.eDP-1.png -i DP-2:/home/$USER/.lockscreen.DP-2.png -i HDMI-A-1:/home/$USER/.lockscreen.HDMI-A-1.png
