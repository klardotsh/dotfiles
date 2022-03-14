# klardotsh's ZSH configuration
# Maintained 2012-22 (and counting)
# Released under the [Unlicense](http://unlicense.org/)

export IS_VOID=`[ $(lsb_release -si 2>&1 || echo 'n/a') = 'VoidLinux' ] && echo 1`

if [ ! -z ~/.cargo/env ]; then
	source ~/.cargo/env
fi

export GPG_TTY=$(tty)
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
export TERMINAL='alacritty'
export EDITOR='nvim'
export BROWSER='xdg-open'
export LANG='en_US.utf8' # Also set in /etc/locale.conf, but hey...

export MOZ_USE_XINPUT2=1 # Pixel-perfect trackpads <3
export MOZ_ENABLE_WAYLAND=1
export MOZ_WAYLAND_USE_VAAPI=1

export IBUS_ENABLE_CTRL_SHIFT_U=1
export XMODIFIERS=@im=ibus

export GTK_CSD=0
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export GTK_IM_MODULE=ibus

export QT_QPA_PLATFORM=wayland-egl
# FIXME currently leaves me with no fonts being rendered?
# export QT_QPA_PLATFORMTHEME=qt5ct
export QT_IM_MODULE=ibus

export BEMENU_BACKEND=wayland
export CLUTTER_BACKEND=wayland
export SDL_VIDEODRIVER=wayland

export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland # otherwise gets set to 'tty', breaking WebRTC

export AWS_SDK_LOAD_CONFIG=true
export BAT_THEME="ansi"
export FZF_DEFAULT_COMMAND="rg --files --hidden"
export FZF_DEFAULT_OPTS="--color=16 --extended"

export MANPATH="$NPM_PACKAGES/share/man:${MANPATH}"
hash most 2>/dev/null && export MANPAGER='most -s'

export LESS=-r

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export _JAVA_AWT_WM_NONREPARTENTING=1

export TFENV_PATH="${HOME}/.tfenv/bin"
hash npm 2>/dev/null && export NPM_PACKAGES="$HOME/.npm-packages" && export NODEJS_PATH="${NPM_PACKAGES}/bin"
hash go 2>/dev/null && export GOPATH="$HOME/.go" && export GOLANG_PATH="${GOPATH}/bin"
hash rustc 2>/dev/null && export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src" && export RUST_PATH="${HOME}/.cargo/bin"
hash ruby 2>/dev/null && export RUBY_PATH="$(ruby -e 'print Gem.user_dir')/bin"
hash nimble 2>/dev/null && export NIMBLE_PATH="${HOME}/.nimble/bin"

# Hackaround for pipenv to auto-install pythons as needed
hash pyenv 2>/dev/null && export PYENV_ROOT=$(pyenv root)

export PERSONAL_PATH="${HOME}/bin:${HOME}/.local/bin"
export PATH="${PERSONAL_PATH}:${TFENV_PATH}:${RUST_PATH}:${GOLANG_PATH}:${NIMBLE_PATH}:${NODEJS_PATH}:${RUBY_PATH}:${PATH}"

# Subpixel hinting mode can be chosen by setting the right TrueType interpreter
# version. The available settings are:
#
# truetype:interpreter-version=35 # Classic mode (default in 2.6)
# truetype:interpreter-version=38 # Infinality mode
# truetype:interpreter-version=40 # Minimal mode (default in 2.7)
#
# There are more properties that can be set, separated by whitespace. Please
# refer to the FreeType documentation for details.
#
# Uncomment and configure below
export FREETYPE_PROPERTIES="truetype:interpreter-version=38"

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt appendhistory autocd beep extendedglob notify promptsubst hist_ignore_dups hist_ignore_space noflowcontrol
bindkey -v # You can't stop here, you're in Vim country!...
zstyle :compinstall filename '/home/j/.zshrc'

fpath+=~/.zfunc

autoload -Uz compinit && compinit
autoload -U colors && colors

zstyle ':completion:*' menu select

# zmv -  a command for renaming files by means of shell patterns.
autoload -U zmv

# Control-x-e to open current line in $EDITOR, awesome when writting functions or editing multiline commands.
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

setopt PROMPT_SUBST

source /usr/share/git/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1

export PROMPT="(%m) %c %F{cyan} \$(__git_ps1 '» %s ')» %{$reset_color%}%"

