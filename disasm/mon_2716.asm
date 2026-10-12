; MON 0800-0FFF, экспорт Ghidra
0800 C3                         ?? C3h
0801 15                         ?? 15h
0802 08                         ?? 08h
0803 C3                         ?? C3h
0804 EB                         ?? EBh
0805 0A                         ?? 0Ah
0806 C3                         ?? C3h
0807 15                         ?? 15h
0808 08                         ?? 08h
0809 C3                         ?? C3h
080A F9                         ?? F9h
080B 0A                         ?? 0Ah
080C C3                         ?? C3h
080D 15                         ?? 15h
080E 08                         ?? 08h
080F C3                         ?? C3h
0810 15                         ?? 15h
0811 08                         ?? 08h
0812 C3                         ?? C3h
0813 07                         ?? 07h
0814 0B                         ?? 0Bh

; ============================================================
; mon_reset
; Сброс монитора: DI, инициализация двух 8251 (FE/FF — консоль, EE/EF — канал HEX),
; поиск верхней границы ОЗУ -> (0004), копия трамплина 0FC7.. в верх ОЗУ, JMP 0C3E в 0000.
; 11 NOP на 0816..0820 — место под патч (например, JMP 2000).
; вызовы из: 0000
0815 F3          mon_reset:     DI
0816 00                         NOP
0817 00                         NOP
0818 00                         NOP
0819 00                         NOP
081A 00                         NOP
081B 00                         NOP
081C 00                         NOP
081D 00                         NOP
081E 00                         NOP
081F 00                         NOP
0820 00                         NOP
0821 3E CF                      MVI A,0xcf
0823 D3 FF                      OUT (0xff)
0825 3E 25                      MVI A,0x25
0827 D3 FF                      OUT (0xff)
0829 3E CF                      MVI A,0xcf
082B D3 EF                      OUT (0xef)
082D 3E 25                      MVI A,0x25
082F D3 EF                      OUT (0xef)

; ============================================================
; mon_warm
; вызовы из: 20CD
0831 21 00 00    mon_warm:      LXI HL,0x0
0834 24          LAB_ram_0834:  INR H
0835 7E                         MOV A,(HL)
0836 2F                         CMA
0837 77                         MOV (HL),A
0838 BE                         CMP (HL)
0839 2F                         CMA
083A 77                         MOV (HL),A
083B CA 34 08                   JZ 0x0834
083E 2B                         DCX HL
083F 22 04 00                   SHLD (0x0004)

; ============================================================
; caseD_55
; вызовы из: 08A1
0842 2A 04 00    caseD_55:      LHLD (0x0004)
0845 01 C7 0F                   LXI BC,0xfc7
0848 69                         MOV L,C
0849 F9                         SPHL
084A 0A          LAB_ram_084a:  LDAX (BC)
084B 77                         MOV (HL),A
084C 0C                         INR C
084D 2C                         INR L
084E C2 4A 08                   JNZ 0x084a
0851 2E D2                      MVI L,0xd2
0853 74                         MOV (HL),H
0854 3E C3                      MVI A,0xc3
0856 32 00 00                   STA (0x0000)
0859 21 3E 0C                   LXI HL,0xc3e
085C 22 01 00                   SHLD (0x0001)
085F 3B                         DCX SP
0860 3B                         DCX SP
0861 21 B9 0B                   LXI HL,0xbb9
0864 CD C5 0A                   CALL 0x0ac5
0867 C3 74 08                   JMP 0x0874

; ============================================================
; caseD_41
; вызовы из: 0895 08A1 0965 0A25 0AA0 0AE8 0B2F 0B6A 0B71 0B77 0B94
086A 2A 04 00    caseD_41:      LHLD (0x0004)
086D 2E FA                      MVI L,0xfa
086F E9                         PCHL
0870 CD                         ?? CDh
0871 F5                         ?? F5h
0872 0A                         ?? 0Ah
0873 2B                         ?? 2Bh    +

