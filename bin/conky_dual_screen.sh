#!/usr/bin/env bash

pidof conky >/dev/null && kill `pidof conky`
pidof bar_1366 >/dev/null && kill `pidof bar_1366`
pidof bar_1440 >/dev/null && kill `pidof bar_1440`

conky -c $HOME/.config/conkyrc 2>/dev/null | tee >(/home/j/bin/bar_1366 -p) | /home/j/bin/bar_1440 -p
