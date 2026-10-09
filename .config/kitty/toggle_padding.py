from kittens.tui.handler import result_handler
from kitty.boss import Boss
from kitty.fast_data_types import get_options
from kitty.options.utils import optional_edge_width

OFF = '-1'
ON = '0 360'


def main(args: list[str]) -> str:
    pass


@result_handler(no_ui=True)
def handle_result(args: list[str], answer: str, target_window_id: int, boss: Boss) -> None:
    current = get_options().single_window_padding_width
    value = OFF if current == optional_edge_width(ON) else ON
    boss.load_config_file(overrides=(f'single_window_padding_width {value}',))
