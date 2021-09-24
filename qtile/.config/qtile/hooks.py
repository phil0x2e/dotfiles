from libqtile import qtile, hook, widget

from colors import Colorscheme


def init_hooks(colors: Colorscheme) -> None:
    @hook.subscribe.startup_once
    def startup() -> None:
        # If there are two screens set workspace on second screen to workspace 6
        if len(screens := qtile.screens) == 2:
            screens[1].set_group(qtile.groups[5])

    @hook.subscribe.current_screen_change
    def screen_change() -> None:
        """
        Change the windowName widgets look when screen loses focus
        """
        curr = qtile.current_screen
        screens = qtile.screens
        for s in screens:
            widgets = s.top.widgets
            window_name_widget = [w for w in widgets if isinstance(w, widget.WindowName)][0]
            if s == curr:
                window_name_widget.background = colors.hl
                window_name_widget.foreground = colors.bg
            if s != curr:
                window_name_widget.background = colors.bg
                window_name_widget.foreground = colors.hl
