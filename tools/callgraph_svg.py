"""Граф вызовов между составными частями прошивки -> docs/callgraph.svg

    python3 tools/callgraph_svg.py
Узлы — группы из etl_info.COMPONENTS, рёбра — число пар «функция → функция» (CALL/JMP) из
disasm/functions.json. Пунктир — передача управления через таблицы (dispatch_key, vid_call).
"""
import json
import os
import sys
from collections import Counter
sys.path.insert(0, os.path.dirname(__file__))
from etl_info import COMPONENTS
from diagrams_svg import Svg
from rom_layout_svg import COLORS
from strings_koi7 import ROOT

# группа: (x, y, w, h, цвет, строки)
NODES = {
    'kbd':   (60, 80, 230, 60, COLORS['ui'][0], ['Клавиатура', '20F1–2202']),
    'start': (400, 80, 260, 70, COLORS['init'][0], ['Старт и главный цикл', '2000–20F0']),
    'mon':   (880, 80, 260, 70, COLORS['mon'][0], ['Монитор (2716)', '0800–0FFF']),
    'test':  (60, 230, 260, 60, COLORS['init'][0], ['Фиксация, самотесты', '2203–22D2']),
    'disp':  (820, 230, 230, 60, COLORS['ui'][0], ['Диспетчер клавиш', '22D3–233D, таблицы']),
    'keys':  (380, 380, 300, 70, COLORS['ui'][0], ['Обработчики клавиш', '233E–2EAC (ROM1)']),
    'bio':   (820, 380, 300, 70, COLORS['bio'][0], ['Биометрия плода', '4DFF–56AA (ROM2)']),
    'calc':  (380, 550, 300, 70, COLORS['calc'][0], ['Измерения и формат', '3045–3C12 (ROM1)']),
    'video': (820, 550, 300, 70, COLORS['video'][0], ['Графика vid_call', '3C13–4DFE (ROM1/ROM2)']),
    'lib':   (380, 710, 300, 70, COLORS['rt'][0], ['Библиотека float32, формат', '6221–7692 (ROM3)']),
}
# единичные связи, которые всё же рисуем (главный цикл)
KEEP = {('start', 'mon'), ('start', 'kbd')}

GROUP_OF = {
    'Старт и главный цикл': 'start', 'Клавиатура': 'kbd', 'Заморозка и самотесты': 'test',
    'Диспетчер клавиш': 'disp', 'Обработчики клавиш': 'keys', 'Пол пациента': 'keys',
    'Измерения и формат': 'calc', 'Биометрия плода': 'bio',
}

# передача управления через таблицы (не CALL)
TABLE_EDGES = [('disp', 'keys', 'таблицы клавиш'), ('disp', 'bio', 'клавиша 5'), ('start', 'disp', 'главный цикл')]


def group(a, comps):
    for lo, hi, rom, cat, name, _ in comps:
        if lo <= a <= hi:
            if cat == 'mon':
                return 'mon'
            if cat == 'video':
                return 'video'
            if cat == 'rt':
                return 'lib'
            return GROUP_OF.get(name)
    return None


def border(n, tx, ty):
    """Точка на границе прямоугольника узла n в направлении (tx,ty)."""
    x, y, w, h = NODES[n][:4]
    cx, cy = x + w / 2, y + h / 2
    dx, dy = tx - cx, ty - cy
    if dx == 0 and dy == 0:
        return cx, cy
    k = min((w / 2) / abs(dx) if dx else 1e9, (h / 2) / abs(dy) if dy else 1e9)
    return cx + dx * k, cy + dy * k


def center(n):
    x, y, w, h = NODES[n][:4]
    return x + w / 2, y + h / 2


def main():
    funcs = json.load(open(ROOT / 'disasm' / 'functions.json'))
    edges = Counter()
    for f in funcs:
        a = group(f['addr'], COMPONENTS)
        for t in f['callees']:
            b = group(t, COMPONENTS)
            if a and b and a != b:
                edges[(a, b)] += 1
    s = Svg(1200, 880, 'ЭТС-ЭЛ-С: граф вызовов между частями прошивки',
            'Число на стрелке — пар «функция → вызываемая функция»; толщина ~ числу. Пунктир — переход через таблицу.')
    s.o.append('<defs><marker id="au" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="11" markerHeight="11" '
               'markerUnits="userSpaceOnUse" orient="auto"><path d="M0 0L10 5L0 10z" fill="#555"/></marker></defs>')
    drawn = set()
    hidden = sorted(k for k, n in edges.items() if n < 2 and k not in KEEP)
    for (a, b), n in sorted(edges.items(), key=lambda e: e[1]):
        if n < 2 and (a, b) not in KEEP:
            continue
        ca, cb = center(a), center(b)
        # пара встречных рёбер — смещаем, чтобы не сливались
        off = 6 if (b, a) in edges else 0
        if off:
            dx, dy = cb[0] - ca[0], cb[1] - ca[1]
            ln = (dx * dx + dy * dy) ** .5
            ox, oy = -dy / ln * off, dx / ln * off
            ca, cb = (ca[0] + ox, ca[1] + oy), (cb[0] + ox, cb[1] + oy)
        p1 = border(a, *cb)
        p2 = border(b, *ca)
        if off:
            p1 = (p1[0] + ox, p1[1] + oy)
            p2 = (p2[0] + ox, p2[1] + oy)
        wdt = 1 + min(n, 60) / 12
        s.o.append('<path d="M%g %g L%g %g" stroke="#555" stroke-width="%.1f" fill="none" marker-end="url(#au)"/>'
                   % (p1[0], p1[1], p2[0], p2[1], wdt))
        t = 0.3 if off else 0.5
        mx, my = p1[0] + (p2[0] - p1[0]) * t, p1[1] + (p2[1] - p1[1]) * t
        s.o.append('<rect x="%g" y="%g" width="24" height="15" rx="3" fill="#fff" stroke="#bbb" stroke-width=".5"/>'
                   % (mx - 12, my - 11))
        s.text(mx, my, str(n), 'a', 'middle')
        drawn.add((a, b))
    for a, b, lbl in TABLE_EDGES:
        ca, cb = center(a), center(b)
        p1, p2 = border(a, *cb), border(b, *ca)
        s.o.append('<path d="M%g %g L%g %g" stroke="#777" stroke-width="1.3" stroke-dasharray="6 4" fill="none" '
                   'marker-end="url(#au)"/>' % (p1[0] + 16, p1[1], p2[0] + 16, p2[1]))
        s.text((p1[0] + p2[0]) / 2 + 22, (p1[1] + p2[1]) / 2 - 4, lbl, 's')
    for n, (x, y, w, h, fill, lines) in NODES.items():
        s.box(x, y, w, h, fill, lines)
    # внутренние связи монитора и библиотеки — подписью
    s.text(880, 172, 'внутри: команды → ввод/вывод (44)', 's')
    s.text(700, 750, 'внутри ROM3: формат/преобразования → float32, 16 бит', 's')
    names = {k: v[5][0] for k, v in NODES.items()}
    hl = ['%s→%s' % (names[a].split()[0].rstrip(','), names[b].split()[0].rstrip(',')) for a, b in hidden]
    s.text(20, 820, 'Не показаны единичные связи (%d): ' % len(hl) + ', '.join(hl[:5]) + ',', 's')
    s.text(20, 838, ', '.join(hl[5:]), 's')
    s.save('callgraph.svg')
    for (a, b), n in sorted(edges.items(), key=lambda e: -e[1]):
        print(n, a, '->', b)


if __name__ == '__main__':
    main()
