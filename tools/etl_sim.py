"""Минимальный эмулятор платы ЭТЛ-ЭЛ-С для проверки tools/etl_serial.py без железа.

Процессор 8080/8085 (RIM/SIM — заглушки, прерываний нет), ОЗУ 0000-07FF,
монитор 0800-0FFF, три 2764 в 2000-7FFF, 8000-FFFF — ОЗУ (видеоОЗУ «УВЗ»).
Два 8251: FE/FF — консоль, EE/EF — канал Intel HEX. Каждый канал снаружи
выглядит как объект pyserial (write / read(n) с таймаутом / reset_input_buffer).

    sim = Board(); con, aux = sim.start()
"""
import os
import queue
import threading
import time

ROOT = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'rom')
ROMS = [(0x0800, 'u_0800_2716-monitor.bin'), (0x2000, 'u_2000_2764-1.bin'),
        (0x4000, 'u_4000_2764-2.bin'), (0x6000, 'u_6000_2764-3.bin')]

PARITY = [bin(i).count('1') % 2 == 0 for i in range(256)]


class CPU:
    def __init__(self, rd, wr, inp, out):
        self.rd, self.wr, self.inp, self.out = rd, wr, inp, out
        self.r = [0] * 8            # B C D E H L (M) A
        self.sp = self.pc = 0
        self.cy = self.z = self.s = self.p = self.ac = 0
        self.ie = 0

    # --- регистры и флаги ---
    def hl(self):
        return self.r[4] << 8 | self.r[5]

    def get(self, i):
        return self.rd(self.hl()) if i == 6 else self.r[i]

    def put(self, i, v):
        if i == 6:
            self.wr(self.hl(), v & 0xFF)
        else:
            self.r[i] = v & 0xFF

    def getrp(self, i):
        return self.sp if i == 3 else self.r[2 * i] << 8 | self.r[2 * i + 1]

    def setrp(self, i, v):
        v &= 0xFFFF
        if i == 3:
            self.sp = v
        else:
            self.r[2 * i], self.r[2 * i + 1] = v >> 8, v & 0xFF

    def flags(self):
        return self.s << 7 | self.z << 6 | self.ac << 4 | self.p << 2 | 2 | self.cy

    def setflags(self, f):
        self.s, self.z, self.ac, self.p, self.cy = f >> 7 & 1, f >> 6 & 1, f >> 4 & 1, f >> 2 & 1, f & 1

    def szp(self, v):
        self.s, self.z, self.p = v >> 7, int(v == 0), int(PARITY[v])

    def cond(self, c):
        return [not self.z, self.z, not self.cy, self.cy,
                not self.p, self.p, not self.s, self.s][c]

    # --- стек и выборка ---
    def fetch(self):
        v = self.rd(self.pc)
        self.pc = (self.pc + 1) & 0xFFFF
        return v

    def fetch16(self):
        lo = self.fetch()
        return self.fetch() << 8 | lo

    def push(self, v):
        self.sp = (self.sp - 1) & 0xFFFF
        self.wr(self.sp, v >> 8)
        self.sp = (self.sp - 1) & 0xFFFF
        self.wr(self.sp, v & 0xFF)

    def pop(self):
        lo = self.rd(self.sp)
        hi = self.rd((self.sp + 1) & 0xFFFF)
        self.sp = (self.sp + 2) & 0xFFFF
        return hi << 8 | lo

    def alu(self, op, v):
        a = self.r[7]
        if op in (0, 1):                                  # ADD ADC
            c = self.cy if op == 1 else 0
            res = a + v + c
            self.ac = int((a & 15) + (v & 15) + c > 15)
            self.cy = int(res > 0xFF)
        elif op in (2, 3, 7):                             # SUB SBB CMP
            c = self.cy if op == 3 else 0
            res = a - v - c
            self.ac = int((a & 15) - (v & 15) - c >= 0)
            self.cy = int(res < 0)
        else:                                             # ANA XRA ORA
            res = [a & v, a ^ v, a | v][op - 4]
            self.ac = int(op == 4 and bool((a | v) & 8))
            self.cy = 0
        res &= 0xFF
        self.szp(res)
        if op != 7:
            self.r[7] = res

    def step(self):
        op = self.fetch()
        if 0x40 <= op < 0x80:
            if op == 0x76:                                # HLT
                self.pc = (self.pc - 1) & 0xFFFF
                return
            self.put(op >> 3 & 7, self.get(op & 7))
        elif 0x80 <= op < 0xC0:
            self.alu(op >> 3 & 7, self.get(op & 7))
        elif op < 0x40:
            d, rp = op >> 3 & 7, op >> 4 & 3
            lo = op & 7
            if lo == 6:
                self.put(d, self.fetch())
            elif lo == 4 or lo == 5:                      # INR DCR
                v = (self.get(d) + (1 if lo == 4 else -1)) & 0xFF
                self.ac = int((v & 15) == 0) if lo == 4 else int((v & 15) != 15)
                self.put(d, v)
                self.szp(v)
            elif op & 0xF == 1:
                self.setrp(rp, self.fetch16())
            elif op & 0xF == 9:                           # DAD
                v = self.hl() + self.getrp(rp)
                self.cy = int(v > 0xFFFF)
                self.setrp(2, v)
            elif op & 0xF == 3:
                self.setrp(rp, self.getrp(rp) + 1)
            elif op & 0xF == 0xB:
                self.setrp(rp, self.getrp(rp) - 1)
            elif op in (0x02, 0x12):
                self.wr(self.getrp(rp), self.r[7])
            elif op in (0x0A, 0x1A):
                self.r[7] = self.rd(self.getrp(rp))
            elif op == 0x22:
                a = self.fetch16()
                self.wr(a, self.r[5])
                self.wr((a + 1) & 0xFFFF, self.r[4])
            elif op == 0x2A:
                a = self.fetch16()
                self.r[5], self.r[4] = self.rd(a), self.rd((a + 1) & 0xFFFF)
            elif op == 0x32:
                self.wr(self.fetch16(), self.r[7])
            elif op == 0x3A:
                self.r[7] = self.rd(self.fetch16())
            elif op == 0x07:
                a = self.r[7]
                self.cy = a >> 7
                self.r[7] = (a << 1 | self.cy) & 0xFF
            elif op == 0x0F:
                a = self.r[7]
                self.cy = a & 1
                self.r[7] = a >> 1 | self.cy << 7
            elif op == 0x17:
                a = self.r[7]
                self.r[7], self.cy = (a << 1 | self.cy) & 0xFF, a >> 7
            elif op == 0x1F:
                a = self.r[7]
                self.r[7], self.cy = a >> 1 | self.cy << 7, a & 1
            elif op == 0x27:                              # DAA
                a, add, c = self.r[7], 0, self.cy
                if (a & 15) > 9 or self.ac:
                    add = 6
                if (a >> 4) > 9 or c or ((a >> 4) >= 9 and (a & 15) > 9):
                    add |= 0x60
                    c = 1
                self.ac = int((a & 15) + (add & 15) > 15)
                a = (a + add) & 0xFF
                self.cy = c
                self.szp(a)
                self.r[7] = a
            elif op == 0x2F:
                self.r[7] ^= 0xFF
            elif op == 0x37:
                self.cy = 1
            elif op == 0x3F:
                self.cy ^= 1
            elif op == 0x20:                              # RIM
                self.r[7] = self.ie << 3
            # 0x00 NOP, 0x30 SIM — ничего
        else:
            lo, c, rp = op & 7, op >> 3 & 7, op >> 4 & 3
            if lo == 0:
                if self.cond(c):
                    self.pc = self.pop()
            elif lo == 1:
                if op & 8:
                    if op == 0xC9:
                        self.pc = self.pop()
                    elif op == 0xE9:
                        self.pc = self.hl()
                    elif op == 0xF9:
                        self.sp = self.hl()
                elif rp == 3:
                    v = self.pop()
                    self.setflags(v & 0xFF)
                    self.r[7] = v >> 8
                else:
                    self.setrp(rp, self.pop())
            elif lo == 2:
                a = self.fetch16()
                if self.cond(c):
                    self.pc = a
            elif lo == 3:
                if op == 0xC3:
                    self.pc = self.fetch16()
                elif op == 0xD3:
                    self.out(self.fetch(), self.r[7])
                elif op == 0xDB:
                    self.r[7] = self.inp(self.fetch()) & 0xFF
                elif op == 0xE3:
                    v = self.pop()
                    self.push(self.hl())
                    self.setrp(2, v)
                elif op == 0xEB:
                    self.r[2], self.r[3], self.r[4], self.r[5] = self.r[4], self.r[5], self.r[2], self.r[3]
                elif op == 0xF3:
                    self.ie = 0
                elif op == 0xFB:
                    self.ie = 1
            elif lo == 4:
                a = self.fetch16()
                if self.cond(c):
                    self.push(self.pc)
                    self.pc = a
            elif lo == 5:
                if op == 0xCD:
                    a = self.fetch16()
                    self.push(self.pc)
                    self.pc = a
                elif rp == 3:
                    self.push(self.r[7] << 8 | self.flags())
                else:
                    self.push(self.getrp(rp))
            elif lo == 6:
                self.alu(c, self.fetch())
            else:                                         # RST n
                self.push(self.pc)
                self.pc = c * 8


