"""Режет образы ПЗУ на составные части по etl_info.COMPONENTS -> parts/*.bin

    python3 tools/split_parts.py
Имя файла: <ПЗУ>_<начало>-<конец>_<категория>.bin; оглавление — parts/index.txt.
"""
import os
import sys
sys.path.insert(0, os.path.dirname(__file__))
from etl_info import COMPONENTS
from strings_koi7 import image, ROOT


def main():
    img = image()
    out = ROOT / 'parts'
    out.mkdir(exist_ok=True)
    idx = []
    for lo, hi, rom, cat, name, desc in COMPONENTS:
        if cat == 'free':
            continue
        fn = '%s_%04X-%04X_%s.bin' % (rom.lower(), lo, hi, cat)
        (out / fn).write_bytes(img[lo:hi + 1])
        idx.append('%-32s %5d  %s — %s' % (fn, hi - lo + 1, name, desc))
    (out / 'index.txt').write_text('\n'.join(idx) + '\n')
    print('\n'.join(idx))


if __name__ == '__main__':
    main()
