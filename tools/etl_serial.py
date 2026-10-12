#!/usr/bin/env python3
"""Работа с монитором ЭТС-ЭЛ-С (2716 «Д17») через последовательный порт.

Протокол восстановлен по дизассемблеру монитора (disasm/mon_2716.asm),
описание — docs/serial_protocol.md. Кратко:

  * консоль — 8251 на портах FE/FF; канал Intel HEX — второй 8251 на EE/EF;
  * режим 8251 0xCF: асинхронный, 8 бит, без чётности, 2 стоп-бита, делитель ×64
    (скорость зависит от тактовой частоты 8251, по плате не установлена — подбирать);
  * приглашение «\\r\\n-», ошибка «+», все символы эхом; только заглавные буквы и hex;
  * ПЕРЕД ВЫВОДОМ КАЖДОГО СИМВОЛА монитор проверяет приём: пришедший байт ставит
    вывод на паузу до следующего байта (^C — прерывание). Поэтому символы шлём
    строго по одному и ждём эха, а во время вывода не шлём ничего;
  * если работает основная программа, ВК (0x0D) с консоли передаёт управление
    монитору (0x20CD → 0x0831); вернуться — «G2000».

Примеры:
  etl_serial.py -p /dev/ttyUSB0 -b 9600 regs
  etl_serial.py -p /dev/ttyUSB0 dump 0 7FF -o ram.bin
  etl_serial.py -p /dev/ttyUSB0 load prog.hex --verify
  etl_serial.py -p /dev/ttyUSB0 go 100 --bp 120
  etl_serial.py -p /dev/ttyUSB0 screen -o screen.png
  etl_serial.py --sim dump 800 83F          # без железа, на эмуляторе
"""
import argparse
import re
import struct
import sys
import time
import zlib

PROMPT = b'\r\n-'
ERROR = b'+' + PROMPT
REG_NAMES = 'PAHLDEBCSFI'                        # порядок вывода команды X
REG16 = {'P', 'S'}
NO_CR = {'P', 'U'}                               # команды без параметров
FLAG_BITS = {'S': 0x80, 'Z': 0x40, 'A': 0x10, 'P': 0x04, 'C': 0x01}

# адреса, которые полезно знать
RAM = (0x0000, 0x07FF)
MON_ROM = (0x0800, 0x0FFF)
MAIN_ENTRY = 0x2000
VRAM = (0xC700, 0xFFFF)                          # видеоОЗУ «УВЗ», 45 байт на строку
VRAM_ROW = 45


class MonitorError(Exception):
    pass