; ============================================================
; mon_cmd_loop
; Командный цикл монитора: символ A..X -> таблица 0x08A2.
; вызовы из: 0867 0887
0874 2A 04 00    mon_cmd_loop:  LHLD (0x0004)
0877 2E BF                      MVI L,0xbf
0879 F9                         SPHL
087A FB                         EI
087B CD 1E 0B                   CALL 0x0b1e
087E CD F5 0A                   CALL 0x0af5
0881 2D                         DCR L
0882 CD 27 0B                   CALL 0x0b27
0885 D6 41                      SUI 0x41
0887 FA 74 08                   JM 0x0874
088A 0E 02                      MVI C,0x2
088C 11 74 08                   LXI DE,0x874
088F D5                         PUSH DE
0890 21 A2 08                   LXI HL,0x8a2
0893 FE 18                      CPI 0x18
0895 F2 6A 08                   JP 0x086a
0898 5F                         MOV E,A
0899 16 00                      MVI D,0x0
089B 19                         DAD HL,DE
089C 19                         DAD HL,DE
089D 7E                         MOV A,(HL)
089E 23                         INX HL
089F 66                         MOV H,(HL)
08A0 6F                         MOV L,A
08A1 E9          switchD:       PCHL
08A2 6A 08       tbl_mon_cmd:   addr ram:086a
08A4 6A 08                      addr ram:086a
08A6 D2 08                      addr ram:08d2
08A8 E6 08                      addr ram:08e6
08AA 05 09                      addr ram:0905
08AC 2D 09                      addr ram:092d
08AE 3C 09                      addr ram:093c
08B0 8A 09                      addr ram:098a
08B2 6A 08                      addr ram:086a
08B4 6A 08                      addr ram:086a
08B6 6A 08                      addr ram:086a
08B8 6A 08                      addr ram:086a
08BA B0 09                      addr ram:09b0
08BC 6A 08                      addr ram:086a
08BE 6A 08                      addr ram:086a
08C0 C1 09                      addr ram:09c1
08C2 6A 08                      addr ram:086a
08C4 F6 09                      addr ram:09f6
08C6 3B 0A                      addr ram:0a3b
08C8 6A 08                      addr ram:086a
08CA 42 08                      addr ram:0842
08CC 6A 08                      addr ram:086a
08CE 4A 0A                      addr ram:0a4a
08D0 8A 0A                      addr ram:0a8a

; ============================================================
; caseD_43
; вызовы из: 08A1
08D2 0C          caseD_43:      INR C
08D3 CD 61 0B                   CALL 0x0b61
08D6 C1                         POP BC
08D7 D1                         POP DE
08D8 E1                         POP HL
08D9 0A          LAB_ram_08d9:  LDAX (BC)
08DA BE                         CMP (HL)
08DB C4 39 0B                   CNZ 0x0b39
08DE CD 57 0B                   CALL 0x0b57
08E1 D8                         RC
08E2 03                         INX BC
08E3 C3 D9 08                   JMP 0x08d9

; ============================================================
; caseD_44
; вызовы из: 08A1
08E6 CD 61 0B    caseD_44:      CALL 0x0b61
08E9 D1                         POP DE
08EA E1                         POP HL
08EB CD 1E 0B    LAB_ram_08eb:  CALL 0x0b1e
08EE CD 9C 09                   CALL 0x099c
08F1 CD 19 0B    LAB_ram_08f1:  CALL 0x0b19
08F4 7E                         MOV A,(HL)
08F5 CD A1 09                   CALL 0x09a1
08F8 CD 57 0B                   CALL 0x0b57
08FB D8                         RC
08FC 7D                         MOV A,L
08FD E6 0F                      ANI 0xf
08FF C2 F1 08                   JNZ 0x08f1
0902 C3 EB 08                   JMP 0x08eb

; ============================================================
; caseD_45
; вызовы из: 08A1
0905 0D          caseD_45:      DCR C
0906 CD 61 0B                   CALL 0x0b61
0909 CD 14 0C                   CALL 0x0c14
090C 3A AF 57                   LDA (0x57af)
090F CD 28 0C                   CALL 0x0c28
0912 E1                         POP HL
0913 CD 23 0C                   CALL 0x0c23
0916 3E 01                      MVI A,0x1
0918 CD 28 0C                   CALL 0x0c28
091B AF                         XRA A
091C 92                         SUB D
091D CD 28 0C                   CALL 0x0c28
0920 CD 14 0C                   CALL 0x0c14
0923 0D                         DCR C
0924 CD 14 0C                   CALL 0x0c14
0927 0A                         LDAX (BC)
0928 CD 14 0C                   CALL 0x0c14
092B 1A                         LDAX (DE)
092C C9                         RET

; ============================================================
; caseD_46
; вызовы из: 08A1
092D 0C          caseD_46:      INR C
092E CD 61 0B                   CALL 0x0b61
0931 C1                         POP BC
0932 D1                         POP DE
0933 E1                         POP HL
0934 71          LAB_ram_0934:  MOV (HL),C
0935 CD 57 0B                   CALL 0x0b57
0938 D2 34 09                   JNC 0x0934
093B C9                         RET

