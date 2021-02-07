#!/usr/bin/env sh

echo 'Which system is this? (see system-configurations/*.nix for options)'
read -r KLARDOTSH_HOSTNAME

env -i PATH="${PATH}" KLARDOTSH_HOSTNAME="${KLARDOTSH_HOSTNAME}" envsubst < configuration.nix.tpl > configuration.nix
