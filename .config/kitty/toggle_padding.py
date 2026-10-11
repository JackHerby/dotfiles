from kittens.tui.handler import result_handler

from kitty.boss import Boss
from kitty.fast_data_types import get_options
from kitty.options.utils import optional_edge_width
from kitty.tabs import Tab

OFF = "-1"
ON = "0 360"


def main(args: list[str]) -> str:
    return ""


@result_handler(no_ui=True)
def handle_result(args: list[str], answer: str, target_window_id: int, boss: Boss) -> None:
    opts = get_options()
    current = opts.single_window_padding_width
    value = OFF if current == optional_edge_width(ON) else ON
    opts.single_window_padding_width = optional_edge_width(value)
    w = boss.window_id_map.get(target_window_id)
    if w is not None:
        w.update_effective_padding()
        if isinstance(tab := w.tabref(), Tab):
            tab.relayout()
