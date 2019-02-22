#!/usr/bin/env sh

PATHNAME=~/Pictures/Screenshots/screenshot-$(date -u +%Y-%m-%d-%TZ).png

grim ${PATHNAME} && notify-send Screenshot ${PATHNAME}
