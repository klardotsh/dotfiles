setxkbmap dvorak -option compose:ralt -option ctrl:nocaps

xinput set-prop 11 274 1 # Tap To Click
xinput set-prop 11 282 1 # Natural Scrolling

sxhkd &
compton --config .config/compton/compton.conf &

setroot -z ~/.wallpaper

exec dbus-launch bspwm
