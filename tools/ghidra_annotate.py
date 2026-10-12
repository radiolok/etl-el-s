"""Разметка проекта Ghidra: таблицы переходов, функции, имена, строки.

Запуск после tools/ghidra_import.py:
    python3 tools/ghidra_annotate.py
Все знания о прошивке собраны здесь, чтобы проект пересоздавался с нуля.
"""
import sys
import os
sys.path.insert(0, os.path.dirname(__file__))
from gh import program
from etl_info import DISPATCH_TABLES, WORD_TABLES, FUNCS, LABELS, COMMENTS, DATA


def main():
    with program(write=True) as p:
        import pyghidra
        from ghidra.program.model.symbol import SourceType, RefType
        from ghidra.program.model.data import ByteDataType, PointerDataType, StringDataType, FloatDataType, ArrayDataType
        from ghidra.app.cmd.disassemble import DisassembleCommand
        from ghidra.app.cmd.function import CreateFunctionCmd
        from ghidra.program.model.listing import CodeUnit
        from ghidra.util.task import TaskMonitor
        mon = TaskMonitor.DUMMY
        sp = p.getAddressFactory().getDefaultAddressSpace()
        A = sp.getAddress
        L = p.getListing()
        mem = p.getMemory()
        st = p.getSymbolTable()
        rm = p.getReferenceManager()
        fm = p.getFunctionManager()

        def byte(a):
            return mem.getByte(A(a)) & 0xFF

        def word(a):
            return byte(a) | byte(a + 1) << 8

        def put(a, dt, n):
            L.clearCodeUnits(A(a), A(a + n - 1), False)
            L.createData(A(a), dt)

        def label(a, name):
            if name:
                st.createLabel(A(a), name, SourceType.USER_DEFINED).setPrimary()

        def code(a, name=None):
            DisassembleCommand(A(a), None, True).applyTo(p, mon)
            if fm.getFunctionAt(A(a)) is None:
                CreateFunctionCmd(A(a)).applyTo(p, mon)
            label(a, name)

        targets = []
        # таблицы {код:1, адрес:2}, конец — байт term
        for tbl, term, name, prefix in DISPATCH_TABLES:
            a = tbl
            label(tbl, name)
            while byte(a) != term:
                k, t = byte(a), word(a + 1)
                put(a, ByteDataType.dataType, 1)
                put(a + 1, PointerDataType(), 2)
                rm.addMemoryReference(A(a + 1), A(t), RefType.COMPUTED_JUMP, SourceType.USER_DEFINED, 0)
                targets.append((t, '%s_%02X' % (prefix, k) if prefix else None))
                a += 3
            put(a, ByteDataType.dataType, 1)
            print('table %04X %s: %d entries' % (tbl, name, (a - tbl) // 3))
        # таблицы адресов (по слову)
        for tbl, n, name, prefix in WORD_TABLES:
            label(tbl, name)
            for i in range(n):
                t = word(tbl + 2 * i)
                put(tbl + 2 * i, PointerDataType(), 2)
                if t == 0:
                    continue
                targets.append((t, '%s_%d' % (prefix, i) if prefix else None))
        for t, nm in targets:
            # имя из FUNCS приоритетнее автоматического
            code(t, None if t in FUNCS else nm)
        for a, nm in FUNCS.items():
            code(a, nm)
        fixpoint(p)
        for a, kind, n, nm, com in DATA:
            dt = {'b': ByteDataType.dataType, 'f': FloatDataType.dataType}[kind]
            arr = ArrayDataType(dt, n, dt.getLength())
            L.clearCodeUnits(A(a), A(a + arr.getLength() - 1), False)
            L.createData(A(a), arr)
            label(a, nm)
            if com:
                L.setComment(A(a), CodeUnit.PLATE_COMMENT, com)
        for a, nm in LABELS.items():
            label(a, nm)
        for a, c in COMMENTS.items():
            L.setComment(A(a), CodeUnit.PLATE_COMMENT if c.startswith('\n') else CodeUnit.EOL_COMMENT, c.strip())

        # строки КОИ-7 с '$' на конце (поиск по образу), если на их месте нет кода
        from strings_koi7 import image, find, koi7
        nstr = 0
        for a, body in find(image()):
            e = a + len(body)
            if any(L.getInstructionContaining(A(x)) is not None for x in range(a, e + 1)):
                continue
            L.clearCodeUnits(A(a), A(e), False)
            L.createData(A(a), StringDataType.dataType, e - a + 1)
            L.setComment(A(a), CodeUnit.EOL_COMMENT, koi7(body))
            nstr += 1
        print('strings', nstr)
    with program(write=True) as p:
        import pyghidra
        pyghidra.analyze(p)
        fixpoint(p)
        pyghidra.analyze(p)


def fixpoint(p):
    """Дизассемблировать все неразобранные цели CALL/JMP, пока появляются новые."""
    from ghidra.app.cmd.disassemble import DisassembleCommand
    from ghidra.app.cmd.function import CreateFunctionCmd
    from ghidra.util.task import TaskMonitor
    L = p.getListing(); mem = p.getMemory(); fm = p.getFunctionManager()
    tried = set()
    while True:
        todo = set()
        it = L.getInstructions(True)
        while it.hasNext():
            i = it.next()
            for t in i.getFlows():
                b = mem.getBlock(t)
                if b and b.isInitialized() and L.getInstructionAt(t) is None \
                        and t.getOffset() not in tried:
                    tried.add(t.getOffset())
                    todo.add((t, i.getFlowType().isCall()))
        if not todo:
            break
        print('fixpoint: %d new targets' % len(todo))
        for t, call in todo:
            DisassembleCommand(t, None, True).applyTo(p, TaskMonitor.DUMMY)
            if call and fm.getFunctionAt(t) is None:
                CreateFunctionCmd(t).applyTo(p, TaskMonitor.DUMMY)


if __name__ == '__main__':
    main()
