# $HOME/.xinitrc
# by iv597 | Modified 01 Dec 2012

# Dat numlock.
numlockx on &

# Because áóéúíìùèòàâôêûîñß are cool and probably broke your ANSI term...
setxkbmap us -variant dvorak-intl -option caps:backspace -option keypad:pointerkeys &

# Merge ALL OF THE BUFFERS!
autocutsel -fork &
autocutsel -selection PRIMARY -fork &

# Setup GTK2_RC for QT's sake
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Key repeat for CapsLock (a.k.a. BackSpace)
xset r 66 &

# Font paths
xset +fp $HOME/.fonts
xset +fp /usr/share/fonts/local # Inform the X server of new directories
xset +fp /usr/share/fonts/artwiz-latin1-fonts
xset fp rehash                  # Forces a new rescan

# Give URxvt some love
xrdb -load $HOME/.Xresources &

# Stop fucking with my displays (only one of them ever turned off...)
xset -dpms &
xset s off &

# ... and instead lock the whole session when I pass out on it!
xautolock -locker slock -time 10 &

# Who needs mice these days?
unclutter &

# Fancysause wallpaper on both wallpapers. 
# I use the same WP on both - 16:10 scales passably to 5:4 for me
imlibsetroot -x e -s f /home/j/.wallpaper &

# My awesomesausery at work...
conky -c $HOME/.config/conkyrc &

# As I'm using notify-osd for now, this is a necessary evil
compton &

# Because I like saving RAM. I think.
urxvtd &

# Because I have no choice with my HDAudio chip - OSS4 sounds horrible on here.
pulseaudio --start &

exec herbstluftwm

# vim:ft=sh

