#!/usr/bin/env bash

pidof conky >/dev/null && kill `pidof conky`
pidof lemonbar >/dev/null && kill `pidof lemonbar`

conky -c $HOME/.config/conkyrc 2>/dev/null | lemonbar -d -f "CamingoCode-11" eDP1 -g 1904x22+8+0
