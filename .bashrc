# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ff='fastfetch -c confy.jsonc'
alias nv='nvim'
alias puuush='git push origin master'
alias off='poweroff'

PS1='\[\033[0;36m\]\w> \[\033[0m\]'
. "$HOME/.cargo/env"
