"""Рисует шрифт 8x8 (0x5D91) и пиктограммы 32x32 (0x42DB) в SVG.

    python3 tools/font2svg.py   ->  docs/font.svg, docs/pictograms.svg
"""
import os
import sys
sys.path.insert(0, os.path.dirname(__file__))
from strings_koi7 import image, CYR, ROOT

FONT, NCHR = 0x5D91, 0x92
PICTO, NPIC = 0x42DB, 8


def bitmap_path(rows, x0, y0, px):
    """Один path из квадратиков: rows — список строк из '0'/'1'."""
    d = []
    for y, row in enumerate(rows):
        x = 0
        while x < len(row):
            if row[x] == '1':
                s = x
                while x < len(row) and row[x] == '1':
                    x += 1
                d.append('M%g %gh%gv%gh-%gz' % (x0 + s * px, y0 + y * px, (x - s) * px, px, (x - s) * px))
            else:
                x += 1
    return ' '.join(d)


def bits(b, n=8):
    return format(b, '0%db' % n)


def label(c):
    if 0x60 <= c <= 0x7E:
        return CYR[c - 0x60]
    if 0x21 <= c < 0x60:
        return {'<': '&lt;', '>': '&gt;', '&': '&amp;'}.get(chr(c), chr(c))
    return ''


STYLE = '''<style>
  .bg{fill:#fff} .cell{fill:#f4f4f4;stroke:#ccc;stroke-width:.5} .ink{fill:#111}
  .t{font:11px monospace;fill:#555} .h{font:bold 15px sans-serif;fill:#111} .s{font:11px sans-serif;fill:#555}
</style>'''


def font_svg(img):
    px, cols = 4, 16
    cw, ch = 8 * px + 14, 8 * px + 30
    W = cols * cw + 60
    rows = (NCHR + cols - 1) // cols
    H = rows * ch + 70
    out = ['<svg xmlns="http://www.w3.org/2000/svg" width="%d" height="%d" viewBox="0 0 %d %d">' % (W, H, W, H),
           STYLE, '<rect class="bg" width="100%" height="100%"/>',
           '<text class="h" x="16" y="24">Шрифт 8×8, ПЗУ 0x5D91–0x6220 (ROM2→ROM3), символы 0x00–0x91</text>',
           '<text class="s" x="16" y="42">MSB слева; 0x60–0x7E — кириллица КОИ-7 Н2; адрес глифа = 0x5D91 + 8·код</text>']
    for c in range(NCHR):
        gx, gy = 50 + (c % cols) * cw, 60 + (c // cols) * ch
        g = [bits(img[FONT + 8 * c + r]) for r in range(8)]
        out.append('<rect class="cell" x="%d" y="%d" width="%d" height="%d"/>' % (gx, gy, 8 * px, 8 * px))
        out.append('<path class="ink" d="%s"/>' % bitmap_path(g, gx, gy, px))
        out.append('<text class="t" x="%d" y="%d">%02X %s</text>' % (gx, gy + 8 * px + 12, c, label(c)))
    for r in range(rows):
        out.append('<text class="t" x="10" y="%d">%X0</text>' % (60 + r * ch + 18, r))
    out.append('</svg>')
    return '\n'.join(out)


def picto_svg(img):
    px, cw = 4, 32 * 4 + 24
    W, H = 4 * cw + 30, 2 * (32 * px + 30) + 60
    out = ['<svg xmlns="http://www.w3.org/2000/svg" width="%d" height="%d" viewBox="0 0 %d %d">' % (W, H, W, H),
           STYLE, '<rect class="bg" width="100%" height="100%"/>',
           '<text class="h" x="16" y="24">Пиктограммы 32×32, ПЗУ 0x42DB (таблица 0x42C3, vid_40)</text>']
    for k in range(NPIC):
        gx, gy = 20 + (k % 4) * cw, 44 + (k // 4) * (32 * px + 30)
        base = PICTO + 128 * k
        g = [''.join(bits(img[base + 4 * r + i]) for i in range(4)) for r in range(32)]
        out.append('<rect class="cell" x="%d" y="%d" width="%d" height="%d"/>' % (gx, gy, 32 * px, 32 * px))
        out.append('<path class="ink" d="%s"/>' % bitmap_path(g, gx, gy, px))
        out.append('<text class="t" x="%d" y="%d">%d @%04X</text>' % (gx, gy + 32 * px + 14, k + 1, base))
    out.append('</svg>')
    return '\n'.join(out)


def main():
    img = image()
    (ROOT / 'docs').mkdir(exist_ok=True)
    (ROOT / 'docs' / 'font.svg').write_text(font_svg(img))
    (ROOT / 'docs' / 'pictograms.svg').write_text(picto_svg(img))


if __name__ == '__main__':
    main()
