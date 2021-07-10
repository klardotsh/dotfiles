#!/usr/bin/env bash

set -euxo pipefail

# ensure various required things are installed
hash curl
hash git
hash nvim
hash zstd

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
ln -sf ~/src/mine/dotfiles/.zshenv ~/
ln -sf ~/src/mine/dotfiles/.zshrc ~/

ln -sf ~/src/mine/dotfiles/.tmux.conf ~/
[ ! -d ~/.tmux/plugins/tpm ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

curl -L -o ~/.wallpaper "$(grep -Ev '^#' ~/src/mine/dotfiles/wallpaper.txt)"

mkdir -p ~/.icons
ln -sf ~/src/mine/dotfiles/.icons/default ~/.icons/

# arch packages this nicely for us, no point in building on-box
[ ! -d ~/.icons/capitaine-cursors ] && curl -L -o /tmp/capitaine-cursors.pkg.tar.zstd https://www.archlinux.org/packages/community/any/capitaine-cursors/download/
[ ! -d ~/.icons/capitaine-cursors ] && mkdir -p ~/.icons/UNPACK.TMP
[ ! -d ~/.icons/capitaine-cursors ] && tar -xv -C ~/.icons/UNPACK.TMP -f /tmp/capitaine-cursors.pkg.tar.zstd
[ ! -d ~/.icons/capitaine-cursors ] && mv ~/.icons/UNPACK.TMP/usr/share/icons/capitaine-cursors ~/.icons/
[ ! -d ~/.icons/capitaine-cursors ] && rm -rf ~/.icons/UNPACK.TMP /tmp/capitaine-cursors.pkg.tar.zstd

# vim MUST be the last thing configured to retain compat with pipe mode, since
# nvim will swallow the rest of curl's pipe into a buffer
PAQ_DEST="${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim
[ ! -d ${PAQ_DEST} ] && git clone --depth=1 https://github.com/savq/paq-nvim.git ${PAQ_DEST}
nvim +PaqInstall +qall
