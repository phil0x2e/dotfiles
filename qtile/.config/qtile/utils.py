#!/bin/python
from libqtile import extension
from libqtile.command.client import CommandClient

power_menu = extension.CommandSet(
    dmenu_prompt="sys",
    commands={
        "Shutdown": "systemctl poweroff -i",
        "Reboot": "systemctl reboot",
        "Logout": "qtile cmd-obj -o cmd -f shutdown &",
        "Lock": "killall rofi ; blurlock",
        "Suspend": "systemctl suspend",
    },
    dmenu_command="rofi -dmenu",
    dmenu_ignorecase=True,
)

c = CommandClient()


def get_keybinds() -> str:
    binds = c.call("display_kb")
    return binds
