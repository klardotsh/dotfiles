export DISPLAY=:0

systemctl --user stop polybar

xrandr --output eDP-1 --auto
xrandr --output DP-2 --auto --right-of eDP-1

sleep 1

systemctl --user start polybar
