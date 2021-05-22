# bliss-dotfiles

![alt text](https://github.com/Chiivo/bliss-dotfiles/blob/main/screenshot.png?raw=true)

- Distro: Arch Linux

- Display Manager: lightdm, lightdm-webkit2, glorious

- Window Manager: qtile

- Application Manager: rofi

- AUR Helper: yay

- Compositer: nitrogen, picom-jonaburg-git
	- Add to autostart:
	```
	nitrogen --restore &
	picom &
	```

- Icon Theme: Flatery

- Widget Theme: Orchis

- Theme Manager: LXDE

- Terminal: kitty

- Text Editor: gvim

- Browser: firefox
	- CSS: flyingfox
	- Addons: fblock, dark reader, ffz, tree style tabs, tabliss
  
- File Manager: pcmanfmgtk, ranger (xarchiver + unzip)

- Video Player: vlc

- USB Mount: udisks2, udiskie
	- Add to autostart: `udiskie &`

- Fonts: Fira Sans, Fira Code Nerd Font, Scientifica, NotoSansJP

- Terminal Apps: neofetch, cbonsai, alsamixer, cava, cmatrix, shell-color-scripts

- Apps: blender, da vinci resolve, discord (Add to autostart: `discord &`), spotify (spicetify), armorpaint, steam, minecraft, via, obs, xppen driver, zathura (zathura-pdf-mupdf), dunst

###### Reminders
- To make executable bash file: `chmod +x script.sh`
- Uncomment multilib in `/etc/pacman.conf`
- Remove battery widget in bar and add network widget
