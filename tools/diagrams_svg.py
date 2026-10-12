"""Схемы в SVG: docs/memory_map.svg, docs/boot_flow.svg, docs/board_block.svg.

    python3 tools/diagrams_svg.py
Схемы рисуются вручную (координаты здесь), данные — по результатам разбора (docs/firmware_parts.md).
"""
import os
import sys
from html import escape
sys.path.insert(0, os.path.dirname(__file__))
from strings_koi7 import ROOT
from rom_layout_svg import COLORS

STYLE = '''<style>
 .h{font:bold 17px sans-serif;fill:#111} .sub{font:12px sans-serif;fill:#555}
 .t{font:13px sans-serif;fill:#111} .tb{font:bold 13px sans-serif;fill:#111}
 .s{font:11px sans-serif;fill:#333} .a{font:11px monospace;fill:#444}
 .box{stroke:#444;stroke-width:1} .dash{stroke:#888;stroke-width:1;stroke-dasharray:5 3;fill:none}
 .ln{stroke:#444;stroke-width:1.3;fill:none} .bus{stroke:#666;stroke-width:5;fill:none;stroke-linecap:round}
</style>
<defs><marker id="ar" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">
<path d="M0 0L10 5L0 10z" fill="#444"/></marker></defs>'''


class Svg:
    def __init__(self, w, h, title, sub=None):
        self.w, self.h = w, h
        self.o = ['<svg xmlns="http://www.w3.org/2000/svg" width="%d" height="%d" viewBox="0 0 %d %d">' % (w, h, w, h),
                  STYLE, '<rect width="100%" height="100%" fill="#fff"/>',
                  '<text class="h" x="20" y="28">%s</text>' % escape(title)]
        if sub:
            self.o.append('<text class="sub" x="20" y="47">%s</text>' % escape(sub))

    def box(self, x, y, w, h, fill='#fff', lines=(), cls='box', rx=4, dash=False):
        self.o.append('<rect class="%s" x="%g" y="%g" width="%g" height="%g" rx="%d" fill="%s"%s/>'
                      % (cls, x, y, w, h, rx, fill, ' stroke-dasharray="5 3"' if dash else ''))
        n = len(lines)
        for i, ln in enumerate(lines):
            c = 'tb' if i == 0 else 's'
            yy = y + h / 2 - (n - 1) * 8 + i * 16 + 4
            self.o.append('<text class="%s" x="%g" y="%g" text-anchor="middle">%s</text>' % (c, x + w / 2, yy, escape(ln)))

    def text(self, x, y, s, cls='t', anchor='start'):
        self.o.append('<text class="%s" x="%g" y="%g" text-anchor="%s">%s</text>' % (cls, x, y, anchor, escape(s)))

    def line(self, pts, arrow=True, cls='ln', both=False):
        d = 'M' + ' L'.join('%g %g' % p for p in pts)
        self.o.append('<path class="%s" d="%s"%s%s/>' % (cls, d, ' marker-end="url(#ar)"' if arrow else '',
                                                         ' marker-start="url(#ar)"' if both else ''))

    def save(self, name):
        self.o.append('</svg>')
        (ROOT / 'docs' / name).write_text('\n'.join(self.o))


