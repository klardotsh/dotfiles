#!/usr/bin/env bash

set -euxo pipefail

OS="$(uname -s)"

is_darwin() {
	[ "${OS}" = "Darwin" ]
}

not_darwin() {
	[ "${OS}" != "Darwin" ]
}

ensure_cloned() {
	if [ ! -d "$2" ]; then
		git clone "$1" "$2"
	fi
}

# ensure various required things are installed
hash curl
hash git
hash nvim
hash fish

fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'

mkdir -p ~/src/mine
ensure_cloned https://git.sr.ht/~klardotsh/dotfiles ~/src/mine/dotfiles

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
ensure_cloned https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

curl -L -o ~/.wallpaper "$(grep -Ev '^#' ~/src/mine/dotfiles/wallpaper.txt)"

is_darwin && curl -L -o ~/bin/git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

if not_darwin; then
	mkdir -p ~/.icons
	ln -sf ~/src/mine/dotfiles/.icons/default ~/.icons/
fi

nvim --headless +JetpackSync +qall
echo "Disregard any 'not synchronized' error you just saw from neovim above: JetpackSync was run!" >&2
nvim --headless +TSUpdate +qall

echo "===> You're all moved in!"
