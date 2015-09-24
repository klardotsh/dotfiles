#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh

for i in /usr/local/etc/bash_completion.d/**; do # Whitespace-safe and recursive
    source "$i"
done

alias sudo='sudo -E '
alias prm=". ${HOME}/src/external/prm/prm.sh"

export EDITOR="vim"

export MY_BINS="${HOME}/bin"

export GEM_DIR="${HOME}/.gem"
export GEM_RUBY_VER="2.2.0"

export NPM_PACKAGES="${HOME}/.npm-packages"

export GOPATH="${HOME}/.golang"

export PATH="${MY_BINS}:${GOPATH}/bin:${NPM_PACKAGES}/bin:${GEM_DIR}/ruby/${GEM_RUBY_VER}/bin:/usr/local/bin:${PATH}"

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH  # delete if you already modified MANPATH elsewhere in your configuration
export MANPATH="${NPM_PACKAGES}/share/man:$(manpath)"

export NODE_PATH="${NPM_PACKAGES}/lib/node_modules:$NODE_PATH"

export WORKON_HOME="${HOME}/.virtualenvs"

man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

set_prompt () {
	Last_Command=$? # Must come first!
	Blue='\[\e[01;34m\]'
	White='\[\e[01;37m\]'
	Red='\[\e[01;31m\]'
	Green='\[\e[01;32m\]'
	Reset='\[\e[00m\]'
	FancyX='\342\234\227'
	Checkmark='\342\234\223'

	PS1="\n"
	
	if [[ $Last_Command == 0 ]]; then
		PS1+="$Green$Checkmark "
	else
		PS1+="$Red$FancyX $Reset(\$?) "
	fi
	
	if [[ $EUID == 0 ]]; then
		PS1+="$Red\\h "
	fi
	
	PS1+="$Blue\\W"
	PS1+="$Reset"
	PS1+=`__git_ps1`
	PS1+=" $Blue\\\$$Reset "
}

PROMPT_COMMAND='set_prompt'

#source /usr/bin/virtualenvwrapper.sh

