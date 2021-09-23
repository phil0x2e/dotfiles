#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='\e[32m\e[1m[\u@\h \e[1m\e[97m\W\e[32m]$\e[0m '
export EDITOR=nvim
