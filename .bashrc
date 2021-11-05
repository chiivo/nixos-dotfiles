# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#Aliases
alias ls='ls --color=auto'
alias pw='nvim /mnt/HDD/thewords.txt'
alias v='nvim'
alias sv='sudoedit'
alias shutdown='shutdown now'
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias remove='sudo pacman -Rs'
alias btctl='bluetoothctl'
export EDITOR='nvim'

#Prompt
PS1='\[\e[37m\]\w   \[\e[0m\]'

#Startup
r=$((RANDOM%15))
	command[0]='macchina -t arch-ascii'
	command[1]='macchina -t borpa-ascii'
	command[2]='macchina -t pyramid-ascii'
	command[3]='macchina -t smeg-ascii'
	command[4]='macchina -t wow-ascii'
	command[5]='cbonsai -L 30 -p'
	command[6]='cbonsai -L 30 -p'
	command[7]='cbonsai -L 30 -p'
	command[8]='cbonsai -L 30 -p'
	command[9]='cbonsai -L 30 -p'
	command[10]='colorscript -e 15'
	command[11]='colorscript -e 21'
	command[12]='colorscript -e 35'
	command[13]='colorscript -e 41'
	command[14]='colorscript -e 50'
eval ${command[$r]}
unset command r
