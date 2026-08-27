#!/bin/sh

set -eu
command -v chezmoi >/dev/null 2>&1 || {
	printf '%s\n' 'move-in.sh: chezmoi is required' >&2
	exit 127
}
command -v git >/dev/null 2>&1 || {
	printf '%s\n' 'move-in.sh: git is required' >&2
	exit 127
}
command -v make >/dev/null 2>&1 || {
	printf '%s\n' 'move-in.sh: make is required' >&2
	exit 127
}

repo="$HOME/src/mine/dotfiles"

if test ! -d "$repo/.git"; then
	mkdir -p "$(dirname "$repo")"
	git clone https://git.sr.ht/~klardotsh/dotfiles "$repo"
fi

exec make -C "$repo" bootstrap