; ============================================================
; caseD_47
; вызовы из: 08A1
093C F3          caseD_47:      DI
093D CD 98 0B                   CALL 0x0b98
0940 CA 4F 09                   JZ 0x094f
0943 CD 7A 0B                   CALL 0x0b7a
0946 EB                         XCHG
0947 2A 04 00                   LHLD (0x0004)
094A 2E E1                      MVI L,0xe1
094C 72                         MOV (HL),D
094D 2B                         DCX HL
094E 73                         MOV (HL),E
094F DA 81 09    LAB_ram_094f:  JC 0x0981
0952 11 02 00                   LXI DE,0x2
0955 CD F5 0A    LAB_ram_0955:  CALL 0x0af5
0958 2D                         DCR L
0959 CD 74 0B                   CALL 0x0b74
095C E5                         PUSH HL
095D 14                         INR D
095E DA 65 09                   JC 0x0965
0961 1D                         DCR E
0962 C2 55 09                   JNZ 0x0955
0965 D2 6A 08    LAB_ram_0965:  JNC 0x086a
0968 2A 04 00                   LHLD (0x0004)
096B 2E E2                      MVI L,0xe2
096D C1          LAB_ram_096d:  POP BC
096E 78                         MOV A,B
096F B1                         ORA C
0970 CA 7D 09                   JZ 0x097d
0973 71                         MOV (HL),C
0974 23                         INX HL
0975 70                         MOV (HL),B
0976 23                         INX HL
0977 0A                         LDAX (BC)
0978 77                         MOV (HL),A
0979 23                         INX HL
097A 3E C7                      MVI A,0xc7
097C 02                         STAX (BC)
097D 15          LAB_ram_097d:  DCR D
097E C2 6D 09                   JNZ 0x096d
0981 2A 04 00    LAB_ram_0981:  LHLD (0x0004)
0984 2E C9                      MVI L,0xc9
0986 F9                         SPHL
0987 2E D3                      MVI L,0xd3
0989 E9                         PCHL

; ============================================================
; caseD_48
; вызовы из: 08A1
098A CD 61 0B    caseD_48:      CALL 0x0b61
098D D1                         POP DE
098E E1                         POP HL
098F AF                         XRA A
0990 86          LAB_ram_0990:  ADD (HL)
0991 4F                         MOV C,A
0992 CD 57 0B                   CALL 0x0b57
0995 79                         MOV A,C
0996 D2 90 09                   JNC 0x0990
0999 C3 A1 09                   JMP 0x09a1

; ============================================================
; FUN_ram_099c
; вызовы из: 08EE 0B4A
099C 7C          FUN_ram_099c:  MOV A,H
099D CD A1 09                   CALL 0x09a1
09A0 7D                         MOV A,L

; ============================================================
; FUN_ram_09a1
; вызовы из: 08F5 0999 099D 0B42 0BE5 0BEC
09A1 F5          FUN_ram_09a1:  PUSH AF
09A2 0F                         RRC
09A3 0F                         RRC
09A4 0F                         RRC
09A5 0F                         RRC
09A6 CD AA 09                   CALL 0x09aa
09A9 F1                         POP AF

; ============================================================
; FUN_ram_09aa
; вызовы из: 09A6
09AA CD 0F 0B    FUN_ram_09aa:  CALL 0x0b0f
09AD C3 F9 0A                   JMP 0x0af9

; ============================================================
; caseD_4d
; вызовы из: 08A1
09B0 0C          caseD_4d:      INR C
09B1 CD 61 0B                   CALL 0x0b61
09B4 C1                         POP BC
09B5 D1                         POP DE
09B6 E1                         POP HL
09B7 7E          LAB_ram_09b7:  MOV A,(HL)
09B8 02                         STAX (BC)
09B9 CD 57 0B                   CALL 0x0b57
09BC D8                         RC
09BD 03                         INX BC
09BE C3 B7 09                   JMP 0x09b7

; ============================================================
; caseD_50
; вызовы из: 08A1
09C1 2A 04 00    caseD_50:      LHLD (0x0004)
09C4 2E CF                      MVI L,0xcf
09C6 46                         MOV B,(HL)
09C7 21 EB 09                   LXI HL,0x9eb
09CA CD 1E 0B                   CALL 0x0b1e
09CD 7E          LAB_ram_09cd:  MOV A,(HL)
09CE B7                         ORA A
09CF C8                         RZ
09D0 4E                         MOV C,(HL)
09D1 CD F9 0A                   CALL 0x0af9
09D4 CD F5 0A                   CALL 0x0af5
09D7 3D                         DCR A
09D8 78                         MOV A,B
09D9 23                         INX HL
09DA A6                         ANA (HL)
09DB 23                         INX HL
09DC 0E 30                      MVI C,0x30
09DE CA E2 09                   JZ 0x09e2
09E1 0C                         INR C
09E2 CD F9 0A    LAB_ram_09e2:  CALL 0x0af9
09E5 CD 19 0B                   CALL 0x0b19
09E8 C3 CD 09                   JMP 0x09cd
09EB 53          DAT_ram_09eb:  undefined1 53h
09EC 80          DAT_ram_09ec:  undefined1 80h
09ED 5A          DAT_ram_09ed:  undefined1 5Ah
09EE 40                         ?? 40h    @
09EF 41                         ?? 41h    A
09F0 10                         ?? 10h
09F1 50                         ?? 50h    P
09F2 04                         ?? 04h
09F3 43                         ?? 43h    C
09F4 01                         ?? 01h
09F5 00                         ?? 00h

