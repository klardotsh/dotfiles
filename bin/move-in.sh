#!/usr/bin/env bash

mkdir -p ~/src/mine
git clone https://git.klar.sh/klardotsh/dotfiles ~/src/mine/dotfiles

mkdir -p ~/.local/share
ln -sf ~/src/mine/dotfiles/.local/share/applications ~/.local/share/

ln -sf ~/src/mine/dotfiles/bin ~/
ln -sf ~/src/mine/dotfiles/.alsoftrc ~/
ln -sf ~/src/mine/dotfiles/.config ~/
ln -sf ~/src/mine/dotfiles/.dir_colors ~/
ln -sf ~/src/mine/dotfiles/.gitconfig ~/
ln -sf ~/src/mine/dotfiles/.gnupg ~/
ln -sf ~/src/mine/dotfiles/.gtkrc-2.0 ~/
ln -sf ~/src/mine/dotfiles/.zshenv ~/
ln -sf ~/src/mine/dotfiles/.zshrc ~/

ln -sf ~/src/mine/dotfiles/.tmux.conf ~/
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

curl -L -o ~/.wallpaper $(cat ~/src/mine/dotfiles/wallpaper.txt | egrep -v "^#")

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall

mkdir -p ~/.icons
ln -sf ~/src/mine/dotfiles/.icons/default ~/.icons/

# arch packages this nicely for us, no point in building on-box
curl -L -o /tmp/capitaine-cursors.pkg.tar.xz https://www.archlinux.org/packages/community/any/capitaine-cursors/download/
mkdir -p ~/.icons/UNPACK.TMP
tar -xv -C ~/.icons/UNPACK.TMP -f /tmp/capitaine-cursors.pkg.tar.xz
mv ~/.icons/UNPACK.TMP/usr/share/icons/capitaine-cursors ~/.icons/
rm -rf ~/.icons/UNPACK.TMP /tmp/capitaine-cursors.pkg.tar.xz
