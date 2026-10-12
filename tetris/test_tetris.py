"""Проверка тетриса на эмуляторе: процедуры вызываются напрямую, адреса — из ассемблера.

    python3 tetris/test_tetris.py
"""
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / 'tools'))
import etl_sim                      # noqa: E402
from asm8085 import Assembler       # noqa: E402

asm = Assembler()
mem = asm.assemble((ROOT / 'tetris' / 'tetris.asm').read_text(encoding='utf-8'))
S = asm.sym
board = etl_sim.Board()
for a, v in mem.items():
    board.mem[a] = v
cpu = board.cpu
RET_TRAP = 0x0010                   # HLT — сюда возвращается вызываемая процедура
board.mem[RET_TRAP] = 0x76


def call(name, a=0, b=0, hl=0, limit=5_000_000):
    cpu.sp = S['STACK']
    cpu.push(RET_TRAP)
    cpu.pc = S[name]
    cpu.r[7], cpu.r[0] = a, b
    cpu.r[4], cpu.r[5] = hl >> 8, hl & 0xFF
    for _ in range(limit):
        if cpu.pc == RET_TRAP:
            return cpu.r[7]
        if cpu.sp > S['STACK'] or cpu.pc > S['CODEEND'] and cpu.pc < 0x2000:
            raise AssertionError('%s: ушли на %04X, SP=%04X' % (name, cpu.pc, cpu.sp))
        cpu.step()
    raise AssertionError('%s: не вернулась' % name)


def cell_addr(r, c):
    call('CELLA', a=r, b=c)
    return cpu.hl()


def put(r, c, v=1):
    call('BLK', a=v, b=0, hl=cell_addr(r, c))


def grid():
    return [''.join('#' if board.mem[cell_addr(r, c)] else '.' for c in range(1, 11))
            for r in range(20)]


def bcd(name, n):
    return int(''.join('%02X' % board.mem[S[name] + i] for i in reversed(range(n))))


def var(name):
    return board.mem[S[name]]


# --- геометрия: клетка (0,1) — bc 15, sy 24; (19,10) — bc 33, sy 271
assert cell_addr(0, 1) == 0xFFFF - 45 * 24 - 15
assert cell_addr(19, 10) == 0xFFFF - 45 * (24 + 13 * 19) - 33

call('SCREEN')
assert grid() == ['.' * 10] * 20

# --- одна линия
for c in range(1, 11):
    put(19, c)
for c in range(1, 6):
    put(18, c)
put(17, 3)
call('CLRLN')
g = grid()
assert g[19] == '#####.....', g[19]
assert g[18] == '..#.......', g[18]
assert all(row == '.' * 10 for row in g[:18])
assert bcd('SCORE', 3) == 40 and bcd('LINES', 2) == 1 and var('LCNT') == 9

# --- четыре линии сразу (тетрис), сверху остаётся мусор
call('SCREEN')
for r in range(16, 20):
    for c in range(1, 11):
        if not (r == 16 and c == 7):
            put(r, c)
put(15, 7)                          # дырка в 16-й строке закрыта сверху
call('CLRLN')                       # уйдут 17, 18, 19 — три линии
g = grid()
assert g[19] == '#' * 6 + '.' + '#' * 3, g[19]
assert g[18] == '......#...', g[18]
assert bcd('SCORE', 3) == 300 and bcd('LINES', 2) == 3

call('SCREEN')
for r in range(16, 20):
    for c in range(1, 11):
        put(r, c)
call('CLRLN')
assert grid() == ['.' * 10] * 20
assert bcd('SCORE', 3) == 1200 and bcd('LINES', 2) == 4

# --- уровень: 10 линий -> уровень 1, очки умножаются на 2
board.mem[S['LCNT']] = 1
for c in range(1, 11):
    put(19, c)
call('CLRLN')
assert var('LEVEL') == 1 and var('LCNT') == 10 and var('SPEED') == 34
for c in range(1, 11):
    put(19, c)
call('CLRLN')
assert bcd('SCORE', 3) == 1200 + 40 + 80, bcd('SCORE', 3)

# --- фигуры: все повороты помещаются в рамку 4x4 и состоят из 4 клеток
for t in range(7):
    for r in range(4):
        cells = mem_cells = [board.mem[S['SHAPES'] + (t * 4 + r) * 4 + i] for i in range(4)]
        assert len(set(cells)) == 4 and all((x & 15) < 4 and (x >> 4) < 4 for x in cells)

# --- движение и упор в стенку
call('SCREEN')
board.mem[S['NT']] = 3              # O
call('SPAWN')
for _ in range(12):
    call('MLEFT')
g = grid()
assert g[0] == '##........' and g[1] == '##........', g[:2]
call('HDROP')                       # кладёт O и выпускает следующую фигуру
g = grid()
assert g[18].startswith('##') and g[19].startswith('##')

# --- конец игры: верх занят — SPAWN уходит в GOVER
call('SCREEN')
for c in range(1, 11):
    put(1, c)
board.mem[S['NT']] = 5              # T
cpu.sp = S['STACK']
cpu.push(RET_TRAP)
cpu.pc = S['SPAWN']
for _ in range(200000):
    cpu.step()
    if cpu.pc == S['WAITST']:
        break
else:
    raise AssertionError('GOVER не сработал')

print('тетрис: все проверки пройдены')
