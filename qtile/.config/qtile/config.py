# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from typing import List  # noqa: F401
from os.path import expanduser

from libqtile import bar, layout, widget, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

from colour import Color

from key_bindings import init_keys, update_keys_for_groups
from colors import Colorscheme
from hooks import init_hooks
from utils import power_menu

# gruvbox colors green hl
gb_colors = Colorscheme(
    hl="#98971a",
    fg="#ebdbb2",
    bg="#282828",
    red="#cc241d",
    green="#98971a",
    yellow="#d79921",
    blue="#458588",
    purple="#b16286",
    aqua="#689d6a",
)
dracula_colors = Colorscheme(
    hl="#bd93f9",
    fg="#f8f8f2",
    bg="#282a36",
    red="#ff5555",
    green="#50fa7b",
    yellow="#f1fa8c",
    blue="#8be9fd",
    purple="#bd93f9",
    aqua="#6272a4",
)
colors = gb_colors

mod = "mod4"
terminal = "kitty"
home_path = expanduser("~")
qtile_path = expanduser("~/.config/qtile/")


keys = init_keys(mod, colors, terminal)

groups = [Group(i) for i in "1234567890"]
groups[-1].label = "10"
groups.append(
    ScratchPad(
        "s",
        dropdowns=[
            DropDown("term", terminal, height=0.45, opacity=0.9, warp_pointer=False),
            DropDown(
                "notepad",
                f"{terminal} nvim {home_path}/MEGA/notes.md",
                height=0.45,
                opacity=0.9,
                warp_pointer=False,
            ),
            DropDown(
                "conf",
                f"{terminal} nvim {qtile_path}/config.py {qtile_path}/key_bindings.py {qtile_path}/colors.py {qtile_path}/utils.py {qtile_path}/hooks.py",
                height=0.9,
                opacity=0.9,
                warp_pointer=False,
            ),
            DropDown(
                "wttr",
                f"{terminal} bash -c 'curl -s wttr.in && sleep 60'",
                height=0.9,
                opacity=0.9,
                warp_pointer=False,
            ),
            DropDown(
                "matrix",
                f"{terminal} cmatrix -as",
                height=1,
                width=1,
                x=0,
                opacity=0.9,
                warp_pointer=False,
                on_focus_lost_hide=False,
            ),
        ],
    )
)

update_keys_for_groups(mod, keys, groups)
init_hooks(colors)

common_layout_conf = {
    "border_width": 2,
    "margin": 2,
    "ratio": 0.55,
    "border_focus": colors.hl,
    "border_normal": colors.bg,
}

layouts = [
    layout.MonadTall(single_border_width=0, single_margin=0, **common_layout_conf),
    layout.MonadWide(single_border_width=0, single_margin=0, **common_layout_conf),
    layout.Columns(border_focus_stack=colors.yellow, margin_on_single=0, **common_layout_conf),
    layout.Max(),
    # layout.Tile(shift_windows=True, **common_layout_conf),
    # layout.Matrix(**common_layout_conf),
    # layout.RatioTile(**common_layout_conf),
    # layout.Columns(border_focus_stack='#d75f5f', **common_layout_conf),
    # layout.Stack(num_stacks=2, **common_layout_conf),
    # layout.Bsp(**common_layout_conf),
    # layout.TreeTab(**common_layout_conf),
    # layout.VerticalTile(**common_layout_conf),
    # layout.Zoomy(**common_layout_conf),
]

widget_defaults = {
    "font": "monospace",
    "fontsize": 14,
    "padding": 3,
    "foreground": colors.fg,
}
extension_defaults = widget_defaults.copy()

dup_widgets = {
    "cpu": widget.CPU(
        format=" {freq_current}GHz {load_percent}%",
        font="monospace",
    ),
    "mem": widget.Memory(format=" {MemPercent}%", font="monospace"),
    "df_root": widget.DF(partition="/", visible_on_warn=False, fmt=" {}"),
    "df_home": widget.DF(partition="/home", visible_on_warn=False),
    "clock": widget.Clock(format=" %a %d.%m.%y %H:%M"),
    "temp": widget.ThermalSensor(fmt=" {}", tag_sensor="temp1", **widget_defaults),
    "updates": widget.CheckUpdates(),
}

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Image(
                    filename="~/Dropbox/icons/manjaro.png",
                    mouse_callbacks={
                        "Button1": lambda: qtile.cmd_spawn("jgmenu_run"),
                        "Button3": lambda: qtile.cmd_run_extension(power_menu),
                    },
                ),
                widget.GroupBox(
                    active=colors.fg,
                    inactive="#504945",
                    this_current_screen_border=colors.hl,
                    this_screen_border=Color(colors.hl, luminance=0.3).get_web(),
                    block_highlight_text_color="#ffffff",
                    other_screen_border="#928374",
                    urgent_border=colors.warn,
                    disable_drag=True,
                ),
                widget.CurrentLayoutIcon(scale=0.8),
                widget.WindowCount(fmt="[{}] "),
                widget.Prompt(),
                widget.WindowName(background=colors.hl, foreground=colors.bg),
                widget.Battery(
                    battery="BAT0",
                    format="{char} {percent:2.0%} {hour:d}:{min:02d}",
                    fmt=" {}",
                    charge_char="+",
                    discharge_char="-",
                    full_char="o",
                    update_interval=30,
                ),
                widget.Sep(),
                dup_widgets["updates"],
                widget.Sep(),
                dup_widgets["cpu"],
                widget.Sep(),
                dup_widgets["temp"],
                widget.Sep(),
                dup_widgets["mem"],
                widget.Sep(),
                dup_widgets["df_root"],
                widget.Sep(),
                dup_widgets["clock"],
                widget.Sep(),
                widget.Systray(),
            ],
            24,
            background=colors.bg,
        ),
    ),
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    active=colors.fg,
                    inactive="#504945",
                    this_current_screen_border=colors.hl,
                    this_screen_border=Color(colors.hl, luminance=0.3).get_web(),
                    block_highlight_text_color="#ffffff",
                    other_screen_border="#928374",
                    urgent_border=colors.warn,
                    disable_drag=True,
                ),
                widget.CurrentLayoutIcon(scale=0.8),
                widget.WindowCount(fmt="[{}]  "),
                widget.Prompt(),
                widget.WindowName(background=colors.bg, foreground=colors.hl),
                widget.Battery(
                    battery="BAT0",
                    format="{char} {percent:2.0%} {hour:d}:{min:02d}",
                    fmt=" {}",
                    charge_char="+",
                    discharge_char="-",
                    full_char="o",
                    update_interval=30,
                ),
                widget.Sep(),
                dup_widgets["updates"],
                widget.Sep(),
                dup_widgets["cpu"],
                widget.Sep(),
                dup_widgets["temp"],
                widget.Sep(),
                dup_widgets["mem"],
                widget.Sep(),
                dup_widgets["df_root"],
                widget.Sep(),
                dup_widgets["clock"],
            ],
            24,
            background=colors.bg,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = False
bring_front_click = True
cursor_warp = False
floating_layout = layout.Floating(
    border_focus=colors.hl,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(wm_class="MEGAsync"),
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ],
)

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