def memory_map():
    s = Svg(1130, 1060, 'ЭТС-ЭЛ-С: карта памяти 8085',
            'Слева — всё адресное пространство (линейно), справа — распределение ОЗУ 0000–07FF по коду программы')
    X, W, TOP, H = 40, 150, 80, 900
    k = H / 0x10000
    regions = [
        (0x0000, 0x07FF, '#fff3b0', ['ОЗУ КР537РУ10', '2 КБ']),
        (0x0800, 0x0FFF, COLORS['mon'][0], ['2716 монитор']),
        (0x1000, 0x1FFF, '#f7f7f7', ['не используется']),
        (0x2000, 0x3FFF, COLORS['ui'][0], ['2764 №1 (ROM1)', 'основная программа']),
        (0x4000, 0x5FFF, COLORS['bio'][0], ['2764 №2 (ROM2)', 'графика, биометрия']),
        (0x6000, 0x7FFF, COLORS['rt'][0], ['2764 №3 (ROM3)', 'шрифт, float']),
        (0x8000, 0xC6FF, '#f7f7f7', ['обращений нет']),
        (0xC700, 0xFFFF, COLORS['video'][0], ['видеоОЗУ («УВЗ»)', 'вне процессорной платы']),
    ]
    for lo, hi, fill, lines in regions:
        y = TOP + lo * k
        h = (hi - lo + 1) * k
        s.box(X, y, W, h, fill, lines if h > 34 else [], rx=0)
        s.text(X - 4, y + 10, '%04X' % lo, 'a', 'end')
        if h <= 34:
            s.text(X + W + 8, y + h / 2 + 4, ' · '.join(lines), 's')
    s.text(X - 4, TOP + H, 'FFFF', 'a', 'end')
    s.text(X + W + 8, TOP + 0xC800 * k + 14, 'C800–FFFF: тест при старте', 's')
    s.text(X + W + 8, TOP + 0xC700 * k + 2, 'C700: очистка (vid_01)', 's')
    s.text(X + W + 8, TOP + 0xCA09 * k + 28, 'CA09: база графики, строка 45 байт', 's')

    # ОЗУ подробно
    RX, RW, RT, RH = 500, 280, 80, 900
    rk = RH / 0x800
    ram = [
        (0x0000, 0x003F, '#fde7a6', 'Векторы', 'JMP 0C3E в 0000; (0004) — верх ОЗУ (монитор)'),
        (0x0040, 0x007F, '#fff3b0', 'Переменные главной программы', '0048/0049 — копии портов FA/F8, клавиатура'),
        (0x0080, 0x00D2, '#e9f5d6', 'Шаблон экранного текста', 'копия 0x2FF1: заставка, дата, «L+», «P», «S»'),
        (0x00D3, 0x00FF, '#fff3b0', 'Маркеры измерений', '00D3.. сбрасываются в FF'),
        (0x0100, 0x01DF, '#d7efd0', 'Рабочая область измерений', 'float-переменные по 4 байта, буфер формата'),
        (0x01E0, 0x01FF, '#fff3b0', 'Состояние интерфейса', 'режимы, курсор (01F3 — строка)'),
        (0x0200, 0x0367, COLORS['video'][0], 'Переменные графики', '02DF режим, 02E3 строка, 02E5 глиф'),
        (0x0368, 0x0607, COLORS['bio'][0], 'Пациент и биометрия', 'протокол, методы 036B–0374, результаты'),
        (0x0608, 0x071F, '#f2f2f2', 'Стек главной программы', 'SP = 0720, растёт вниз'),
        (0x0720, 0x07C6, '#e3e9f6', 'Стек монитора', 'SP = 07BF'),
        (0x07C7, 0x07FF, COLORS['mon'][0], 'Трамплин монитора', 'регистры, JMP-векторы (копия 0FC7)'),
    ]
    for lo, hi, fill, name, desc in ram:
        y = RT + lo * rk
        h = (hi - lo + 1) * rk
        s.box(RX, y, RW, h, fill, [], rx=0)
        s.text(RX - 4, y + 10, '%04X' % lo, 'a', 'end')
        s.text(RX + 8, y + min(h / 2, 18) + 4, name, 'tb' if h > 16 else 's')
        s.text(RX + RW + 10, y + min(h / 2, 18) + 4, desc, 's')
    s.text(RX - 4, RT + RH, '07FF', 'a', 'end')
    # выноска ОЗУ
    y1, y2 = TOP, TOP + 0x800 * k
    s.line([(X + W, y1), (RX - 40, RT)], arrow=False, cls='dash')
    s.line([(X + W, y2), (RX - 40, RT + RH)], arrow=False, cls='dash')
    s.text(20, TOP + H + 40, 'При сбросе чтение с 0x0000 идёт из ПЗУ (оверлей): из 2716 (JMP 0815) или, по гипотезе, из ROM1.', 's')
    s.text(20, TOP + H + 56, 'Запись в 0x0000 всегда попадает в ОЗУ. Порты: FE/FF и EE/EF — 8251; F6 — клавиатура; F8, FA — управление.', 's')
    s.save('memory_map.svg')