; ============================================================
; caseD_52
; вызовы из: 08A1
09F6 0D          caseD_52:      DCR C
09F7 CD 61 0B                   CALL 0x0b61
09FA CD EF 0B    LAB_ram_09fa:  CALL 0x0bef
09FD FE 3A                      CPI 0x3a
09FF C2 FA 09                   JNZ 0x09fa
0A02 AF                         XRA A
0A03 57                         MOV D,A
0A04 CD FB 0B                   CALL 0x0bfb
0A07 CA 2B 0A                   JZ 0x0a2b
0A0A 5F                         MOV E,A
0A0B CD FB 0B                   CALL 0x0bfb
0A0E 67                         MOV H,A
0A0F CD FB 0B                   CALL 0x0bfb
0A12 6F                         MOV L,A
0A13 C1                         POP BC
0A14 09                         DAD HL,BC
0A15 C5                         PUSH BC
0A16 CD FB 0B                   CALL 0x0bfb
0A19 CD FB 0B    LAB_ram_0a19:  CALL 0x0bfb
0A1C 77                         MOV (HL),A
0A1D 23                         INX HL
0A1E 1D                         DCR E
0A1F C2 19 0A                   JNZ 0x0a19
0A22 CD FB 0B                   CALL 0x0bfb
0A25 C2 6A 08                   JNZ 0x086a
0A28 C3 FA 09                   JMP 0x09fa
0A2B E1          LAB_ram_0a2b:  POP HL
0A2C 2A 04 00                   LHLD (0x0004)
0A2F 2E E1                      MVI L,0xe1
0A31 CD FB 0B                   CALL 0x0bfb
0A34 77                         MOV (HL),A
0A35 CD FB 0B                   CALL 0x0bfb
0A38 2B                         DCX HL
0A39 77                         MOV (HL),A
0A3A C9                         RET

; ============================================================
; caseD_53
; вызовы из: 08A1
0A3B CD 74 0B    caseD_53:      CALL 0x0b74
0A3E D8                         RC
0A3F EB                         XCHG
0A40 CD 74 0B    LAB_ram_0a40:  CALL 0x0b74
0A43 7D                         MOV A,L
0A44 12                         STAX (DE)
0A45 13                         INX DE
0A46 D8                         RC
0A47 C3 40 0A                   JMP 0x0a40

; ============================================================
; caseD_57
; вызовы из: 08A1
0A4A CD 61 0B    caseD_57:      CALL 0x0b61
0A4D D1                         POP DE
0A4E E1                         POP HL
0A4F CD 14 0C    LAB_ram_0a4f:  CALL 0x0c14
0A52 3A 01 10                   LDA (0x1001)
0A55 00                         NOP
0A56 E5                         PUSH HL
0A57 04          LAB_ram_0a57:  INR B
0A58 0D                         DCR C
0A59 C2 57 0A                   JNZ 0x0a57
0A5C E1                         POP HL
0A5D D5                         PUSH DE
0A5E 16 00                      MVI D,0x0
0A60 78                         MOV A,B
0A61 CD 28 0C                   CALL 0x0c28
0A64 CD 23 0C                   CALL 0x0c23
0A67 AF                         XRA A
0A68 CD 28 0C                   CALL 0x0c28
0A6B 7E          LAB_ram_0a6b:  MOV A,(HL)
0A6C CD 28 0C                   CALL 0x0c28
0A6F 23                         INX HL
0A70 05                         DCR B
0A71 C2 6B 0A                   JNZ 0x0a6b
0A74 AF                         XRA A
0A75 92                         SUB D
0A76 CD 28 0C                   CALL 0x0c28
0A79 D1                         POP DE
0A7A 2B                         DCX HL
0A7B CD 14 0C                   CALL 0x0c14
0A7E 0D                         DCR C
0A7F CD 14 0C                   CALL 0x0c14
0A82 0A                         LDAX (BC)
0A83 CD 57 0B                   CALL 0x0b57
0A86 D2 4F 0A                   JNC 0x0a4f
0A89 C9                         RET

; ============================================================
; caseD_58
; вызовы из: 08A1 0AB1 0ABC 0AC2
0A8A 21 B9 0B    caseD_58:      LXI HL,0xbb9
0A8D CD 98 0B                   CALL 0x0b98
0A90 DA C5 0A                   JC 0x0ac5
0A93 0E 0B                      MVI C,0xb
0A95 BE          LAB_ram_0a95:  CMP (HL)
0A96 CA A3 0A                   JZ 0x0aa3
0A99 23                         INX HL
0A9A 23                         INX HL
0A9B 23                         INX HL
0A9C 0D                         DCR C
0A9D C2 95 0A                   JNZ 0x0a95
0AA0 C3 6A 08                   JMP 0x086a
0AA3 CD 19 0B    LAB_ram_0aa3:  CALL 0x0b19
0AA6 CD DB 0B                   CALL 0x0bdb
0AA9 CD F5 0A                   CALL 0x0af5
0AAC 2D                         DCR L
0AAD CD 98 0B                   CALL 0x0b98
0AB0 D8                         RC
0AB1 CA 8A 0A                   JZ 0x0a8a
0AB4 C5                         PUSH BC
0AB5 CD 7A 0B                   CALL 0x0b7a
0AB8 7D                         MOV A,L
0AB9 12          LAB_ram_0ab9:  STAX (DE)
0ABA F1                         POP AF
0ABB B7          LAB_ram_0abb:  ORA A
0ABC FA 8A 0A                   JM 0x0a8a
0ABF 13          LAB_ram_0abf:  INX DE
0AC0 7C                         MOV A,H
0AC1 12          LAB_ram_0ac1:  STAX (DE)
0AC2 C3 8A 0A                   JMP 0x0a8a

