#!/bin/bash

muted=`amixer get Master | egrep -o "\[on\]|\[off\]"`
vol=`amixer get Master | egrep -o "[0-9]+%" | cut -d'%' -f1 | head -n 1`

if [[ $muted == "[off]" ]]; then
	[[ $vol -gt 80 ]] && echo "%{F#FFa0864b}ӱӱӱӱӱ%{F#FFa5a5a5}" && exit
	[[ $vol -gt 70 ]] && echo "%{F#FFa0864b}ӱӱӱӱӰ%{F#FFa5a5a5}" && exit
	[[ $vol -gt 55 ]] && echo "%{F#FFa0864b}ӱӱӱӰӰ%{F#FFa5a5a5}" && exit
	[[ $vol -gt 40 ]] && echo "%{F#FFa0864b}ӱӱӰӰӰ%{F#FFa5a5a5}" && exit
	[[ $vol -gt 25 ]] && echo "%{F#FFa0864b}ӱӰӰӰӰ%{F#FFa5a5a5}" && exit
	echo "%{F#FFa0864b}ӰӰӰӰӰ%{F#FFa5a5a5}" && exit
fi

[[ $vol -gt 80 ]] && echo "ӱӱӱӱӱ" && exit
[[ $vol -gt 70 ]] && echo "ӱӱӱӱӰ" && exit
[[ $vol -gt 55 ]] && echo "ӱӱӱӰӰ" && exit
[[ $vol -gt 40 ]] && echo "ӱӱӰӰӰ" && exit
[[ $vol -gt 25 ]] && echo "ӱӰӰӰӰ" && exit
echo "ӰӰӰӰӰ" && exit
