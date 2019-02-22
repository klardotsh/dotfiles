#!/usr/bin/env sh

PATHNAME=~/Pictures/Screenshots/screenshot-$(date -u +%Y-%m-%d-%TZ).png

slurp | grim -g - ${PATHNAME} && notify-send Screenshot ${PATHNAME}
