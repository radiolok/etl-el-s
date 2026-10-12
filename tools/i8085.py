"""Intel 8085 opcode table and single-instruction decoder.

Each entry: (mnemonic template, length, flow)
  template uses {b} for an 8-bit immediate, {w} for a 16-bit immediate/address
  flow: None   - falls through
        'jmp'  - unconditional jump to {w}
        'jcc'  - conditional jump to {w}
        'call' - unconditional call to {w}
        'ccc'  - conditional call to {w}
        'ret'  - unconditional return (no fall-through)
        'rcc'  - conditional return
        'pchl' - computed jump (no fall-through)
        'rst'  - restart (call to fixed vector)
        'hlt'  - halt
"""

REGS = ['B', 'C', 'D', 'E', 'H', 'L', 'M', 'A']
RP = ['B', 'D', 'H', 'SP']
RPP = ['B', 'D', 'H', 'PSW']
CC = ['NZ', 'Z', 'NC', 'C', 'PO', 'PE', 'P', 'M']
ALU = ['ADD', 'ADC', 'SUB', 'SBB', 'ANA', 'XRA', 'ORA', 'CMP']
ALUI = ['ADI', 'ACI', 'SUI', 'SBI', 'ANI', 'XRI', 'ORI', 'CPI']

OPS = {}

def _build():
    # undocumented 8085 opcodes are kept as DB (80C85 does not guarantee them)
    for op in range(256):
        OPS[op] = ('DB {op:02X}H', 1, 'bad')
    OPS[0x00] = ('NOP', 1, None)
    OPS[0x20] = ('RIM', 1, None)
    OPS[0x30] = ('SIM', 1, None)
    for i in range(4):
        OPS[0x01 + i * 16] = ('LXI ' + RP[i] + ',{w}', 3, None)
        OPS[0x03 + i * 16] = ('INX ' + RP[i], 1, None)
        OPS[0x09 + i * 16] = ('DAD ' + RP[i], 1, None)
        OPS[0x0B + i * 16] = ('DCX ' + RP[i], 1, None)
        OPS[0xC1 + i * 16] = ('POP ' + RPP[i], 1, None)
        OPS[0xC5 + i * 16] = ('PUSH ' + RPP[i], 1, None)
    OPS[0x02] = ('STAX B', 1, None)
    OPS[0x12] = ('STAX D', 1, None)
    OPS[0x0A] = ('LDAX B', 1, None)
    OPS[0x1A] = ('LDAX D', 1, None)
    OPS[0x22] = ('SHLD {w}', 3, None)
    OPS[0x2A] = ('LHLD {w}', 3, None)
    OPS[0x32] = ('STA {w}', 3, None)
    OPS[0x3A] = ('LDA {w}', 3, None)
    for r in range(8):
        OPS[0x04 + r * 8] = ('INR ' + REGS[r], 1, None)
        OPS[0x05 + r * 8] = ('DCR ' + REGS[r], 1, None)
        OPS[0x06 + r * 8] = ('MVI ' + REGS[r] + ',{b}', 2, None)
    for i, m in enumerate(['RLC', 'RRC', 'RAL', 'RAR', 'DAA', 'CMA', 'STC', 'CMC']):
        OPS[0x07 + i * 8] = (m, 1, None)
    for d in range(8):
        for s in range(8):
            OPS[0x40 + d * 8 + s] = ('MOV %s,%s' % (REGS[d], REGS[s]), 1, None)
    OPS[0x76] = ('HLT', 1, 'hlt')
    for a in range(8):
        for s in range(8):
            OPS[0x80 + a * 8 + s] = ('%s %s' % (ALU[a], REGS[s]), 1, None)
        OPS[0xC6 + a * 8] = (ALUI[a] + ' {b}', 2, None)
        OPS[0xC7 + a * 8] = ('RST %d' % a, 1, 'rst')
    for c in range(8):
        OPS[0xC0 + c * 8] = ('R' + CC[c], 1, 'rcc')
        OPS[0xC2 + c * 8] = ('J' + CC[c] + ' {w}', 3, 'jcc')
        OPS[0xC4 + c * 8] = ('C' + CC[c] + ' {w}', 3, 'ccc')
    OPS[0xC3] = ('JMP {w}', 3, 'jmp')
    OPS[0xC9] = ('RET', 1, 'ret')
    OPS[0xCD] = ('CALL {w}', 3, 'call')
    OPS[0xD3] = ('OUT {b}', 2, None)
    OPS[0xDB] = ('IN {b}', 2, None)
    OPS[0xE3] = ('XTHL', 1, None)
    OPS[0xE9] = ('PCHL', 1, 'pchl')
    OPS[0xEB] = ('XCHG', 1, None)
    OPS[0xF3] = ('DI', 1, None)
    OPS[0xFB] = ('EI', 1, None)
    OPS[0xF9] = ('SPHL', 1, None)

_build()


def decode(mem, pc):
    """Return (length, mnemonic_template, flow, operand) for opcode at pc."""
    op = mem[pc & 0xFFFF]
    tmpl, ln, flow = OPS[op]
    operand = None
    if ln == 2:
        operand = mem[(pc + 1) & 0xFFFF]
    elif ln == 3:
        operand = mem[(pc + 1) & 0xFFFF] | (mem[(pc + 2) & 0xFFFF] << 8)
    return ln, tmpl, flow, operand
