#!/bin/python
from typing import List, Dict

from libqtile.config import Key, Group
from libqtile.lazy import lazy
from libqtile import extension

from colors import Colorscheme
from utils import power_menu, float_to_front


def init_keys(mod: str, colors: Colorscheme, terminal: str) -> List[Key]:
    """
    Initialize key bindings
    """
    keys = [
        ## Starting programs
        Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
        Key(
            [mod],
            "d",
            lazy.run_extension(
                extension.DmenuRun(
                    dmenu_prompt=">_",
                    dmenu_font="monospace:pixelsize=18",
                    **colors.get_dmenu_theme()
                )
            ),
            desc="Launch dmenu",
        ),
        Key(
            [mod],
            "r",
            lazy.run_extension(
                extension.DmenuRun(
                    dmenu_command="rofi -show drun -modi 'drun,run' -show-icons",
                )
            ),
            desc="Launch rofi",
        ),
        Key([mod], "F2", lazy.spawn("firefox"), desc="Launch web browser"),
        Key([mod], "e", lazy.spawn("pcmanfm"), desc="Launch file explorer"),
        Key([mod], "x", lazy.spawn("xkill"), desc="Launch xkill"),
        Key([mod, "shift"], "Escape", lazy.run_extension(power_menu), desc="Launch Poweroff Menu"),
        Key([mod], "F8", lazy.group["s"].dropdown_toggle("matrix")),
        Key([mod], "F9", lazy.group["s"].dropdown_toggle("wttr")),
        Key([mod], "F10", lazy.group["s"].dropdown_toggle("conf")),
        Key([mod], "F11", lazy.group["s"].dropdown_toggle("notepad")),
        Key([mod], "F12", lazy.group["s"].dropdown_toggle("term")),
        ## WM
        # Switch between windows
        Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
        Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
        Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
        Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
        Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
        # Move windows between left/right columns or move up/down in current stack.
        # Moving out of range in Columns layout will create new column.
        Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
        Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
        Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
        Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
        # Grow windows. If current window is on the edge of screen and direction
        # will be to screen edge - window would shrink.
        Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
        Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
        Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
        Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
        Key([mod], "n", lazy.layout.normalize(), desc="Reset all secondary window sizes"),
        Key([mod, "shift"], "n", lazy.layout.reset(), desc="Reset all window sizes"),
        Key(
            [mod],
            "plus",
            lazy.layout.increase_ratio(),
            lazy.layout.grow(),
            desc="Increase window ratio or size",
        ),
        Key(
            [mod],
            "minus",
            lazy.layout.decrease_ratio(),
            lazy.layout.shrink(),
            desc="Decrease window ratio or size",
        ),
        Key([mod], "z", lazy.layout.maximize(), desc="Maximize window in layout"),
        Key([mod], "i", lazy.layout.increase_nmaster(), desc="Increase number of master windows"),
        Key(
            [mod, "shift"],
            "i",
            lazy.layout.decrease_nmaster(),
            desc="Decrease number of master windows",
        ),
        # Toggle between split and unsplit sides of stack.
        # Split = all windows displayed
        # Unsplit = 1 window displayed, like Max layout, but still with
        # multiple stack panes
        Key(
            [mod, "shift"],
            "Return",
            lazy.layout.toggle_split(),
            desc="Toggle between split and unsplit sides of stack",
        ),
        # Layouts
        Key([mod], "Tab", lazy.next_layout(), desc="Next Layout"),
        Key([mod, "shift"], "Tab", lazy.prev_layout(), desc="Previous Layout"),
        Key([mod, "shift"], "space", lazy.window.toggle_floating(), desc="Toggle floating"),
        Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
        Key(
            [mod, "control"],
            "space",
            lazy.function(float_to_front),
            desc="Bring all floating windows to front",
        ),
        Key([mod], "m", lazy.group.setlayout("max"), desc="Change to Max Layout"),
        Key([mod], "t", lazy.group.setlayout("monadtall"), desc="Change to Monad Tall Layout"),
        Key([mod], "u", lazy.group.setlayout("monadwide"), desc="Change to Monad Wide Layout"),
        Key([mod], "c", lazy.group.setlayout("columns"), desc="Change to Columns Layout"),
        # Other
        Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),
        Key([mod, "shift"], "r", lazy.restart(), desc="Restart Qtile"),
        Key([mod, "shift"], "e", lazy.shutdown(), desc="Shutdown Qtile"),
        Key([mod], "b", lazy.hide_show_bar(), desc="Toggle bar"),
        Key([mod], "s", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
        # Switch focus of monitors
        Key([mod], "period", lazy.next_screen(), desc="Move focus to next monitor"),
        Key([mod], "comma", lazy.prev_screen(), desc="Move focus to prev monitor"),
    ]
    return keys


def update_keys_for_groups(mod: str, keys: List[Key], groups: List[Group]) -> None:
    """
    Set keybindings related to groups
    'keys' parameter gets modified
    """
    for i in groups:
        keys.extend(
            [
                # mod1 + letter of group = switch to group
                Key(
                    [mod],
                    i.name,
                    lazy.group[i.name].toscreen(toggle=False),
                    desc="Switch to group {}".format(i.name),
                ),
                # mod1 + shift + letter of group = switch to & move focused window to group
                Key(
                    [mod, "shift"],
                    i.name,
                    lazy.window.togroup(i.name, switch_group=False),
                    desc="Switch to & move focused window to group {}".format(i.name),
                ),
                Key(
                    [mod, "shift", "control"],
                    i.name,
                    lazy.window.togroup(i.name, switch_group=True),
                    desc="Switch to & move focused window to group {}".format(i.name),
                ),
                # Or, use below if you prefer not to switch to that group.
                # # mod1 + shift + letter of group = move focused window to group
                # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
                #     desc="move focused window to group {}".format(i.name)),
            ]
        )