; ============================================================
; mon_puts
; вызовы из: 0864 0A90
0AC5 CD 1E 0B    mon_puts:      CALL 0x0b1e
0AC8 CD 19 0B    LAB_ram_0ac8:  CALL 0x0b19
0ACB AF                         XRA A
0ACC B6                         ORA (HL)
0ACD F8          LAB_ram_0acd:  RM
0ACE 4E                         MOV C,(HL)
0ACF CD F9 0A    LAB_ram_0acf:  CALL 0x0af9
0AD2 CD F5 0A    LAB_ram_0ad2:  CALL 0x0af5
0AD5 3D                         DCR A
0AD6 CD DB 0B                   CALL 0x0bdb
0AD9 C3 C8 0A                   JMP 0x0ac8

; ============================================================
; FUN_ram_0adc
; вызовы из: 0AF9
0ADC CD 07 0B    FUN_ram_0adc:  CALL 0x0b07
0ADF B7          LAB_ram_0adf:  ORA A
0AE0 C8          LAB_ram_0ae0:  RZ
0AE1 CD EB 0A    LAB_ram_0ae1:  CALL 0x0aeb
0AE4 E6 7F       LAB_ram_0ae4:  ANI 0x7f
0AE6 FE 03       LAB_ram_0ae6:  CPI 0x3
0AE8 CA 6A 08                   JZ 0x086a

; ============================================================
; con_getc_raw
; вызовы из: 0AE1 0AEF 0B28
0AEB DB FF       con_getc_raw:  IN (0xff)
0AED E6 02                      ANI 0x2
0AEF CA EB 0A                   JZ 0x0aeb
0AF2 DB FE                      IN (0xfe)
0AF4 C9                         RET

; ============================================================
; FUN_ram_0af5
; вызовы из: 087E 0955 09D4 0AA9 0AD2 0B1E 0B22
0AF5 E3          FUN_ram_0af5:  XTHL
0AF6 4E                         MOV C,(HL)
0AF7 23                         INX HL
0AF8 E3                         XTHL

; ============================================================
; con_putc
; вызовы из: 09AD 09D1 09E2 0ACF 0B1B 0B33
0AF9 CD DC 0A    con_putc:      CALL 0x0adc
0AFC DB FF       LAB_ram_0afc:  IN (0xff)
0AFE E6 01                      ANI 0x1
0B00 CA FC 0A                   JZ 0x0afc
0B03 79                         MOV A,C
0B04 D3 FE                      OUT (0xfe)
0B06 C9                         RET

; ============================================================
; con_status
; вызовы из: 0ADC
0B07 DB FF       con_status:    IN (0xff)
0B09 E6 02                      ANI 0x2
0B0B C8                         RZ
0B0C AF                         XRA A
0B0D 2F                         CMA
0B0E C9                         RET

; ============================================================
; FUN_ram_0b0f
; вызовы из: 09AA 0C2D 0C34
0B0F E6 0F       FUN_ram_0b0f:  ANI 0xf
0B11 C6 90                      ADI 0x90
0B13 27                         DAA
0B14 CE 40                      ACI 0x40
0B16 27                         DAA
0B17 4F                         MOV C,A
0B18 C9                         RET

; ============================================================
; FUN_ram_0b19
; вызовы из: 08F1 09E5 0AA3 0AC8 0B45 0B4D
0B19 0E 20       FUN_ram_0b19:  MVI C,0x20
0B1B C3 F9 0A                   JMP 0x0af9

; ============================================================
; FUN_ram_0b1e
; вызовы из: 087B 08EB 09CA 0AC5 0B3E
0B1E CD F5 0A    FUN_ram_0b1e:  CALL 0x0af5
0B21 0D                         DCR C
0B22 CD F5 0A                   CALL 0x0af5
0B25 0A                         LDAX (BC)
0B26 C9                         RET

; ============================================================
; con_getc_echo
; вызовы из: 0882 0B8A 0B98
0B27 C5          con_getc_echo: PUSH BC
0B28 CD EB 0A                   CALL 0x0aeb
0B2B E6 7F                      ANI 0x7f
0B2D FE 03                      CPI 0x3
0B2F CA 6A 08                   JZ 0x086a
0B32 4F                         MOV C,A
0B33 CD F9 0A                   CALL 0x0af9
0B36 79                         MOV A,C
0B37 C1                         POP BC
0B38 C9                         RET

