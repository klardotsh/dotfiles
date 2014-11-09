# iv597's ZSH configuration
# Non-Copyright 2012-14ish, All Awesomeness Reserved
#
# This file has historically been a bit of a clusterfuck, if the
# copyright header didn't tip you off to the age of this file already. I
# make no guarantees as to how efficient this duct-taped file is.

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt appendhistory autocd beep extendedglob notify promptsubst hist_ignore_dups hist_ignore_space noflowcontrol
bindkey -v # You can't stop here, you're in Vim country!...
zstyle :compinstall filename '/home/j/.zshrc'

autoload -Uz compinit && compinit
autoload -U colors && colors

# zmv -  a command for renaming files by means of shell patterns.
autoload -U zmv

# Control-x-e to open current line in $EDITOR, awesome when writting functions or editing multiline commands.
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Fix for tmux on linux.
case "$(uname -o)" in
	'GNU/Linux')
		export EVENT_NOEPOLL=1
	;;
esac

source $HOME/.gistit

[[ -f $HOME/bin/alarmClock.sh ]] && source $HOME/bin/alarmClock.sh
[[ -f $HOME/bin/cmusSleep.sh ]] && source $HOME/bin/cmusSleep.sh

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

sprunge() {
	curl -F sprunge=@- sprunge.us
}

sprup() {
	cat $1 | sprunge
}

unset MANPATH

export EDITOR='vim'
export BROWSER='chromium'
export LANG='en_US.utf8' # Also set in /etc/locale.conf, but hey...
export SDL_AUDIODRIVER='pulse'
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export XDG_CONFIG_HOME="$HOME/.config"
export GOPATH="$HOME/.golang"
export NPM_PACKAGES="$HOME/.npm-packages"
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
export MANPAGER='most -s'
export PATH="/home/j/bin:/home/j/bin/chromeos:$HOME/.golang/bin:$HOME/.gem/ruby/2.1.0/bin:$PATH:$NPM_PACKAGES/bin"

export PROMPT="%F{cyan} » "

alias pf='packer -Ss'
alias pi='packer -S'
alias pu='packer -Syu'

alias mp='makepkg -ics'

alias tdo='todo.sh' # not `t` because I have a ruby timetracker at that path

alias sudo='sudo -E '

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

alias hc='herbstclient'

if command -v colordiff > /dev/null 2>&1; then
	alias diff="colordiff -Nuar"
else
	alias diff="diff -Nuar"
fi

zstyle ':completion:*:sudo::' environ PATH="/sbin:/usr/sbin:$PATH" HOME="/root"

# Not all servers have terminfo for rxvt-256color.
if [ "${TERM}" = 'rxvt-256color' ] && ! [ -f '/usr/share/terminfo/r/rxvt-256color' ] && ! [ -f '/lib/terminfo/r/rxvt-256color' ] && ! [ -f "${HOME}/.terminfo/r/rxvt-256color" ]; then
	export TERM='rxvt-unicode'
fi

if [ "${TERM}" = 'xterm-termite' ] && ! [ -f '/usr/share/terminfo/x/xterm-termite' ] && ! [ -f '/lib/terminfo/r/xterm-termite' ] && ! [ -f "${HOME}/.terminfo/r/xterm-termite" ]; then
	export TERM='xterm-256color'
fi

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

preexec () {
  # Check if tmux is running
  if [ "$TERM" = "screen-256color" ] && [ -n "$TMUX" ]; then
    # Store CWD in a tmux session veriable.
    tmux setenv TMUXCMD_$(tmux display -p "#I") "$1"
  fi
}

precmd () {
  echo
  # Check if tmux is running
  if [ "$TERM" = "screen-256color" ] && [ -n "$TMUX" ]; then
    # Store CWD in a tmux session veriable.
    tmux setenv TMUXPWD_$(tmux display -p "#I") "$PWD"
    # Run the script that sets the tmux statusbar.
    tmux_set_status.sh
  fi
}

cd $HOME # I have no fucking clue why I need to do this but I seem to end up in ~/.virtualenvs for whatever reason if I don't
