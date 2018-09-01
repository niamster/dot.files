xrdb ~/.Xdefaults
tint2 &
feh --bg-scale ~/images/wallpaper.* &
urxvtd -q -f
gxkb &
parcellite &
pasystray &
brightnessicon &
nm-applet --no-agent &
xcalib -d :0 ~/.color/icc/current.icm
xbindkeys

exec openbox --config-file ~/.config/openbox/openbox.xml
