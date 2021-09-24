#!/bin/python
from libqtile.command.client import CommandClient
from libqtile import extension
from libqtile.core.manager import Qtile

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


def float_to_front(qtile: Qtile):
    """
    Bring all floating windows of the current group to front
    """
    for window in qtile.current_group.windows:
        if window.floating:
            window.cmd_bring_to_front()


c = CommandClient()


def get_keybinds() -> str:
    binds = c.call("display_kb")
    return binds
