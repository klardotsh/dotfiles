export IS_VOID=`[ $(lsb_release -sc 2>&1 || echo 'n/a') = 'void' ] && echo 1`
export IS_GENTOO=`[ $(lsb_release -si 2>&1 || echo 'n/a') = 'Gentoo' ] && echo 1`

if test -z "${XDG_RUNTIME_DIR}"; then
	export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
	if ! test -d "${XDG_RUNTIME_DIR}"; then
		mkdir "${XDG_RUNTIME_DIR}"
		chmod 0700 "${XDG_RUNTIME_DIR}"
	fi
fi

if test -z "${XDG_CONFIG_HOME}"; then
	export XDG_CONFIG_HOME="${HOME}/.config"
fi

export GPG_TTY=$(tty)
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
export TERMINAL='alacritty'
export EDITOR='nvim'
export BROWSER='xdg-open'
export LANG='en_US.utf8' # Also set in /etc/locale.conf, but hey...

export MOZ_USE_XINPUT2=1 # Pixel-perfect trackpads <3
export MOZ_ENABLE_WAYLAND=1

export IBUS_ENABLE_CTRL_SHIFT_U=1
export XMODIFIERS=@im=ibus

export GTK_CSD=0
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export GTK_IM_MODULE=ibus
export GDK_BACKEND=wayland

export QT_QPA_PLATFORM=wayland-egl
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_IM_MODULE=ibus

export BEMENU_BACKEND=wayland
export CLUTTER_BACKEND=wayland
export SDL_VIDEODRIVER=wayland

export MANPATH="$NPM_PACKAGES/share/man:${MANPATH}"
export MANPAGER='most -s'

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

hash npm 2>/dev/null && export NPM_PACKAGES="$HOME/.npm-packages" && export NODEJS_PATH="${NPM_PACKAGES}/bin"
hash go 2>/dev/null && export GOPATH="$HOME/.go" && export GOLANG_PATH="${GOPATH}/bin"
hash rustc 2>/dev/null && export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src" && export RUST_PATH="${HOME}/.cargo/bin"
hash ruby 2>/dev/null && export RUBY_PATH="$(ruby -e 'print Gem.user_dir')/bin"

# Hackaround for pipenv to auto-install pythons as needed
hash pyenv 2>/dev/null && export PYENV_ROOT=$(pyenv root)

export PERSONAL_PATH="${HOME}/bin"
export PATH="${PERSONAL_PATH}:${RUST_PATH}:${GOLANG_PATH}:${NODEJS_PATH}:${RUBY_PATH}:${PATH}"
