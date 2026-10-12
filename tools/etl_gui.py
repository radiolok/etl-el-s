"""Эмулятор платы ЭТС-ЭЛ-С с экраном и пультом (Tk).

    python3 tools/etl_gui.py                                   # основная программа (G2000)
    python3 tools/etl_gui.py --hex tetris/tetris.hex --go 40   # тетрис
    python3 tools/etl_gui.py --go 815                          # монитор (вывод консоли — в терминал)

Без окна — снимок экрана после заданного времени работы (время эмулируемое):
    python3 tools/etl_gui.py --hex tetris/tetris.hex --go 40 \\
        --shot shot.png --seconds 3 --press 1.0:1A --press 1.5:87:0.5

Клавиши ПК -> пульт:
    стрелки            ← → ↑ ↓   (87 82 84 85)
    Home PgUp End PgDn ↖ ↗ ↙ ↘   (86 81 88 83), то же — цифровой блок 7 9 1 3
    пробел, KP 5       «+» в центре блока стрелок (10)
    Enter              СТАРТ (1A)
    Esc                МЕНЮ (13)
    0-9                цифры (30-39)
    F                  ФОКУС (14),  P — П/Н (16),  X — x2 (11)
Экран: видеоОЗУ 0xCA09-0xFFFF (307 строк по 45 байт), повёрнуто на 180°.
"""
import argparse
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import etl_sim  # noqa: E402

from PIL import Image, ImageOps  # noqa: E402

VBASE = 0xCA09
W, H = 360, 307
FG, BG = (170, 255, 225), (8, 28, 26)

KEYMAP = {
    'Left': 0x87, 'Right': 0x82, 'Up': 0x84, 'Down': 0x85,
    'KP_Left': 0x87, 'KP_Right': 0x82, 'KP_Up': 0x84, 'KP_Down': 0x85,
    'Home': 0x86, 'Prior': 0x81, 'End': 0x88, 'Next': 0x83,
    'KP_Home': 0x86, 'KP_Prior': 0x81, 'KP_End': 0x88, 'KP_Next': 0x83,
    'space': 0x10, 'KP_Begin': 0x10, 'KP_5': 0x10,
    'Return': 0x1A, 'KP_Enter': 0x1A, 'Escape': 0x13,
    'f': 0x14, 'F': 0x14, 'p': 0x16, 'P': 0x16, 'x': 0x11, 'X': 0x11,
}
KEYMAP.update({str(d): 0x30 + d for d in range(10)})


def frame(board, scale=2):
    """Снимок экрана (PIL Image, RGB)."""
    raw = bytes(board.mem[VBASE:0x10000])
    img = Image.frombytes('1', (W, H), raw, 'raw', '1;R').rotate(180)
    img = ImageOps.colorize(img.convert('L'), BG, FG)
    return img.resize((W * scale, H * scale), Image.NEAREST) if scale != 1 else img


def make_board(args):
    board = etl_sim.Board(mhz=None if args.shot else args.mhz)
    for h in args.hex or []:
        lo, hi = board.load_hex(Path(h).read_text())
        print('%s: %04X-%04X' % (h, lo, hi))
    board.cpu.pc = args.go
    board.cpu.sp = 0x07C0
    return board


def headless(board, args):
    """Прогон по эмулируемому времени с заданными нажатиями, затем снимок."""
    events = []
    for p in args.press or []:
        parts = p.split(':')
        t, code = float(parts[0]), int(parts[1], 16)
        dur = float(parts[2]) if len(parts) > 2 else 0.1
        events += [(t, 1, code), (t + dur, 0, code)]
    events.sort()
    hz = args.mhz * 1e6
    cpu = board.cpu
    end = args.seconds * hz
    while cpu.cyc < end:
        while events and events[0][0] * hz <= cpu.cyc:
            _, down, code = events.pop(0)
            (board.keys.add if down else board.keys.discard)(code)
        for _ in range(2000):
            cpu.step()
    frame(board, args.scale).save(args.shot)
    print('%s: PC=%04X, %.2f с' % (args.shot, cpu.pc, cpu.cyc / hz))


def gui(board, args):
    import tkinter as tk
    from PIL import ImageTk

    root = tk.Tk()
    root.title('ЭТС-ЭЛ-С — эмулятор')
    root.configure(bg='black')
    label = tk.Label(root, bg='black', bd=0)
    label.pack()
    tk.Label(root, bg='black', fg='#8fb', justify='left', font=('monospace', 9),
             text='Стрелки, Home/PgUp/End/PgDn — пульт   Пробел — «+»   Enter — СТАРТ   '
                  'Esc — МЕНЮ   0-9, F, P, X').pack(fill='x')
    pending = {}

    def press(e):
        code = KEYMAP.get(e.keysym)
        if code is None:
            return
        if e.keysym in pending:          # автоповтор X11: отпускание+нажатие подряд
            root.after_cancel(pending.pop(e.keysym))
        board.keys.add(code)

    def release(e):
        code = KEYMAP.get(e.keysym)
        if code is None:
            return

        def up():
            pending.pop(e.keysym, None)
            board.keys.discard(code)
        pending[e.keysym] = root.after(30, up)

    def tick():
        img = ImageTk.PhotoImage(frame(board, args.scale))
        label.configure(image=img)
        label.image = img
        out = bytearray()
        q = board.con.from_cpu
        while not q.empty():
            out.append(q.get_nowait())
        if out:
            sys.stdout.write(out.decode('ascii', 'replace').replace('\r', ''))
            sys.stdout.flush()
        root.after(40, tick)

    root.bind('<KeyPress>', press)
    root.bind('<KeyRelease>', release)
    board.start()
    tick()
    root.mainloop()
    board.stop.set()


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0],
                                 formatter_class=argparse.RawDescriptionHelpFormatter,
                                 epilog=__doc__.split('\n', 1)[1])
    ap.add_argument('--hex', action='append', help='загрузить Intel HEX в память (можно несколько)')
    ap.add_argument('--go', type=lambda s: int(s, 16), default=0x2000, help='адрес запуска, hex (2000)')
    ap.add_argument('--mhz', type=float, default=3.0, help='частота процессора, МГц (3)')
    ap.add_argument('--scale', type=int, default=2)
    ap.add_argument('--shot', help='без окна: сохранить снимок экрана в PNG')
    ap.add_argument('--seconds', type=float, default=3.0, help='для --shot: сколько секунд работать')
    ap.add_argument('--press', action='append',
                    help='для --shot: нажатие «время:код[:длительность]», код hex')
    args = ap.parse_args()
    board = make_board(args)
    if args.shot:
        headless(board, args)
    else:
        gui(board, args)


if __name__ == '__main__':
    main()
