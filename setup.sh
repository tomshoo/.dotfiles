#! /bin/bash

echo "Installing required dependancies..."
sudo pacman -Syu --needed xmonad xmonad-contrib dmenu rofi alacritty rxvt-unicode rxvt-unicode-terminfo nitrogen picom unzip
echo "Checking if yay is installed"
if which yay > /dev/null 2>&1; then
    echo "Yay was installed proceeding"
    yay -Syu betterlockscreen ttf-fontawesome-4 i3exit
else
    pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    yay -Syu betterlockscreen ttf-fontawesome-4 i3exit
fi

echo "Setting up alacritty..."
cp -r alacritty $HOME/.config/alacritty

echo "Setting up rofi..."
cp -r rofi $HOME/.config/rofi

function xmonad_setup(){
	if ! [ -f $HOME/.xmonad/xmonad.hs ]; then
		cp -r xmonad/ $HOME/.xmonad/
		cp xmobarrc $HOME/.xmobarrc
	else
	    shopt -s nocasematch
		read -p "Config file already exists do you want to overwrite it (y/N): " YES_NO
		case $YES_NO in
		    "y" | "yes")
		        cp $HOME/.xmonad/xmonad.hs $HOME/.xmonad/xmonad.hs.bck
		        cp -r xmonad/ $HOME/.xmonad/
		        cp xmobarrc $HOME/.xmobarrc.bck
		        echo "Copied config file to ~/.xmonad/"
		        echo "Backup of previous file created at ~/.xmonad/xmonad.hs.bck"
		        echo "Backup of previous xmobar config created at ~/.xmobarrc.bck";;

		    "n" | "no") echo "Leaving default config as is." ;;

		    *) echo "Leaving default config as is." ;;
		esac
    fi
}

function i3_setup(){
	if ! [ -f $HOME/.config/i3/config ]; then
	    cp -r i3/ $HOME/.config/
	    echo "Created new config please restart your window manager"
	else
	    shopt -s nocasematch
	    read -p "config file already exists do you want to overwrite it (y/N): " YES_NO
	    case $YES_NO in
	        "y" | "yes")
	            cp $HOME/.config/i3/config $HOME/.config/i3/config.bck
	            cp -r i3/ $HOME/.config/i3/
	            echo "Created new config please restart your window manager"
	            echo "Backup of previous config created at ~/.config/i3/config.bck" ;;

	        "n" | "no") echo "Leaving default config as is." ;;

	        *) echo "Leaving default config as is." ;;
	    esac
	fi
}

echo "Available window managers are: "
echo "    1. Xmonad"
echo "    2. I3-gaps"

read -p "Enter the number or name of window manager: " WMVALUE

shopt -s nocasematch
case $WMVALUE in
    "1" | "xmonad") xmonad_setup ;;

    "2" | "i3" | "i3-gaps") i3_setup ;;

    *) echo "Error: Invalid option specified"

esac
