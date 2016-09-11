xsetroot -xcf /usr/share/icons/DMZ96/cursors/left_ptr 16

xautolock -locker slock -time 10 &

xrdb -merge /home/j/.Xresources

xbanish &

autocutsel -fork &
autocutsel -selection PRIMARY -fork &

exec awesome

