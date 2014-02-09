#!/bin/bash

pkgs=$(/usr/bin/pacman -Qqu | wc -l)

echo $pkgs