class Monitor:
    def __init__(self, con, aux=None, timeout=3.0, log=None):
        self.con, self.aux = con, aux
        self.timeout = timeout
        self.log = log

    # ---------- низкий уровень ----------
    def _read(self, port, n=1):
        data = port.read(n)
        if data and self.log:
            self.log.write(data.decode('latin-1'))
            self.log.flush()
        return data

    def _wait(self, want, timeout=None, port=None):
        """Читать до появления want (bytes); вернуть всё прочитанное."""
        port = port or self.con
        buf = bytearray()
        deadline = time.monotonic() + (timeout or self.timeout)
        while not buf.endswith(want):
            if buf.endswith(ERROR):
                raise MonitorError('монитор ответил «+» (ошибка): %r' % bytes(buf))
            if time.monotonic() > deadline:
                raise MonitorError('нет ответа %r, получено %r' % (want, bytes(buf)))
            buf += self._read(port, 1)
        return bytes(buf)

    def _type(self, text, extra=None):
        """Набрать text посимвольно, дожидаясь эха.

        extra: {индекс символа: что монитор дополнительно выведет после эха}
        (например, «-» после разделителя в команде G)."""
        extra = extra or {}
        for i, ch in enumerate(text.encode('ascii')):
            self.con.write(bytes([ch]))
            want = bytes([ch]) + extra.get(i, '').encode('ascii')
            got = self._wait(want, timeout=1.0)
            if got.endswith(ERROR):
                raise MonitorError('ошибка при наборе %r' % text)

    def command(self, text, timeout=None, wait=True):
        """Выполнить команду (без завершающего ВК) и вернуть вывод до приглашения.
        P и U параметров не читают и выполняются сразу по букве — им ВК не шлём
        (лишний байт во время вывода монитор принял бы за «паузу»)."""
        text = text.upper()
        if text in NO_CR:
            self.con.write(text.encode())
            out = self._wait(PROMPT, timeout=timeout)
            if out.endswith(ERROR):
                raise MonitorError('команда %r: ошибка' % text)
            return out[1:-len(PROMPT)]
        self._type(text)
        self.con.write(b'\r')
        if not wait:
            self._wait(b'\r', timeout=1.0)
            return b''
        out = self._wait(PROMPT, timeout=timeout)
        if out.endswith(ERROR):
            raise MonitorError('команда %r: ошибка' % text)
        out = out[:-len(PROMPT)]
        return out[1:] if out.startswith(b'\r') else out   # эхо ВК

    def sync(self, tries=4):
        """Добиться приглашения монитора. ВК в цикле команд — новое приглашение,
        ВК в основной программе — вход в монитор; ^C прерывает ввод параметров."""
        for i in range(tries):
            self.con.reset_input_buffer()
            self.con.write(b'\x03\r' if i else b'\r')
            try:
                self._wait(PROMPT, timeout=1.5)
            except MonitorError:
                continue
            time.sleep(0.05)                     # добрать хвост, если был дамп регистров
            while self.con.in_waiting:
                self._read(self.con, self.con.in_waiting)
            return True
        raise MonitorError('монитор не отвечает (скорость? кабель? основная программа без ВК?)')

    # ---------- память ----------
    def read_mem(self, start, end, chunk=0x400):
        """Команда D: прочитать start..end включительно."""
        out = bytearray()
        a = start
        while a <= end:
            b = min(end, a + chunk - 1)
            text = self.command('D%X %X' % (a, b), timeout=10 + chunk / 50).decode('latin-1')
            expect = a
            for m in re.finditer(r'([0-9A-F]{4})((?: [0-9A-F]{2})+)', text):
                addr = int(m.group(1), 16)
                if addr != expect:
                    raise MonitorError('дамп: ожидался адрес %04X, получен %04X' % (expect, addr))
                vals = bytes(int(x, 16) for x in m.group(2).split())
                out += vals
                expect += len(vals)
            if expect != b + 1:
                raise MonitorError('дамп %04X-%04X неполный (до %04X)' % (a, b, expect))
            a = b + 1
        return bytes(out)

    def write_mem(self, addr, data, chunk=32):
        """Команда S: «Sадрес зн зн ...». Значения пишутся без показа старых."""
        for i in range(0, len(data), chunk):
            part = data[i:i + chunk]
            self.command('S%X ' % (addr + i) + ' '.join('%X' % b for b in part))

    def checksum(self, start, end):
        """Команда H: сумма байтов start..end по модулю 256."""
        return int(self.command('H%X %X' % (start, end)).strip()[-2:], 16)

    def fill(self, start, end, value):
        self.command('F%X %X %X' % (start, end, value & 0xFF))

    def move(self, start, end, dest):
        self.command('M%X %X %X' % (start, end, dest))

    def compare(self, start, end, dest):
        """Команда C: список (адрес2, байт2, адрес1, байт1) различий."""
        text = self.command('C%X %X %X' % (start, end, dest), timeout=30).decode('latin-1')
        return [(int(d, 16), int(dv, 16), int(s, 16), int(sv, 16)) for dv, d, sv, s in
                re.findall(r'([0-9A-F]{2}) ([0-9A-F]{4}) ([0-9A-F]{2}) ([0-9A-F]{4})', text)]

    # ---------- регистры, запуск ----------
    @staticmethod
    def parse_regs(text):
        if isinstance(text, bytes):
            text = text.decode('latin-1')
        return {k: int(v, 16) for k, v in re.findall(r'([PAHLDEBCSFI])=([0-9A-F]{2,4})', text)}

    def regs(self):
        """Команда X без параметров: сохранённые регистры программы пользователя."""
        return self.parse_regs(self.command('X'))

    def set_reg(self, name, value):
        name = name.upper()
        if name not in REG_NAMES:
            raise ValueError('регистр %s: допустимы %s' % (name, REG_NAMES))
        self._type('X')
        self.con.write(name.encode())
        self._wait(b'-', timeout=1.0)            # «имя значение-»
        self._type('%X' % value)
        self.con.write(b'\r')                    # значение принято, ждёт имя следующего
        self._wait(b'\r', timeout=1.0)
        self.con.write(b'\r')                    # ВК — дамп всех регистров и выход
        return self.parse_regs(self._wait(PROMPT))

    def flags(self):
        """Команда P: флаги сохранённого PSW."""
        text = self.command('P').decode('latin-1')
        return {k: int(v) for k, v in re.findall(r'([SZAPC])=([01])', text)}

    def go(self, addr=None, breakpoints=(), wait=None):
        """Команда G[адрес][ точка1[,точка2]]. Точки останова — RST 0 (0xC7),
        поэтому работают только в ОЗУ. wait: секунды ожидания останова
        (None — не ждать). Возвращает регистры в момент останова."""
        if len(breakpoints) > 2:
            raise ValueError('монитор поддерживает не более двух точек останова')
        text, extra = 'G', {}
        if addr is not None:
            text += '%X' % addr
        for i, bp in enumerate(breakpoints):
            extra[len(text)] = '-'               # после разделителя монитор пишет «-»
            text += ' ,'[i > 0] + '%X' % bp
        self._type(text, extra)
        self.con.write(b'\r')
        self._wait(b'\r', timeout=1.0)
        if wait is None:
            return None
        return self.parse_regs(self._wait(PROMPT, timeout=wait))

    def restart(self):
        """Команда U: переинициализировать трамплин/регистры, без теста ОЗУ."""
        return self.parse_regs(self.command('U'))

    def run_main(self):
        """Запустить основную программу эхотомоскопа (холодный старт с 0x2000)."""
        self.go(MAIN_ENTRY)

    # ---------- канал Intel HEX (8251 №2, EE/EF) ----------
    def _need_aux(self):
        if self.aux is None:
            raise MonitorError('нужен второй порт (--aux) — канал Intel HEX на EE/EF')

    def hex_send(self, records, bias=0, timeout=120):
        """Команда R: монитор читает Intel HEX с канала EE/EF, прибавляя bias
        к адресам. Запись конца (тип 01) задаёт PC для последующего G."""
        self._need_aux()
        self.command('R%X' % bias, wait=False)
        self.aux.write(records.encode('ascii'))
        self._wait(PROMPT, timeout=timeout)

    def hex_receive(self, start, end, timeout=120):
        """Команда W: монитор выдаёт start..end в Intel HEX на канал EE/EF
        (записи всегда по 16 байт — последняя может выйти за end)."""
        self._need_aux()
        self.aux.reset_input_buffer()
        self.command('W%X %X' % (start, end), timeout=timeout)
        time.sleep(0.2)
        text = b''
        while self.aux.in_waiting:
            text += self._read(self.aux, self.aux.in_waiting)
        return text.decode('ascii', 'replace')

    def hex_eof(self, entry):
        """Команда E: выдать запись конца файла «:00aaaa01cc» и ^Z в EE/EF."""
        self._need_aux()
        self.command('E%X' % entry)


