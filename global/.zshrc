# iv597's ZSH configuration
# Non-Copyright 2012-13ish, All Awesomeness Reserved

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=10000

setopt appendhistory autocd beep extendedglob notify
bindkey -v # You can't stop here, you're in Vim country!...
zstyle :compinstall filename '/home/j/.zshrc'

autoload -Uz compinit && compinit
autoload -U colors && colors

alias cs='cower -s'
alias cdl='cower -dd'
alias pks='pacman -Ss'
alias pki='sudo pacman -S'
alias t='todo.sh'
alias sudo='sudo '
alias df='df -h -x devtmpfs -x rootfs -x tmpfs'
alias rcp='rsync -v --progress'
alias rmv='rsync -v --progress --remove-source-files'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias chmod="chmod -c"
alias chown="chown -c"
if command -v colordiff > /dev/null 2>&1; then
	alias diff="colordiff -Nuar"
else
	alias diff="diff -Nuar"
fi

alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias ls='ls --color=auto --human-readable --group-directories-first --classify'
alias tree='tree -CA'

export EDITOR='vim'
export BROWSER='/data/bin/elinks.sh'
export MANPAGER='most -s'
export LANG='en_US.utf8' # Also set in /etc/locale.conf, but hey...
export PATH='/data/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/bin/core_perl'
export SDL_AUDIODRIVER='pulse'

sprunge() {
	curl -F sprunge=@- sprunge.us
}

alias spr="sprunge"

sprup() {
	cat $1 | sprunge
}

# Not all servers have terminfo for rxvt-256color. :&lt;
if [ "${TERM}" = 'rxvt-256color' ] && ! [ -f '/usr/share/terminfo/r/rxvt-256color' ] && ! [ -f '/lib/terminfo/r/rxvt-256color' ] && ! [ -f "${HOME}/.terminfo/r/rxvt-256color" ]; then
	export TERM='rxvt-unicode'
fi

# Le features!
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
	rxvt*|xterm*)
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

	linux)
		bindkey "^[[1~" beginning-of-line #Home key
		bindkey "^[[4~" end-of-line #End key
		bindkey "^[[3~" delete-char #Del key
		bindkey "^[[A" history-beginning-search-backward
		bindkey "^[[B" history-beginning-search-forward
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

bindkey "^R" history-incremental-pattern-search-backward 
bindkey "^S" history-incremental-pattern-search-forward

if [ -f ~/.alert ]; then cat ~/.alert; fi

# Le me, pretending to be clever. Bit more clean than most solutions I've seen, though.
gitCheck() {
	git status &> /dev/null && gitBranch="$(git branch | cut -d ' ' -f 2-) " || gitBranch=""
	if [ -n $gitBranch ]; then
		[ $(git status 2>/dev/null | wc -l) -gt 2 ] && gitBranch="$fg_bold[red]$gitBranch" || gitBranch="$fg[yellow]$gitBranch"
	fi
}

sshCheck() {
	([ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]) && sshConn="$fg_bold[cyan]>" || sshConn="$fg_bold[green]>"
}

setPrompt() {
	gitCheck
	PROMPT="%{$fg_bold[blue]%}%3~ ${gitBranch}${sshConn}%{$reset_color%} "
}

precmd() {
	setPrompt
}

sshCheck
setPrompt

