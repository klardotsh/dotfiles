#!/usr/bin/env bash

export DISPLAY=":0"

sleep 1

`cat ${HOME}/.xinitrc | grep setxkb`
