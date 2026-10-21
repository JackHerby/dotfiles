from kittens.tui.handler import result_handler

from kitty.boss import Boss
from kitty.fast_data_types import os_window_has_background_image

OFF = -1
ON = 0
DEFAULT = "default"
TRANSLUCENT = "0.0"


def main(args: list[str]) -> str:
    return ""


@result_handler(no_ui=True)
def handle_result(args: list[str], answer: str, target_window_id: int, boss: Boss) -> None:
    osw = boss.window_id_map[target_window_id].os_window_id
    os_windows = (osw,)

    hbi = os_window_has_background_image(osw)
    global_index = OFF if hbi else ON
    opacity = TRANSLUCENT if hbi else DEFAULT

    boss.set_background_image(None, os_windows, False, None, global_index=global_index)
    boss.set_background_opacity(opacity)
