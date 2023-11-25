#!/usr/bin/env bash

set -euxo pipefail

# ensure various required things are installed
hash curl
hash git
hash nvim

mkdir -p ~/src/mine
[ ! -d ~/src/mine/dotfiles ] && git clone https://git.klar.sh/klardotsh/dotfiles ~/src/mine/dotfiles

mkdir -p ~/.local/share/themes
ln -sf ~/src/mine/dotfiles/.local/share/applications ~/.local/share/
# workaround https://github.com/deviantfero/wpgtk/issues/157
ln -sf ~/.local/share/themes ~/.themes

ln -sf ~/src/mine/dotfiles/bin ~/
ln -sf ~/src/mine/dotfiles/.alsoftrc ~/
ln -sf ~/src/mine/dotfiles/.config ~/
ln -sf ~/src/mine/dotfiles/.dir_colors ~/
ln -sf ~/src/mine/dotfiles/.gitconfig ~/
ln -sf ~/src/mine/dotfiles/.gnupg ~/
ln -sf ~/src/mine/dotfiles/.gtkrc-2.0 ~/
ln -sf ~/src/mine/dotfiles/.mailboxes ~/
ln -sf ~/src/mine/dotfiles/.notmuch-config ~/
ln -sf ~/src/mine/dotfiles/.zshenv ~/
ln -sf ~/src/mine/dotfiles/.zshrc ~/

ln -sf ~/src/mine/dotfiles/.tmux.conf ~/
ln -sf ~/src/mine/dotfiles/.tmux-chat.conf ~/
[ ! -d ~/.tmux/plugins/tpm ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

curl -L -o ~/.wallpaper "$(grep -Ev '^#' ~/src/mine/dotfiles/wallpaper.txt)"

mkdir -p ~/.icons
ln -sf ~/src/mine/dotfiles/.icons/default ~/.icons/

nvim +JetpackSync +qall
