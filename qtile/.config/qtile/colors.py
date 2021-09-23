#!/bin/python
from dataclasses import dataclass
from typing import Dict


@dataclass
class Colorscheme:
    hl: str
    fg: str
    bg: str
    red: str
    green: str
    yellow: str
    blue: str
    purple: str
    aqua: str

    @property
    def warn(self) -> str:
        return self.yellow

    @property
    def err(self) -> str:
        return self.red

    def get_dmenu_theme(self) -> Dict[str, str]:
        return {
            "background": self.bg,
            "foreground": self.fg,
            "selected_background": self.hl,
            "selected_foreground": self.bg,
        }
