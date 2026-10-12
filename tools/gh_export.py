"""Экспорт из проекта Ghidra в disasm/: листинги по ПЗУ, функции, порты, внешние обращения.

    python3 tools/gh_export.py
"""
import sys, os, json
sys.path.insert(0, os.path.dirname(__file__))
from gh import program, ROOT
from gh_list import fmt

OUT = ROOT / 'disasm'
ROMS = [('MON', 0x0800, 0x1000, 'mon_2716.asm'), ('ROM1', 0x2000, 0x4000, 'rom1_2000.asm'),
        ('ROM2', 0x4000, 0x6000, 'rom2_4000.asm'), ('ROM3', 0x6000, 0x8000, 'rom3_6000.asm')]


def blk(a):
    for n, lo, hi, _ in ROMS:
        if lo <= a < hi: return n
    return 'VEC' if a < 0x40 else 'RAM' if a < 0x800 else 'EXT'


def main():
    OUT.mkdir(exist_ok=True)
    with program() as p:
        sp = p.getAddressFactory().getDefaultAddressSpace(); A = sp.getAddress
        L = p.getListing(); fm = p.getFunctionManager(); rm = p.getReferenceManager()
        mem = p.getMemory()
        for name, lo, hi, fn in ROMS:
            lines = ['; %s %04X-%04X, экспорт Ghidra' % (name, lo, hi - 1)]
            it = L.getCodeUnits(A(lo), True)
            while it.hasNext():
                cu = it.next()
                a = cu.getAddress().getOffset()
                if a >= hi: break
                f = fm.getFunctionAt(cu.getAddress())
                if f is not None:
                    lines.append('')
                    lines.append('; ' + '=' * 60)
                    lines.append('; %s' % f.getName())
                    pc = cu.getComment(3)
                    if pc:
                        lines += ['; ' + x for x in pc.split('\n')]
                    callers = sorted({r.getFromAddress().getOffset() for r in rm.getReferencesTo(cu.getAddress())
                                      if r.getReferenceType().isCall() or r.getReferenceType().isJump()})
                    if callers:
                        lines.append('; вызовы из: ' + ' '.join('%04X' % c for c in callers[:20]) + (' …' if len(callers) > 20 else ''))
                elif cu.getComment(3):
                    lines.append('')
                    lines += ['; ' + x for x in cu.getComment(3).split('\n')]
                lines.append(fmt(cu))
            # свернуть длинные серии FF
            out, ff = [], 0
            for l in lines:
                if l[5:16].strip() == 'FF' and '??' in l:
                    ff += 1
                    if ff == 1: out.append(l)
                    elif ff == 2: out.append(';   … FF …')
                    continue
                ff = 0; out.append(l)
            (OUT / fn).write_text('\n'.join(out) + '\n')

        funcs = []
        for f in fm.getFunctions(True):
            ent = f.getEntryPoint().getOffset()
            body = f.getBody()
            size = sum(r.getLength() for r in body)
            first = bytes(mem.getByte(A(ent + i)) & 0xFF for i in range(6))
            cfun = (first[0] == 0x21 and first[3] == 0x39) or first[:4] == b'\xc5\x21\x00\x00'
            callees = sorted({c.getEntryPoint().getOffset() for c in f.getCalledFunctions(None)})
            callers = sorted({c.getEntryPoint().getOffset() for c in f.getCallingFunctions(None)})
            funcs.append(dict(addr=ent, name=f.getName(), block=blk(ent), size=size, c_frame=bool(cfun),
                              callees=callees, callers=callers))
        (OUT / 'functions.json').write_text(json.dumps(funcs, indent=0))

        io, ext, ram = [], {}, {}
        it = L.getInstructions(True)
        while it.hasNext():
            i = it.next()
            a = i.getAddress().getOffset()
            m = i.getMnemonicString()
            f = fm.getFunctionContaining(i.getAddress())
            fn_name = f.getName() if f else '-'
            if m in ('IN', 'OUT'):
                io.append(('%04X' % a, m, '%02X' % (i.getByte(1) & 0xFF), fn_name))
            if i.getLength() == 3 and i.getByte(0) & 0xFF not in (0xC3, 0xCD) and (i.getByte(0) & 0xC7) not in (0xC2, 0xC4):
                v = (i.getByte(1) & 0xFF) | (i.getByte(2) & 0xFF) << 8
                if 0x1000 <= v < 0x2000 or v >= 0x8000:
                    ext.setdefault(v, []).append(('%04X' % a, str(i)))
                elif v < 0x800 and m in ('LDA', 'STA', 'LHLD', 'SHLD', 'LXI'):
                    ram.setdefault(v, set()).add(fn_name)
        with open(OUT / 'io_ports.txt', 'w') as fo:
            for r in sorted(io, key=lambda x: (x[2], x[0])):
                fo.write('%s  %-3s %s   %s\n' % (r[2], r[1], r[0], r[3]))
        with open(OUT / 'ext_refs.txt', 'w') as fo:
            for v in sorted(ext):
                fo.write('%04X: %s\n' % (v, '; '.join('%s %s' % x for x in ext[v])))
        with open(OUT / 'ram_vars.txt', 'w') as fo:
            for v in sorted(ram):
                fo.write('%04X: %s\n' % (v, ' '.join(sorted(ram[v]))))
        print('functions', len(funcs), 'io', len(io), 'ext', len(ext), 'ram vars', len(ram))


if __name__ == '__main__':
    main()