# ---------- Intel HEX ----------
def ihex_encode(chunks, entry=0, width=16):
    """chunks: [(адрес, bytes)] → текст Intel HEX с записью конца (PC = entry)."""
    lines = []
    for addr, data in chunks:
        for i in range(0, len(data), width):
            part = data[i:i + width]
            a = addr + i
            rec = bytes([len(part), a >> 8 & 0xFF, a & 0xFF, 0]) + part
            lines.append(':%s%02X' % (rec.hex().upper(), -sum(rec) & 0xFF))
    rec = bytes([0, entry >> 8 & 0xFF, entry & 0xFF, 1])
    lines.append(':%s%02X' % (rec.hex().upper(), -sum(rec) & 0xFF))
    return '\r\n'.join(lines) + '\r\n'


def ihex_decode(text):
    """→ (list[(адрес, bytes)], точка входа или None)."""
    chunks, entry = [], None
    for line in text.splitlines():
        line = line.strip().lstrip('\x1a')
        if not line.startswith(':'):
            continue
        rec = bytes.fromhex(line[1:])
        if sum(rec) & 0xFF:
            raise ValueError('контрольная сумма: ' + line)
        n, a, t = rec[0], rec[1] << 8 | rec[2], rec[3]
        if t == 0:
            chunks.append((a, rec[4:4 + n]))
        elif t == 1:
            entry = a
            break
    return chunks, entry


