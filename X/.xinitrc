xrdb ~/.Xdefaults
tint2 &
feh --bg-scale ~/images/wallpaper.* &
urxvtd -q -f
xxkb &
parcellite &
volumeicon &
brightnessicon &
wicd-gtk &
xcalib -d :0 ~/.color/icc/current.icm
/opt/urserver/urserver --daemon

exec openbox --config-file ~/.config/openbox/openbox.xml
