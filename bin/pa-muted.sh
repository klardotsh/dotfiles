#!/usr/bin/env bash

# for conky
# outputs muted icon if muted, headphone if plugged in,
# or finally falls back on speaker icon
#
# uses my cure-icons.pcf mod

ponymix is-muted 2>/dev/null && echo "ӛ" && exit
[ `pacmd list-sinks | grep 'active port' | awk '{ print $3 }'` == "<analog-output-headphones>" ] && echo "Ӳ" || echo "ӝ"
