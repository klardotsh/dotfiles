#!/usr/bin/env bash

die() { echo "not playing"; exit; }

pidof cmus >/dev/null || die

statu=`cmus-remote -Q | grep status`

[ "${statu}" == "status playing" ] || die

stream=`cmus-remote -Q | grep file | grep http`

title=`cmus-remote -Q | grep -m 1 title | cut -d' ' -f3-`
artist=`cmus-remote -Q | grep -v aaa_mode | grep -v albumartist | grep -m 1 artist | cut -d' ' -f3-`

if [[ ! -z $stream ]]; then
	streamURL=`echo ${stream} | cut -d' ' -f2`
	streamData=`python2 ${HOME}/bin/conky/shoutcast_meta.py ${streamURL} | cut -d"'" -f2`
	if `echo ${title} | grep "cliqhop" > /dev/null`; then
		title="soma.fm :: cliqhop"
	else
		if `echo ${title} | grep "public safety radio" > /dev/null`; then
			title="soma.fm :: sf-1033"
		else
			if `echo ${title} | grep "Soma" > /dev/null`; then
				title="soma.fm :: $(echo ${title} | cut -d':' -f1)"
			fi
		fi
	fi
	echo "${streamData} - ${title} "
else
	echo "${artist} - ${title}"
fi