; ============================================================
; FUN_ram_0b39
; вызовы из: 08DB
0B39 D5          FUN_ram_0b39:  PUSH DE
0B3A C5                         PUSH BC
0B3B 16 02                      MVI D,0x2
0B3D 5F                         MOV E,A
0B3E CD 1E 0B                   CALL 0x0b1e
0B41 7B          LAB_ram_0b41:  MOV A,E
0B42 CD A1 09                   CALL 0x09a1
0B45 CD 19 0B                   CALL 0x0b19
0B48 5E                         MOV E,(HL)
0B49 E3                         XTHL
0B4A CD 9C 09                   CALL 0x099c
0B4D CD 19 0B                   CALL 0x0b19
0B50 15                         DCR D
0B51 C2 41 0B                   JNZ 0x0b41
0B54 C1                         POP BC
0B55 D1                         POP DE
0B56 C9                         RET

; ============================================================
; FUN_ram_0b57
; вызовы из: 08DE 08F8 0935 0992 09B9 0A83
0B57 23          FUN_ram_0b57:  INX HL
0B58 7C                         MOV A,H
0B59 B5                         ORA L
0B5A 37                         STC
0B5B C8                         RZ
0B5C 7B                         MOV A,E
0B5D 95                         SUB L
0B5E 7A                         MOV A,D
0B5F 9C                         SBB H
0B60 C9                         RET

; ============================================================
; FUN_ram_0b61
; вызовы из: 08D3 08E6 0906 092E 098A 09B1 09F7 0A4A 0B6E
0B61 CD 74 0B    FUN_ram_0b61:  CALL 0x0b74
0B64 E3                         XTHL
0B65 E5                         PUSH HL
0B66 0D                         DCR C
0B67 D2 6E 0B                   JNC 0x0b6e
0B6A C2 6A 08                   JNZ 0x086a
0B6D C9                         RET
0B6E C2 61 0B    LAB_ram_0b6e:  JNZ 0x0b61
0B71 C3 6A 08                   JMP 0x086a

; ============================================================
; FUN_ram_0b74
; вызовы из: 0959 0A3B 0A40 0B61
0B74 CD 98 0B    FUN_ram_0b74:  CALL 0x0b98
0B77 CA 6A 08                   JZ 0x086a

; ============================================================
; FUN_ram_0b7a
; вызовы из: 0943 0AB5
0B7A 21 00 00    FUN_ram_0b7a:  LXI HL,0x0
0B7D 47          LAB_ram_0b7d:  MOV B,A
0B7E CD A7 0B                   CALL 0x0ba7
0B81 DA 90 0B                   JC 0x0b90
0B84 29                         DAD HL,HL
0B85 29                         DAD HL,HL
0B86 29                         DAD HL,HL
0B87 29                         DAD HL,HL
0B88 B5                         ORA L
0B89 6F                         MOV L,A
0B8A CD 27 0B                   CALL 0x0b27
0B8D C3 7D 0B                   JMP 0x0b7d
0B90 78          LAB_ram_0b90:  MOV A,B
0B91 CD 9B 0B                   CALL 0x0b9b
0B94 C2 6A 08                   JNZ 0x086a
0B97 C9                         RET

; ============================================================
; FUN_ram_0b98
; вызовы из: 093D 0A8D 0AAD 0B74
0B98 CD 27 0B    FUN_ram_0b98:  CALL 0x0b27

; ============================================================
; FUN_ram_0b9b
; вызовы из: 0B91
0B9B FE 20       FUN_ram_0b9b:  CPI 0x20
0B9D C8                         RZ
0B9E FE 2C                      CPI 0x2c
0BA0 C8                         RZ
0BA1 FE 0D                      CPI 0xd
0BA3 37                         STC
0BA4 C8                         RZ
0BA5 3F                         CMC
0BA6 C9                         RET

; ============================================================
; FUN_ram_0ba7
; вызовы из: 0B7E 0BFF 0C0A
0BA7 D6 30       FUN_ram_0ba7:  SUI 0x30
0BA9 D8                         RC
0BAA C6 E9                      ADI 0xe9
0BAC D8                         RC
0BAD C6 06                      ADI 0x6
0BAF F2 B5 0B                   JP 0x0bb5
0BB2 C6 07                      ADI 0x7
0BB4 D8                         RC
0BB5 C6 0A       LAB_ram_0bb5:  ADI 0xa
0BB7 B7                         ORA A
0BB8 C9                         RET
0BB9 50          DAT_ram_0bb9:  undefined1 50h
0BBA E1                         ?? E1h
0BBB 01                         ?? 01h
0BBC 41          DAT_ram_0bbc:  undefined1 41h
0BBD D0                         ?? D0h
0BBE 00                         ?? 00h
0BBF 48                         ?? 48h    H
0BC0 DD                         ?? DDh
0BC1 00                         ?? 00h
0BC2 4C                         ?? 4Ch    L
0BC3 DC                         ?? DCh
0BC4 00                         ?? 00h
0BC5 44                         ?? 44h    D
0BC6 CA                         ?? CAh
0BC7 00                         ?? 00h
0BC8 45                         ?? 45h    E
0BC9 C9                         ?? C9h
0BCA 00                         ?? 00h
0BCB 42                         ?? 42h    B
0BCC CC                         ?? CCh
0BCD 00                         ?? 00h
0BCE 43                         ?? 43h    C
0BCF CB                         ?? CBh
0BD0 00                         ?? 00h
0BD1 53                         ?? 53h    S
0BD2 D2                         ?? D2h
0BD3 01                         ?? 01h
0BD4 46                         ?? 46h    F
0BD5 CF                         ?? CFh
0BD6 00                         ?? 00h
0BD7 49                         ?? 49h    I
0BD8 CE                         ?? CEh
0BD9 00                         ?? 00h
0BDA FF                         ?? FFh

