import sys

from prompt_toolkit.key_binding.vi_state import InputMode, ViState
from traitlets.config import get_config

c = get_config()


def get_input_mode(self):
    return self._input_mode


def set_input_mode(self, mode):
    shape = {InputMode.NAVIGATION: 2, InputMode.REPLACE: 3}.get(mode, 5)
    raw = "\x1b[{} q".format(shape)
    if hasattr(sys.stdout, "_cli"):
        out = sys.stdout._cli.output.write_raw
    else:
        out = sys.stdout.write
    out(raw)
    sys.stdout.flush()
    self._input_mode = mode


ViState._input_mode = InputMode.INSERT
ViState.input_mode = property(get_input_mode, set_input_mode)
c.TerminalInteractiveShell.editing_mode = "vi"
c.InteractiveShell.pdb = True
c.ZMQTerminalInteractiveShell.include_other_output = True
