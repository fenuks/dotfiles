from IPython import get_ipython
from IPython.core.interactiveshell import InteractiveShell
from prompt_toolkit.auto_suggest import AutoSuggestFromHistory
from prompt_toolkit.enums import DEFAULT_BUFFER
from prompt_toolkit.filters import Condition, HasFocus, HasSelection, vi_insert_mode
from prompt_toolkit.key_binding.key_processor import KeyPressEvent
from prompt_toolkit.keys import Keys

ip: InteractiveShell = get_ipython()
ip.pt_app.auto_suggest = AutoSuggestFromHistory()
app = ip.pt_app.app
keybindings = ip.pt_app.key_bindings
handle = keybindings.add


@handle("c-k", filter=vi_insert_mode)
def complete_next(event: KeyPressEvent) -> None:
    event.current_buffer.auto_up(count=event.arg)


@handle("c-j", filter=vi_insert_mode)
def _complete_prev(event: KeyPressEvent) -> None:
    event.current_buffer.auto_down(count=event.arg)


@Condition
def suggestion_available() -> bool:
    return (
        app.current_buffer.suggestion is not None
        and len(app.current_buffer.suggestion.text) > 0
        and app.current_buffer.document.is_cursor_at_the_end
    )


# <a-f>
@handle(Keys.ControlY, filter=suggestion_available)
def accept_suggestion(event: KeyPressEvent) -> None:
    buf = event.current_buffer

    if suggestion := buf.suggestion:
        buf.insert_text(suggestion.text)


@handle(
    Keys.ControlA, filter=(HasFocus(DEFAULT_BUFFER) & ~HasSelection() & vi_insert_mode)
)
def start_of_line(event: KeyPressEvent):
    buf = event.current_buffer
    buf.cursor_position += buf.document.get_start_of_line_position(
        after_whitespace=True
    )


@handle(
    Keys.ControlE, filter=(HasFocus(DEFAULT_BUFFER) & ~HasSelection() & vi_insert_mode)
)
def end_of_line(event: KeyPressEvent):
    buf = event.current_buffer
    buf.cursor_position += buf.document.get_end_of_line_position()
