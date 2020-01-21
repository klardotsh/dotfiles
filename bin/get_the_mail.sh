#!/usr/bin/env sh

mbsync -a
notmuch new
killall -s USR1 alot
