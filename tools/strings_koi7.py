"""Извлечение строк КОИ-7 Н2 (0x60-0x7E = кириллица) из образа ПЗУ.

    python3 tools/strings_koi7.py [--min N] > docs/strings.txt
Строки в прошивке оканчиваются на '$' (0x24).
"""
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
ROMS = [('u_0800_2716-monitor.bin', 0x0800), ('u_2000_2764-1.bin', 0x2000),
        ('u_4000_2764-2.bin', 0x4000), ('u_6000_2764-3.bin', 0x6000)]

# КОИ-7 Н2: 0x60..0x7E
CYR = 'ЮАБЦДЕФГХИЙКЛМНОПЯРСТУЖВЬЫЗШЭЩЧ'


def image():
    img = bytearray(b'\xff' * 0x8000)
    for fn, base in ROMS:
        d = (ROOT / 'rom' / fn).read_bytes()
        img[base:base + len(d)] = d
    return img


def koi7(bs):
    out = []
    for c in bs:
        if 0x60 <= c <= 0x7E:
            out.append(CYR[c - 0x60])
        elif 0x20 <= c < 0x60:
            out.append(chr(c))
        else:
            out.append('\\x%02X' % c)
    return ''.join(out)


def printable(c):
    return 0x20 <= c <= 0x7E


def find(img, minlen=3):
    """Строки вида <печатные/управляющие байты>'$'."""
    res = []
    a = 0
    while a < len(img):
        if img[a] == 0x24:
            s = a - 1
            while s >= 0 and (printable(img[s]) and img[s] != 0x24 or img[s] in (0x0A, 0x0D)):
                s -= 1
            s += 1
            body = img[s:a]
            letters = sum(1 for c in body if 0x60 <= c <= 0x7E or 0x41 <= c <= 0x5A)
            if len(body) >= minlen and letters >= max(2, len(body) // 3):
                res.append((s, bytes(body)))
        a += 1
    return res


def main():
    minlen = int(sys.argv[sys.argv.index('--min') + 1]) if '--min' in sys.argv else 3
    img = image()
    for s, body in find(img, minlen):
        print('%04X  %s' % (s, koi7(body)))


if __name__ == '__main__':
    main()
