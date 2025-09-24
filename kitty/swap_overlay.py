from kitty.boss import Boss
from kittens.tui.handler import result_handler


def main(args: list[str]) -> str:
    pass


@result_handler(no_ui=True)
def handle_result(
    args: list[str], answer: str, target_window_id: int, boss: Boss
) -> None:
    w = boss.window_id_map.get(target_window_id)
    tab = boss.active_tab
    if args[1] == "next":
        group = list(tab.windows.windows_in_group_of(tab.active_window))
        if len(group) == 1:
            return
        new_window = group[0]
        tab.move_window_to_top_of_group(new_window)
        group_ids = [w.id for w in group]
        highlight = len(group_ids) - group_ids.index(min(group_ids)) - 1
        boss.launch(
            "--type=overlay",
            "python",
            "/home/charlie/.config/kitty/print_and_wait.py",
            f"{highlight + 1}/{len(group_ids)}",
            "0.6",
        )
    elif args[1] == "make":
        window = tab.active_window
        boss.call_remote_control(
            window, ("launch", "--type=overlay-main", "--cwd=current")
        )
    else:
        raise ValueError(f"Unknown command '{args[1]}'")
