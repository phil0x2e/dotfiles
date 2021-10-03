export QT_STYLE_OVERRIDE=kvantum
lxsession &
#slstatus &
bash .screenlayout/standard.sh
pa-applet &
nm-applet &
nitrogen --restore &
picom -b --experimental-backends --backend glx --vsync --blur-method gaussian --blur-size 5 --blur-deviation 5 &
#exec dwm
exec qtile start
