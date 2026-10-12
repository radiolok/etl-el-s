"""Простой двухпроходный ассемблер Intel 8080/8085 (мнемоники Intel).

    python3 tools/asm8085.py prog.asm [-o prog.hex] [--bin prog.bin] [--lst prog.lst]

Синтаксис:
    метка:  MVI A,30H        ; комментарий
    ИМЯ     EQU 0FFFFH-45*2
            ORG 0100H
            DB 1,2,'ТЕКСТ',0  ; строки — в КОИ-7 Н2 (кириллица 0x60-0x7E), как в прошивке
            DW метка, 1234H
            DS 10
Числа: 1234H, 0x1234, 0b101, 10 (десятичное), 'c'. $ — текущий адрес.
Выражения — как в Python (+ - * // % & | ^ << >> ~), плюс LOW(x), HIGH(x).
Таблица команд берётся из tools/i8085.py (та же, что у дизассемблера).
"""
import argparse
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from i8085 import OPS  # noqa: E402

CYR = 'ЮАБЦДЕФГХИЙКЛМНОПЯРСТУЖВЬЫЗШЭЩЧ'   # КОИ-7 Н2: 0x60..0x7E


def koi7(s):
    out = bytearray()
    for ch in s:
        ch = ch.upper() if ch in 'ёЁ' or 'а' <= ch <= 'я' else ch
        if ch == 'Ё':
            ch = 'Е'
        if ch in CYR:
            out.append(0x60 + CYR.index(ch))
        elif ord(ch) < 0x60:
            out.append(ord(ch))
        else:
            raise ValueError('символа %r нет в КОИ-7 Н2' % ch)
    return bytes(out)


# мнемоника -> [(операнды шаблона, длина, код)]
TEMPLATES = {}
for _op, (_t, _ln, _flow) in OPS.items():
    if _flow == 'bad':
        continue
    _m, _, _args = _t.partition(' ')
    TEMPLATES.setdefault(_m, []).append(([a for a in _args.split(',') if a], _ln, _op))


class AsmError(Exception):
    pass


def split_operands(s):
    """Делит по запятым вне кавычек."""
    out, cur, q = [], '', None
    for ch in s:
        if q:
            cur += ch
            if ch == q:
                q = None
        elif ch in '\'"':
            q = ch
            cur += ch
        elif ch == ',':
            out.append(cur.strip())
            cur = ''
        else:
            cur += ch
    if cur.strip():
        out.append(cur.strip())
    return out


def strip_comment(line):
    q = None
    for i, ch in enumerate(line):
        if q:
            if ch == q:
                q = None
        elif ch in '\'"':
            q = ch
        elif ch == ';':
            return line[:i]
    return line


NUM_H = re.compile(r'\b([0-9][0-9A-Fa-f]*)[Hh]\b')
NUM_B = re.compile(r'\b([01]+)[Bb]\b')