def merge_chunks(chunks):
    """Слить подряд идущие куски."""
    out = []
    for a, d in sorted(chunks):
        if out and out[-1][0] + len(out[-1][1]) == a:
            out[-1] = (out[-1][0], out[-1][1] + d)
        else:
            out.append((a, bytes(d)))
    return out


# ---------- снимок видеоОЗУ ----------
def vram_png(data, row_bytes=VRAM_ROW, rotate=True):
    """1 бит/точка, в памяти младший бит — меньший x (vid_xy2addr 0x4809).
    На экране изображение повёрнуто на 180° (луч идёт от старших адресов
    к младшим — проверено по заставке на эмуляторе), rotate=True это учитывает.
    data должны кончаться на 0xFFFF: строки выровнены по концу видеоОЗУ
    (база графики 0xCA09 = 0x10000 - 307*45), лишние байты в начале отбрасываются."""
    data = data[len(data) % row_bytes:]
    w = row_bytes * 8
    h = len(data) // row_bytes
    rows = []
    for y in range(h):
        row = bytearray()
        for b in data[y * row_bytes:(y + 1) * row_bytes]:
            row += bytes(255 if b >> i & 1 else 0 for i in range(8))
        rows.append(row[::-1] if rotate else row)
    raw = b''.join(b'\0' + r for r in (rows[::-1] if rotate else rows))

    def chunk(tag, body):
        return struct.pack('>I', len(body)) + tag + body + struct.pack('>I', zlib.crc32(tag + body))
    return (b'\x89PNG\r\n\x1a\n' + chunk(b'IHDR', struct.pack('>IIBBBBB', w, h, 8, 0, 0, 0, 0))
            + chunk(b'IDAT', zlib.compress(raw, 9)) + chunk(b'IEND', b''))


def hexdump(addr, data):
    for i in range(0, len(data), 16):
        part = data[i:i + 16]
        print('%04X  %-48s %s' % (addr + i, ' '.join('%02X' % b for b in part),
                                  ''.join(chr(b) if 32 <= b < 127 else '.' for b in part)))


# ---------- CLI ----------
def num(s):
    return int(s, 16)


