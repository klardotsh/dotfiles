#!/usr/bin/env zsh
# iv597's xinitrc
# vim:ft=sh

LOCKER=slock
LOCKTIME=10
WALLPAPER=$HOME/.wallpaper
LAYOUT=dvorak

source $HOME/.zshrc

setxkbmap $LAYOUT -option caps:backspace -option keypad:pointerkeys -option compose:ralt &
xset r 66 &
numlockx on &

#unclutter &
synclient TapButton2=3
synclient TapButton3=2
synclient VertScrollDelta=-19 # just a flip of the default for natural/"aussie" scrolling

autocutsel -fork &
autocutsel -selection PRIMARY -fork &

xset fp+ $HOME/.fonts
xset fp+ /usr/share/fonts/local
xset fp+ /usr/share/fonts/TTF
xset fp+ /usr/share/fonts/misc
xset fp+ /usr/share/fonts/t1-dejavu-ib
xset fp rehash
xset -dpms &
xset s off &

xrdb -load $HOME/.Xresources &

xautolock -locker $LOCKER -time $LOCKTIME &

xrandr --output HDMI1 --auto --right-of LVDS1
/home/j/bin/conky_bar.sh &

imlibsetroot -x e -s f $WALLPAPER &

dunst -config $HOME/.config/dunst/dunstrc &

compton --config $HOME/.config/compton/compton.conf &

/home/j/bin/offlineimap_idle.sh &

exec dbus-launch herbstluftwm
#exec dbus-launch gnome-session
