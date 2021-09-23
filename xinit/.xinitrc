export QT_STYLE_OVERRIDE=kvantum
lxsession &
#slstatus &
bash .screenlayout/standard.sh
pa-applet &
nm-applet &
nitrogen --restore &
picom -b &
#exec dwm
exec qtile start
