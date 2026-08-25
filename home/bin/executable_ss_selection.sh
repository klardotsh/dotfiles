#!/usr/bin/env sh

# MS Teams and other poorly-written softwares choke on colons in filenames, so
# use underscores instead.
PATHNAME=~/Pictures/Screenshots/screenshot-$(date -u +%Y-%m-%d-%TZ | tr ':' '_').png

grimshot --notify save anything "${PATHNAME}"