def boot_flow():
    s = Svg(1060, 880, 'ЭТС-ЭЛ-С: последовательность запуска',
            'По коду монитора (0815) и основной программы (2000). Пунктир — гипотеза.')
    C = lambda x, w: x + w / 2
    s.box(430, 70, 200, 40, '#eee', ['СБРОС 8085'])
    s.line([(530, 110), (530, 140)])
    s.box(380, 140, 300, 44, '#fff3b0', ['Чтение 0000 — из ПЗУ (оверлей)', 'запись 0000 — в ОЗУ'])
    s.line([(450, 184), (250, 230)])
    s.line([(610, 184), (810, 230)], cls='ln" stroke-dasharray="5 3')
    s.text(250, 200, 'режим отладки (2716)', 's')
    s.text(740, 200, 'рабочий режим (гипотеза, джампер?)', 's')

    # ветка монитора
    mx, mw = 90, 320
    steps = [
        ('0000: JMP 0815', 'векторы 2716'),
        ('0815: DI, 11×NOP', 'место под патч'),
        ('Инициализация 8251', 'FF и EF: режим CF, команда 25'),
        ('Поиск конца ОЗУ', 'по страницам → (0004) = 07FF'),
        ('Трамплин 0FC7 → 07C7', 'JMP 0C3E → 0000'),
        ('Вывод регистров', 'P A H L D E B C S F I'),
        ('Командный цикл', 'C D E F G H M P R S U W X'),
    ]
    y = 230
    for i, (a, b) in enumerate(steps):
        s.box(mx, y, mw, 44, COLORS['mon'][0], [a, b])
        if i < len(steps) - 1:
            s.line([(C(mx, mw), y + 44), (C(mx, mw), y + 60)])
        y += 60
    s.line([(mx + mw, y - 38), (mx + mw + 70, y - 38), (mx + mw + 70, 300), (610, 300)])
    s.text(mx + mw + 6, y - 44, 'G 2000', 'a')

    # ветка основной программы
    px, pw = 610, 340
    s.box(px, 230, pw, 44, COLORS['ui'][0], ['0000: ROM1 с нулевого адреса', 'LXI SP / LXI H / … / JNZ 2008'], dash=True)
    s.line([(C(px, pw), 274), (C(px, pw), 290)])
    msteps = [
        ('2000 main_start', 'стек 0720, обнуление 0041–0070, 036B–0373'),
        ('8251 на FF, порты F8=30, FA=80', 'копии в 0049/0048'),
        ('Тест видеоОЗУ C800–FFFF', '«ОШИБКА УВЗ» — повтор до успеха'),
        ('JMP 0C3E → 0000, EI', 'выход в монитор по RST0'),
        ('Новый пациент (55BE)', 'протокол, заставка MEDELKOM SLE-101'),
        ('Экран: vid_call 1 (очистка C700–FFFF)', 'шаблон текста 2FF1 → 0080'),
        ('SOD=1 (SIM), режимы, маркеры', 'живое изображение'),
    ]
    y = 290
    for i, (a, b) in enumerate(msteps):
        s.box(px, y, pw, 44, COLORS['init'][0] if i < 4 else COLORS['ui'][0], [a, b])
        s.line([(C(px, pw), y + 44), (C(px, pw), y + 58)])
        y += 58
    s.box(px, y, pw, 70, '#f3e19a', ['Главный цикл 20B8', 'kbd_scan → dispatch_key', '(таблица «живой» 22E8 / «фиксация» 22FE)'])
    s.line([(px + pw, y + 52), (px + pw + 30, y + 52), (px + pw + 30, y + 18), (px + pw, y + 18)])
    s.text(px + pw + 34, y + 39, 'цикл', 's')
    s.box(px - 10, y + 100, pw + 20, 44, '#e3e9f6', ['ВК с консоли (8251 FE)', '→ JMP 0831: тёплый вход в монитор'])
    s.line([(C(px, pw), y + 70), (C(px, pw), y + 100)])
    s.line([(px - 10, y + 122), (60, y + 122), (60, 230 + 3 * 60 + 22), (mx, 230 + 3 * 60 + 22)])
    s.text(64, 230 + 3 * 60 + 16, '0831', 'a')
    s.save('boot_flow.svg')


