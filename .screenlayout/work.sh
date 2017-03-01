export DISPLAY=:0

xrandr --output eDP1 --auto
xrandr --output DP1-1 --auto --right-of eDP1
xrandr --output DP1-2 --auto --right-of DP1-1

herbstclient reload
