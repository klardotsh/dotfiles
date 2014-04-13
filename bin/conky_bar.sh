#!/usr/bin/env bash

pidof conky >/dev/null && kill `pidof conky`
pidof bar >/dev/null && kill `pidof bar`

conky -c $HOME/.config/conkyrc 2>/dev/null | /home/j/bin/bar -f "-*-cure-*-*-*-*-11-*-*-*-*-*-*-*" -g 1366x16