; ============================================================
; FUN_ram_0bdb
; вызовы из: 0AA6 0AD6
0BDB 23          FUN_ram_0bdb:  INX HL
0BDC 5E                         MOV E,(HL)
0BDD 3A 05 00                   LDA (0x0005)
0BE0 57                         MOV D,A
0BE1 23                         INX HL
0BE2 46                         MOV B,(HL)
0BE3 23                         INX HL
0BE4 1A                         LDAX (DE)
0BE5 CD A1 09                   CALL 0x09a1
0BE8 05                         DCR B
0BE9 F8                         RM
0BEA 1B                         DCX DE
0BEB 1A                         LDAX (DE)
0BEC C3 A1 09                   JMP 0x09a1

; ============================================================
; aux_getc
; вызовы из: 09FA 0BF3 0BFC 0C07
0BEF DB EF       aux_getc:      IN (0xef)
0BF1 E6 02                      ANI 0x2
0BF3 CA EF 0B                   JZ 0x0bef
0BF6 DB EE                      IN (0xee)
0BF8 E6 7F                      ANI 0x7f
0BFA C9                         RET

; ============================================================
; FUN_ram_0bfb
; вызовы из: 0A04 0A0B 0A0F 0A16 0A19 0A22 0A31 0A35
0BFB C5          FUN_ram_0bfb:  PUSH BC
0BFC CD EF 0B                   CALL 0x0bef
0BFF CD A7 0B                   CALL 0x0ba7
0C02 07                         RLC
0C03 07                         RLC
0C04 07                         RLC
0C05 07                         RLC
0C06 4F                         MOV C,A
0C07 CD EF 0B                   CALL 0x0bef
0C0A CD A7 0B                   CALL 0x0ba7
0C0D B1                         ORA C
0C0E 4F                         MOV C,A
0C0F 82                         ADD D
0C10 57                         MOV D,A
0C11 79                         MOV A,C
0C12 C1                         POP BC
0C13 C9                         RET

; ============================================================
; FUN_ram_0c14
; вызовы из: 0909 0920 0924 0928 0A4F 0A7B 0A7F
0C14 E3          FUN_ram_0c14:  XTHL
0C15 4E                         MOV C,(HL)
0C16 23                         INX HL
0C17 E3                         XTHL

; ============================================================
; aux_putc
; вызовы из: 0C1C 0C30 0C37
0C18 DB EF       aux_putc:      IN (0xef)
0C1A E6 01                      ANI 0x1
0C1C CA 18 0C                   JZ 0x0c18
0C1F 79                         MOV A,C
0C20 D3 EE                      OUT (0xee)
0C22 C9                         RET

; ============================================================
; FUN_ram_0c23
; вызовы из: 0913 0A64
0C23 7C          FUN_ram_0c23:  MOV A,H
0C24 CD 28 0C                   CALL 0x0c28
0C27 7D                         MOV A,L

; ============================================================
; FUN_ram_0c28
; вызовы из: 090F 0918 091D 0A61 0A68 0A6C 0A76 0C24
0C28 5F          FUN_ram_0c28:  MOV E,A
0C29 0F                         RRC
0C2A 0F                         RRC
0C2B 0F                         RRC
0C2C 0F                         RRC
0C2D CD 0F 0B                   CALL 0x0b0f
0C30 CD 18 0C                   CALL 0x0c18
0C33 7B                         MOV A,E
0C34 CD 0F 0B                   CALL 0x0b0f
0C37 CD 18 0C                   CALL 0x0c18
0C3A 7B                         MOV A,E
0C3B 82                         ADD D
0C3C 57                         MOV D,A
0C3D C9                         RET

