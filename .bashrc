# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#Variables
export EDITOR='nvim'

#Aliases
alias ls='ls --color=auto'
alias pw='nvim /mnt/SSD/thewords.txt'
alias v='nvim'
alias se='sudoedit'
alias shutdown='poweroff'
alias update='sudo nixos-rebuild switch --upgrade'
alias clean='sudo nix-collect-garbage -d'
alias config='se /etc/nixos/configuration.nix'
alias btctl='bluetoothctl'
alias swaptgl='sudo swapoff -a; sudo swapon -a'

#Prompt
PS1='\[\e[37m\]\[\e[0m\]\[\e[47;1m\]\[\e[30m\]\w  \[\e[0m\]\[\e[37m\]\[\e[0m\] '
# PS1='\[\e[37;1m\]\w   \[\e[0m\]'

#Startup
r=$((RANDOM%15))
  command[0]='neofetch'
  command[1]='neofetch'
  command[2]='neofetch'
  command[3]='neofetch'
  command[4]='neofetch'
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