def board_block():
    s = Svg(1280, 720, 'ЭТС-ЭЛ-С: блок-схема процессорной платы',
            'По фото платы и обращениям в коде. Адреса и порты — из прошивки; номера дешифраторов не сверены со схемой.')
    BX0, BX1 = 250, 1240
    s.line([(BX0, 210), (BX1, 210)], arrow=False, cls='bus')
    s.line([(BX0, 430), (BX1, 430)], arrow=False, cls='bus')
    s.text(BX1, 228, 'шина адреса A0–A15', 's', 'end')
    s.text(BX1, 450, 'шина данных D0–D7', 's', 'end')
    s.box(30, 240, 190, 160, '#f6c99b', ['ИМ1821ВМ85А', '(80C85)', 'кварц', 'SOD — выход', 'INTR не используется'])
    s.box(250, 270, 130, 100, '#eee', ['ИР23 / ИР35', 'защёлка адреса', '(ALE, AD0–AD7)'])
    s.line([(220, 310), (250, 310)])
    s.line([(315, 270), (315, 215)])
    s.line([(220, 390), (236, 390), (236, 425)])
    s.box(420, 80, 180, 80, '#eee', ['К555ИД7', 'дешифраторы', 'памяти и портов'])
    s.line([(510, 205), (510, 160)])
    s.box(760, 80, 200, 80, '#eee', ['КР1533АП6 (245)', 'буфер шины данных', 'на разъём'])
    s.line([(860, 160), (860, 205)], arrow=False)
    s.box(1020, 70, 200, 90, COLORS['video'][0], ['ВидеоОЗУ C700–FFFF', '«УВЗ», ~14 КБ', 'на другой плате'], dash=True)
    s.line([(1120, 160), (1120, 205)], both=True)
    mem = [
        (COLORS['mon'][0], ['КР573РФ2', '2716, «Д17»', '0800–0FFF', '+ оверлей 0000']),
        (COLORS['ui'][0], ['К573РФ4А', '2764 №1', '2000–3FFF', 'ROM1']),
        (COLORS['bio'][0], ['К573РФ4А', '2764 №2', '4000–5FFF', 'ROM2']),
        (COLORS['rt'][0], ['К573РФ4А', '2764 №3', '6000–7FFF', 'ROM3']),
        ('#fff3b0', ['КР537РУ10', '6116, 2 КБ', '0000–07FF', 'ОЗУ']),
    ]
    for k, (f, lines) in enumerate(mem):
        x = 410 + k * 160
        s.box(x, 250, 140, 140, f, lines)
        s.line([(x + 70, 210), (x + 70, 250)], arrow=False)
        s.line([(x + 70, 390), (x + 70, 430)], arrow=False)
    bot = [
        ('#e3e9f6', ['КР580ВВ51А (8251)', 'FE — данные, FF — упр.', 'консоль монитора'], False),
        ('#e3e9f6', ['8251 №2 или зеркало', 'порты EE / EF', 'Intel HEX (R/W/E)'], True),
        ('#f3e19a', ['Порты вывода F8, FA', 'F8 бит 0: «фиксация»', 'FA биты 4–5: столбец ПУ'], False),
        ('#f3e19a', ['Порт ввода F6', 'строки клавиатуры ПУ', '(инверсно)'], False),
    ]
    for k, (f, lines, d) in enumerate(bot):
        x = 270 + k * 240
        s.box(x, 490, 210, 90, f, lines, dash=d)
        s.line([(x + 105, 430), (x + 105, 490)], arrow=False)
        cls = 'ln" stroke-dasharray="5 3' if d else 'ln'
        s.line([(x + 105, 580), (x + 105, 620)], cls=cls)
    s.box(270, 620, 450, 64, '#f7f7f7', ['Последовательный канал', 'терминал или ЭВМ: отладка, загрузка Intel HEX'])
    s.box(750, 620, 450, 64, '#f7f7f7', ['Разъём на другие платы', 'пульт управления (ПУ), видеотракт'])
    s.save('board_block.svg')


def main():
    memory_map()
    boot_flow()
    board_block()


if __name__ == '__main__':
    main()
