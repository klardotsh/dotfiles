# klardotsh's ZSH configuration
# Maintained 2012-19 (and counting)
# Released under the [Unlicense](http://unlicense.org/)

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

cat ${XDG_CONFIG_HOME}/wpg/sequences

setopt no_complete_aliases

alias e='nvim'
alias vim='nvim'
alias m='mosh'

if [ "${IS_VOID}" = "1" ]; then
	source /usr/share/doc/fzf/key-bindings.zsh

	alias sway='ck-launch-session dbus-launch --sh-syntax --exit-with-session /usr/bin/sway'
	alias pf='xbps-query -Rs'
	alias pff='xlocate'
	alias pffi='xlocate -S'
	alias pi='sudo xbps-install -S'
	alias pu='sudo xbps-install -Su'
	alias pql='xbps-query -f'
	alias pqs='xbps-query -s'
else
	source /usr/share/fzf/key-bindings.zsh

	alias pf='yay -Ss'
	alias pi='yay -S'
	alias pii='yay -Sy'
	alias pu='yay -Syu'
	alias pql='pacman -Ql'
	alias pqs='pacman -Qs'
fi

alias mp='makepkg -icsr'

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

# This is a disgusting hack to ensure running "git commit" will bring up the PGP key unlock
# on the correct terminal (and not in fucking Narnia or whatever, where it tends to go if
# left to its own devices). Realistically this should be something smarter, that understands
# what types of git commands will actually (potentially) bring up a PGP window. Even better,
# this hack should be moved to a wrapper script that git can call as "gpg" - be it by $PATH
# hackery or something else. Because I'm lazy, this stays for now.
alias git="echo UPDATESTARTUPTTY | gpg-connect-agent >/dev/null && /usr/bin/git"

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

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /home/j/src/lumen/healthchecker/node_modules/tabtab/.completions/serverless.zsh ]] && . /home/j/src/lumen/healthchecker/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /home/j/src/lumen/healthchecker/node_modules/tabtab/.completions/sls.zsh ]] && . /home/j/src/lumen/healthchecker/node_modules/tabtab/.completions/sls.zsh
