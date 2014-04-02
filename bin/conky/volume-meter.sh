#!/bin/bash

muted=`amixer get Master | egrep -o "\[on\]|\[off\]"`
vol=`amixer get Master | egrep -o "[0-9]+%" | cut -d'%' -f1 | head -n 1`

if [[ $muted == "[off]" ]]; then
	[[ $vol -gt 80 ]] && echo "\f7ӱӱӱӱӱ\fr" && exit
	[[ $vol -gt 70 ]] && echo "\f7ӱӱӱӱӰ\fr" && exit
	[[ $vol -gt 55 ]] && echo "\f7ӱӱӱӰӰ\fr" && exit
	[[ $vol -gt 40 ]] && echo "\f7ӱӱӰӰӰ\fr" && exit
	[[ $vol -gt 25 ]] && echo "\f7ӱӰӰӰӰ\fr" && exit
	echo "\f7ӰӰӰӰӰ\fr" && exit
fi

[[ $vol -gt 80 ]] && echo "ӱӱӱӱӱ" && exit
[[ $vol -gt 70 ]] && echo "ӱӱӱӱӰ" && exit
[[ $vol -gt 55 ]] && echo "ӱӱӱӰӰ" && exit
[[ $vol -gt 40 ]] && echo "ӱӱӰӰӰ" && exit
[[ $vol -gt 25 ]] && echo "ӱӰӰӰӰ" && exit
echo "ӰӰӰӰӰ" && exit
