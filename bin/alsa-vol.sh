#!/bin/bash

amixer get Master | egrep -o "[0-9]+%" | cut -d'%' -f1
