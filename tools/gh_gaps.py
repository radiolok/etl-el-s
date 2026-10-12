"""Отчёт о непокрытых участках ПЗУ и косвенных переходах (PCHL)."""
import sys, os
sys.path.insert(0, os.path.dirname(__file__))
from gh import program
with program() as p:
    sp = p.getAddressFactory().getDefaultAddressSpace(); A = sp.getAddress
    L = p.getListing(); mem = p.getMemory(); rm = p.getReferenceManager()
    for b in mem.getBlocks():
        if not b.isInitialized() or b.getName() == 'VEC': continue
        a = b.getStart().getOffset(); e = b.getEnd().getOffset()
        start = None
        while a <= e + 1:
            cu = L.getCodeUnitAt(A(a)) if a <= e else None
            und = cu is not None and cu.getClass().getSimpleName() == 'DataDB' and not cu.isDefined()
            if und and start is None: start = a
            if not und and start is not None:
                n = a - start
                raw = bytes(mem.getByte(A(x)) & 0xFF for x in range(start, min(a, start + 16)))
                if not all(c == 0xFF for c in bytes(mem.getByte(A(x)) & 0xFF for x in range(start, a))):
                    refs = sum(1 for _ in rm.getReferencesTo(A(start)))
                    print('%s %04X-%04X %5d refs=%d %s' % (b.getName(), start, a - 1, n, refs, raw.hex(' ')))
                start = None
            a += cu.getLength() if cu is not None and a <= e else 1
    print('--- PCHL')
    it = L.getInstructions(True)
    while it.hasNext():
        i = it.next()
        if i.getMnemonicString() == 'PCHL':
            f = p.getFunctionManager().getFunctionContaining(i.getAddress())
            print(i.getAddress(), f.getName() if f else '-')