precmd() { print "" }

# This block is the output, as of 23 Jan 2019, of:
# eval "$(pipenv --completion)"
#
# If stuff breaks, it's because I hardcoded this blob for term startup speed.
# Fun fact: my shells spawn WAY faster now. Avg 0.2s, down from 0.5s when
# this was an eval

#compdef pipenv
_pipenv() {
  eval $(env COMMANDLINE="${words[1,$CURRENT]}" _PIPENV_COMPLETE=complete-zsh  pipenv)
}
if [[ "$(basename -- ${(%):-%x})" != "_pipenv" ]]; then
  autoload -U compinit && compinit
  compdef _pipenv pipenv
fi

setopt no_complete_aliases

alias todo="todo.sh -d ${HOME}/.todo/todo.cfg"
alias t='todo'

alias e=$EDITOR
alias v=$EDITOR
alias vim=$EDITOR
alias m='mosh'
alias mux='tmux.sh $(hostname)'
alias glow='lowdown -Tterm'

glowpage() {
	glow $@ | less ${LESS}
}

# partially due to https://github.com/ytdl-org/youtube-dl/issues/30132 and just
# generally youtube-dl not backporting fixes quickly enough / retaining support
# for ancient Pythons holding it back
alias youtube-dl='yt-dlp'

if [ "${IS_VOID}" = "1" ]; then
	export PRIV_CHANGER='doas'
	alias sudo="${PRIV_CHANGER} "

	source /usr/share/fzf/key-bindings.zsh

	alias pf='xbps-query -Rs'
	alias pff='xlocate'
	alias pffi='xlocate -S'
	alias pi="${PRIV_CHANGER} xbps-install -S"
	alias pu="${PRIV_CHANGER} xbps-install -Su"
	alias pql='xbps-query -f'
	alias pqs='xbps-query -s'
else
	export PRIV_CHANGER='sudo'
	alias sudo='sudo -E '

	source /usr/share/fzf/key-bindings.zsh
fi

alias nmap-quickscan="${PRIV_CHANGER} nmap -sV -T4 -O -F --version-light"

alias mp='makepkg -icsr'

alias df='df -h -x devtmpfs -x rootfs -x tmpfs' # hide all these Arch-standard FSes

alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'

alias chmod="chmod -c"
alias chown="chown -c"

alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'

alias ls='ls --color=auto --human-readable --group-directories-first --classify'
alias tree='tree -CA'

alias gl="git lol"
alias gls="git lol --since '2 weeks' --author 'Josh Klar'"
alias gca="git cram" # Muscle memory dies hard - this is NOT git commit -a

# https://bluz71.github.io/2018/11/26/fuzzy-finding-in-bash-with-fzf.html
fzf_git_log() {
    local commits=$(
      git lol --color=always "$@" |
        fzf --ansi --no-sort --height 100% \
            --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
                       xargs -I@ sh -c 'git show --color=always @'"
      )
    if [[ -n $commits ]]; then
        local hashes=$(printf "$commits" | cut -d' ' -f2 | tr '\n' ' ')
        git show $hashes
    fi
}

alias gll='fzf_git_log'

if command -v colordiff > /dev/null 2>&1; then
	alias diff="colordiff -Nuar"
else
	alias diff="diff -Nuar"
fi

zstyle ':completion:*:sudo::' environ PATH="/sbin:/usr/sbin:$PATH"
zstyle ':completion:*:doas::' environ PATH="/sbin:/usr/sbin:$PATH"

bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[H" beginning-of-line #Home key
bindkey "^[[F" end-of-line #End key
bindkey "^[[3~" delete-char #Del key
bindkey "^[[A" history-beginning-search-backward #Up Arrow
bindkey "^[[B" history-beginning-search-forward #Down Arrow
bindkey "^[Oc" forward-word # control + right arrow
bindkey "^[Od" backward-word # control + left arrow
bindkey "^H" backward-kill-word # control + backspace
bindkey "^[[3^" kill-word # control + delete

aws-assume() {
	export AWS_PROFILE=$1
}

eval "$(direnv hook zsh)"
eval $(thefuck --alias)
eval $(opam env)

available-fonts() {
	fc-list | grep $1 | cut -d':' -f 2 | sort -u
}

available-mono-fonts() {
	available-fonts 'Mono'
}