class SimPort:
    """Сторона ПК одного канала 8251 (интерфейс как у serial.Serial)."""

    def __init__(self, timeout=1.0):
        self.timeout = timeout
        self.to_cpu = queue.Queue()     # байты, которые «ПК» послал на плату
        self.from_cpu = queue.Queue()   # байты, которые плата передала
        self.name = 'sim'

    def write(self, data):
        for b in data:
            self.to_cpu.put(b)
        return len(data)

    def read(self, n=1):
        out = bytearray()
        deadline = time.monotonic() + (self.timeout or 0)
        while len(out) < n:
            left = deadline - time.monotonic()
            try:
                out.append(self.from_cpu.get(timeout=max(left, 0.0)) if left > 0
                           else self.from_cpu.get_nowait())
            except queue.Empty:
                break
        return bytes(out)

    @property
    def in_waiting(self):
        return self.from_cpu.qsize()

    def reset_input_buffer(self):
        while not self.from_cpu.empty():
            self.from_cpu.get_nowait()

    def flush(self):
        pass

    def close(self):
        pass


class Board:
    def __init__(self):
        self.mem = bytearray(0x10000)
        self.rom = bytearray(0x10000)   # 1 = адрес только для чтения
        for base, name in ROMS:
            data = open(os.path.join(ROOT, name), 'rb').read()
            self.mem[base:base + len(data)] = data
            self.rom[base:base + len(data)] = b'\1' * len(data)
        self.rom[0x1000:0x2000] = b'\1' * 0x1000      # дыра 1000-1FFF
        self.mem[0x1000:0x2000] = b'\xFF' * 0x1000
        self.con, self.aux = SimPort(), SimPort()
        self.cpu = CPU(self.rd, self.wr, self.inp, self.out)
        self.cpu.pc = 0x0815            # сброс: оверлей 2716 на 0000 даёт JMP 0815
        self.stop = threading.Event()

    def rd(self, a):
        return self.mem[a]

    def wr(self, a, v):
        if not self.rom[a]:
            self.mem[a] = v

    def _uart(self, port):
        return {0xFE: self.con, 0xFF: self.con, 0xEE: self.aux, 0xEF: self.aux}.get(port)

    def inp(self, port):
        u = self._uart(port)
        if u is None:
            return 0xFF                  # F6 — клавиатура: «ничего не нажато»
        if port & 1:                     # статус: TxRDY всегда, RxRDY если есть байт
            return 0x85 | (2 if not u.to_cpu.empty() else 0)
        try:
            return u.to_cpu.get_nowait()
        except queue.Empty:
            return 0

    def out(self, port, v):
        u = self._uart(port)
        if u is not None and not port & 1:
            u.from_cpu.put(v)

    def run(self):
        step = self.cpu.step
        while not self.stop.is_set():
            for _ in range(5000):
                step()
            time.sleep(0)

    def start(self):
        threading.Thread(target=self.run, daemon=True).start()
        return self.con, self.aux
