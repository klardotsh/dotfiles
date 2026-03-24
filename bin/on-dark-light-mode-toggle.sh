#!/usr/bin/env sh

# opencode (and the in-house TUI library they wrote for it) only supports RGBA
# truecolor, not ANSI color codes, and so the "system" theme in opencode asks
# the terminal for the currently defined set of colors at startup, and on USR2
# signal. Thus, when we toggle dark/light mode, we need to tell opencode to
# recalculate the color palette to keep things readable. Ugh, why do
# applications get clever?
killall -SIGUSR2 opencode