def open_ports(args):
    if args.sim:
        sys.path.insert(0, __import__('os').path.dirname(__file__))
        import etl_sim
        board = etl_sim.Board()
        con, aux = board.start()
        con.read(200)                            # стартовый дамп регистров
        return con, aux
    import serial                                # pyserial
    kw = dict(bytesize=8, parity='N', stopbits=2, timeout=0.2)
    con = serial.Serial(args.port, args.baud, **kw)
    aux = serial.Serial(args.aux, args.aux_baud or args.baud, **kw) if args.aux else None
    return con, aux


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n\n')[0],
                                 formatter_class=argparse.RawDescriptionHelpFormatter,
                                 epilog='Адреса и значения — в hex. Подробно: docs/serial_protocol.md')
    ap.add_argument('-p', '--port', help='консоль (8251 FE/FF), напр. /dev/ttyUSB0, COM3')
    ap.add_argument('-b', '--baud', type=int, default=9600,
                    help='скорость (по умолчанию 9600; на плате не проверено)')
    ap.add_argument('--aux', help='второй порт — канал Intel HEX (8251 EE/EF)')
    ap.add_argument('--aux-baud', type=int)
    ap.add_argument('--sim', action='store_true', help='эмулятор вместо железа (tools/etl_sim.py)')
    ap.add_argument('-v', '--verbose', action='store_true', help='показывать обмен с консолью')
    sub = ap.add_subparsers(dest='cmd', required=True)

    sub.add_parser('regs', help='сохранённые регистры (X) и флаги (P)')
    p = sub.add_parser('setreg', help='изменить регистры: setreg P=100 A=5 ...')
    p.add_argument('assign', nargs='+')
    p = sub.add_parser('dump', help='прочитать память (D)')
    p.add_argument('start', type=num); p.add_argument('end', type=num)
    p.add_argument('-o', '--out', help='файл .bin или .hex; без него — на экран')
    p = sub.add_parser('load', help='записать файл в память (S или R)')
    p.add_argument('file'); p.add_argument('--addr', type=num, help='адрес для .bin')
    p.add_argument('--via', choices=['con', 'aux'], default='con',
                   help='con — командой S по консоли; aux — Intel HEX командой R по EE/EF')
    p.add_argument('--verify', action='store_true', help='проверить суммой (H) и чтением')
    p = sub.add_parser('fill', help='заполнить (F)')
    p.add_argument('start', type=num); p.add_argument('end', type=num); p.add_argument('value', type=num)
    p = sub.add_parser('move', help='переслать (M)')
    p.add_argument('start', type=num); p.add_argument('end', type=num); p.add_argument('dest', type=num)
    p = sub.add_parser('compare', help='сравнить блоки (C)')
    p.add_argument('start', type=num); p.add_argument('end', type=num); p.add_argument('dest', type=num)
    p = sub.add_parser('sum', help='сумма байтов (H)')
    p.add_argument('start', type=num); p.add_argument('end', type=num)
    p = sub.add_parser('go', help='запуск (G), до двух точек останова в ОЗУ')
    p.add_argument('addr', type=num, nargs='?')
    p.add_argument('--bp', type=num, action='append', default=[])
    p.add_argument('--wait', type=float, help='ждать останова N секунд')
    sub.add_parser('run-main', help='запустить основную программу (G2000)')
    sub.add_parser('monitor', help='войти в монитор из основной программы (ВК)')
    p = sub.add_parser('hexout', help='выгрузить память в Intel HEX через EE/EF (W)')
    p.add_argument('start', type=num); p.add_argument('end', type=num)
    p.add_argument('-o', '--out', required=True)
    p = sub.add_parser('screen', help='снимок видеоОЗУ в PNG')
    p.add_argument('-o', '--out', default='screen.png')
    p.add_argument('--start', type=num, default=VRAM[0])
    p.add_argument('--end', type=num, default=VRAM[1])
    p.add_argument('--raw', help='сохранить также сырые байты')
    p.add_argument('--no-rotate', action='store_true', help='как лежит в памяти, без поворота на 180°')
    sub.add_parser('term', help='простой терминал (pyserial miniterm)')
    sub.add_parser('probe', help='подобрать скорость: ВК на 300…38400, ждать «\\r\\n-»')

    args = ap.parse_args()
    if not args.sim and not args.port:
        ap.error('укажите --port или --sim')

    if args.cmd == 'term':
        if args.sim:
            ap.error('term с эмулятором не поддерживается')
        from serial.tools import miniterm
        sys.argv = ['miniterm', args.port, str(args.baud), '--parity', 'N',
                    '--eol', 'CR', '--raw']
        print('8251 шлёт 8N2, ПК в 8N1 это принимает. Только ЗАГЛАВНЫЕ буквы;'
              ' ^C — прервать команду; любая клавиша — пауза вывода.', file=sys.stderr)
        return miniterm.main()

    if args.cmd == 'probe':
        import serial
        for baud in (9600, 19200, 4800, 2400, 1200, 38400, 600, 300):
            with serial.Serial(args.port, baud, stopbits=2, timeout=0.3) as port:
                try:
                    Monitor(port).sync(tries=2)
                except MonitorError:
                    print('%6d — нет' % baud)
                    continue
                print('%6d — монитор отвечает' % baud)
                return
        sys.exit('не найдено: проверьте уровни (8251 — ТТЛ, нужен MAX232), TxD/RxD, CTS/DSR 8251')

    con, aux = open_ports(args)
    mon = Monitor(con, aux, log=sys.stderr if args.verbose else None)
    mon.sync()

    c = args.cmd
    if c == 'regs':
        r = mon.regs()
        print(' '.join('%s=%0*X' % (k, 4 if k in REG16 else 2, r[k]) for k in REG_NAMES if k in r))
        print(' '.join('%s=%d' % kv for kv in mon.flags().items()))
    elif c == 'setreg':
        for a in args.assign:
            k, v = a.split('=')
            r = mon.set_reg(k, int(v, 16))
        print(' '.join('%s=%0*X' % (k, 4 if k in REG16 else 2, r[k]) for k in REG_NAMES if k in r))
    elif c == 'dump':
        data = mon.read_mem(args.start, args.end)
        if not args.out:
            hexdump(args.start, data)
        elif args.out.lower().endswith('.hex'):
            open(args.out, 'w').write(ihex_encode([(args.start, data)]))
        else:
            open(args.out, 'wb').write(data)
    elif c == 'load':
        if args.file.lower().endswith('.hex'):
            text = open(args.file).read()
            chunks, entry = ihex_decode(text)
        else:
            if args.addr is None:
                ap.error('для .bin нужен --addr')
            chunks, entry = [(args.addr, open(args.file, 'rb').read())], None
        chunks = merge_chunks(chunks)
        if args.via == 'aux':
            mon.hex_send(ihex_encode(chunks, entry or 0))
        else:
            for a, d in chunks:
                mon.write_mem(a, d)
            if entry is not None:
                mon.set_reg('P', entry)
        if args.verify:
            for a, d in chunks:
                if mon.checksum(a, a + len(d) - 1) != sum(d) & 0xFF or mon.read_mem(a, a + len(d) - 1) != d:
                    sys.exit('ОШИБКА проверки %04X-%04X (ПЗУ? нет ОЗУ по адресу?)' % (a, a + len(d) - 1))
        print('записано: ' + ', '.join('%04X-%04X' % (a, a + len(d) - 1) for a, d in chunks))
    elif c == 'fill':
        mon.fill(args.start, args.end, args.value)
    elif c == 'move':
        mon.move(args.start, args.end, args.dest)
    elif c == 'compare':
        diff = mon.compare(args.start, args.end, args.dest)
        for d, dv, s, sv in diff:
            print('%04X:%02X  %04X:%02X' % (s, sv, d, dv))
        print('различий: %d' % len(diff))
    elif c == 'sum':
        print('%02X' % mon.checksum(args.start, args.end))
    elif c == 'go':
        r = mon.go(args.addr, args.bp, wait=args.wait)
        if r:
            print('останов: ' + ' '.join('%s=%X' % kv for kv in r.items()))
    elif c == 'run-main':
        mon.run_main()
    elif c == 'monitor':
        print('монитор: ' + ' '.join('%s=%X' % kv for kv in mon.regs().items()))
    elif c == 'hexout':
        text = mon.hex_receive(args.start, args.end)
        chunks, _ = ihex_decode(text)
        data = b''.join(d for _, d in merge_chunks(chunks))[:args.end - args.start + 1]
        open(args.out, 'w').write(ihex_encode([(args.start, data)]))
    elif c == 'screen':
        data = mon.read_mem(args.start, args.end)
        if args.raw:
            open(args.raw, 'wb').write(data)
        open(args.out, 'wb').write(vram_png(data, rotate=not args.no_rotate))
        print('%s: %dx%d' % (args.out, VRAM_ROW * 8, len(data) // VRAM_ROW))


if __name__ == '__main__':
    try:
        main()
    except MonitorError as e:
        sys.exit('монитор: %s' % e)
