#!/bin/bash
if [ "$@" ]
then
    case $1 in
        Shutdown)
            systemctl poweroff -i
        ;;
        Reboot)
            systemctl reboot
        ;;
        Logout)
            if [[ $GDMSESSION == bspwm ]]
            then
                bspc quit
            elif [[ $GDMSESSION == dwm ]]
            then
                killall dwm
            elif [[ $GDMSESSION == qtile ]]
            then
                qtile cmd-obj -o cmd -f shutdown
            fi
        ;;
        Lock)
            killall rofi && blurlock
        ;;
        Suspend)
           systemctl suspend
        ;;
    esac
else
    echo "Shutdown"
    echo "Reboot"
    echo "Logout"
    echo "Lock"
    echo "Suspend"
fi
