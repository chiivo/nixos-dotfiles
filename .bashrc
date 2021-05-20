#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '
PS1=' \W => '

r=$((RANDOM%3))
command[0]="neofetch --ascii_colors 0 1 7 3 4 5"
command[1]="cbonsai -p"
command[2]="colorscript -e zwaves"
eval ${command[$r]}
unset command r

#neofetch
#cbonsai -L 22 -p
#colorscript -r
