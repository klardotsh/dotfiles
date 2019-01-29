#!/usr/bin/env sh

systemctl --user stop waybar
systemctl --user stop mako
swaymsg exit