class Assembler:
    def __init__(self):
        self.sym = {}
        self.mem = {}
        self.listing = []

    def eval(self, expr, pc, final):
        e = expr.strip()
        m = re.fullmatch(r"'(.)'", e)
        if m:
            return koi7(m.group(1))[0]
        e = NUM_H.sub(lambda m: str(int(m.group(1), 16)), e)
        e = NUM_B.sub(lambda m: str(int(m.group(1), 2)), e)
        e = re.sub(r"'(.)'", lambda m: str(koi7(m.group(1))[0]), e)
        e = e.replace('$', '(_PC_)')
        names = dict(self.sym, _PC_=pc, LOW=lambda x: x & 0xFF, HIGH=lambda x: x >> 8 & 0xFF)
        try:
            return int(eval(e, {'__builtins__': {}}, names))
        except NameError:
            if final:
                raise AsmError('неизвестное имя в выражении: ' + expr)
            return 0
        except SyntaxError:
            raise AsmError('ошибка в выражении: ' + expr)

    def encode(self, mnem, ops, pc, final):
        cands = TEMPLATES.get(mnem)
        if not cands:
            raise AsmError('неизвестная команда ' + mnem)
        for targs, ln, code in cands:
            if len(targs) != len(ops):
                continue
            val, ok = None, True
            for ta, o in zip(targs, ops):
                if ta in ('{b}', '{w}'):
                    val = self.eval(o, pc, final)
                elif ta != o.upper():
                    ok = False
                    break
            if not ok:
                continue
            if ln == 1:
                return bytes([code])
            if ln == 2:
                if final and not -128 <= val <= 255:
                    raise AsmError('байт вне диапазона: %d' % val)
                return bytes([code, val & 0xFF])
            return bytes([code, val & 0xFF, val >> 8 & 0xFF])
        raise AsmError('неверные операнды: %s %s' % (mnem, ','.join(ops)))

    def data(self, kind, ops, pc, final):
        out = bytearray()
        for o in ops:
            if kind == 'DB' and len(o) >= 2 and o[0] == o[-1] and o[0] in '\'"' and len(o) != 3:
                out += koi7(o[1:-1])
            elif kind == 'DB':
                out.append(self.eval(o, pc, final) & 0xFF)
            else:
                v = self.eval(o, pc, final)
                out += bytes([v & 0xFF, v >> 8 & 0xFF])
        return bytes(out)

    def run_pass(self, lines, final):
        pc = 0
        for no, raw in enumerate(lines, 1):
            try:
                line = strip_comment(raw).rstrip()
                if not line.strip():
                    if final:
                        self.listing.append((None, b'', raw))
                    continue
                label = None
                m = re.match(r'^\s*([A-Za-z_.][\w.]*):', line)
                if m:
                    label = m.group(1)
                    line = line[m.end():]
                parts = line.split(None, 1)
                if not parts:
                    self.define(label, pc, final)
                    if final:
                        self.listing.append((pc, b'', raw))
                    continue
                # ИМЯ EQU выражение
                if len(parts) == 2 and parts[1].split(None, 1)[0].upper() == 'EQU' and not label:
                    expr = parts[1].split(None, 1)[1]
                    self.sym[parts[0]] = self.eval(expr, pc, final)
                    if final:
                        self.listing.append((None, b'', raw))
                    continue
                mnem = parts[0].upper()
                ops = split_operands(parts[1]) if len(parts) > 1 else []
                self.define(label, pc, final)
                if mnem == 'ORG':
                    pc = self.eval(ops[0], pc, True)
                    code = b''
                elif mnem == 'END':
                    break
                elif mnem in ('DB', 'DW'):
                    code = self.data(mnem, ops, pc, final)
                elif mnem == 'DS':
                    n = self.eval(ops[0], pc, True)
                    if final:
                        self.listing.append((pc, b'', raw))
                    pc += n
                    continue
                else:
                    code = self.encode(mnem, ops, pc, final)
                if final:
                    for i, b in enumerate(code):
                        if pc + i in self.mem:
                            raise AsmError('перекрытие по адресу %04X' % (pc + i))
                        self.mem[pc + i] = b
                    self.listing.append((pc, code, raw))
                pc += len(code)
            except (AsmError, ValueError) as e:
                raise AsmError('строка %d: %s\n    %s' % (no, e, raw.rstrip()))

    def define(self, label, pc, final):
        if not label:
            return
        if not final and label in self.sym and self.sym[label] != pc:
            raise AsmError('метка %s определена дважды' % label)
        self.sym[label] = pc

    def assemble(self, text):
        lines = text.splitlines()
        self.run_pass(lines, False)
        self.run_pass(lines, True)
        return self.mem


def intel_hex(mem, rec=16):
    out = []
    addrs = sorted(mem)
    i = 0
    while i < len(addrs):
        start = addrs[i]
        chunk = [mem[start]]
        i += 1
        while i < len(addrs) and addrs[i] == start + len(chunk) and len(chunk) < rec:
            chunk.append(mem[addrs[i]])
            i += 1
        body = bytes([len(chunk), start >> 8, start & 0xFF, 0]) + bytes(chunk)
        out.append(':' + body.hex().upper() + '%02X' % (-sum(body) & 0xFF))
    out.append(':00000001FF')
    return '\n'.join(out) + '\n'


def main():
    ap = argparse.ArgumentParser(description='Ассемблер 8080/8085')
    ap.add_argument('src')
    ap.add_argument('-o', '--hex', help='Intel HEX (по умолчанию — рядом с исходником)')
    ap.add_argument('--bin', help='сырой образ от младшего до старшего адреса')
    ap.add_argument('--lst', help='листинг')
    a = ap.parse_args()
    asm = Assembler()
    try:
        mem = asm.assemble(Path(a.src).read_text(encoding='utf-8'))
    except AsmError as e:
        sys.exit('%s: %s' % (a.src, e))
    out = a.hex or str(Path(a.src).with_suffix('.hex'))
    Path(out).write_text(intel_hex(mem))
    lo, hi = min(mem), max(mem)
    if a.bin:
        Path(a.bin).write_bytes(bytes(mem.get(x, 0) for x in range(lo, hi + 1)))
    if a.lst:
        with open(a.lst, 'w', encoding='utf-8') as f:
            for pc, code, raw in asm.listing:
                addr = '%04X' % pc if pc is not None else '    '
                f.write('%s %-12s %s\n' % (addr, code[:4].hex(' ').upper(), raw.rstrip()))
                for k in range(4, len(code), 4):
                    f.write('%04X %-12s\n' % (pc + k, code[k:k + 4].hex(' ').upper()))
    print('%s: %04X-%04X, %d байт' % (out, lo, hi, len(mem)))


if __name__ == '__main__':
    main()
