alias fuck='TF_CMD=$(TF_ALIAS=fuck PYTHONIOENCODING=utf-8 TF_SHELL_ALIASES=$(alias) thefuck $(fc -ln -1 | tail -n 1)) && eval $TF_CMD && print -s $TF_CMD'
source /usr/bin/virtualenvwrapper_lazy.sh

unset MANPATH

export GPG_TTY=$(tty)
export TERMINAL='termite'
export EDITOR='nvim'
export BROWSER='xdg-open'
export LANG='en_CA.utf8' # Also set in /etc/locale.conf, but hey...

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

export PATH="$HOME/bin:$HOME/.cargo/bin:${GOPATH}/bin:${NPM_PACKAGES}/bin:$(ruby -e 'print Gem.user_dir')/bin:$PATH"

