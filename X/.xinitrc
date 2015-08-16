xrdb ~/.Xdefaults
tint2 &
feh --bg-scale ~/images/wallpaper.* &
urxvtd -q -f
xxkb &
parcellite &
pulseaudio --start
pasystray &
brightnessicon &
wicd-gtk &
xcalib -d :0 ~/.color/icc/current.icm
xbindkeys

exec openbox --config-file ~/.config/openbox/openbox.xml
