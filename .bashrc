# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#Variables
export EDITOR='nvim'

#Aliases
alias ls='ls --color=auto'
alias pw='nvim /mnt/HDD/thewords.txt'
alias v='nvim'
alias se='sudoedit'
alias shutdown='poweroff'
alias update='sudo pacman -Syyu && paru -Syua --skipreview --nodevel; sudo pacman -Rsn $(paru -Qdtq); paru -cc'
alias install='sudo pacman -S || paru -S --skipreview'
alias clean='sudo pacman -Rsn $(paru -Qdtq); paru -cc'
alias remove='sudo pacman -Rs'
alias btctl='bluetoothctl'

#Prompt
PS1='\[\e[37m\]\[\e[0m\]\[\e[47;1m\]\[\e[30m\]\w  \[\e[0m\]\[\e[37m\]\[\e[0m\] '
#PS1='\[\e[37m\]\w  \[\e[0m\]'

#Startup
r=$((RANDOM%15))
	command[0]='macchina -t arch-ascii'
	command[1]='macchina -t borpa-ascii'
	command[2]='macchina -t pyramid-ascii'
	command[3]='macchina -t smeg-ascii'
	command[4]='macchina -t wow-ascii'
	command[5]='sleep .1; cbonsai -L 27 -p'
	command[6]='sleep .1; cbonsai -L 27 -p'
	command[7]='sleep .1; cbonsai -L 27 -p'
	command[8]='sleep .1; cbonsai -L 27 -p'
	command[9]='sleep .1; cbonsai -L 27 -p'
  command[10]='colorscript -e crunchbang'
  command[11]='colorscript -e faces'
  command[12]='colorscript -e rails'
  command[13]='colorscript -e square'
  command[14]='colorscript -e zwaves'
eval ${command[$r]}
unset command r
