#!/usr/bin/env bash

mkdir -p ~/src/mine
git clone ssh://git@git.klar.sh:2222/klardotsh/dotfiles ~/src/mine/dotfiles

mkdir -p ~/.local/share
ln -sf ~/src/mine/dotfiles/.local/share/applications ~/.local/share/

ln -sf ~/src/mine/dotfiles/bin ~/
ln -sf ~/src/mine/dotfiles/.config ~/
ln -sf ~/src/mine/dotfiles/.dir_colors ~/
ln -sf ~/src/mine/dotfiles/.gitconfig ~/
ln -sf ~/src/mine/dotfiles/.gnupg ~/
ln -sf ~/src/mine/dotfiles/.gtkrc-2.0 ~/
ln -sf ~/src/mine/dotfiles/.tmux.conf ~/
ln -sf ~/src/mine/dotfiles/.zshenv ~/
ln -sf ~/src/mine/dotfiles/.zshrc ~/

curl -L -o ~/.wallpaper $(cat wallpaper.txt | egrep -v "^#")

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall
