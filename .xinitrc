setxkbmap dvorak -option compose:ralt -option ctrl:nocaps

xinput set-prop "DLL0704:01 06CB:76AE Touchpad" "libinput Tapping Enabled" 1
xinput set-prop "DLL0704:01 06CB:76AE Touchpad" "libinput Natural Scrolling Enabled" 1

xsetroot -xcf /usr/share/icons/DMZ96/cursors/left_ptr 16

xautolock -locker slock -time 10 &

xrdb -merge /home/j/.Xresources

#compton --config /home/j/.config/compton/compton.conf &

exec awesome

