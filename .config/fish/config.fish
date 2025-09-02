# Appears to be harmless and silent on systems where this directory doesn't
# exist, so no need to gate on MacOS
fish_add_path /opt/homebrew/bin

set -U fish_greeting
set -x _PR_AI_DISABLE true # No "AI" for https://codeberg.org/iff/pay-respects

set __OS "$(uname -s)"
if type -q lsb_release && [ $(lsb_release -si 2>&1 || echo 'n/a') = 'VoidLinux' ]
	set IS_VOID true
else
	set IS_VOID false
end

# Also set system-wide, but better safe than sorry.
set -x LANG en_US.utf8

set -x GPG_TTY "$(tty)"
set -x SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"

if type -q wezterm
	set -x TERMINAL wezterm
end

if type -q nvim
	set -x EDITOR nvim
	set -x MANPAGER "nvim +Man!"
else
	set -x EDITOR vi
end

if type -q ov
	set -x PAGER "ov"
end

set -x LESS "-R"

set -x AWS_SDK_LOAD_CONFIG true
set -x BAT_THEME ansi
set -x FZF_DEFAULT_OPTS "--color=16 --extended"

set -x TFENV_PATH ~/.tfenv/bin

set -x NODE_COMPILE_CACHE ~/.cache/nodejs-compile-cache
set -x NPM_PACKAGES ~/.npm-packages
fish_add_path "$NPM_PACKAGES/bin"

set -x GOPATH ~/.go
fish_add_path "$GOPATH/bin"

if type -q rustc
	set -x RUST_SRC_PATH "$(rustc --print sysroot)/lib/rustlib/src/rust/src"
end
set -x CARGO_NET_GIT_FETCH_WITH_CLI true
fish_add_path ~/.cargo/bin

if type -q ruby
	fish_add_path "$(ruby -e 'print Gem.user_dir')/bin"
end

if type -q podman
	set -x OCI_RUNNER podman
else
	set -x OCI_RUNNER docker
end

set -x BROWSER xdg-open
set -x MOZ_USE_XINPUT2 1

set -x GTK_CSD 0
set -x GTK2_RC_FILES ~/.gtkrc-2.0

set -x _JAVA_OPTIONS '-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

if status is-interactive
	alias e $EDITOR
	alias m mosh
	alias mux "tmux.sh $(hostname)"

	alias todo "todo.sh -d ~/.todo/todo.cfg"
	alias t todo
	alias tbr "t ls +tbr"

	if $IS_VOID
		set -x PRIV_CHANGER doas
		alias sudo $PRIV_CHANGER

		alias pf "xbps-query -Rs"
		alias pff "xlocate"
		alias pffi "xlocate -S"
		alias pi "$PRIV_CHANGER xbps-install -S"
		alias pql "xbps-query -f"
		alias pqs "xbps-query -s"
		alias pu "$PRIV_CHANGER sh -c 'xbps-install -Su && xbps-remove -yOoR && vkpurge rm all'"
	else
		set -x PRIV_CHANGER sudo
		alias sudo "sudo -E "
	end

	alias nmap-quickscan "$PRIV_CHANGER nmap -sV -T4 -O -F --version-light"

	if type -q bat
		alias cat bat
	end

	alias cp "cp -iv"
	alias mv "mv -iv"
	alias rm "rm -iv"

	alias chmod "chmod -c"
	alias chown "chown -c"

	alias ip="ip -c"

	if type -q rg
		alias grep rg
		alias egrep "rg -e"
		alias frg "rg --files-with-matches"
		alias fgrep frg
	end

	if type -q eza
		alias ls eza
	end

	if type -q erd
		alias tree erd
	end

	if type -q colordiff
		alias diff "colordiff -Nuar"
	else
		alias diff "diff -Nuar"
	end

	if type -q qrencode
		alias quickqr "qrencode -t ansiutf8"
	end

	# HTTPie replacement
	if type -q xh
		alias http xh
	end

	alias gl "git lol"

	alias gls "git lol --since '2 weeks' --author 'Josh Klar'"
	alias gca "git cram" # Muscle memory dies hard - this is NOT git commit -a

	if type -q cyme
		alias lsusb 'cyme --lsusb'
	end

	if type -q yazi
		alias filebrowser 'yazi'
		alias files 'yazi'
	end

	if type -q jf
		alias json-str 'jf %q'
		alias json-arr 'jf "[%*s]"'
		alias json-obj 'jf "{%**s}"'
	end

	# This section is reserved for things that start up fast enough to not add
	# noticeable latency to shell startup - otherwise, dump to
	# ~/.config/fish/functions!
	fzf --fish | source
	zoxide init fish | source
	direnv hook fish | source
	pay-respects fish --alias --nocnf | source
	starship init fish | source
	erd --completions fish | source

	# `thefuck --alias` was dumped into ~/.config/fish/functions/fuck.fish,
	# because Python's startup time is much, much slower than is acceptable
	# to have in the hot path here.
	#
	# For cases when you override a command and turn it into an alias (e.g.
	# alias sed=gsed or alias git=hub), you should add all them to the
	# THEFUCK_OVERRIDDEN_ALIASES environment variable, separated by comma. For
	# example, in your config.fish:
	#
	# set -x THEFUCK_OVERRIDDEN_ALIASES 'gsed,git'
end

fish_add_path ~/bin
