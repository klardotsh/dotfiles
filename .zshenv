unset MANPATH

export GPG_TTY=$(tty)
export SSH_AUTH_SOCK="/run/user/$(id -u)/gnupg/S.gpg-agent.ssh"
export TERMINAL='kitty'
export EDITOR='nvim'
export BROWSER='xdg-open'
export LANG='en_CA.utf8' # Also set in /etc/locale.conf, but hey...

export MOZ_USE_XINPUT2=1 # Pixel-perfect trackpads <3
export IBUS_ENABLE_CTRL_SHIFT_U=1
export XMODIFIERS=@im=ibus

export GTK_CSD=0
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export GTK_IM_MODULE=ibus

export QT_QPA_PLATFORMTHEME=qt5ct
export QT_IM_MODULE=ibus

export XDG_CONFIG_HOME="$HOME/.config"

export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
export MANPAGER='most -s'

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

export NPM_PACKAGES="$HOME/.npm-packages"
export GOPATH="$HOME/.go"
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# Hackaround for pipenv to auto-install pythons as needed
export PYENV_ROOT=$(pyenv root)

export PATH="$HOME/bin:$HOME/.cargo/bin:${GOPATH}/bin:${NPM_PACKAGES}/bin:$(ruby -e 'print Gem.user_dir')/bin:$PATH"
