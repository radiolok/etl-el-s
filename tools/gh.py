"""Общий хелпер: открыть проект Ghidra ghidra/etl и программу /etl_fw."""
import os, contextlib
from pathlib import Path
import pyghidra
ROOT = Path(__file__).resolve().parent.parent

@contextlib.contextmanager
def program(write=False):
    pyghidra.start(install_dir=Path(os.environ.get('GHIDRA_INSTALL_DIR', Path.home() / 'ghidra_12.1.4_PUBLIC')))
    project = pyghidra.open_project(ROOT / 'ghidra', 'etl')
    try:
        with pyghidra.program_context(project, '/etl_fw') as prog:
            if write:
                with pyghidra.transaction(prog, 'edit'):
                    yield prog
                from ghidra.util.task import TaskMonitor
                prog.save('edit', TaskMonitor.DUMMY)
            else:
                yield prog
    finally:
        project.close()
