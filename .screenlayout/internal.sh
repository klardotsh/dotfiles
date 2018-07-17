export DISPLAY=:0

xrandr --output DP-1 --off --output DP-2 --off
systemctl --user restart polybar
