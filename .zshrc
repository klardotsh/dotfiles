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

sprunge() {
	curl -F sprunge=@- sprunge.us
}

sprup() {
	cat $1 | sprunge
}

eval "$(thefuck --alias)"

unset MANPATH

export EDITOR='vim'
export BROWSER='chromium'
export LANG='en_US.utf8' # Also set in /etc/locale.conf, but hey...
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export XDG_CONFIG_HOME="$HOME/.config"
export NPM_PACKAGES="$HOME/.npm-packages"
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
export MANPAGER='most -s'
export PATH="$HOME/bin:$HOME/.gem/ruby/2.1.0/bin:$PATH:$NPM_PACKAGES/bin"

setopt PROMPT_SUBST

# Currently unused
source /usr/share/git/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1

export PROMPT=" %c %F{cyan} $(__git_ps1 '» %s ')» %{$reset_color%}%"

setopt no_complete_aliases

alias packer='packer-color'
alias pf='packer-color -Ss'
alias pi='packer-color -S'
alias pu='packer-color -Syu'
alias pql='pacman -Ql'
alias pqs='pacman -Qs'

alias mp='makepkg -ics'

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

if command -v colordiff > /dev/null 2>&1; then
	alias diff="colordiff -Nuar"
else
	alias diff="diff -Nuar"
fi

zstyle ':completion:*:sudo::' environ PATH="/sbin:/usr/sbin:$PATH" HOME="/root"

bindkey "^[[H" beginning-of-line #Home key
bindkey "^[[F" end-of-line #End key
bindkey "^[[3~" delete-char #Del key
bindkey "^[[A" history-beginning-search-backward #Up Arrow
bindkey "^[[B" history-beginning-search-forward #Down Arrow
bindkey "^[Oc" forward-word # control + right arrow
bindkey "^[Od" backward-word # control + left arrow
bindkey "^H" backward-kill-word # control + backspace
bindkey "^[[3^" kill-word # control + delete

cd $HOME # I have no fucking clue why I need to do this but I seem to end up in ~/.virtualenvs for whatever reason if I don't

