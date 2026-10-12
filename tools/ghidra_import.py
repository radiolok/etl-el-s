"""Создаёт проект Ghidra с прошивкой ЭТС-ЭЛ-С (8085) и запускает автоанализ.

Запуск:  GHIDRA_INSTALL_DIR=~/ghidra_12.1.4_PUBLIC python3 tools/ghidra_import.py
Проект:  ghidra/etl.gpr (в .gitignore)

Карта памяти:
  VEC  0000-003F  2716 @0..3F — то, что видит CPU при сбросе (оверлей ПЗУ на 0000)
  RAM  0040-07FF  КР537РУ10, неинициализирована
  MON  0800-0FFF  2716 монитор
  ROM1 2000-3FFF, ROM2 4000-5FFF, ROM3 6000-7FFF  — 3x 2764
"""
import os
import sys
from pathlib import Path

import pyghidra

ROOT = Path(__file__).resolve().parent.parent
ROMDIR = ROOT / 'rom'
PROJ_DIR = ROOT / 'ghidra'
PROJ_NAME = 'etl'

BLOCKS = [  # name, file, base
    ('MON', 'u_0800_2716-monitor.bin', 0x0800),
    ('ROM1', 'u_2000_2764-1.bin', 0x2000),
    ('ROM2', 'u_4000_2764-2.bin', 0x4000),
    ('ROM3', 'u_6000_2764-3.bin', 0x6000),
]

ENTRIES = {
    0x0000: 'reset_vec',
    0x0815: 'mon_reset',
    0x0C3E: 'mon_break',
    0x2000: 'main_start',
}


def main():
    pyghidra.start(install_dir=Path(os.environ.get(
        'GHIDRA_INSTALL_DIR', Path.home() / 'ghidra_12.1.4_PUBLIC')))
    from java.io import ByteArrayInputStream
    from ghidra.program.model.symbol import SourceType
    from ghidra.app.cmd.disassemble import DisassembleCommand
    from ghidra.program.model.address import AddressSet
    from ghidra.util.task import TaskMonitor

    PROJ_DIR.mkdir(exist_ok=True)
    # пустой образ-заглушка, реальные блоки создаём сами
    stub = PROJ_DIR / 'etl_stub.bin'
    stub.write_bytes((ROMDIR / BLOCKS[0][1]).read_bytes()[:0x40])

    from ghidra.app.util.opinion import BinaryLoader
    project = pyghidra.open_project(PROJ_DIR, PROJ_NAME, create=True)
    if project.getProjectData().getFile('/etl_fw') is not None:
        project.getProjectData().getFile('/etl_fw').delete()
    with pyghidra.program_loader().project(project).source(str(stub)).name('etl_fw') \
            .language('8085:LE:16:default').loaders(BinaryLoader).load() as res:
        res.save(TaskMonitor.DUMMY)
    with pyghidra.program_context(project, '/etl_fw') as prog:
        mem = prog.getMemory()
        sp = prog.getAddressFactory().getDefaultAddressSpace()
        A = sp.getAddress
        mon = TaskMonitor.DUMMY
        with pyghidra.transaction(prog, 'setup'):
            # заглушка загружена по 0000 длиной 0x40 — это и есть блок VEC
            blk = mem.getBlock(A(0))
            blk.setName('VEC')
            blk.setComment('2716 @0000-003F, виден при сбросе (оверлей)')
            ram = mem.createUninitializedBlock('RAM', A(0x40), 0x800 - 0x40, False)
            ram.setRead(True); ram.setWrite(True); ram.setExecute(True)
            for name, fn, base in BLOCKS:
                data = (ROMDIR / fn).read_bytes()
                b = mem.createInitializedBlock(name, A(base), ByteArrayInputStream(data),
                                               len(data), mon, False)
                b.setRead(True); b.setWrite(False); b.setExecute(True)
                b.setComment(fn)
            st = prog.getSymbolTable()
            for addr, name in ENTRIES.items():
                st.createLabel(A(addr), name, SourceType.USER_DEFINED)
                st.addExternalEntryPoint(A(addr))
                DisassembleCommand(A(addr), None, True).applyTo(prog, mon)
        log = pyghidra.analyze(prog)
        print(log[-3000:])
        prog.save('import+analysis', mon)
    project.close()
    stub.unlink()


if __name__ == '__main__':
    sys.exit(main())
