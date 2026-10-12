"""Схема размещения составных частей в ПЗУ (docs/rom_layout.svg) по etl_info.COMPONENTS.

    python3 tools/rom_layout_svg.py
"""
import os
import sys
from html import escape
sys.path.insert(0, os.path.dirname(__file__))
from etl_info import COMPONENTS
from strings_koi7 import ROOT

ROMS = [('MON', 0x0800, 0x0800, 'КР573РФ2 (2716) «Д17»', 'u_0800_2716-monitor.bin'),
        ('ROM1', 0x2000, 0x2000, 'К573РФ4А (2764) №1', 'u_2000_2764-1.bin'),
        ('ROM2', 0x4000, 0x2000, 'К573РФ4А (2764) №2', 'u_4000_2764-2.bin'),
        ('ROM3', 0x6000, 0x2000, 'К573РФ4А (2764) №3', 'u_6000_2764-3.bin')]

COLORS = {  # категория -> (заливка, подпись)
    'mon': ('#c9d7f0', 'монитор/отладчик'),
    'init': ('#f6c99b', 'старт, самотесты'),
    'ui': ('#f3e19a', 'интерфейс, клавиатура'),
    'calc': ('#b9e3b0', 'измерения, формат чисел'),
    'video': ('#b5dde6', 'графика (видеоОЗУ)'),
    'bio': ('#e3c1e6', 'биометрия плода'),
    'data': ('#dedede', 'строки, таблицы, картинки'),
    'font': ('#c7c7c7', 'шрифт 8×8'),
    'rt': ('#f0b7b7', 'библиотека float32, формат'),
    'free': ('#ffffff', 'свободно (0xFF)'),
}

COL_W, BAR_W, TOP, H8K = 400, 70, 70, 760


def main():
    W = len(ROMS) * COL_W + 40
    H = TOP + H8K + 140
    o = ['<svg xmlns="http://www.w3.org/2000/svg" width="%d" height="%d" viewBox="0 0 %d %d">' % (W, H, W, H),
         '<style>.h{font:bold 16px sans-serif;fill:#111}.c{font:bold 12px sans-serif;fill:#111}'
         '.s{font:11px sans-serif;fill:#333}.a{font:10px monospace;fill:#555}'
         '.n{font:11px sans-serif;fill:#111}.d{font:10px sans-serif;fill:#444}</style>',
         '<rect width="100%" height="100%" fill="#fff"/>',
         '<text class="h" x="20" y="26">ЭТС-ЭЛ-С (MEDELKOM SLE-101): составные части прошивки по ПЗУ</text>',
         '<text class="s" x="20" y="46">Высота столбца пропорциональна размеру ПЗУ (2716 = 2 КБ, 2764 = 8 КБ). '
         'Адреса — в адресном пространстве 8085.</text>']
    for i, (rom, base, size, chip, fn) in enumerate(ROMS):
        x = 20 + i * COL_W
        scale = H8K / 0x2000
        o.append('<text class="c" x="%d" y="%d">%s</text>' % (x, TOP - 8, escape(chip)))
        parts = [c for c in COMPONENTS if c[2] == rom]
        last_label_y = -100
        for lo, hi, _, cat, name, desc in parts:
            y0 = TOP + (lo - base) * scale
            h = (hi - lo + 1) * scale
            o.append('<rect x="%d" y="%.1f" width="%d" height="%.1f" fill="%s" stroke="#555" stroke-width=".6"/>'
                     % (x, y0, BAR_W, h, COLORS[cat][0]))
            o.append('<text class="a" x="%d" y="%.1f">%04X</text>' % (x + 3, y0 + 10 if h > 11 else y0 + h - 1, lo))
            # подпись справа; не наезжать на предыдущую
            ly = max(y0 + min(h, 30) / 2 + 4, last_label_y + 24)
            o.append('<line x1="%d" y1="%.1f" x2="%d" y2="%.1f" stroke="#999" stroke-width=".6"/>'
                     % (x + BAR_W, y0 + min(h, 30) / 2, x + BAR_W + 8, ly - 4))
            o.append('<text class="n" x="%d" y="%.1f">%s <tspan class="a">%04X–%04X</tspan></text>'
                     % (x + BAR_W + 10, ly, escape(name), lo, hi))
            o.append('<text class="d" x="%d" y="%.1f">%s</text>' % (x + BAR_W + 10, ly + 11, escape(desc if len(desc) <= 52 else desc[:51] + "…")))
            last_label_y = ly
        o.append('<text class="a" x="%d" y="%.1f">%s</text>' % (x, max(TOP + size * scale + 14, last_label_y + 28), fn))
        o.append('<rect x="%d" y="%d" width="%d" height="%.1f" fill="none" stroke="#111" stroke-width="1.2"/>'
                 % (x, TOP, BAR_W, size * scale))
    ly = TOP + H8K + 40
    for k, (cat, (col, txt)) in enumerate(COLORS.items()):
        lx = 20 + (k % 5) * 230
        yy = ly + (k // 5) * 22
        o.append('<rect x="%d" y="%d" width="14" height="14" fill="%s" stroke="#555" stroke-width=".6"/>' % (lx, yy - 11, col))
        o.append('<text class="s" x="%d" y="%d">%s</text>' % (lx + 20, yy, escape(txt)))
    o.append('</svg>')
    (ROOT / 'docs' / 'rom_layout.svg').write_text('\n'.join(o))


if __name__ == '__main__':
    main()
