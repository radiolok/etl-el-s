"""Печать листинга Ghidra по диапазону: python3 tools/gh_list.py 2000 2100"""
import sys
sys.path.insert(0, __import__('os').path.dirname(__file__))
from gh import program

def fmt(cu):
    a = cu.getAddress().getOffset()
    raw = cu.getBytes()
    bs = ' '.join('%02X' % (b & 0xFF) for b in raw[:3]) + (' …' if len(raw) > 3 else '')
    lab = cu.getLabel() or ''
    com = cu.getComment(0) or cu.getComment(1) or ''  # EOL / PRE
    return '%04X %-11s %-14s %s%s' % (a, bs, (lab + ':') if lab else '', cu.toString(), ('  ; ' + com.replace('\n', ' ')) if com else '')

def main(lo, hi):
    with program() as p:
        sp = p.getAddressFactory().getDefaultAddressSpace()
        L = p.getListing()
        it = L.getCodeUnits(sp.getAddress(lo), True)
        out = []
        while it.hasNext():
            cu = it.next()
            if cu.getAddress().getOffset() >= hi: break
            out.append(fmt(cu))
        print('\n'.join(out))

if __name__ == '__main__':
    main(int(sys.argv[1], 16), int(sys.argv[2], 16))