; ============================================================
; mon_break
0C3E F3          mon_break:     DI
0C3F E5                         PUSH HL
0C40 D5                         PUSH DE
0C41 C5                         PUSH BC
0C42 F5                         PUSH AF
0C43 E1                         POP HL
0C44 F5                         PUSH AF
0C45 E5                         PUSH HL
0C46 2A 04 00                   LHLD (0x0004)
0C49 2E D3                      MVI L,0xd3
0C4B EB                         XCHG
0C4C 21 0C 00                   LXI HL,0xc
0C4F 39                         DAD HL,SP
0C50 06 05                      MVI B,0x5
0C52 EB                         XCHG
0C53 2B          LAB_ram_0c53:  DCX HL
0C54 72                         MOV (HL),D
0C55 2B                         DCX HL
0C56 73                         MOV (HL),E
0C57 D1                         POP DE
0C58 05                         DCR B
0C59 C2 53 0C                   JNZ 0x0c53
0C5C C1                         POP BC
0C5D 0B                         DCX BC
0C5E 2B                         DCX HL
0C5F 2B                         DCX HL
0C60 F9                         SPHL
0C61 2E E2                      MVI L,0xe2
0C63 7E                         MOV A,(HL)
0C64 91                         SUB C
0C65 23                         INX HL
0C66 C2 6E 0C                   JNZ 0x0c6e
0C69 7E                         MOV A,(HL)
0C6A 98                         SBB B
0C6B CA 7C 0C                   JZ 0x0c7c
0C6E 23          LAB_ram_0c6e:  INX HL
0C6F 23                         INX HL
0C70 7E                         MOV A,(HL)
0C71 91                         SUB C
0C72 23                         INX HL
0C73 C2 7B 0C                   JNZ 0x0c7b
0C76 7E                         MOV A,(HL)
0C77 98                         SBB B
0C78 CA 7C 0C                   JZ 0x0c7c
0C7B 03          LAB_ram_0c7b:  INX BC
0C7C 2A 04 00    LAB_ram_0c7c:  LHLD (0x0004)
0C7F 2E DC                      MVI L,0xdc
0C81 73                         MOV (HL),E
0C82 23                         INX HL
0C83 72                         MOV (HL),D
0C84 2E E0                      MVI L,0xe0
0C86 71                         MOV (HL),C
0C87 23                         INX HL
0C88 70                         MOV (HL),B
0C89 2A 04 00                   LHLD (0x0004)
0C8C 2E E2                      MVI L,0xe2
0C8E 16 02                      MVI D,0x2
0C90 4E          LAB_ram_0c90:  MOV C,(HL)
0C91 AF                         XRA A
0C92 77                         MOV (HL),A
0C93 23                         INX HL
0C94 46                         MOV B,(HL)
0C95 77                         MOV (HL),A
0C96 23                         INX HL
0C97 79                         MOV A,C
0C98 B0                         ORA B
0C99 CA 9E 0C                   JZ 0x0c9e
0C9C 7E                         MOV A,(HL)
0C9D 02                         STAX (BC)
0C9E 23          LAB_ram_0c9e:  INX HL
0C9F 15                         DCR D
0CA0 C2 90 0C                   JNZ 0x0c90
0CA3 C9                         RET
0CA4 FF                         ?? FFh
;   … FF …
0FC7 5F          mon_tramp_src: undefined1 5Fh
0FC8 08          DAT_ram_0fc8:  undefined1 08h
0FC9 EE                         ?? EEh
0FCA DD                         ?? DDh
0FCB CC                         ?? CCh
0FCC BB                         ?? BBh
0FCD 00                         ?? 00h
0FCE 00                         ?? 00h
0FCF FF                         ?? FFh
0FD0 AA                         ?? AAh
0FD1 60                         ?? 60h    `
0FD2 00                         ?? 00h
0FD3 D1                         ?? D1h
0FD4 C1                         ?? C1h
0FD5 F1                         ?? F1h
0FD6 00                         ?? 00h
0FD7 00                         ?? 00h
0FD8 F1                         ?? F1h
0FD9 E1                         ?? E1h
0FDA F9                         ?? F9h
0FDB 21                         ?? 21h    !
0FDC 34                         ?? 34h    4
0FDD 12                         ?? 12h
0FDE FB                         ?? FBh
0FDF C3                         ?? C3h
0FE0 15                         ?? 15h
0FE1 08                         ?? 08h
0FE2 00                         ?? 00h
0FE3 00                         ?? 00h
0FE4 00                         ?? 00h
0FE5 00                         ?? 00h
0FE6 00                         ?? 00h
0FE7 00                         ?? 00h
0FE8 C3                         ?? C3h
0FE9 15                         ?? 15h
0FEA 08                         ?? 08h
0FEB C3                         ?? C3h
0FEC 15                         ?? 15h
0FED 08                         ?? 08h
0FEE C3                         ?? C3h
0FEF 15                         ?? 15h
0FF0 08                         ?? 08h
0FF1 C3                         ?? C3h
0FF2 15                         ?? 15h
0FF3 08                         ?? 08h
0FF4 C3                         ?? C3h
0FF5 15                         ?? 15h
0FF6 08                         ?? 08h
0FF7 C3                         ?? C3h
0FF8 15                         ?? 15h
0FF9 08                         ?? 08h
0FFA C3                         ?? C3h
0FFB 70                         ?? 70h    p
0FFC 08                         ?? 08h
0FFD C3                         ?? C3h
0FFE 15                         ?? 15h
0FFF 08                         ?? 08h
