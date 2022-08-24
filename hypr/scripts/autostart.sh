export SCRIPTS=$HOME/.config/hypr/scripts

systemctl start --user dunst.service

systemctl --user import-environment WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP MOZ_ENABLE_WAYLAND
dbus-update-activation-environment --systemd XDG_CURRENT_DESKTOP DISPLAY WAYLAND_DISPLAY SWAYSOCK MOZ_ENABLE_WAYLAND

foot --server &
$SCRIPTS/wallpaper.sh &
$SCRIPTS/waybar.sh &

gsettings set org.gonem.desktop.wm.preferences button-layout " "
gsettings set org.gnome.desktop.interface cursor-theme "Vimix-Doder-dark"
gsettings set org.gnome.desktop.interface icon-theme "Vimix-Doder-dark"
gsettings set org.gnome.desktop.interface gtk-theme "Orchis-Dark"
