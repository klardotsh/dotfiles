export DISPLAY=:0
xrandr --output eDP1 --auto
xrandr --output DP1-1 --auto --above eDP1
xrandr --output DP1-2 --auto --right-of DP1-1
setroot -z ${HOME}/.wallpaper -z ${HOME}/.wallpaper -z ${HOME}/.wallpaper
