#!/usr/bin/env bash

set -euxo pipefail

OS="$(uname -s)"

not_darwin() {
	[ "${OS}" != "Darwin" ]
}

# ensure various required things are installed
hash curl
hash git
hash nvim

mkdir -p ~/src/mine
[ ! -d ~/src/mine/dotfiles ] && git clone https://git.sr.ht/~klardotsh/dotfiles ~/src/mine/dotfiles

if not_darwin; then
	mkdir -p ~/.local/share/themes
	ln -sf ~/src/mine/dotfiles/.local/share/applications ~/.local/share/
	# workaround https://github.com/deviantfero/wpgtk/issues/157
	ln -sf ~/.local/share/themes ~/.themes
fi

ln -sf ~/src/mine/dotfiles/bin ~/
not_darwin && ln -sf ~/src/mine/dotfiles/.alsoftrc ~/
ln -sf ~/src/mine/dotfiles/.config ~/
ln -sf ~/src/mine/dotfiles/.dir_colors ~/
ln -sf ~/src/mine/dotfiles/.gitconfig ~/
ln -sf ~/src/mine/dotfiles/.gnupg ~/
not_darwin && ln -sf ~/src/mine/dotfiles/.gtkrc-2.0 ~/
# My only MacOS boxes are corporate work machines, where I can't IMAP anyway,
# so no mailboxes or notmuch on these.
not_darwin && ln -sf ~/src/mine/dotfiles/.mailboxes ~/
not_darwin && ln -sf ~/src/mine/dotfiles/.notmuch-config ~/
ln -sf ~/src/mine/dotfiles/.zshenv ~/
ln -sf ~/src/mine/dotfiles/.zshrc ~/

ln -sf ~/src/mine/dotfiles/.tmux.conf ~/
# Currently no point in having IRC clients on the work machines.
not_darwin && ln -sf ~/src/mine/dotfiles/.tmux-chat.conf ~/
[ ! -d ~/.tmux/plugins/tpm ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

curl -L -o ~/.wallpaper "$(grep -Ev '^#' ~/src/mine/dotfiles/wallpaper.txt)"

if not_darwin; then
	mkdir -p ~/.icons
	ln -sf ~/src/mine/dotfiles/.icons/default ~/.icons/
fi

nvim +JetpackSync +qall
