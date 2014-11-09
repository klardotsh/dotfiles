# iv597's ZSH configuration
# Non-Copyright 2012-13ish, All Awesomeness Reserved

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt appendhistory autocd beep extendedglob notify
bindkey -v # You can't stop here, you're in Vim country!...
zstyle :compinstall filename '/home/j/.zshrc'

autoload -Uz compinit && compinit
autoload -U colors && colors

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

#alias cf='cower -s'
#alias cl='cower -dd'
#alias clf='cower -ddf'
#alias cu='cower -dduf'

#alias pf='pacman -Ss'
#alias pi='sudo pacman -S'
#alias pu='sudo pacman -Syu'
alias pf='packer -Ss'
alias pi='packer -S'
alias pu='packer -Syu'
alias pd='sudo pacman -R'
alias pds='sudo pacman -Rsc'

alias mp='makepkg -ics'
alias mpf='makepkg -icsf'

alias ti='timetrap'
alias tdo='todo.sh'

alias sudo='sudo -E '

alias df='df -h -x devtmpfs -x rootfs -x tmpfs'

alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'

alias chmod="chmod -c"
alias chown="chown -c"

alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'

alias ls='ls --color=auto --human-readable --group-directories-first --classify'
alias tree='tree -CA'

alias m='mosh iv597.com'
alias mo='mosh'

alias hc='herbstclient'

if command -v colordiff > /dev/null 2>&1; then
	alias diff="colordiff -Nuar"
else
	alias diff="diff -Nuar"
fi

alias amix="alsamixer -c 1"
alias aeq="alsamixer -D equal"

export EDITOR='vim'
export BROWSER='chromium'
export LANG='en_US.utf8' # Also set in /etc/locale.conf, but hey...
export SDL_AUDIODRIVER='pulse'
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export XDG_CONFIG_HOME="$HOME/.config"
export GOPATH="$HOME/.golang"
export NPM_PACKAGES="$HOME/.npm-packages"
unset MANPATH
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
export MANPAGER='most -s'
export PATH="/home/j/bin:/home/j/bin/chromeos:$HOME/.golang/bin:$HOME/.gem/ruby/2.1.0/bin:$PATH:$NPM_PACKAGES/bin"

source $HOME/.gistit

zstyle ':completion:*:sudo::' environ PATH="/sbin:/usr/sbin:$PATH" HOME="/root"

[[ -f $HOME/bin/alarmClock.sh ]] && source $HOME/bin/alarmClock.sh
[[ -f $HOME/bin/cmusSleep.sh ]] && source $HOME/bin/cmusSleep.sh

sprunge() {
	curl -F sprunge=@- sprunge.us
}

alias spr="sprunge"

sprup() {
	cat $1 | sprunge
}

export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

# Not all servers have terminfo for rxvt-256color.
if [ "${TERM}" = 'rxvt-256color' ] && ! [ -f '/usr/share/terminfo/r/rxvt-256color' ] && ! [ -f '/lib/terminfo/r/rxvt-256color' ] && ! [ -f "${HOME}/.terminfo/r/rxvt-256color" ]; then
	export TERM='rxvt-unicode'
fi

if [ "${TERM}" = 'xterm-termite' ] && ! [ -f '/usr/share/terminfo/x/xterm-termite' ] && ! [ -f '/lib/terminfo/r/xterm-termite' ] && ! [ -f "${HOME}/.terminfo/r/xterm-termite" ]; then
	export TERM='xterm-256color'
fi

# Les features!
# extended globbing, awesome!
setopt extendedGlob

# zmv -  a command for renaming files by means of shell patterns.
autoload -U zmv

# zargs, as an alternative to find -exec and xargs.
autoload -U zargs

# Turn on command substitution in the prompt (and parameter expansion and arithmetic expansion).
# TODO Figure out why this seemed to have no effect, hence why I manually set $PROMPT now...
setopt promptsubst

# Control-x-e to open current line in $EDITOR, awesome when writting functions or editing multiline commands.
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Ignore duplicate in history.
setopt hist_ignore_dups

# Prevent record in history entry if preceding them with at least one space
setopt hist_ignore_space

# Nobody needs flow control anymore.
setopt noflowcontrol

# Fix for tmux on linux.
case "$(uname -o)" in
	'GNU/Linux')
		export EVENT_NOEPOLL=1
	;;
esac

# Keys.
case $TERM in
	rxvt*|xterm)
		bindkey "^[[7~" beginning-of-line #Home key
		bindkey "^[[8~" end-of-line #End key
		bindkey "^[[3~" delete-char #Del key
		bindkey "^[[A" history-beginning-search-backward #Up Arrow
		bindkey "^[[B" history-beginning-search-forward #Down Arrow
		bindkey "^[Oc" forward-word # control + right arrow
		bindkey "^[Od" backward-word # control + left arrow
		bindkey "^H" backward-kill-word # control + backspace
		bindkey "^[[3^" kill-word # control + delete
	;;

	xterm-termite|xterm-256color)
		bindkey "^[OH" beginning-of-line #Home key
		bindkey "^[OF" end-of-line #End key
		bindkey "^[[3~" delete-char #Del key
		bindkey "^[[A" history-beginning-search-backward #Up Arrow
		bindkey "^[[B" history-beginning-search-forward #Down Arrow
		bindkey "^[Oc" forward-word # control + right arrow
		bindkey "^[Od" backward-word # control + left arrow
		bindkey "^H" backward-kill-word # control + backspace
		bindkey "^[[3^" kill-word # control + delete
	;;

	linux)
		bindkey "^[[1~" beginning-of-line #Home key
		bindkey "^[[4~" end-of-line #End key
		bindkey "^[[3~" delete-char #Del key
		bindkey "^[[A" history-beginning-search-backward
		bindkey "^[[B" history-beginning-search-forward
		bindkey "^H" backward-delete-char
	;;

	screen|screen-*)
		bindkey "^[[1~" beginning-of-line #Home key
		bindkey "^[[4~" end-of-line #End key
		bindkey "^[[3~" delete-char #Del key
		bindkey "^[[A" history-beginning-search-backward #Up Arrow
		bindkey "^[[B" history-beginning-search-forward #Down Arrow
		bindkey "^[Oc" forward-word # control + right arrow
		bindkey "^[Od" backward-word # control + left arrow
		bindkey "^H" backward-kill-word # control + backspace
		bindkey "^[[3^" kill-word # control + delete
	;;
esac

bindkey "^H" backward-delete-char

if [ -f ~/.alert ]; then cat ~/.alert; fi

setPrompt() {
	PROMPT=""
	([ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]) && PROMPT+="%F{white}%m "
	PROMPT+="%F{blue}%3~"
	# Because running this shit over an sshfs connection is torture
	if [ ! $(stat -f -c %T .) = "fuseblk" ]; then
		PROMPT+=" %F{green}"
		# Silently fails and adds nothing to the prompt if we're not in a git repo
		local GITSHIT=`git branch 2>/dev/null | grep '*' | cut -d ' ' -f 2`
		if [[ ! -z $GITSHIT ]]; then
			[[ `git status -uno -s | wc -l` == 0 ]] || PROMPT+="%F{red}"
			PROMPT+="$GITSHIT "
		fi
	fi
	PROMPT+="%F{white}%f• "
}

precmd() {
	setPrompt
}

setPrompt

# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

