#!/bin/zsh

###
### Common settings
###

# history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history


# zsh options
autoload -U compinit; compinit -u

setopt ALWAYS_TO_END
setopt AUTO_LIST
setopt AUTO_PUSHD
setopt BANG_HIST
setopt EXTENDED_GLOB
setopt EXTENDED_HISTORY
setopt NO_FLOW_CONTROL
setopt GLOB_DOTS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt IGNORE_EOF
setopt INTERACTIVE_COMMENTS
setopt LIST_PACKED
setopt LIST_TYPES
setopt LONG_LIST_JOBS
setopt MAGIC_EQUAL_SUBST
setopt NOTIFY
setopt NUMERIC_GLOB_SORT
setopt PRINT_EIGHT_BIT
setopt PROMPT_SUBST
setopt PUSHD_IGNORE_DUPS
setopt SHARE_HISTORY

unsetopt BG_NICE

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


# prompt
if [ `hostname | grep -i -e '.local$'` ]; then
    PROMPT="%n@%m%# "
else
    PROMPT="%n@%{[31m%}%m%{[m%}%# "
fi

RPROMPT="[%~]"


# add ~/local/{bin,sbin} to PATH
export PATH=~/local/bin:~/local/sbin:$PATH


# useful aliases and functions
alias grep='grep --color=auto'

mkcd() { mkdir -p "$@" && cd "$_"; }
gzless() { gzcat "$@" | less; }


###
### Mac OS X specific settings
###

if [ -d "/Volumes" ]; then
    # add /opt/local/{bin,sbin} to PATH
    export PATH=/opt/local/bin:/opt/local/sbin:$PATH

    # useful aliases and functions
    alias ls='ls -Gw'
    alias rm='rmtrash'
fi  # if [ -d "/Volumes" ]; then


###
### HGC specific settings
###

if [ `hostname | grep -e "\(gw[0-9]\+\)\|\(c[0-9]\+\)\|\(cl[0-9]\+\)"` ]; then
    # terminal (for qlogin)
    export TERM=xterm
fi
