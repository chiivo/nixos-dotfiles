# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#Aliases
alias ls='ls --color=auto'
alias pw='nvim /mnt/HDD/thewords.txt'
alias v='nvim'
alias shutdown='shutdown now'

#Prompt
#PS1=' [\u@\h \W] \$ '
#PS1=' ╭[\u][\w]
# ╰─❯ '
PS1=' \w $ '

#Startup
r=$((RANDOM%12))
	command[0]="neofetch"
	command[1]="neofetch --ascii_colors 0 1 2 7 4 5 6 7 --source .config/neofetch/wow-ascii"
	command[2]="neofetch --ascii_colors 0 1 2 7 4 5 6 7 --source .config/neofetch/borpa-ascii"
	command[3]="neofetch --ascii_colors 0 1 2 3 4 5 6 7 --source .config/neofetch/pyramid-ascii"
	command[4]="cbonsai -c ○ -L 25 -p"
	command[5]="cbonsai -c ○ -L 25 -p"
	command[6]="cbonsai -c ○ -L 25 -p"
	command[7]="cbonsai -c ○ -L 25 -p"
	command[8]="colorscript -e 21"
	command[9]="colorscript -e 35"
	command[10]="colorscript -e 41"
	command[11]="colorscript -e 50"
	eval ${command[$r]}
	unset command r
