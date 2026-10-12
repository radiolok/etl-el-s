; ROM2 4000-5FFF, экспорт Ghidra
4000 21 5F 00                   LXI HL,0x5f
4003 E5                         PUSH HL
4004 3E 01                      MVI A,0x1
4006 06 FF                      MVI B,0xff
4008 0E 00                      MVI C,0x0
400A CD 5A 3D                   CALL 0x3d5a
400D E1                         POP HL
400E 11 11 00                   LXI DE,0x11
4011 06 03                      MVI B,0x3
4013 3E 01                      MVI A,0x1
4015 CD 5A 3D                   CALL 0x3d5a
4018 C9                         RET

; ============================================================
; vid_33
; вызовы из: 3CB4 3F3B
4019 3E 40       vid_33:        MVI A,0x40
401B 32 DF 02                   STA (0x02df)
401E 3A E0 01                   LDA (0x01e0)
4021 B7                         ORA A
4022 0E F3                      MVI C,0xf3
4024 3E 13                      MVI A,0x13
4026 CA 2D 40                   JZ 0x402d
4029 0E E6                      MVI C,0xe6
402B 3E 09                      MVI A,0x9
402D 32 FA 01    LAB_ram_402d:  STA (0x01fa)
4030 06 FF                      MVI B,0xff
4032 21 0F 01                   LXI HL,0x10f
4035 09                         DAD HL,BC
4036 EB                         XCHG
4037 C5          LAB_ram_4037:  PUSH BC
4038 CD 4A 40                   CALL 0x404a
403B C1                         POP BC
403C EB                         XCHG
403D 09                         DAD HL,BC
403E EB                         XCHG
403F 3A FA 01                   LDA (0x01fa)
4042 3D                         DCR A
4043 32 FA 01                   STA (0x01fa)
4046 C2 37 40                   JNZ 0x4037
4049 C9                         RET

; ============================================================
; FUN_ram_404a
; вызовы из: 4038
404A 21 5E 00    FUN_ram_404a:  LXI HL,0x5e
404D 3E 06                      MVI A,0x6

; ============================================================
; FUN_ram_404f
; вызовы из: 3FF9
404F 32 E0 02    FUN_ram_404f:  STA (0x02e0)
4052 AF                         XRA A
4053 32 E2 02                   STA (0x02e2)
4056 2F                         CMA
4057 32 E1 02                   STA (0x02e1)
405A CD 6A 4A                   CALL 0x4a6a
405D C9                         RET

; ============================================================
; vid_14
; вызовы из: 3C72 3F3E
405E 3E 01       vid_14:        MVI A,0x1
4060 32 FD 01                   STA (0x01fd)
4063 21 10 02                   LXI HL,0x210
4066 06 C0                      MVI B,0xc0
4068 CD 6E 47                   CALL 0x476e

; ============================================================
; FUN_ram_406b
; вызовы из: 40BC
406B 3A ED 01    FUN_ram_406b:  LDA (0x01ed)
406E 32 F7 01                   STA (0x01f7)
4071 3E 80                      MVI A,0x80
4073 32 DF 02    LAB_ram_4073:  STA (0x02df)
4076 01 10 02                   LXI BC,0x210
4079 11 10 01                   LXI DE,0x110
407C 3A E0 01                   LDA (0x01e0)
407F B7                         ORA A
4080 3E 80                      MVI A,0x80
4082 C2 93 40                   JNZ 0x4093
4085 3A F7 01                   LDA (0x01f7)
4088 07                         RLC
4089 07                         RLC
408A 07                         RLC
408B 2F                         CMA
408C 6F                         MOV L,A
408D 26 FF                      MVI H,0xff
408F 19                         DAD HL,DE
4090 EB                         XCHG
4091 3E 40                      MVI A,0x40
4093 CD 97 40    LAB_ram_4093:  CALL 0x4097
4096 C9                         RET

; ============================================================
; FUN_ram_4097
; вызовы из: 4093
4097 21 5C 00    FUN_ram_4097:  LXI HL,0x5c
409A 32 E0 02                   STA (0x02e0)
409D AF                         XRA A
409E 32 E1 02                   STA (0x02e1)
40A1 3E FE                      MVI A,0xfe
40A3 32 E2 02                   STA (0x02e2)
40A6 3E 80                      MVI A,0x80
40A8 CD E1 4A                   CALL 0x4ae1
40AB C9                         RET

; ============================================================
; vid_15
; вызовы из: 3C75 40B9
40AC AF          vid_15:        XRA A
40AD 32 FD 01                   STA (0x01fd)
40B0 3E 90                      MVI A,0x90
40B2 C3 73 40                   JMP 0x4073

; ============================================================
; vid_16
; вызовы из: 3C78
40B5 AF          vid_16:        XRA A
40B6 32 FD 01                   STA (0x01fd)
40B9 CD AC 40                   CALL 0x40ac
40BC C3 6B 40                   JMP 0x406b

; ============================================================
; vid_2E
; вызовы из: 3CAE 3F41
40BF 3E 40       vid_2E:        MVI A,0x40
40C1 32 DF 02                   STA (0x02df)
40C4 3A EE 01                   LDA (0x01ee)
40C7 FE 02                      CPI 0x2
40C9 3E 00                      MVI A,0x0
40CB CA D4 40                   JZ 0x40d4
40CE CD F1 40                   CALL 0x40f1
40D1 3A EE 01                   LDA (0x01ee)
40D4 21 01 41    LAB_ram_40d4:  LXI HL,0x4101
40D7 FE 01                      CPI 0x1
40D9 CA DD 40                   JZ 0x40dd
40DC 23                         INX HL
40DD 7E          LAB_ram_40dd:  MOV A,(HL)
40DE 2F                         CMA
40DF 3C                         INR A
40E0 6F                         MOV L,A
40E1 26 FF                      MVI H,0xff
40E3 11 12 01                   LXI DE,0x112
40E6 19                         DAD HL,DE
40E7 EB                         XCHG
40E8 21 57 00                   LXI HL,0x57
40EB 3E 3C                      MVI A,0x3c
40ED CD 64 4D                   CALL 0x4d64
40F0 C9                         RET

; ============================================================
; FUN_ram_40f1
; вызовы из: 40CE
40F1 11 0F 01    FUN_ram_40f1:  LXI DE,0x10f
40F4 06 FF                      MVI B,0xff
40F6 21 57 00                   LXI HL,0x57
40F9 0E 00                      MVI C,0x0
40FB 3E 01                      MVI A,0x1
40FD CD D4 3D                   CALL 0x3dd4
4100 C9                         RET
4101 4E          DAT_ram_4101:  undefined1 4Eh
4102 CF          DAT_ram_4102:  undefined1 CFh

; ============================================================
; vid_17
; вызовы из: 3C7B 4135 413E
4103 06 04       vid_17:        MVI B,0x4
4105 CD 6B 47                   CALL 0x476b

; ============================================================
; vid_19
; вызовы из: 3C81
4108 AF          vid_19:        XRA A
4109 32 DF 02    LAB_ram_4109:  STA (0x02df)
410C 3A E8 01                   LDA (0x01e8)
410F 5F                         MOV E,A
4110 3A E7 01                   LDA (0x01e7)
4113 CD DB 46                   CALL 0x46db
4116 AF                         XRA A
4117 CD C9 48                   CALL 0x48c9
411A C9                         RET

; ============================================================
; vid_18
; вызовы из: 3C7E 4120 41E4
411B 3E 10       vid_18:        MVI A,0x10
411D C3 09 41                   JMP 0x4109

; ============================================================
; vid_20
; вызовы из: 3C84
4120 CD 1B 41    vid_20:        CALL 0x411b
4123 3E 40                      MVI A,0x40
4125 32 DF 02                   STA (0x02df)
4128 3A E8 01                   LDA (0x01e8)
412B 5F                         MOV E,A
412C 3A E7 01                   LDA (0x01e7)
412F CD DB 46                   CALL 0x46db
4132 CD 5B 48                   CALL 0x485b
4135 CD 03 41                   CALL 0x4103
4138 C9                         RET

; ============================================================
; vid_21
; вызовы из: 3C87
4139 06 04       vid_21:        MVI B,0x4
413B CD 6B 47                   CALL 0x476b
413E C3 03 41                   JMP 0x4103

; ============================================================
; vid_35
; вызовы из: 3CBA
4141 21 EA 02    vid_35:        LXI HL,0x2ea
4144 11 D0 02                   LXI DE,0x2d0
4147 06 04                      MVI B,0x4
4149 CD 54 41                   CALL 0x4154
414C 21 00 03                   LXI HL,0x300
414F 11 D4 02                   LXI DE,0x2d4
4152 06 03                      MVI B,0x3

; ============================================================
; FUN_ram_4154
; вызовы из: 4149 415C
4154 1A          FUN_ram_4154:  LDAX (DE)
4155 4E                         MOV C,(HL)
4156 77                         MOV (HL),A
4157 79                         MOV A,C
4158 12                         STAX (DE)
4159 23                         INX HL
415A 13                         INX DE
415B 05                         DCR B
415C C2 54 41                   JNZ 0x4154
415F C9                         RET

; ============================================================
; vid_23
4160 21 F2 02    vid_23:        LXI HL,0x2f2
4163 06 04                      MVI B,0x4
4165 CD 6E 47                   CALL 0x476e

; ============================================================
; vid_25
; вызовы из: 3C93
4168 AF          vid_25:        XRA A
4169 32 DF 02    LAB_ram_4169:  STA (0x02df)
416C 3A EA 01                   LDA (0x01ea)
416F 5F                         MOV E,A
4170 3A E9 01                   LDA (0x01e9)
4173 CD DB 46                   CALL 0x46db
4176 AF                         XRA A
4177 CD 9A 49                   CALL 0x499a
417A C9                         RET

; ============================================================
; vid_24
; вызовы из: 3C90
417B 3E 10       vid_24:        MVI A,0x10
417D C3 69 41                   JMP 0x4169

; ============================================================
; vid_26
; вызовы из: 3C96
4180 21 EE 02    vid_26:        LXI HL,0x2ee
4183 06 04                      MVI B,0x4
4185 CD 6E 47                   CALL 0x476e

; ============================================================
; vid_28
; вызовы из: 3C9C
4188 AF          vid_28:        XRA A
4189 32 DF 02    LAB_ram_4189:  STA (0x02df)
418C 3A F0 01                   LDA (0x01f0)
418F 5F                         MOV E,A
4190 3A EF 01                   LDA (0x01ef)
4193 CD DB 46                   CALL 0x46db
4196 3E FF                      MVI A,0xff
4198 CD C9 48                   CALL 0x48c9
419B C9                         RET

; ============================================================
; vid_27
; вызовы из: 3C99
419C 3E 10       vid_27:        MVI A,0x10
419E C3 89 41                   JMP 0x4189

; ============================================================
; vid_29
; вызовы из: 3C9F
41A1 21 F6 02    vid_29:        LXI HL,0x2f6
41A4 06 04                      MVI B,0x4
41A6 CD 6E 47                   CALL 0x476e

; ============================================================
; vid_2B
; вызовы из: 3CA5
41A9 AF          vid_2B:        XRA A
41AA 32 DF 02    LAB_ram_41aa:  STA (0x02df)
41AD 3A F2 01                   LDA (0x01f2)
41B0 5F                         MOV E,A
41B1 3A F1 01                   LDA (0x01f1)
41B4 CD DB 46                   CALL 0x46db
41B7 3E FF                      MVI A,0xff
41B9 CD 9A 49                   CALL 0x499a
41BC C9                         RET

; ============================================================
; vid_2A
; вызовы из: 3CA2
41BD 3E 10       vid_2A:        MVI A,0x10
41BF C3 AA 41                   JMP 0x41aa

; ============================================================
; vid_2F
; вызовы из: 3CB1
41C2 2A F3 01    vid_2F:        LHLD (0x01f3)
41C5 22 E3 02                   SHLD (0x02e3)
41C8 CD F2 46                   CALL 0x46f2
41CB CD 16 47                   CALL 0x4716
41CE 3E 40                      MVI A,0x40
41D0 32 DF 02                   STA (0x02df)
41D3 CD 45 4D    LAB_ram_41d3:  CALL 0x4d45
41D6 3A E4 01                   LDA (0x01e4)
41D9 3D                         DCR A
41DA 32 E4 01                   STA (0x01e4)
41DD C8                         RZ
41DE CD EA 46                   CALL 0x46ea
41E1 C3 D3 41                   JMP 0x41d3

; ============================================================
; vid_22
41E4 CD 1B 41    vid_22:        CALL 0x411b
41E7 3E 40                      MVI A,0x40
41E9 32 DF 02                   STA (0x02df)
41EC 3A E8 01                   LDA (0x01e8)
41EF 5F                         MOV E,A
41F0 3A E7 01                   LDA (0x01e7)
41F3 CD DB 46                   CALL 0x46db
41F6 EB                         XCHG
41F7 01 04 00                   LXI BC,0x4
41FA 09                         DAD HL,BC
41FB EB                         XCHG
41FC 09                         DAD HL,BC
41FD 3A E5 01                   LDA (0x01e5)
4200 CD 64 4D                   CALL 0x4d64
4203 C9                         RET

; ============================================================
; vid_2C
; вызовы из: 3CA8
4204 21 08 02    vid_2C:        LXI HL,0x208
4207 06 08                      MVI B,0x8
4209 CD 6E 47                   CALL 0x476e
420C AF                         ?? AFh

; ============================================================
; FUN_ram_420d
; вызовы из: 4221
420D 32 DF 02    FUN_ram_420d:  STA (0x02df)
4210 CD F2 46                   CALL 0x46f2
4213 CD 16 47                   CALL 0x4716
4216 01 08 02                   LXI BC,0x208
4219 3E 7F                      MVI A,0x7f
421B CD 64 4D                   CALL 0x4d64
421E C9                         RET

; ============================================================
; vid_2D
; вызовы из: 3CAB
421F 3E 10       vid_2D:        MVI A,0x10
4221 C3 0D 42                   JMP 0x420d

; ============================================================
; vid_34
; вызовы из: 3CB7
4224 21 5E 01    vid_34:        LXI HL,0x15e
4227 11 0F 01                   LXI DE,0x10f
422A D5                         PUSH DE
422B 06 7F                      MVI B,0x7f
422D 3E 20                      MVI A,0x20
422F CD 5A 3D                   CALL 0x3d5a
4232 D1                         POP DE
4233 0E F8                      MVI C,0xf8
4235 06 7F                      MVI B,0x7f
4237 CD D1 3D                   CALL 0x3dd1
423A C9                         RET

; ============================================================
; vid_3E
; вызовы из: 3CCC 424C
423B 21 5A 01    vid_3E:        LXI HL,0x15a
423E 11 0F 01                   LXI DE,0x10f
4241 3E 04                      MVI A,0x4
4243 06 20                      MVI B,0x20
4245 C3 5A 3D                   JMP 0x3d5a

; ============================================================
; vid_3D
; вызовы из: 3CC9
4248 3A F5 01    vid_3D:        LDA (0x01f5)
424B B7                         ORA A
424C CA 3B 42                   JZ 0x423b
424F 3E 04                      MVI A,0x4
4251 32 05 02                   STA (0x0205)
4254 3E 20                      MVI A,0x20
4256 32 07 02                   STA (0x0207)
4259 21 C3 42                   LXI HL,0x42c3
425C 3A F5 01                   LDA (0x01f5)
425F 47                         MOV B,A
4260 CD 64 42                   CALL 0x4264
4263 C9                         RET

; ============================================================
; FUN_ram_4264
; вызовы из: 4260 426C
4264 7E          FUN_ram_4264:  MOV A,(HL)
4265 B8                         CMP B
4266 23                         INX HL
4267 CA 6F 42                   JZ 0x426f
426A 23                         INX HL
426B 23                         INX HL
426C C3 64 42                   JMP 0x4264
426F 5E          LAB_ram_426f:  MOV E,(HL)
4270 23                         INX HL
4271 56                         MOV D,(HL)
4272 D5                         PUSH DE
4273 21 5A 01                   LXI HL,0x15a
4276 11 0F 01                   LXI DE,0x10f
4279 CD 09 48                   CALL 0x4809
427C D1                         POP DE
427D E5          LAB_ram_427d:  PUSH HL
427E 3A 05 02                   LDA (0x0205)
4281 32 06 02                   STA (0x0206)
4284 1A          LAB_ram_4284:  LDAX (DE)
4285 77                         MOV (HL),A
4286 13                         INX DE
4287 2B                         DCX HL
4288 3A 06 02                   LDA (0x0206)
428B 3D                         DCR A
428C 32 06 02                   STA (0x0206)
428F C2 84 42                   JNZ 0x4284
4292 3A 07 02                   LDA (0x0207)
4295 3D                         DCR A
4296 32 07 02                   STA (0x0207)
4299 CA A4 42                   JZ 0x42a4
429C E1                         POP HL
429D 01 D3 FF                   LXI BC,0xffd3
42A0 09                         DAD HL,BC
42A1 C3 7D 42                   JMP 0x427d
42A4 E1          LAB_ram_42a4:  POP HL
42A5 C9                         RET

; ============================================================
; vid_3F
; вызовы из: 3CCF
42A6 AF          vid_3F:        XRA A
42A7 32 DF 02    LAB_ram_42a7:  STA (0x02df)
42AA CD 11 47                   CALL 0x4711
42AD CD 16 47                   CALL 0x4716
42B0 01 F0 FF                   LXI BC,0xfff0
42B3 09                         DAD HL,BC
42B4 01 D7 02                   LXI BC,0x2d7
42B7 3A E5 01                   LDA (0x01e5)
42BA CD 64 4D                   CALL 0x4d64
42BD C9                         RET

; ============================================================
; vid_picto
; вызовы из: 3CD2
42BE 3E 10       vid_picto:     MVI A,0x10
42C0 C3 A7 42                   JMP 0x42a7
42C3 01                         ?? 01h
42C4 DB                         ?? DBh
42C5 42                         ?? 42h    B
42C6 02                         ?? 02h
42C7 5B                         ?? 5Bh    [
42C8 43                         ?? 43h    C
42C9 03                         ?? 03h
42CA DB                         ?? DBh
42CB 43                         ?? 43h    C
42CC 04                         ?? 04h
42CD 5B                         ?? 5Bh    [
42CE 44                         ?? 44h    D
42CF 05                         ?? 05h
42D0 DB                         ?? DBh
42D1 44                         ?? 44h    D
42D2 06                         ?? 06h
42D3 5B                         ?? 5Bh    [
42D4 45                         ?? 45h    E
42D5 07                         ?? 07h
42D6 DB                         ?? DBh
42D7 45                         ?? 45h    E
42D8 08                         ?? 08h
42D9 5B                         ?? 5Bh    [
42DA 46                         ?? 46h    F

; Пиктограммы 1..8, по 128 байт; таблица {номер,адрес} на 0x42C3
42DB 20 00 00 …  picto_bitmaps: db[1024] 

; ============================================================
; FUN_ram_46db
; вызовы из: 4113 412F 4173 4193 41B4 41F3
46DB 4F          FUN_ram_46db:  MOV C,A
46DC 16 00                      MVI D,0x0
46DE 06 00                      MVI B,0x0
46E0 21 10 00                   LXI HL,0x10
46E3 19                         DAD HL,DE
46E4 EB                         XCHG
46E5 21 63 00                   LXI HL,0x63
46E8 09                         DAD HL,BC
46E9 C9                         RET

; ============================================================
; FUN_ram_46ea
; вызовы из: 41DE
46EA E5          FUN_ram_46ea:  PUSH HL
46EB 21 F4 FF                   LXI HL,0xfff4
46EE 19                         DAD HL,DE
46EF EB                         XCHG
46F0 E1                         POP HL
46F1 C9                         RET

; ============================================================
; FUN_ram_46f2
; вызовы из: 3CF7 3D7D 3DA7 3DF8 3EB9 3EDE 3EED 3F05 3FB3 41C8 4210
46F2 1E 0C       FUN_ram_46f2:  MVI E,0xc
46F4 E5          LAB_ram_46f4:  PUSH HL
46F5 3A E3 01                   LDA (0x01e3)
46F8 FE 16                      CPI 0x16
46FA CA 0C 47                   JZ 0x470c
46FD 3D                         DCR A
46FE 47                         MOV B,A
46FF CD 2A 47                   CALL 0x472a
4702 CD 49 47                   CALL 0x4749
4705 11 0F 01                   LXI DE,0x10f
4708 19                         DAD HL,DE
4709 EB                         XCHG
470A E1                         POP HL
470B C9                         RET
470C 11 0D 00    LAB_ram_470c:  LXI DE,0xd
470F E1                         POP HL
4710 C9                         RET

; ============================================================
; FUN_ram_4711
; вызовы из: 42AA
4711 1E 08       FUN_ram_4711:  MVI E,0x8
4713 C3 F4 46                   JMP 0x46f4

; ============================================================
; FUN_ram_4716
; вызовы из: 3D80 3DFB 3EE1 3EF0 3F08 3FB6 41CB 4213 42AD
4716 D5          FUN_ram_4716:  PUSH DE
4717 3A E2 01                   LDA (0x01e2)
471A 3D                         DCR A
471B 47                         MOV B,A
471C 1E 08                      MVI E,0x8
471E CD 2A 47                   CALL 0x472a
4721 CD 49 47                   CALL 0x4749
4724 11 6E 01                   LXI DE,0x16e
4727 19                         DAD HL,DE
4728 D1                         POP DE
4729 C9                         RET

; ============================================================
; FUN_ram_472a
; вызовы из: 3D01 46FF 471E
472A AF          FUN_ram_472a:  XRA A
472B 57                         MOV D,A
472C 67                         MOV H,A
472D 6F                         MOV L,A
472E 0E 08                      MVI C,0x8
4730 78          LAB_ram_4730:  MOV A,B
4731 0F                         RRC
4732 47                         MOV B,A
4733 D2 37 47                   JNC 0x4737
4736 19                         DAD HL,DE
4737 EB          LAB_ram_4737:  XCHG
4738 CD 41 47                   CALL 0x4741
473B EB                         XCHG
473C 0D                         DCR C
473D C2 30 47                   JNZ 0x4730
4740 C9                         RET

; ============================================================
; FUN_ram_4741
; вызовы из: 4738
4741 AF          FUN_ram_4741:  XRA A
4742 7D                         MOV A,L
4743 17                         RAL
4744 6F                         MOV L,A
4745 7C                         MOV A,H
4746 17                         RAL
4747 67                         MOV H,A
4748 C9                         RET

; ============================================================
; FUN_ram_4749
; вызовы из: 4702 4721
4749 7D          FUN_ram_4749:  MOV A,L
474A 2F                         CMA
474B 6F                         MOV L,A
474C 7C                         MOV A,H
474D 2F                         CMA
474E 67                         MOV H,A
474F 23                         INX HL
4750 C9                         RET

; ============================================================
; shr16_hl_2
4751 AF          shr16_hl_2:    XRA A
4752 7C                         MOV A,H
4753 1F                         RAR
4754 67                         MOV H,A
4755 7D                         MOV A,L
4756 1F                         RAR
4757 6F                         MOV L,A
4758 C9                         RET

; ============================================================
; FUN_ram_4759
; вызовы из: 3CE6 3D54 3DEC
4759 21 D0 02    FUN_ram_4759:  LXI HL,0x2d0
475C 06 04                      MVI B,0x4
475E CD 6E 47                   CALL 0x476e

; ============================================================
; FUN_ram_4761
4761 21 D4 02    FUN_ram_4761:  LXI HL,0x2d4
4764 06 03                      MVI B,0x3
4766 CD 6E 47                   CALL 0x476e
4769 06                         ?? 06h
476A 19                         ?? 19h

; ============================================================
; FUN_ram_476b
; вызовы из: 4105 413B
476B 21 EA 02    FUN_ram_476b:  LXI HL,0x2ea

; ============================================================
; FUN_ram_476e
; вызовы из: 4068 4165 4185 41A6 4209 475E 4766 4772
476E AF          FUN_ram_476e:  XRA A
476F 77                         MOV (HL),A
4770 23                         INX HL
4771 05                         DCR B
4772 C2 6E 47                   JNZ 0x476e
4775 C9                         RET

; ============================================================
; FUN_ram_4776
; вызовы из: 4A9D
4776 E5          FUN_ram_4776:  PUSH HL
4777 D5                         PUSH DE
4778 CD 09 48                   CALL 0x4809
477B 57                         MOV D,A
477C E5                         PUSH HL
477D C5                         PUSH BC
477E E1                         POP HL
477F C1                         POP BC
4780 7A                         MOV A,D
4781 53                         MOV D,E
4782 5F                         MOV E,A
4783 3A DF 02                   LDA (0x02df)
4786 17                         RAL
4787 DA 9D 47                   JC 0x479d
478A 17                         RAL
478B CD DB 47                   CALL 0x47db
478E DC 00 48                   CC 0x4800
4791 7B          LAB_ram_4791:  MOV A,E
4792 0F                         RRC
4793 E5                         PUSH HL
4794 C1                         POP BC
4795 D2 99 47                   JNC 0x4799
4798 03                         INX BC
4799 D1          LAB_ram_4799:  POP DE
479A E1                         POP HL
479B 37                         STC
479C C9                         RET
479D 17          LAB_ram_479d:  RAL
479E CD DB 47                   CALL 0x47db
47A1 DC 00 48                   CC 0x4800
47A4 7B                         MOV A,E
47A5 0F                         RRC
47A6 D2 AA 47                   JNC 0x47aa
47A9 23                         INX HL
47AA 5F          LAB_ram_47aa:  MOV E,A
47AB 7A                         MOV A,D
47AC 0F                         RRC
47AD D2 B1 47                   JNC 0x47b1
47B0 0B                         DCX BC
47B1 57          LAB_ram_47b1:  MOV D,A
47B2 CD BD 48                   CALL 0x48bd
47B5 7B                         MOV A,E
47B6 0F                         RRC
47B7 D2 BB 47                   JNC 0x47bb
47BA 23                         INX HL
47BB 5F          LAB_ram_47bb:  MOV E,A
47BC E5                         PUSH HL
47BD 21 2D 00                   LXI HL,0x2d
47C0 09                         DAD HL,BC
47C1 E5                         PUSH HL
47C2 C1                         POP BC
47C3 E1                         POP HL
47C4 CD BD 48                   CALL 0x48bd
47C7 7B                         MOV A,E
47C8 0F                         RRC
47C9 D2 CD 47                   JNC 0x47cd
47CC 23                         INX HL
47CD 5F          LAB_ram_47cd:  MOV E,A
47CE 7A                         MOV A,D
47CF 07                         RLC
47D0 D2 D4 47                   JNC 0x47d4
47D3 03                         INX BC
47D4 57          LAB_ram_47d4:  MOV D,A
47D5 CD BD 48                   CALL 0x48bd
47D8 C3 91 47                   JMP 0x4791

; ============================================================
; FUN_ram_47db
; вызовы из: 478B 479E 4868 4877 48B6 48C2
47DB 17          FUN_ram_47db:  RAL
47DC D8                         RC
47DD E5                         PUSH HL
47DE C5                         PUSH BC
47DF 7A                         MOV A,D
47E0 F5                         PUSH AF
47E1 56                         MOV D,(HL)
47E2 7A                         MOV A,D
47E3 A3                         ANA E
47E4 B7                         ORA A
47E5 CA EA 47                   JZ 0x47ea
47E8 3E FF                      MVI A,0xff
47EA 67          LAB_ram_47ea:  MOV H,A
47EB F1                         POP AF
47EC 57                         MOV D,A
47ED C1                         POP BC
47EE 2F                         CMA
47EF 6F                         MOV L,A
47F0 2F                         CMA
47F1 A4                         ANA H
47F2 67                         MOV H,A
47F3 0A                         LDAX (BC)
47F4 A5                         ANA L
47F5 B4                         ORA H
47F6 02                         STAX (BC)
47F7 E1                         POP HL
47F8 CD FC 47                   CALL 0x47fc
47FB C9                         RET

; ============================================================
; FUN_ram_47fc
; вызовы из: 47F8 486B 487A 48B9
47FC 7B          FUN_ram_47fc:  MOV A,E
47FD B6                         ORA (HL)
47FE 77                         MOV (HL),A
47FF C9                         RET

; ============================================================
; FUN_ram_4800
; вызовы из: 478E 47A1 48C5
4800 0A          FUN_ram_4800:  LDAX (BC)
4801 E5                         PUSH HL
4802 67                         MOV H,A
4803 7A                         MOV A,D
4804 2F                         CMA
4805 A4                         ANA H
4806 02                         STAX (BC)
4807 E1                         POP HL
4808 C9                         RET

; ============================================================
; vid_xy2addr
; Координаты HL -> адрес в видеоОЗУ: база 0xCA09, строка 45 байт (360 точек),
; блоки по 36 строк (0x654 байт). B = номер бита.
; вызовы из: 3D5D 3DD4 4279 4778 485D 4D66
4809 C5          vid_xy2addr:   PUSH BC
480A F5                         PUSH AF
480B AF                         XRA A
480C 7D                         MOV A,L
480D E6 07                      ANI 0x7
480F 47                         MOV B,A
4810 7D                         MOV A,L
4811 E6 F8                      ANI 0xf8
4813 4F                         MOV C,A
4814 7C                         MOV A,H
4815 1F                         RAR
4816 79                         MOV A,C
4817 1F                         RAR
4818 0F                         RRC
4819 0F                         RRC
481A 4F                         MOV C,A
481B C5                         PUSH BC
481C 21 09 CA                   LXI HL,0xca09
481F EB                         XCHG
4820 01 DC FF                   LXI BC,0xffdc
4823 E5          LAB_ram_4823:  PUSH HL
4824 09                         DAD HL,BC
4825 7C                         MOV A,H
4826 B7                         ORA A
4827 FA 37 48                   JM 0x4837
482A EB                         XCHG
482B C5                         PUSH BC
482C 01 54 06                   LXI BC,0x654
482F 09                         DAD HL,BC
4830 EB                         XCHG
4831 C1                         POP BC
4832 33                         INX SP
4833 33                         INX SP
4834 C3 23 48                   JMP 0x4823
4837 E1          LAB_ram_4837:  POP HL
4838 EB                         XCHG
4839 7A                         MOV A,D
483A B3                         ORA E
483B CA 46 48                   JZ 0x4846
483E 01 2D 00                   LXI BC,0x2d
4841 09          LAB_ram_4841:  DAD HL,BC
4842 1D                         DCR E
4843 C2 41 48                   JNZ 0x4841
4846 C1          LAB_ram_4846:  POP BC
4847 AF                         XRA A
4848 1E 01                      MVI E,0x1
484A B0                         ORA B
484B CA 55 48                   JZ 0x4855
484E 7B                         MOV A,E
484F 17          LAB_ram_484f:  RAL
4850 05                         DCR B
4851 C2 4F 48                   JNZ 0x484f
4854 5F                         MOV E,A
4855 AF          LAB_ram_4855:  XRA A
4856 47                         MOV B,A
4857 09                         DAD HL,BC
4858 F1                         POP AF
4859 C1                         POP BC
485A C9                         RET

; ============================================================
; FUN_ram_485b
; вызовы из: 3FC8 4132 4AA0
485B E5          FUN_ram_485b:  PUSH HL
485C D5                         PUSH DE
485D CD 09 48                   CALL 0x4809
4860 57                         MOV D,A
4861 3A DF 02                   LDA (0x02df)
4864 17                         RAL
4865 DA 77 48                   JC 0x4877
4868 CD DB 47                   CALL 0x47db
486B DC FC 47                   CC 0x47fc
486E 7A          LAB_ram_486e:  MOV A,D
486F 0F                         RRC
4870 D2 74 48                   JNC 0x4874
4873 03                         INX BC
4874 D1          LAB_ram_4874:  POP DE
4875 E1                         POP HL
4876 C9                         RET
4877 CD DB 47    LAB_ram_4877:  CALL 0x47db
487A DC FC 47                   CC 0x47fc
487D 7B                         MOV A,E
487E 0F                         RRC
487F D2 83 48                   JNC 0x4883
4882 2B                         DCX HL
4883 5F          LAB_ram_4883:  MOV E,A
4884 7A                         MOV A,D
4885 0F                         RRC
4886 D2 8A 48                   JNC 0x488a
4889 03                         INX BC
488A 57          LAB_ram_488a:  MOV D,A
488B CD B2 48                   CALL 0x48b2
488E 7A                         MOV A,D
488F 0F                         RRC
4890 D2 94 48                   JNC 0x4894
4893 03                         INX BC
4894 57          LAB_ram_4894:  MOV D,A
4895 D5                         PUSH DE
4896 11 2D 00                   LXI DE,0x2d
4899 19                         DAD HL,DE
489A D1                         POP DE
489B CD B2 48                   CALL 0x48b2
489E 7B                         MOV A,E
489F 07                         RLC
48A0 D2 A4 48                   JNC 0x48a4
48A3 23                         INX HL
48A4 5F          LAB_ram_48a4:  MOV E,A
48A5 7A                         MOV A,D
48A6 0F                         RRC
48A7 D2 AB 48                   JNC 0x48ab
48AA 03                         INX BC
48AB 57          LAB_ram_48ab:  MOV D,A
48AC CD B2 48                   CALL 0x48b2
48AF C3 6E 48                   JMP 0x486e

; ============================================================
; FUN_ram_48b2
; вызовы из: 488B 489B 48AC
48B2 3A DF 02    FUN_ram_48b2:  LDA (0x02df)
48B5 17                         RAL
48B6 CD DB 47                   CALL 0x47db
48B9 DC FC 47                   CC 0x47fc
48BC C9                         RET

; ============================================================
; FUN_ram_48bd
; вызовы из: 47B2 47C4 47D5
48BD 3A DF 02    FUN_ram_48bd:  LDA (0x02df)
48C0 17                         RAL
48C1 17                         RAL
48C2 CD DB 47                   CALL 0x47db
48C5 DC 00 48                   CC 0x4800
48C8 C9                         RET

; ============================================================
; FUN_ram_48c9
; вызовы из: 4117 4198
48C9 C5          FUN_ram_48c9:  PUSH BC
48CA E5                         PUSH HL
48CB F5                         PUSH AF
48CC D5                         PUSH DE
48CD 5F                         MOV E,A
48CE 2A EA 02                   LHLD (0x02ea)
48D1 01 00 03                   LXI BC,0x300
48D4 16 03                      MVI D,0x3
48D6 B7                         ORA A
48D7 CA E2 48                   JZ 0x48e2
48DA 2A EE 02                   LHLD (0x02ee)
48DD 01 03 03                   LXI BC,0x303
48E0 16 02                      MVI D,0x2
48E2 7A          LAB_ram_48e2:  MOV A,D
48E3 32 E0 02                   STA (0x02e0)
48E6 C5                         PUSH BC
48E7 3A DF 02                   LDA (0x02df)
48EA 32 65 03                   STA (0x0365)
48ED 7D                         MOV A,L
48EE B4                         ORA H
48EF CA 19 49                   JZ 0x4919
48F2 7B                         MOV A,E
48F3 EB                         XCHG
48F4 2A EC 02                   LHLD (0x02ec)
48F7 B7                         ORA A
48F8 CA FE 48                   JZ 0x48fe
48FB 2A F0 02                   LHLD (0x02f0)
48FE EB          LAB_ram_48fe:  XCHG
48FF 3A DF 02                   LDA (0x02df)
4902 E6 30                      ANI 0x30
4904 C2 16 49                   JNZ 0x4916
4907 3A DF 02                   LDA (0x02df)
490A E6 40                      ANI 0x40
490C 3E 20                      MVI A,0x20
490E C2 13 49                   JNZ 0x4913
4911 3E 10                      MVI A,0x10
4913 32 DF 02    LAB_ram_4913:  STA (0x02df)
4916 CD 58 49    LAB_ram_4916:  CALL 0x4958
4919 C1          LAB_ram_4919:  POP BC
491A D1                         POP DE
491B 3A 65 03                   LDA (0x0365)
491E 32 DF 02                   STA (0x02df)
4921 E6 30                      ANI 0x30
4923 CA 3A 49                   JZ 0x493a
4926 F1                         POP AF
4927 21 00 00                   LXI HL,0x0
492A B7                         ORA A
492B CA 34 49                   JZ 0x4934
492E 22 EE 02                   SHLD (0x02ee)
4931 C3 37 49                   JMP 0x4937
4934 22 EA 02    LAB_ram_4934:  SHLD (0x02ea)
4937 E1          LAB_ram_4937:  POP HL
4938 C1                         POP BC
4939 C9                         RET
493A F1          LAB_ram_493a:  POP AF
493B E1                         POP HL
493C B7                         ORA A
493D CA 4A 49                   JZ 0x494a
4940 22 EE 02                   SHLD (0x02ee)
4943 EB                         XCHG
4944 22 F0 02                   SHLD (0x02f0)
4947 C3 51 49                   JMP 0x4951
494A 22 EA 02    LAB_ram_494a:  SHLD (0x02ea)
494D EB                         XCHG
494E 22 EC 02                   SHLD (0x02ec)
4951 EB          LAB_ram_4951:  XCHG
4952 CD 58 49                   CALL 0x4958
4955 13                         INX DE
4956 C1                         POP BC
4957 C9                         RET

; ============================================================
; FUN_ram_4958
; вызовы из: 4916 4952
4958 AF          FUN_ram_4958:  XRA A
4959 32 E2 02                   STA (0x02e2)
495C 3C                         INR A
495D 32 E1 02                   STA (0x02e1)
4960 3A E0 02                   LDA (0x02e0)
4963 3C                         INR A
4964 32 E0 02                   STA (0x02e0)
4967 3E 80                      MVI A,0x80
4969 CD 6A 4A                   CALL 0x4a6a
496C F5                         PUSH AF
496D 3A E0 02                   LDA (0x02e0)
4970 3D                         DCR A
4971 32 E0 02                   STA (0x02e0)
4974 3E FF                      MVI A,0xff
4976 32 E1 02                   STA (0x02e1)
4979 F1                         POP AF
497A 2B                         DCX HL
497B CD 6A 4A                   CALL 0x4a6a
497E F5                         PUSH AF
497F AF                         XRA A
4980 32 E1 02                   STA (0x02e1)
4983 3C                         INR A
4984 32 E2 02                   STA (0x02e2)
4987 F1                         POP AF
4988 23                         INX HL
4989 13                         INX DE
498A CD 6A 4A                   CALL 0x4a6a
498D F5                         PUSH AF
498E 1B                         DCX DE
498F 1B                         DCX DE
4990 3E FF                      MVI A,0xff
4992 32 E2 02                   STA (0x02e2)
4995 F1                         POP AF
4996 CD 6A 4A                   CALL 0x4a6a
4999 C9                         RET

; ============================================================
; FUN_ram_499a
; вызовы из: 4177 41B9
499A C5          FUN_ram_499a:  PUSH BC
499B E5                         PUSH HL
499C F5                         PUSH AF
499D D5                         PUSH DE
499E 5F                         MOV E,A
499F 2A F2 02                   LHLD (0x02f2)
49A2 01 05 03                   LXI BC,0x305
49A5 16 03                      MVI D,0x3
49A7 B7                         ORA A
49A8 CA B3 49                   JZ 0x49b3
49AB 16 02                      MVI D,0x2
49AD 2A F6 02                   LHLD (0x02f6)
49B0 01 08 03                   LXI BC,0x308
49B3 7A          LAB_ram_49b3:  MOV A,D
49B4 32 E0 02                   STA (0x02e0)
49B7 C5                         PUSH BC
49B8 3A DF 02                   LDA (0x02df)
49BB 32 65 03                   STA (0x0365)
49BE 7D                         MOV A,L
49BF B4                         ORA H
49C0 CA EA 49                   JZ 0x49ea
49C3 7B                         MOV A,E
49C4 EB                         XCHG
49C5 2A F4 02                   LHLD (0x02f4)
49C8 B7                         ORA A
49C9 CA CF 49                   JZ 0x49cf
49CC 2A F8 02                   LHLD (0x02f8)
49CF EB          LAB_ram_49cf:  XCHG
49D0 3A DF 02                   LDA (0x02df)
49D3 E6 30                      ANI 0x30
49D5 C2 E7 49                   JNZ 0x49e7
49D8 3A DF 02                   LDA (0x02df)
49DB E6 40                      ANI 0x40
49DD 3E 20                      MVI A,0x20
49DF C2 E4 49                   JNZ 0x49e4
49E2 3E 10                      MVI A,0x10
49E4 32 DF 02    LAB_ram_49e4:  STA (0x02df)
49E7 CD 2A 4A    LAB_ram_49e7:  CALL 0x4a2a
49EA C1          LAB_ram_49ea:  POP BC
49EB D1                         POP DE
49EC 3A 65 03                   LDA (0x0365)
49EF 32 DF 02                   STA (0x02df)
49F2 E6 30                      ANI 0x30
49F4 CA 0B 4A                   JZ 0x4a0b
49F7 F1                         POP AF
49F8 21 00 00                   LXI HL,0x0
49FB B7                         ORA A
49FC CA 05 4A                   JZ 0x4a05
49FF 22 F6 02                   SHLD (0x02f6)
4A02 C3 08 4A                   JMP 0x4a08
4A05 22 F2 02    LAB_ram_4a05:  SHLD (0x02f2)
4A08 E1          LAB_ram_4a08:  POP HL
4A09 C1                         POP BC
4A0A C9                         RET
4A0B F1          LAB_ram_4a0b:  POP AF
4A0C E1                         POP HL
4A0D B7                         ORA A
4A0E CA 20 4A                   JZ 0x4a20
4A11 22 F6 02                   SHLD (0x02f6)
4A14 EB                         XCHG
4A15 22 F8 02                   SHLD (0x02f8)
4A18 EB          LAB_ram_4a18:  XCHG
4A19 CD 2A 4A                   CALL 0x4a2a
4A1C 2B                         DCX HL
4A1D 13                         INX DE
4A1E C1                         POP BC
4A1F C9                         RET
4A20 22 F2 02    LAB_ram_4a20:  SHLD (0x02f2)
4A23 EB                         XCHG
4A24 22 F4 02                   SHLD (0x02f4)
4A27 C3 18 4A                   JMP 0x4a18

; ============================================================
; FUN_ram_4a2a
; вызовы из: 49E7 4A19
4A2A 3E 01       FUN_ram_4a2a:  MVI A,0x1
4A2C 32 E1 02                   STA (0x02e1)
4A2F 32 E2 02                   STA (0x02e2)
4A32 3A E0 02                   LDA (0x02e0)
4A35 3C                         INR A
4A36 32 E0 02                   STA (0x02e0)
4A39 3E 80                      MVI A,0x80
4A3B CD 6A 4A                   CALL 0x4a6a
4A3E F5                         PUSH AF
4A3F 13                         INX DE
4A40 3A E0 02                   LDA (0x02e0)
4A43 3D                         DCR A
4A44 32 E0 02                   STA (0x02e0)
4A47 2B                         DCX HL
4A48 3E FF                      MVI A,0xff
4A4A 32 E1 02                   STA (0x02e1)
4A4D F1                         POP AF
4A4E CD 6A 4A                   CALL 0x4a6a
4A51 F5                         PUSH AF
4A52 1B                         DCX DE
4A53 1B                         DCX DE
4A54 3E FF                      MVI A,0xff
4A56 32 E2 02                   STA (0x02e2)
4A59 F1                         POP AF
4A5A CD 6A 4A                   CALL 0x4a6a
4A5D F5                         PUSH AF
4A5E 23                         INX HL
4A5F 23                         INX HL
4A60 3E 01                      MVI A,0x1
4A62 32 E1 02                   STA (0x02e1)
4A65 F1                         POP AF
4A66 CD 6A 4A                   CALL 0x4a6a
4A69 C9                         RET

; ============================================================
; FUN_ram_4a6a
; вызовы из: 3E2A 3E32 3E42 3E49 3F5F 3F7D 3FAA 3FAF 405A 4969 497B 498A 4996 4A3B 4A4E 4A5A 4A66 4AF0 4B13 4B17 …
4A6A E5          FUN_ram_4a6a:  PUSH HL
4A6B D5                         PUSH DE
4A6C 32 64 03                   STA (0x0364)
4A6F 22 5E 03                   SHLD (0x035e)
4A72 EB                         XCHG
4A73 22 60 03                   SHLD (0x0360)
4A76 3A E0 02                   LDA (0x02e0)
4A79 32 E7 02                   STA (0x02e7)
4A7C 3A E2 02                   LDA (0x02e2)
4A7F CD CB 4A                   CALL 0x4acb
4A82 22 5A 03                   SHLD (0x035a)
4A85 3A E1 02                   LDA (0x02e1)
4A88 CD CB 4A                   CALL 0x4acb
4A8B 22 5C 03                   SHLD (0x035c)
4A8E 2A 60 03    LAB_ram_4a8e:  LHLD (0x0360)
4A91 EB                         XCHG
4A92 2A 5E 03                   LHLD (0x035e)
4A95 3A DF 02                   LDA (0x02df)
4A98 E6 30                      ANI 0x30
4A9A 3A 64 03                   LDA (0x0364)
4A9D C4 76 47                   CNZ 0x4776
4AA0 D4 5B 48                   CNC 0x485b
4AA3 32 64 03                   STA (0x0364)
4AA6 3A E7 02                   LDA (0x02e7)
4AA9 3D                         DCR A
4AAA 32 E7 02                   STA (0x02e7)
4AAD CA C5 4A                   JZ 0x4ac5
4AB0 E5                         PUSH HL
4AB1 2A 5A 03                   LHLD (0x035a)
4AB4 19                         DAD HL,DE
4AB5 22 60 03                   SHLD (0x0360)
4AB8 E1                         POP HL
4AB9 EB                         XCHG
4ABA 2A 5C 03                   LHLD (0x035c)
4ABD 19                         DAD HL,DE
4ABE 22 5E 03                   SHLD (0x035e)
4AC1 C3 8E 4A                   JMP 0x4a8e
4AC4 C1                         ?? C1h
4AC5 3A 64 03    LAB_ram_4ac5:  LDA (0x0364)
4AC8 D1                         POP DE
4AC9 E1                         POP HL
4ACA C9                         RET

; ============================================================
; FUN_ram_4acb
; вызовы из: 4A7F 4A88
4ACB 26 00       FUN_ram_4acb:  MVI H,0x0
4ACD B7                         ORA A
4ACE F2 D3 4A                   JP 0x4ad3
4AD1 26 FF                      MVI H,0xff
4AD3 6F          LAB_ram_4ad3:  MOV L,A
4AD4 C9                         RET

; ============================================================
; FUN_ram_4ad5
; вызовы из: 4B0D 4B45 4B64
4AD5 3A DF 02    FUN_ram_4ad5:  LDA (0x02df)
4AD8 32 E9 02                   STA (0x02e9)
4ADB E6 7F                      ANI 0x7f
4ADD 32 DF 02                   STA (0x02df)
4AE0 C9                         RET

; ============================================================
; FUN_ram_4ae1
; вызовы из: 40A8
4AE1 E5          FUN_ram_4ae1:  PUSH HL
4AE2 D5                         PUSH DE
4AE3 32 E8 02                   STA (0x02e8)
4AE6 3A DF 02                   LDA (0x02df)
4AE9 17                         RAL
4AEA DA F6 4A                   JC 0x4af6
4AED 3A E8 02    LAB_ram_4aed:  LDA (0x02e8)
4AF0 CD 6A 4A                   CALL 0x4a6a
4AF3 D1          LAB_ram_4af3:  POP DE
4AF4 E1                         POP HL
4AF5 C9                         RET
4AF6 E5          LAB_ram_4af6:  PUSH HL
4AF7 3A E1 02                   LDA (0x02e1)
4AFA 67                         MOV H,A
4AFB 3A E2 02                   LDA (0x02e2)
4AFE BC                         CMP H
4AFF C2 2E 4B                   JNZ 0x4b2e
4B02 FE 01                      CPI 0x1
4B04 CA 0C 4B                   JZ 0x4b0c
4B07 FE FF                      CPI 0xff
4B09 C2 77 4B                   JNZ 0x4b77
4B0C E1          LAB_ram_4b0c:  POP HL
4B0D CD D5 4A                   CALL 0x4ad5
4B10 3A E8 02                   LDA (0x02e8)
4B13 CD 6A 4A                   CALL 0x4a6a
4B16 23                         INX HL
4B17 CD 6A 4A                   CALL 0x4a6a
4B1A 2B                         DCX HL
4B1B 2B                         DCX HL
4B1C CD 6A 4A                   CALL 0x4a6a
4B1F 32 E8 02                   STA (0x02e8)
4B22 3A E9 02    LAB_ram_4b22:  LDA (0x02e9)
4B25 32 DF 02                   STA (0x02df)
4B28 3A E8 02                   LDA (0x02e8)
4B2B C3 F3 4A                   JMP 0x4af3
4B2E B7          LAB_ram_4b2e:  ORA A
4B2F CA 58 4B                   JZ 0x4b58
4B32 7C                         MOV A,H
4B33 B7                         ORA A
4B34 C2 77 4B                   JNZ 0x4b77
4B37 3A E2 02                   LDA (0x02e2)
4B3A FE 01                      CPI 0x1
4B3C CA 44 4B                   JZ 0x4b44
4B3F FE FF                      CPI 0xff
4B41 C2 77 4B                   JNZ 0x4b77
4B44 E1          LAB_ram_4b44:  POP HL
4B45 CD D5 4A                   CALL 0x4ad5
4B48 3A E8 02                   LDA (0x02e8)
4B4B CD 6A 4A                   CALL 0x4a6a
4B4E 23                         INX HL
4B4F CD 6A 4A                   CALL 0x4a6a
4B52 32 E8 02                   STA (0x02e8)
4B55 C3 22 4B                   JMP 0x4b22
4B58 7C          LAB_ram_4b58:  MOV A,H
4B59 FE 01                      CPI 0x1
4B5B CA 63 4B                   JZ 0x4b63
4B5E FE FF                      CPI 0xff
4B60 C2 77 4B                   JNZ 0x4b77
4B63 E1          LAB_ram_4b63:  POP HL
4B64 CD D5 4A                   CALL 0x4ad5
4B67 3A E8 02                   LDA (0x02e8)
4B6A CD 6A 4A                   CALL 0x4a6a
4B6D 13                         INX DE
4B6E CD 6A 4A                   CALL 0x4a6a
4B71 32 E8 02                   STA (0x02e8)
4B74 C3 22 4B                   JMP 0x4b22
4B77 E1          LAB_ram_4b77:  POP HL
4B78 C3 ED 4A                   JMP 0x4aed

; ============================================================
; FUN_ram_4b7b
4B7B 32 67 03    FUN_ram_4b7b:  STA (0x0367)
4B7E 3A DF 02                   LDA (0x02df)
4B81 E6 30                      ANI 0x30
4B83 C2 E5 4B                   JNZ 0x4be5
4B86 01 2D 00                   LXI BC,0x2d
4B89 09          LAB_ram_4b89:  DAD HL,BC
4B8A 1B                         DCX DE
4B8B 7B                         MOV A,E
4B8C B2                         ORA D
4B8D C2 89 4B                   JNZ 0x4b89
4B90 EB                         XCHG
4B91 2A FA 02                   LHLD (0x02fa)
4B94 7D                         MOV A,L
4B95 B4                         ORA H
4B96 EB                         XCHG
4B97 01 0A 03                   LXI BC,0x30a
4B9A 22 FA 02                   SHLD (0x02fa)
4B9D CA C4 4B                   JZ 0x4bc4
4BA0 E5                         PUSH HL
4BA1 D5                         PUSH DE
4BA2 3A DF 02                   LDA (0x02df)
4BA5 E6 40                      ANI 0x40
4BA7 C4 3A 4C                   CNZ 0x4c3a
4BAA CC 11 4C                   CZ 0x4c11
4BAD D1                         POP DE
4BAE E1                         POP HL
4BAF C5                         PUSH BC
4BB0 01 80 16                   LXI BC,0x1680
4BB3 09                         DAD HL,BC
4BB4 EB                         XCHG
4BB5 09                         DAD HL,BC
4BB6 EB                         XCHG
4BB7 C1                         POP BC
4BB8 3A DF 02                   LDA (0x02df)
4BBB E6 40                      ANI 0x40
4BBD C4 3A 4C                   CNZ 0x4c3a
4BC0 CC 11 4C                   CZ 0x4c11
4BC3 C9                         RET
4BC4 3A DF 02    LAB_ram_4bc4:  LDA (0x02df)
4BC7 E6 40                      ANI 0x40
4BC9 E5                         PUSH HL
4BCA 3E FF                      MVI A,0xff
4BCC C4 2C 4C                   CNZ 0x4c2c
4BCF CC 4A 4C                   CZ 0x4c4a
4BD2 E1                         POP HL
4BD3 11 80 16                   LXI DE,0x1680
4BD6 19                         DAD HL,DE
4BD7 3A DF 02                   LDA (0x02df)
4BDA E6 40                      ANI 0x40
4BDC 3E FF                      MVI A,0xff
4BDE C4 2C 4C                   CNZ 0x4c2c
4BE1 CC 4A 4C                   CZ 0x4c4a
4BE4 C9                         RET
4BE5 2A FA 02    LAB_ram_4be5:  LHLD (0x02fa)
4BE8 01 0A 03                   LXI BC,0x30a
4BEB 11 00 00                   LXI DE,0x0
4BEE EB                         XCHG
4BEF 22 FA 02                   SHLD (0x02fa)
4BF2 EB                         XCHG
4BF3 E6 20                      ANI 0x20
4BF5 E5                         PUSH HL
4BF6 CC 5A 4C                   CZ 0x4c5a
4BF9 3E 00                      MVI A,0x0
4BFB D4 2C 4C                   CNC 0x4c2c
4BFE E1                         POP HL
4BFF 11 80 16                   LXI DE,0x1680
4C02 19                         DAD HL,DE
4C03 3A DF 02                   LDA (0x02df)
4C06 E6 20                      ANI 0x20
4C08 CC 5A 4C                   CZ 0x4c5a
4C0B 3E 00                      MVI A,0x0
4C0D D4 2C 4C                   CNC 0x4c2c
4C10 C9                         RET

; ============================================================
; FUN_ram_4c11
; вызовы из: 4BAA 4BC0
4C11 3A 67 03    FUN_ram_4c11:  LDA (0x0367)
4C14 32 E0 02                   STA (0x02e0)
4C17 0A          LAB_ram_4c17:  LDAX (BC)
4C18 12                         STAX (DE)
4C19 7E                         MOV A,(HL)
4C1A 02                         STAX (BC)
4C1B 3E FF                      MVI A,0xff
4C1D 77                         MOV (HL),A
4C1E 2B                         DCX HL
4C1F 1B                         DCX DE
4C20 03                         INX BC
4C21 3A E0 02                   LDA (0x02e0)
4C24 3D                         DCR A
4C25 32 E0 02                   STA (0x02e0)
4C28 C2 17 4C                   JNZ 0x4c17
4C2B C9                         RET

; ============================================================
; FUN_ram_4c2c
; вызовы из: 4BCC 4BDE 4BFB 4C0D
4C2C F5          FUN_ram_4c2c:  PUSH AF
4C2D 3A 67 03                   LDA (0x0367)
4C30 47                         MOV B,A
4C31 F1                         POP AF
4C32 77          LAB_ram_4c32:  MOV (HL),A
4C33 2B                         DCX HL
4C34 05                         DCR B
4C35 C2 32 4C                   JNZ 0x4c32
4C38 B7                         ORA A
4C39 C9                         RET

; ============================================================
; FUN_ram_4c3a
; вызовы из: 4BA7 4BBD
4C3A 3A 67 03    FUN_ram_4c3a:  LDA (0x0367)
4C3D 47                         MOV B,A
4C3E AF          LAB_ram_4c3e:  XRA A
4C3F 12                         STAX (DE)
4C40 2F                         CMA
4C41 77                         MOV (HL),A
4C42 1B                         DCX DE
4C43 2B                         DCX HL
4C44 05                         DCR B
4C45 C2 3E 4C                   JNZ 0x4c3e
4C48 B7                         ORA A
4C49 C9                         RET

; ============================================================
; FUN_ram_4c4a
; вызовы из: 4BCF 4BE1
4C4A 3A 67 03    FUN_ram_4c4a:  LDA (0x0367)
4C4D 57                         MOV D,A
4C4E 7E          LAB_ram_4c4e:  MOV A,(HL)
4C4F 02                         STAX (BC)
4C50 3E FF                      MVI A,0xff
4C52 77                         MOV (HL),A
4C53 2B                         DCX HL
4C54 03                         INX BC
4C55 15                         DCR D
4C56 C2 4E 4C                   JNZ 0x4c4e
4C59 C9                         RET

; ============================================================
; FUN_ram_4c5a
; вызовы из: 4BF6 4C08
4C5A 3A 67 03    FUN_ram_4c5a:  LDA (0x0367)
4C5D 57                         MOV D,A
4C5E 0A          LAB_ram_4c5e:  LDAX (BC)
4C5F 77                         MOV (HL),A
4C60 03                         INX BC
4C61 2B                         DCX HL
4C62 15                         DCR D
4C63 C2 5E 4C                   JNZ 0x4c5e
4C66 37                         STC
4C67 C9                         RET

; ============================================================
; FUN_ram_4c68
4C68 01 4A 03    FUN_ram_4c68:  LXI BC,0x34a
4C6B 3E 80                      MVI A,0x80
4C6D CD 6A 4A                   CALL 0x4a6a
4C70 F5                         PUSH AF
4C71 3A E0 02                   LDA (0x02e0)
4C74 3D                         DCR A
4C75 32 E0 02                   STA (0x02e0)
4C78 AF                         XRA A
4C79 32 E1 02                   STA (0x02e1)
4C7C 2F                         CMA
4C7D 32 E2 02                   STA (0x02e2)
4C80 F1                         POP AF
4C81 1B                         DCX DE
4C82 CD 6A 4A                   CALL 0x4a6a
4C85 D5                         PUSH DE
4C86 11 80 FF                   LXI DE,0xff80
4C89 19                         DAD HL,DE
4C8A D1                         POP DE
4C8B CD 6A 4A                   CALL 0x4a6a
4C8E F5                         PUSH AF
4C8F 3A E0 02                   LDA (0x02e0)
4C92 3C                         INR A
4C93 32 E0 02                   STA (0x02e0)
4C96 AF                         XRA A
4C97 32 E2 02                   STA (0x02e2)
4C9A 3C                         INR A
4C9B 32 E1 02                   STA (0x02e1)
4C9E F1                         POP AF
4C9F 13                         INX DE
4CA0 CD 6A 4A                   CALL 0x4a6a
4CA3 E5                         PUSH HL
4CA4 21 80 FF                   LXI HL,0xff80
4CA7 19                         DAD HL,DE
4CA8 EB                         XCHG
4CA9 E1                         POP HL
4CAA CD 6A 4A                   CALL 0x4a6a
4CAD F5                         PUSH AF
4CAE 3A E0 02                   LDA (0x02e0)
4CB1 3D                         DCR A
4CB2 32 E0 02                   STA (0x02e0)
4CB5 13                         INX DE
4CB6 AF                         XRA A
4CB7 32 E1 02                   STA (0x02e1)
4CBA 3C                         INR A
4CBB 32 E2 02                   STA (0x02e2)
4CBE F1                         POP AF
4CBF CD 6A 4A                   CALL 0x4a6a
4CC2 D5                         PUSH DE
4CC3 11 80 00                   LXI DE,0x80
4CC6 19                         DAD HL,DE
4CC7 D1                         POP DE
4CC8 CD 6A 4A                   CALL 0x4a6a
4CCB F5                         PUSH AF
4CCC 3A E0 02                   LDA (0x02e0)
4CCF 3C                         INR A
4CD0 32 E0 02                   STA (0x02e0)
4CD3 AF                         XRA A
4CD4 32 E2 02                   STA (0x02e2)
4CD7 2F                         CMA
4CD8 32 E1 02                   STA (0x02e1)
4CDB F1                         POP AF
4CDC 1B                         DCX DE
4CDD CD 6A 4A                   CALL 0x4a6a
4CE0 C9                         RET
4CE1 C5                         ?? C5h
4CE2 F5                         ?? F5h
4CE3 E5                         ?? E5h
4CE4 D5                         ?? D5h
4CE5 3A                         ?? 3Ah    :
4CE6 DF                         ?? DFh
4CE7 02                         ?? 02h
4CE8 32                         ?? 32h    2
4CE9 65                         ?? 65h    e
4CEA 03                         ?? 03h
4CEB AF                         ?? AFh
4CEC 32                         ?? 32h    2
4CED E2                         ?? E2h
4CEE 02                         ?? 02h
4CEF 2F                         ?? 2Fh    /
4CF0 32                         ?? 32h    2
4CF1 E1                         ?? E1h
4CF2 02                         ?? 02h
4CF3 3E                         ?? 3Eh    >
4CF4 05                         ?? 05h
4CF5 32                         ?? 32h    2
4CF6 E0                         ?? E0h
4CF7 02                         ?? 02h
4CF8 2A                         ?? 2Ah    *
4CF9 FC                         ?? FCh
4CFA 02                         ?? 02h
4CFB 7C                         ?? 7Ch    |
4CFC B5                         ?? B5h
4CFD CA                         ?? CAh
4CFE 34                         ?? 34h    4
4CFF 4D                         ?? 4Dh    M
4D00 3A                         ?? 3Ah    :
4D01 DF                         ?? DFh
4D02 02                         ?? 02h
4D03 E6                         ?? E6h
4D04 30                         ?? 30h    0
4D05 C2                         ?? C2h
4D06 17                         ?? 17h
4D07 4D                         ?? 4Dh    M
4D08 3A                         ?? 3Ah    :
4D09 DF                         ?? DFh
4D0A 02                         ?? 02h
4D0B E6                         ?? E6h
4D0C 40                         ?? 40h    @
4D0D 3E                         ?? 3Eh    >
4D0E 20                         ?? 20h     
4D0F C2                         ?? C2h
4D10 14                         ?? 14h
4D11 4D                         ?? 4Dh    M
4D12 3E                         ?? 3Eh    >
4D13 10                         ?? 10h
4D14 32                         ?? 32h    2
4D15 DF                         ?? DFh
4D16 02                         ?? 02h
4D17 EB                         ?? EBh
4D18 2A                         ?? 2Ah    *
4D19 FE                         ?? FEh
4D1A 02                         ?? 02h
4D1B CD                         ?? CDh
4D1C 68                         ?? 68h    h
4D1D 4C                         ?? 4Ch    L
4D1E 3A                         ?? 3Ah    :
4D1F 65                         ?? 65h    e
4D20 03                         ?? 03h
4D21 32                         ?? 32h    2
4D22 DF                         ?? DFh
4D23 02                         ?? 02h
4D24 E6                         ?? E6h
4D25 30                         ?? 30h    0
4D26 CA                         ?? CAh
4D27 34                         ?? 34h    4
4D28 4D                         ?? 4Dh    M
4D29 21                         ?? 21h    !
4D2A 00                         ?? 00h
4D2B 00                         ?? 00h
4D2C 22                         ?? 22h    "
4D2D FC                         ?? FCh
4D2E 02                         ?? 02h
4D2F D1                         ?? D1h
4D30 E1                         ?? E1h
4D31 F1                         ?? F1h
4D32 C1                         ?? C1h
4D33 C9                         ?? C9h
4D34 E1                         ?? E1h
4D35 22                         ?? 22h    "
4D36 FC                         ?? FCh
4D37 02                         ?? 02h
4D38 EB                         ?? EBh
4D39 E1                         ?? E1h
4D3A 22                         ?? 22h    "
4D3B FE                         ?? FEh
4D3C 02                         ?? 02h
4D3D E5                         ?? E5h
4D3E D5                         ?? D5h
4D3F CD                         ?? CDh
4D40 68                         ?? 68h    h
4D41 4C                         ?? 4Ch    L
4D42 C3                         ?? C3h
4D43 2F                         ?? 2Fh    /
4D44 4D                         ?? 4Dh    M

; ============================================================
; vid_text
; вызовы из: 3ECC 3EE9 41D3
4D45 E5          vid_text:      PUSH HL
4D46 E5          LAB_ram_4d46:  PUSH HL
4D47 2A E3 02                   LHLD (0x02e3)
4D4A 7E                         MOV A,(HL)
4D4B 23                         INX HL
4D4C 22 E3 02                   SHLD (0x02e3)
4D4F FE 24                      CPI 0x24
4D51 CA 61 4D                   JZ 0x4d61
4D54 E1                         POP HL
4D55 CD 64 4D                   CALL 0x4d64
4D58 D5                         PUSH DE
4D59 11 F8 FF                   LXI DE,0xfff8
4D5C 19                         DAD HL,DE
4D5D D1                         POP DE
4D5E C3 46 4D                   JMP 0x4d46
4D61 E1          LAB_ram_4d61:  POP HL
4D62 E1                         POP HL
4D63 C9                         RET

; ============================================================
; vid_char
; вызовы из: 3D18 3E00 3E6B 3E73 3E96 3EA7 3EFB 3F20 40ED 4200 421B 42BA 4D55
4D64 E5          vid_char:      PUSH HL
4D65 D5                         PUSH DE
4D66 CD 09 48                   CALL 0x4809
4D69 EB                         XCHG
4D6A CD DF 4D                   CALL 0x4ddf
4D6D 2A E5 02                   LHLD (0x02e5)
4D70 EB                         XCHG
4D71 3E 08                      MVI A,0x8
4D73 32 67 03                   STA (0x0367)
4D76 3A DF 02                   LDA (0x02df)
4D79 E6 30                      ANI 0x30
4D7B C2 A7 4D                   JNZ 0x4da7
4D7E 3A DF 02                   LDA (0x02df)
4D81 E6 40                      ANI 0x40
4D83 C2 98 4D                   JNZ 0x4d98
4D86 7E          LAB_ram_4d86:  MOV A,(HL)
4D87 02                         STAX (BC)
4D88 1A                         LDAX (DE)
4D89 CD C6 4D                   CALL 0x4dc6
4D8C 77                         MOV (HL),A
4D8D 03                         INX BC
4D8E 13                         INX DE
4D8F CD D1 4D                   CALL 0x4dd1
4D92 C2 86 4D                   JNZ 0x4d86
4D95 D1          LAB_ram_4d95:  POP DE
4D96 E1                         POP HL
4D97 C9                         RET
4D98 1A          LAB_ram_4d98:  LDAX (DE)
4D99 CD C6 4D                   CALL 0x4dc6
4D9C 77                         MOV (HL),A
4D9D 13                         INX DE
4D9E CD D1 4D                   CALL 0x4dd1
4DA1 C2 98 4D                   JNZ 0x4d98
4DA4 C3 95 4D                   JMP 0x4d95
4DA7 E6 10       LAB_ram_4da7:  ANI 0x10
4DA9 C2 BA 4D                   JNZ 0x4dba
4DAC AF          LAB_ram_4dac:  XRA A
4DAD CD C6 4D                   CALL 0x4dc6
4DB0 77                         MOV (HL),A
4DB1 CD D1 4D                   CALL 0x4dd1
4DB4 C2 AC 4D                   JNZ 0x4dac
4DB7 C3 95 4D                   JMP 0x4d95
4DBA 0A          LAB_ram_4dba:  LDAX (BC)
4DBB 77                         MOV (HL),A
4DBC 03                         INX BC
4DBD CD D1 4D                   CALL 0x4dd1
4DC0 C2 BA 4D                   JNZ 0x4dba
4DC3 C3 95 4D                   JMP 0x4d95

; ============================================================
; FUN_ram_4dc6
; вызовы из: 4D89 4D99 4DAD
4DC6 C5          FUN_ram_4dc6:  PUSH BC
4DC7 47                         MOV B,A
4DC8 3A DF 02                   LDA (0x02df)
4DCB 1F                         RAR
4DCC 78                         MOV A,B
4DCD C1                         POP BC
4DCE D0                         RNC
4DCF 2F                         CMA
4DD0 C9                         RET

; ============================================================
; FUN_ram_4dd1
; вызовы из: 4D8F 4D9E 4DB1 4DBD
4DD1 C5          FUN_ram_4dd1:  PUSH BC
4DD2 01 D3 FF                   LXI BC,0xffd3
4DD5 09                         DAD HL,BC
4DD6 C1                         POP BC
4DD7 3A 67 03                   LDA (0x0367)
4DDA 3D                         DCR A
4DDB 32 67 03                   STA (0x0367)
4DDE C9                         RET

; ============================================================
; font_ptr
; (02E5) = 0x5D91 + 8*A — адрес глифа в шрифте.
; вызовы из: 4D6A
4DDF E5          font_ptr:      PUSH HL
4DE0 D5                         PUSH DE
4DE1 16 00                      MVI D,0x0
4DE3 B7                         ORA A
4DE4 17                         RAL
4DE5 5F                         MOV E,A
4DE6 7A                         MOV A,D
4DE7 17                         RAL
4DE8 57                         MOV D,A
4DE9 7B                         MOV A,E
4DEA 17                         RAL
4DEB 5F                         MOV E,A
4DEC 7A                         MOV A,D
4DED 17                         RAL
4DEE 57                         MOV D,A
4DEF 7B                         MOV A,E
4DF0 17                         RAL
4DF1 5F                         MOV E,A
4DF2 7A                         MOV A,D
4DF3 17                         RAL
4DF4 57                         MOV D,A
4DF5 21 91 5D                   LXI HL,0x5d91
4DF8 19                         DAD HL,DE
4DF9 22 E5 02                   SHLD (0x02e5)
4DFC D1                         POP DE
4DFD E1                         POP HL
4DFE C9                         RET

; ============================================================
; bio_menu
; вызовы из: 253C
4DFF CD 3B 22    bio_menu:      CALL 0x223b
4E02 CD 6E 2E                   CALL 0x2e6e
4E05 3E 04                      MVI A,0x4
4E07 CD 13 3C                   CALL 0x3c13
4E0A 21 7B 57                   LXI HL,0x577b
4E0D 01 05 04                   LXI BC,0x405
4E10 16 08                      MVI D,0x8
4E12 CD 1D 56                   CALL 0x561d
4E15 CD 2A 4E    LAB_ram_4e15:  CALL 0x4e2a
4E18 21 05 4E                   LXI HL,0x4e05
4E1B E5                         PUSH HL
4E1C 3A 7C 03                   LDA (0x037c)
4E1F 47                         MOV B,A
4E20 21 36 4E                   LXI HL,0x4e36
4E23 CD D3 22                   CALL 0x22d3
4E26 E1                         POP HL
4E27 C3 15 4E                   JMP 0x4e15

; ============================================================
; FUN_ram_4e2a
; вызовы из: 4E15 4E2E 4E85 4FE1 52C9 5328 55AE
4E2A CD F1 20    FUN_ram_4e2a:  CALL 0x20f1
4E2D B7                         ORA A
4E2E CA 2A 4E                   JZ 0x4e2a
4E31 47                         MOV B,A
4E32 32 7C 03                   STA (0x037c)
4E35 C9                         RET
4E36 31          tbl_keys_bio_menu: db 31h
4E37 F8 52                      addr ram:52f8
4E39 32                         db 32h
4E3A A9 4F                      addr ram:4fa9
4E3C 33                         db 33h
4E3D 5B 4E                      addr ram:4e5b
4E3F 34                         db 34h
4E40 EA 51                      addr ram:51ea
4E42 35                         db 35h
4E43 CD 51                      addr ram:51cd
4E45 36                         db 36h
4E46 BE 55                      addr ram:55be
4E48 16                         db 16h
4E49 4C 4E                      addr ram:4e4c
4E4B FF                         db FFh

; ============================================================
; kbio_16
; вызовы из: 4E49
4E4C E1          kbio_16:       POP HL
4E4D AF                         XRA A
4E4E 32 6C 00                   STA (0x006c)
4E51 CD 58 2E                   CALL 0x2e58
4E54 CD DD 52                   CALL 0x52dd
4E57 CD A9 2A                   CALL 0x2aa9
4E5A C9                         RET

; ============================================================
; kbio_33
; вызовы из: 4E3D
4E5B CD 6E 2E    kbio_33:       CALL 0x2e6e
4E5E 3E 04                      MVI A,0x4
4E60 CD 13 3C                   CALL 0x3c13
4E63 21 AC 5B                   LXI HL,0x5bac
4E66 01 05 04                   LXI BC,0x405
4E69 16 0A                      MVI D,0xa
4E6B CD 1D 56                   CALL 0x561d
4E6E 01 05 0C                   LXI BC,0xc05
4E71 CD B9 4E                   CALL 0x4eb9
4E74 21 EE 58                   LXI HL,0x58ee
4E77 3A 74 03                   LDA (0x0374)
4E7A 1F                         RAR
4E7B D2 81 4E                   JNC 0x4e81
4E7E 21 2D 59                   LXI HL,0x592d
4E81 0C          LAB_ram_4e81:  INR C
4E82 CD 1D 56                   CALL 0x561d
4E85 CD 2A 4E    LAB_ram_4e85:  CALL 0x4e2a
4E88 21 6E 4E                   LXI HL,0x4e6e
4E8B E5                         PUSH HL
4E8C 3A 7C 03                   LDA (0x037c)
4E8F 47                         MOV B,A
4E90 21 9A 4E                   LXI HL,0x4e9a
4E93 CD D3 22                   CALL 0x22d3
4E96 E1                         POP HL
4E97 C3 85 4E                   JMP 0x4e85
4E9A 31          tbl_keys_bio_methods: db 31h
4E9B 25 4F                      addr ram:4f25
4E9D 32                         db 32h
4E9E 3F 4F                      addr ram:4f3f
4EA0 33                         db 33h
4EA1 4C 4F                      addr ram:4f4c
4EA3 34                         db 34h
4EA4 59 4F                      addr ram:4f59
4EA6 35                         db 35h
4EA7 66 4F                      addr ram:4f66
4EA9 36                         db 36h
4EAA 73 4F                      addr ram:4f73
4EAC 37                         db 37h
4EAD 80 4F                      addr ram:4f80
4EAF 38                         db 38h
4EB0 8D 4F                      addr ram:4f8d
4EB2 39                         db 39h
4EB3 9A 4F                      addr ram:4f9a
4EB5 16                         db 16h
4EB6 A7 4F                      addr ram:4fa7
4EB8 FF                         db FFh

; ============================================================
; FUN_ram_4eb9
; вызовы из: 4E71 52A6
4EB9 21 EE 58    FUN_ram_4eb9:  LXI HL,0x58ee
4EBC 3A 6B 03                   LDA (0x036b)
4EBF 1F                         RAR
4EC0 D2 C6 4E                   JNC 0x4ec6
4EC3 21 F7 58                   LXI HL,0x58f7
4EC6 16 01       LAB_ram_4ec6:  MVI D,0x1
4EC8 CD 1D 56                   CALL 0x561d
4ECB 21 EE 58                   LXI HL,0x58ee
4ECE 3A 6C 03                   LDA (0x036c)
4ED1 1F                         RAR
4ED2 D2 D8 4E                   JNC 0x4ed8
4ED5 21 00 59                   LXI HL,0x5900
4ED8 0C          LAB_ram_4ed8:  INR C
4ED9 CD 1D 56                   CALL 0x561d
4EDC 21 EE 58                   LXI HL,0x58ee
4EDF 3A 6D 03                   LDA (0x036d)
4EE2 1F                         RAR
4EE3 D2 E9 4E                   JNC 0x4ee9
4EE6 21 09 59                   LXI HL,0x5909
4EE9 0C          LAB_ram_4ee9:  INR C
4EEA CD 1D 56                   CALL 0x561d
4EED 21 12 59                   LXI HL,0x5912
4EF0 0C                         INR C
4EF1 CD 1D 56                   CALL 0x561d
4EF4 21 EE 58                   LXI HL,0x58ee
4EF7 3A 70 03                   LDA (0x0370)
4EFA 1F                         RAR
4EFB D2 01 4F                   JNC 0x4f01
4EFE 21 1B 59                   LXI HL,0x591b
4F01 0C          LAB_ram_4f01:  INR C
4F02 CD 1D 56                   CALL 0x561d
4F05 21 24 59                   LXI HL,0x5924
4F08 0C                         INR C
4F09 CD 1D 56                   CALL 0x561d
4F0C 21 EE 58                   LXI HL,0x58ee
4F0F 3A 72 03                   LDA (0x0372)
4F12 1F                         RAR
4F13 D2 19 4F                   JNC 0x4f19
4F16 21 24 59                   LXI HL,0x5924
4F19 0C          LAB_ram_4f19:  INR C
4F1A CD 1D 56                   CALL 0x561d
4F1D 21 12 59                   LXI HL,0x5912
4F20 0C                         INR C
4F21 CD 1D 56                   CALL 0x561d
4F24 C9                         RET

; ============================================================
; kmeth_31
; вызовы из: 4E9B
4F25 21 FE 5B    kmeth_31:      LXI HL,0x5bfe
4F28 CD AB 55                   CALL 0x55ab
4F2B 3D                         DCR A
4F2C 32 6B 03                   STA (0x036b)
4F2F 3E 10       LAB_ram_4f2f:  MVI A,0x10
4F31 32 E3 01                   STA (0x01e3)
4F34 3E 05                      MVI A,0x5
4F36 32 E4 01                   STA (0x01e4)
4F39 3E 3A                      MVI A,0x3a
4F3B CD 13 3C                   CALL 0x3c13
4F3E C9                         RET

; ============================================================
; kmeth_32
; вызовы из: 4E9E
4F3F 21 3F 5C    kmeth_32:      LXI HL,0x5c3f
4F42 CD AB 55                   CALL 0x55ab
4F45 3D                         DCR A
4F46 32 6C 03                   STA (0x036c)
4F49 C3 2F 4F                   JMP 0x4f2f

; ============================================================
; kmeth_33
; вызовы из: 4EA1
4F4C 21 6D 5C    kmeth_33:      LXI HL,0x5c6d
4F4F CD AB 55                   CALL 0x55ab
4F52 3D                         DCR A
4F53 32 6D 03                   STA (0x036d)
4F56 C3 2F 4F                   JMP 0x4f2f

; ============================================================
; kmeth_34
; вызовы из: 4EA4 4F60
4F59 21 9A 5C    kmeth_34:      LXI HL,0x5c9a
4F5C CD AB 55                   CALL 0x55ab
4F5F 1F                         RAR
4F60 D2 59 4F                   JNC 0x4f59
4F63 C3 2F 4F                   JMP 0x4f2f

; ============================================================
; kmeth_35
; вызовы из: 4EA7
4F66 21 BD 5C    kmeth_35:      LXI HL,0x5cbd
4F69 CD AB 55                   CALL 0x55ab
4F6C 3D                         DCR A
4F6D 32 70 03                   STA (0x0370)
4F70 C3 2F 4F                   JMP 0x4f2f

; ============================================================
; kmeth_36
; вызовы из: 4EAA 4F7A
4F73 21 E3 5C    kmeth_36:      LXI HL,0x5ce3
4F76 CD AB 55                   CALL 0x55ab
4F79 1F                         RAR
4F7A D2 73 4F                   JNC 0x4f73
4F7D C3 2F 4F                   JMP 0x4f2f

; ============================================================
; kmeth_37
; вызовы из: 4EAD
4F80 21 0D 5D    kmeth_37:      LXI HL,0x5d0d
4F83 CD AB 55                   CALL 0x55ab
4F86 3D                         DCR A
4F87 32 72 03                   STA (0x0372)
4F8A C3 2F 4F                   JMP 0x4f2f

; ============================================================
; kmeth_38
; вызовы из: 4EB0 4F94
4F8D 21 4E 5D    kmeth_38:      LXI HL,0x5d4e
4F90 CD AB 55                   CALL 0x55ab
4F93 1F                         RAR
4F94 D2 8D 4F                   JNC 0x4f8d
4F97 C3 2F 4F                   JMP 0x4f2f

; ============================================================
; kmeth_39
; вызовы из: 4EB3
4F9A 21 77 5D    kmeth_39:      LXI HL,0x5d77
4F9D CD AB 55                   CALL 0x55ab
4FA0 3D                         DCR A
4FA1 32 74 03                   STA (0x0374)
4FA4 C3 2F 4F                   JMP 0x4f2f

; ============================================================
; kmeth_16
; вызовы из: 4EB6 500D
4FA7 E1          kmeth_16:      POP HL
4FA8 C9                         RET

; ============================================================
; kbio_32
; вызовы из: 4E3A
4FA9 CD 6E 2E    kbio_32:       CALL 0x2e6e
4FAC 3E 04                      MVI A,0x4
4FAE CD 13 3C                   CALL 0x3c13
4FB1 AF                         XRA A
4FB2 32 7B 03                   STA (0x037b)
4FB5 21 0A 58                   LXI HL,0x580a
4FB8 01 05 04                   LXI BC,0x405
4FBB 16 0F                      MVI D,0xf
4FBD CD 1D 56                   CALL 0x561d
4FC0 CD 6B 56                   CALL 0x566b
4FC3 21 36 05                   LXI HL,0x536
4FC6 01 0A 0B                   LXI BC,0xb0a
4FC9 CD 71 56                   CALL 0x5671
4FCC 21 47 05                   LXI HL,0x547
4FCF 01 0D 0B                   LXI BC,0xb0d
4FD2 CD 71 56                   CALL 0x5671
4FD5 21 58 05                   LXI HL,0x558
4FD8 01 10 0B                   LXI BC,0xb10
4FDB CD 71 56                   CALL 0x5671
4FDE CD 77 56                   CALL 0x5677
4FE1 CD 2A 4E    LAB_ram_4fe1:  CALL 0x4e2a
4FE4 21 E1 4F                   LXI HL,0x4fe1
4FE7 E5                         PUSH HL
4FE8 3A 7C 03                   LDA (0x037c)
4FEB 47                         MOV B,A
4FEC 21 FD 4F                   LXI HL,0x4ffd
4FEF 3A 7B 03                   LDA (0x037b)
4FF2 B7                         ORA A
4FF3 CC D3 22                   CZ 0x22d3
4FF6 CD 95 50                   CALL 0x5095
4FF9 E1                         POP HL
4FFA C3 E1 4F                   JMP 0x4fe1
4FFD 31          tbl_keys_bio_protocol: db 31h
4FFE 10 50                      addr ram:5010
5000 32                         db 32h
5001 39 50                      addr ram:5039
5003 33                         db 33h
5004 65 50                      addr ram:5065
5006 34                         db 34h
5007 6D 50                      addr ram:506d
5009 35                         db 35h
500A 75 50                      addr ram:5075
500C 16                         db 16h
500D A7 4F                      addr ram:4fa7
500F FF                         db FFh

; ============================================================
; kprot_31
; вызовы из: 4FFE
5010 3E 01       kprot_31:      MVI A,0x1
5012 32 7B 03                   STA (0x037b)
5015 3E 10                      MVI A,0x10
5017 32 75 03                   STA (0x0375)
501A 32 76 03                   STA (0x0376)
501D 21 25 05                   LXI HL,0x525
5020 22 77 03                   SHLD (0x0377)
5023 3E 07                      MVI A,0x7
5025 32 E3 01                   STA (0x01e3)
5028 32 69 03                   STA (0x0369)
502B 3E 06                      MVI A,0x6
502D 32 E2 01                   STA (0x01e2)
5030 32 68 03                   STA (0x0368)
5033 3E 2C                      MVI A,0x2c
5035 CD 13 3C                   CALL 0x3c13
5038 C9                         RET

; ============================================================
; kprot_32
; вызовы из: 5001
5039 21 36 05    kprot_32:      LXI HL,0x536
503C 3E 0A                      MVI A,0xa
503E 32 E3 01    LAB_ram_503e:  STA (0x01e3)
5041 32 69 03                   STA (0x0369)
5044 22 77 03                   SHLD (0x0377)
5047 22 79 03                   SHLD (0x0379)
504A 3E 0B                      MVI A,0xb
504C 32 68 03                   STA (0x0368)
504F 32 E2 01                   STA (0x01e2)
5052 3E 02                      MVI A,0x2
5054 32 7B 03                   STA (0x037b)
5057 3E 10                      MVI A,0x10
5059 32 75 03                   STA (0x0375)
505C 32 76 03                   STA (0x0376)
505F 3E 2C                      MVI A,0x2c
5061 CD 13 3C                   CALL 0x3c13
5064 C9                         RET

; ============================================================
; kprot_33
; вызовы из: 5004
5065 21 47 05    kprot_33:      LXI HL,0x547
5068 3E 0D                      MVI A,0xd
506A C3 3E 50                   JMP 0x503e

; ============================================================
; kprot_34
; вызовы из: 5007
506D 21 58 05    kprot_34:      LXI HL,0x558
5070 3E 10                      MVI A,0x10
5072 C3 3E 50                   JMP 0x503e

; ============================================================
; kprot_35
; вызовы из: 500A
5075 3E 04       kprot_35:      MVI A,0x4
5077 32 7B 03                   STA (0x037b)
507A 3E 01                      MVI A,0x1
507C 32 75 03                   STA (0x0375)
507F 3E 12                      MVI A,0x12
5081 32 E3 01                   STA (0x01e3)
5084 32 69 03                   STA (0x0369)
5087 3E 0D                      MVI A,0xd
5089 32 E2 01                   STA (0x01e2)
508C 32 68 03                   STA (0x0368)
508F 3E 2C                      MVI A,0x2c
5091 CD 13 3C                   CALL 0x3c13
5094 C9                         RET

; ============================================================
; FUN_ram_5095
; вызовы из: 4FF6
5095 3A 7B 03    FUN_ram_5095:  LDA (0x037b)
5098 B7                         ORA A
5099 C8                         RZ
509A 78                         MOV A,B
509B FE 87                      CPI 0x87
509D CA 44 51                   JZ 0x5144
50A0 FE 16                      CPI 0x16
50A2 CA C5 51                   JZ 0x51c5
50A5 D6 30                      SUI 0x30
50A7 FA C5 51                   JM 0x51c5
50AA 3E 39                      MVI A,0x39
50AC 90                         SUB B
50AD FA C5 51                   JM 0x51c5
50B0 3A 75 03                   LDA (0x0375)
50B3 3D                         DCR A
50B4 32 75 03                   STA (0x0375)
50B7 3A 69 03                   LDA (0x0369)
50BA 32 E3 01                   STA (0x01e3)
50BD 3A 68 03                   LDA (0x0368)
50C0 32 E2 01                   STA (0x01e2)
50C3 3E 2D                      MVI A,0x2d
50C5 CD 13 3C                   CALL 0x3c13
50C8 78                         MOV A,B
50C9 32 E5 01                   STA (0x01e5)
50CC 2A 77 03                   LHLD (0x0377)
50CF 3A 7B 03                   LDA (0x037b)
50D2 FE 01                      CPI 0x1
50D4 C2 F6 50                   JNZ 0x50f6
50D7 70                         MOV (HL),B
50D8 23                         INX HL
50D9 22 77 03                   SHLD (0x0377)
50DC CD 6B 56                   CALL 0x566b
50DF 3A 68 03                   LDA (0x0368)
50E2 3C                         INR A
50E3 32 68 03                   STA (0x0368)
50E6 32 E2 01                   STA (0x01e2)
50E9 3A 75 03    LAB_ram_50e9:  LDA (0x0375)
50EC B7                         ORA A
50ED CA C0 51                   JZ 0x51c0
50F0 3E 2C                      MVI A,0x2c
50F2 CD 13 3C                   CALL 0x3c13
50F5 C9                         RET
50F6 FE 04       LAB_ram_50f6:  CPI 0x4
50F8 CA B9 51                   JZ 0x51b9
50FB 3A 68 03                   LDA (0x0368)
50FE 3C                         INR A
50FF 32 68 03                   STA (0x0368)
5102 70                         MOV (HL),B
5103 23                         INX HL
5104 22 77 03                   SHLD (0x0377)
5107 3A 75 03                   LDA (0x0375)
510A FE 0E                      CPI 0xe
510C C2 35 51                   JNZ 0x5135
510F 3E 11                      MVI A,0x11
5111 32 68 03                   STA (0x0368)
5114 3E 0A                      MVI A,0xa
5116 11 04 00    LAB_ram_5116:  LXI DE,0x4
5119 19                         DAD HL,DE
511A 22 77 03                   SHLD (0x0377)
511D 32 75 03                   STA (0x0375)
5120 2A 79 03    LAB_ram_5120:  LHLD (0x0379)
5123 06 0B                      MVI B,0xb
5125 3A 69 03                   LDA (0x0369)
5128 4F                         MOV C,A
5129 CD 71 56                   CALL 0x5671
512C 3A 68 03                   LDA (0x0368)
512F 32 E2 01                   STA (0x01e2)
5132 C3 E9 50                   JMP 0x50e9
5135 FE 08       LAB_ram_5135:  CPI 0x8
5137 C2 20 51                   JNZ 0x5120
513A 3E 17                      MVI A,0x17
513C 32 68 03                   STA (0x0368)
513F 3E 04                      MVI A,0x4
5141 C3 16 51                   JMP 0x5116
5144 3E 80       LAB_ram_5144:  MVI A,0x80
5146 CD 08 24                   CALL 0x2408
5149 3A 75 03                   LDA (0x0375)
514C 4F                         MOV C,A
514D 3A 76 03                   LDA (0x0376)
5150 B9                         CMP C
5151 C8                         RZ
5152 2A 77 03                   LHLD (0x0377)
5155 36 2A                      MVI (HL),0x2a
5157 2B                         DCX HL
5158 22 77 03                   SHLD (0x0377)
515B 3A 68 03                   LDA (0x0368)
515E 32 E2 01                   STA (0x01e2)
5161 3E 2D                      MVI A,0x2d
5163 CD 13 3C                   CALL 0x3c13
5166 3A 75 03                   LDA (0x0375)
5169 3C                         INR A
516A 32 75 03                   STA (0x0375)
516D 3A 68 03                   LDA (0x0368)
5170 3D                         DCR A
5171 32 68 03                   STA (0x0368)
5174 32 E2 01                   STA (0x01e2)
5177 3A 7B 03                   LDA (0x037b)
517A FE 01                      CPI 0x1
517C C2 8B 51                   JNZ 0x518b
517F CD 6B 56                   CALL 0x566b
5182 3A 68 03                   LDA (0x0368)
5185 32 E2 01                   STA (0x01e2)
5188 C3 E9 50                   JMP 0x50e9
518B 3A 75 03    LAB_ram_518b:  LDA (0x0375)
518E FE 05                      CPI 0x5
5190 C2 AA 51                   JNZ 0x51aa
5193 3E 12                      MVI A,0x12
5195 32 68 03                   STA (0x0368)
5198 3E 09                      MVI A,0x9
519A 2A 77 03    LAB_ram_519a:  LHLD (0x0377)
519D 11 FC FF                   LXI DE,0xfffc
51A0 19                         DAD HL,DE
51A1 22 77 03                   SHLD (0x0377)
51A4 32 75 03                   STA (0x0375)
51A7 C3 20 51                   JMP 0x5120
51AA FE 0B       LAB_ram_51aa:  CPI 0xb
51AC C2 20 51                   JNZ 0x5120
51AF 3E 0C                      MVI A,0xc
51B1 32 68 03                   STA (0x0368)
51B4 3E 0F                      MVI A,0xf
51B6 C3 9A 51                   JMP 0x519a
51B9 78          LAB_ram_51b9:  MOV A,B
51BA 32 69 05                   STA (0x0569)
51BD CD 77 56                   CALL 0x5677
51C0 AF          LAB_ram_51c0:  XRA A
51C1 32 7B 03                   STA (0x037b)
51C4 C9                         RET
51C5 3E 2D       LAB_ram_51c5:  MVI A,0x2d
51C7 CD 13 3C                   CALL 0x3c13
51CA C3 C0 51                   JMP 0x51c0

; ============================================================
; kbio_35
; вызовы из: 4E43
51CD 21 73 5B    kbio_35:       LXI HL,0x5b73
51D0 11 6A 05                   LXI DE,0x56a
51D3 CD 61 56                   CALL 0x5661
51D6 21 CA 59                   LXI HL,0x59ca
51D9 11 7D 03                   LXI DE,0x37d
51DC CD 61 56                   CALL 0x5661
51DF 21 AB 00                   LXI HL,0xab
51E2 22 ED 00                   SHLD (0x00ed)
51E5 AF                         XRA A
51E6 CD 45 30                   CALL 0x3045
51E9 C9                         RET

; ============================================================
; kbio_34
; вызовы из: 4E40
51EA CD 6E 2E    kbio_34:       CALL 0x2e6e
51ED 21 9E 03                   LXI HL,0x39e
51F0 11 25 05                   LXI DE,0x525
51F3 06 10                      MVI B,0x10
51F5 1A          LAB_ram_51f5:  LDAX (DE)
51F6 77                         MOV (HL),A
51F7 23                         INX HL
51F8 13                         INX DE
51F9 05                         DCR B
51FA C2 F5 51                   JNZ 0x51f5
51FD 21 36 05                   LXI HL,0x536
5200 01 BB 03                   LXI BC,0x3bb
5203 CD 8D 56                   CALL 0x568d
5206 21 58 05                   LXI HL,0x558
5209 01 CE 03                   LXI BC,0x3ce
520C CD 8D 56                   CALL 0x568d
520F 21 47 05                   LXI HL,0x547
5212 01 DB 03                   LXI BC,0x3db
5215 CD 8D 56                   CALL 0x568d
5218 3A 69 05                   LDA (0x0569)
521B 32 B5 03                   STA (0x03b5)
521E 21 00 00                   LXI HL,0x0
5221 22 D3 00                   SHLD (0x00d3)
5224 3A 47 05                   LDA (0x0547)
5227 FE 2A                      CPI 0x2a
5229 CA 7C 52                   JZ 0x527c
522C 3A 58 05                   LDA (0x0558)
522F FE 2A                      CPI 0x2a
5231 CA 7C 52                   JZ 0x527c
5234 21 48 05                   LXI HL,0x548
5237 06 02                      MVI B,0x2
5239 CD 65 55                   CALL 0x5565
523C 7B                         MOV A,E
523D 32 D3 00                   STA (0x00d3)
5240 21 4E 05                   LXI HL,0x54e
5243 06 02                      MVI B,0x2
5245 CD 65 55                   CALL 0x5565
5248 7B                         MOV A,E
5249 32 D4 00                   STA (0x00d4)
524C 21 56 05                   LXI HL,0x556
524F 06 04                      MVI B,0x4
5251 CD 65 55                   CALL 0x5565
5254 EB                         XCHG
5255 22 D5 00                   SHLD (0x00d5)
5258 21 59 05                   LXI HL,0x559
525B 06 02                      MVI B,0x2
525D CD 65 55                   CALL 0x5565
5260 7B                         MOV A,E
5261 32 D7 00                   STA (0x00d7)
5264 21 5F 05                   LXI HL,0x55f
5267 06 02                      MVI B,0x2
5269 CD 65 55                   CALL 0x5565
526C 7B                         MOV A,E
526D 32 D8 00                   STA (0x00d8)
5270 21 67 05                   LXI HL,0x567
5273 06 04                      MVI B,0x4
5275 CD 65 55                   CALL 0x5565
5278 EB                         XCHG
5279 22 D9 00                   SHLD (0x00d9)
527C 21 EE 03    LAB_ram_527c:  LXI HL,0x3ee
527F 22 ED 00                   SHLD (0x00ed)
5282 3E 07                      MVI A,0x7
5284 CD 45 30                   CALL 0x3045
5287 3A 74 03                   LDA (0x0374)
528A 32 F2 00                   STA (0x00f2)
528D 21 1F 05                   LXI HL,0x51f
5290 22 ED 00                   SHLD (0x00ed)
5293 3E 08                      MVI A,0x8
5295 CD 45 30                   CALL 0x3045
5298 21 7D 03                   LXI HL,0x37d
529B 01 02 04                   LXI BC,0x402
529E 16 11                      MVI D,0x11
52A0 CD 1D 56                   CALL 0x561d
52A3 01 07 0A                   LXI BC,0xa07
52A6 CD B9 4E                   CALL 0x4eb9
52A9 21 EE 58                   LXI HL,0x58ee
52AC 3A 74 03                   LDA (0x0374)
52AF 1F                         RAR
52B0 D2 B6 52                   JNC 0x52b6
52B3 21 2D 59                   LXI HL,0x592d
52B6 01 12 0A    LAB_ram_52b6:  LXI BC,0xa12
52B9 16 01                      MVI D,0x1
52BB CD 1D 56                   CALL 0x561d
52BE 01 14 04                   LXI BC,0x414
52C1 21 F4 5B                   LXI HL,0x5bf4
52C4 16 01                      MVI D,0x1
52C6 CD 1D 56                   CALL 0x561d
52C9 CD 2A 4E    LAB_ram_52c9:  CALL 0x4e2a
52CC 3A 7C 03                   LDA (0x037c)
52CF FE 16                      CPI 0x16
52D1 CA D7 52                   JZ 0x52d7
52D4 C3 C9 52                   JMP 0x52c9
52D7 3E 04       LAB_ram_52d7:  MVI A,0x4
52D9 CD 13 3C                   CALL 0x3c13
52DC C9                         RET

; ============================================================
; FUN_ram_52dd
; вызовы из: 4E54 5384 53BB 53E3 540B 5438 5460 5481 54A9 54D9
52DD 3E 04       FUN_ram_52dd:  MVI A,0x4
52DF CD 13 3C                   CALL 0x3c13
52E2 3E 10                      MVI A,0x10
52E4 32 E3 01                   STA (0x01e3)
52E7 3E 06                      MVI A,0x6
52E9 32 E4 01                   STA (0x01e4)
52EC 3E 03                      MVI A,0x3
52EE CD 13 3C                   CALL 0x3c13
52F1 CD 3B 22                   CALL 0x223b
52F4 CD 63 2D                   CALL 0x2d63
52F7 C9                         RET

; ============================================================
; kbio_31
; вызовы из: 4E37
52F8 AF          kbio_31:       XRA A
52F9 32 F3 00                   STA (0x00f3)
52FC 3E 04                      MVI A,0x4
52FE CD 13 3C                   CALL 0x3c13
5301 CD 58 2E                   CALL 0x2e58
5304 3E 06                      MVI A,0x6
5306 32 E3 01                   STA (0x01e3)
5309 3E 10                      MVI A,0x10
530B 32 E4 01                   STA (0x01e4)
530E 3E 03                      MVI A,0x3
5310 CD 13 3C                   CALL 0x3c13
5313 21 78 59                   LXI HL,0x5978
5316 22 F3 01                   SHLD (0x01f3)
5319 3E 0A                      MVI A,0xa
531B 32 E4 01                   STA (0x01e4)
531E 3E 06                      MVI A,0x6
5320 32 E3 01                   STA (0x01e3)
5323 3E 0B                      MVI A,0xb
5325 CD 13 3C                   CALL 0x3c13
5328 CD 2A 4E    LAB_ram_5328:  CALL 0x4e2a
532B 21 28 53                   LXI HL,0x5328
532E E5                         PUSH HL
532F 3A 7C 03                   LDA (0x037c)
5332 47                         MOV B,A
5333 E6 80                      ANI 0x80
5335 78                         MOV A,B
5336 C2 DA 20                   JNZ 0x20da
5339 21 43 53                   LXI HL,0x5343
533C CD D3 22                   CALL 0x22d3
533F E1                         POP HL
5340 C3 28 53                   JMP 0x5328
5343 31          tbl_keys_bio_measure: db 31h
5344 84 53                      addr ram:5384
5346 32                         db 32h
5347 BB 53                      addr ram:53bb
5349 33                         db 33h
534A E3 53                      addr ram:53e3
534C 34                         db 34h
534D 0B 54                      addr ram:540b
534F 35                         db 35h
5350 38 54                      addr ram:5438
5352 36                         db 36h
5353 60 54                      addr ram:5460
5355 37                         db 37h
5356 81 54                      addr ram:5481
5358 38                         db 38h
5359 A9 54                      addr ram:54a9
535B 16                         db 16h
535C D6 54                      addr ram:54d6
535E 39                         db 39h
535F F1 54                      addr ram:54f1
5361 15                         db 15h
5362 AC 53                      addr ram:53ac
5364 10                         db 10h
5365 76 53                      addr ram:5376
5367 12                         db 12h
5368 7D 53                      addr ram:537d
536A FF                         db FFh

; ============================================================
; FUN_ram_536b
; вызовы из: 5376 537D
536B 3A F3 00    FUN_ram_536b:  LDA (0x00f3)
536E B7                         ORA A
536F C8                         RZ
5370 FE 04                      CPI 0x4
5372 C8                         RZ
5373 FE 08                      CPI 0x8
5375 C9                         RET

; ============================================================
; kmeas_10
; вызовы из: 5365
5376 CD 6B 53    kmeas_10:      CALL 0x536b
5379 C8                         RZ
537A C3 21 24                   JMP 0x2421

; ============================================================
; kmeas_12
; вызовы из: 5368
537D CD 6B 53    kmeas_12:      CALL 0x536b
5380 C8                         RZ
5381 C3 93 24                   JMP 0x2493

; ============================================================
; kmeas_31
; вызовы из: 5344
5384 CD DD 52    kmeas_31:      CALL 0x52dd
5387 3A 6B 03                   LDA (0x036b)
538A 32 F2 00                   STA (0x00f2)
538D 21 EE 58                   LXI HL,0x58ee
5390 1F                         RAR
5391 D2 97 53                   JNC 0x5397
5394 21 F7 58                   LXI HL,0x58f7
5397 11 F4 03    LAB_ram_5397:  LXI DE,0x3f4
539A 01 36 59                   LXI BC,0x5936
539D CD 3F 55                   CALL 0x553f
53A0 21 AB 56                   LXI HL,0x56ab
53A3 22 EB 00                   SHLD (0x00eb)
53A6 3E 01                      MVI A,0x1
53A8 32 F3 00                   STA (0x00f3)
53AB C9                         RET

; ============================================================
; kmeas_15
; вызовы из: 5362
53AC 3A F3 00    kmeas_15:      LDA (0x00f3)
53AF FE 04                      CPI 0x4
53B1 CA B7 53                   JZ 0x53b7
53B4 FE 08                      CPI 0x8
53B6 C0                         RNZ
53B7 CD D1 2A    LAB_ram_53b7:  CALL 0x2ad1
53BA C9                         RET

; ============================================================
; kmeas_32
; вызовы из: 5347
53BB CD DD 52    kmeas_32:      CALL 0x52dd
53BE 3A 6C 03                   LDA (0x036c)
53C1 32 F2 00                   STA (0x00f2)
53C4 21 EE 58                   LXI HL,0x58ee
53C7 1F                         RAR
53C8 D2 CE 53                   JNC 0x53ce
53CB 21 00 59                   LXI HL,0x5900
53CE 01 3D 59    LAB_ram_53ce:  LXI BC,0x593d
53D1 11 11 04                   LXI DE,0x411
53D4 CD 3F 55                   CALL 0x553f
53D7 3E 02                      MVI A,0x2
53D9 32 F3 00                   STA (0x00f3)
53DC 21 CB 56                   LXI HL,0x56cb
53DF 22 EB 00                   SHLD (0x00eb)
53E2 C9                         RET

; ============================================================
; kmeas_33
; вызовы из: 534A
53E3 CD DD 52    kmeas_33:      CALL 0x52dd
53E6 3A 6D 03                   LDA (0x036d)
53E9 32 F2 00                   STA (0x00f2)
53EC 21 EE 58                   LXI HL,0x58ee
53EF 1F                         RAR
53F0 D2 F6 53                   JNC 0x53f6
53F3 21 09 59                   LXI HL,0x5909
53F6 01 44 59    LAB_ram_53f6:  LXI BC,0x5944
53F9 11 2E 04                   LXI DE,0x42e
53FC CD 3F 55                   CALL 0x553f
53FF 3E 03                      MVI A,0x3
5401 32 F3 00                   STA (0x00f3)
5404 21 EB 56                   LXI HL,0x56eb
5407 22 EB 00                   SHLD (0x00eb)
540A C9                         RET

; ============================================================
; kmeas_34
; вызовы из: 534D
540B CD DD 52    kmeas_34:      CALL 0x52dd
540E 3A 6F 03                   LDA (0x036f)
5411 32 F2 00                   STA (0x00f2)
5414 21 12 59                   LXI HL,0x5912
5417 01 4B 59                   LXI BC,0x594b
541A 11 4B 04                   LXI DE,0x44b
541D CD 3F 55                   CALL 0x553f
5420 21 8F 05                   LXI HL,0x58f
5423 22 F3 01                   SHLD (0x01f3)
5426 22 ED 00                   SHLD (0x00ed)
5429 3E 04                      MVI A,0x4
542B 32 F3 00                   STA (0x00f3)
542E 21 0B 57                   LXI HL,0x570b
5431 22 EB 00                   SHLD (0x00eb)
5434 CD D1 2A                   CALL 0x2ad1
5437 C9                         RET

; ============================================================
; kmeas_35
; вызовы из: 5350
5438 CD DD 52    kmeas_35:      CALL 0x52dd
543B 3A 70 03                   LDA (0x0370)
543E 32 F2 00                   STA (0x00f2)
5441 21 EE 58                   LXI HL,0x58ee
5444 1F                         RAR
5445 D2 4B 54                   JNC 0x544b
5448 21 1B 59                   LXI HL,0x591b
544B 01 52 59    LAB_ram_544b:  LXI BC,0x5952
544E 11 68 04                   LXI DE,0x468
5451 CD 3F 55                   CALL 0x553f
5454 3E 05                      MVI A,0x5
5456 32 F3 00                   STA (0x00f3)
5459 21 1B 57                   LXI HL,0x571b
545C 22 EB 00                   SHLD (0x00eb)
545F C9                         RET

; ============================================================
; kmeas_36
; вызовы из: 5353
5460 CD DD 52    kmeas_36:      CALL 0x52dd
5463 3A 71 03                   LDA (0x0371)
5466 32 F2 00                   STA (0x00f2)
5469 21 24 59                   LXI HL,0x5924
546C 01 59 59                   LXI BC,0x5959
546F 11 85 04                   LXI DE,0x485
5472 CD 3F 55                   CALL 0x553f
5475 3E 06                      MVI A,0x6
5477 32 F3 00                   STA (0x00f3)
547A 21 3B 57                   LXI HL,0x573b
547D 22 EB 00                   SHLD (0x00eb)
5480 C9                         RET

; ============================================================
; kmeas_37
; вызовы из: 5356
5481 CD DD 52    kmeas_37:      CALL 0x52dd
5484 3A 72 03                   LDA (0x0372)
5487 32 F2 00                   STA (0x00f2)
548A 21 EE 58                   LXI HL,0x58ee
548D 1F                         RAR
548E D2 94 54                   JNC 0x5494
5491 21 24 59                   LXI HL,0x5924
5494 01 60 59    LAB_ram_5494:  LXI BC,0x5960
5497 11 A2 04                   LXI DE,0x4a2
549A CD 3F 55                   CALL 0x553f
549D 21 4B 57                   LXI HL,0x574b
54A0 22 EB 00                   SHLD (0x00eb)
54A3 3E 07                      MVI A,0x7
54A5 32 F3 00                   STA (0x00f3)
54A8 C9                         RET

; ============================================================
; kmeas_38
; вызовы из: 5359
54A9 CD DD 52    kmeas_38:      CALL 0x52dd
54AC 3A 73 03                   LDA (0x0373)
54AF 32 F2 00                   STA (0x00f2)
54B2 21 12 59                   LXI HL,0x5912
54B5 01 67 59                   LXI BC,0x5967
54B8 11 BF 04                   LXI DE,0x4bf
54BB CD 3F 55                   CALL 0x553f
54BE 21 8F 05                   LXI HL,0x58f
54C1 22 ED 00                   SHLD (0x00ed)
54C4 22 F3 01                   SHLD (0x01f3)
54C7 3E 08                      MVI A,0x8
54C9 32 F3 00                   STA (0x00f3)
54CC 21 6B 57                   LXI HL,0x576b
54CF 22 EB 00                   SHLD (0x00eb)
54D2 CD D1 2A                   CALL 0x2ad1
54D5 C9                         RET

; ============================================================
; kmeas_16
; вызовы из: 535C
54D6 CD 6E 2E    kmeas_16:      CALL 0x2e6e
54D9 CD DD 52                   CALL 0x52dd
54DC 3E 05                      MVI A,0x5
54DE 32 E3 01                   STA (0x01e3)
54E1 3E 11                      MVI A,0x11
54E3 32 E4 01                   STA (0x01e4)
54E6 3E 03                      MVI A,0x3
54E8 CD 13 3C                   CALL 0x3c13
54EB AF                         XRA A
54EC 32 F3 00                   STA (0x00f3)
54EF E1                         POP HL
54F0 C9                         RET

; ============================================================
; kmeas_39
; вызовы из: 535F
54F1 3A F3 00    kmeas_39:      LDA (0x00f3)
54F4 B7                         ORA A
54F5 C8                         RZ
54F6 AF                         XRA A
54F7 32 F3 00                   STA (0x00f3)
54FA 2A F5 00                   LHLD (0x00f5)
54FD E5                         PUSH HL
54FE 11 17 00                   LXI DE,0x17
5501 19                         DAD HL,DE
5502 EB                         XCHG
5503 2A ED 00                   LHLD (0x00ed)
5506 01 04 00                   LXI BC,0x4
5509 09                         DAD HL,BC
550A 7E                         MOV A,(HL)
550B 12                         STAX (DE)
550C 13                         INX DE
550D 23                         INX HL
550E 7E                         MOV A,(HL)
550F 12                         STAX (DE)
5510 23                         INX HL
5511 13                         INX DE
5512 23                         INX HL
5513 13                         INX DE
5514 7E                         MOV A,(HL)
5515 12                         STAX (DE)
5516 E1                         POP HL
5517 11 10 00                   LXI DE,0x10
551A 19                         DAD HL,DE
551B EB                         XCHG
551C 2A ED 00                   LHLD (0x00ed)
551F 01 0D 00                   LXI BC,0xd
5522 09                         DAD HL,BC
5523 7E                         MOV A,(HL)
5524 12                         STAX (DE)
5525 23                         INX HL
5526 13                         INX DE
5527 7E                         MOV A,(HL)
5528 12                         STAX (DE)
5529 23                         INX HL
552A 13                         INX DE
552B 7E                         MOV A,(HL)
552C 12                         STAX (DE)
552D 2A F8 00                   LHLD (0x00f8)
5530 EB                         XCHG
5531 2A FA 00                   LHLD (0x00fa)
5534 06 08                      MVI B,0x8
5536 1A          LAB_ram_5536:  LDAX (DE)
5537 77                         MOV (HL),A
5538 13                         INX DE
5539 23                         INX HL
553A 05                         DCR B
553B C2 36 55                   JNZ 0x5536
553E C9                         RET

; ============================================================
; FUN_ram_553f
; вызовы из: 539D 53D4 53FC 541D 5451 5472 549A 54BB
553F D5          FUN_ram_553f:  PUSH DE
5540 C5                         PUSH BC
5541 01 10 26                   LXI BC,0x2610
5544 16 01                      MVI D,0x1
5546 CD 1D 56                   CALL 0x561d
5549 E1                         POP HL
554A 0C                         INR C
554B CD 1D 56                   CALL 0x561d
554E 21 6A 05                   LXI HL,0x56a
5551 22 ED 00                   SHLD (0x00ed)
5554 22 F3 01                   SHLD (0x01f3)
5557 E1                         POP HL
5558 22 F5 00                   SHLD (0x00f5)
555B 21 73 5B                   LXI HL,0x5b73
555E 11 6A 05                   LXI DE,0x56a
5561 CD 61 56                   CALL 0x5661
5564 C9                         RET

; ============================================================
; FUN_ram_5565
; вызовы из: 5239 5245 5251 525D 5269 5275
5565 11 00 00    FUN_ram_5565:  LXI DE,0x0
5568 7E                         MOV A,(HL)
5569 E6 0F                      ANI 0xf
556B 5F                         MOV E,A
556C 05                         DCR B
556D C8                         RZ
556E 2B                         DCX HL
556F E5                         PUSH HL
5570 7E                         MOV A,(HL)
5571 E6 0F                      ANI 0xf
5573 CA 81 55                   JZ 0x5581
5576 4F                         MOV C,A
5577 EB                         XCHG
5578 11 0A 00                   LXI DE,0xa
557B 19          LAB_ram_557b:  DAD HL,DE
557C 0D                         DCR C
557D C2 7B 55                   JNZ 0x557b
5580 EB                         XCHG
5581 E1          LAB_ram_5581:  POP HL
5582 05                         DCR B
5583 C8                         RZ
5584 2B                         DCX HL
5585 7E                         MOV A,(HL)
5586 E5                         PUSH HL
5587 E6 0F                      ANI 0xf
5589 4F                         MOV C,A
558A CA 97 55                   JZ 0x5597
558D EB                         XCHG
558E 11 64 00                   LXI DE,0x64
5591 19          LAB_ram_5591:  DAD HL,DE
5592 0D                         DCR C
5593 C2 91 55                   JNZ 0x5591
5596 EB                         XCHG
5597 E1          LAB_ram_5597:  POP HL
5598 05                         DCR B
5599 C8                         RZ
559A 2B                         DCX HL
559B 7E                         MOV A,(HL)
559C E6 0F                      ANI 0xf
559E C8                         RZ
559F 4F                         MOV C,A
55A0 EB                         XCHG
55A1 11 E8 03                   LXI DE,0x3e8
55A4 19          LAB_ram_55a4:  DAD HL,DE
55A5 0D                         DCR C
55A6 C2 A4 55                   JNZ 0x55a4
55A9 EB                         XCHG
55AA C9                         RET

; ============================================================
; FUN_ram_55ab
; вызовы из: 4F28 4F42 4F4F 4F5C 4F69 4F76 4F83 4F90 4F9D
55AB CD 07 56    FUN_ram_55ab:  CALL 0x5607
55AE CD 2A 4E    LAB_ram_55ae:  CALL 0x4e2a
55B1 3A 7C 03                   LDA (0x037c)
55B4 47                         MOV B,A
55B5 FE 31                      CPI 0x31
55B7 C8                         RZ
55B8 FE 32                      CPI 0x32
55BA C8                         RZ
55BB C3 AE 55                   JMP 0x55ae

; ============================================================
; new_patient
; вызовы из: 205D 4E46
55BE 21 CA 59    new_patient:   LXI HL,0x59ca
55C1 11 7D 03                   LXI DE,0x37d
55C4 CD 61 56                   CALL 0x5661
55C7 21 DC 58                   LXI HL,0x58dc
55CA 11 36 05                   LXI DE,0x536
55CD CD 61 56                   CALL 0x5661
55D0 21 DC 58                   LXI HL,0x58dc
55D3 CD 61 56                   CALL 0x5661
55D6 21 DC 58                   LXI HL,0x58dc
55D9 CD 61 56                   CALL 0x5661
55DC 3E 2A                      MVI A,0x2a
55DE 32 69 05                   STA (0x0569)
55E1 21 73 5B                   LXI HL,0x5b73
55E4 11 6A 05                   LXI DE,0x56a
55E7 CD 61 56                   CALL 0x5661
55EA 21 25 05                   LXI HL,0x525
55ED 3E 10                      MVI A,0x10
55EF 36 2A       LAB_ram_55ef:  MVI (HL),0x2a
55F1 23                         INX HL
55F2 3D                         DCR A
55F3 C2 EF 55                   JNZ 0x55ef
55F6 36 24                      MVI (HL),0x24
55F8 21 AB 00                   LXI HL,0xab
55FB 22 ED 00                   SHLD (0x00ed)
55FE AF                         XRA A
55FF CD 45 30                   CALL 0x3045
5602 AF                         XRA A
5603 32 7B 03                   STA (0x037b)
5606 C9                         RET

; ============================================================
; FUN_ram_5607
; вызовы из: 55AB
5607 E5          FUN_ram_5607:  PUSH HL
5608 21 32 5C                   LXI HL,0x5c32
560B 01 10 0B                   LXI BC,0xb10
560E 16 01                      MVI D,0x1
5610 CD 1D 56                   CALL 0x561d
5613 E1                         POP HL
5614 01 11 04                   LXI BC,0x411
5617 16 04                      MVI D,0x4
5619 CD 1D 56                   CALL 0x561d
561C C9                         RET

; ============================================================
; FUN_ram_561d
; вызовы из: 4E12 4E6B 4E82 4EC8 4ED9 4EEA 4EF1 4F02 4F09 4F1A 4F21 4FBD 52A0 52BB 52C6 5546 554B 5610 5619 5673
561D 22 F3 01    FUN_ram_561d:  SHLD (0x01f3)
5620 78                         MOV A,B
5621 32 E2 01                   STA (0x01e2)
5624 79                         MOV A,C
5625 32 E3 01                   STA (0x01e3)
5628 7A                         MOV A,D
5629 32 E4 01                   STA (0x01e4)
562C 3E 2F                      MVI A,0x2f
562E CD 13 3C                   CALL 0x3c13
5631 C9                         RET

; ============================================================
; FUN_ram_5632
; вызовы из: 3501 35BB 3BC7
5632 E5          FUN_ram_5632:  PUSH HL
5633 01 00 01                   LXI BC,0x100
5636 16 08                      MVI D,0x8
5638 5F                         MOV E,A
5639 7B          LAB_ram_5639:  MOV A,E
563A 1F                         RAR
563B 5F                         MOV E,A
563C D2 43 56                   JNC 0x5643
563F 79                         MOV A,C
5640 80                         ADD B
5641 27                         DAA
5642 4F                         MOV C,A
5643 15          LAB_ram_5643:  DCR D
5644 CA 4E 56                   JZ 0x564e
5647 78                         MOV A,B
5648 80                         ADD B
5649 27                         DAA
564A 47                         MOV B,A
564B C3 39 56                   JMP 0x5639
564E 79          LAB_ram_564e:  MOV A,C
564F E6 F0                      ANI 0xf0
5651 1F                         RAR
5652 1F                         RAR
5653 1F                         RAR
5654 1F                         RAR
5655 F6 30                      ORI 0x30
5657 E1                         POP HL
5658 77                         MOV (HL),A
5659 79                         MOV A,C
565A E6 0F                      ANI 0xf
565C F6 30                      ORI 0x30
565E 23                         INX HL
565F 77                         MOV (HL),A
5660 C9                         RET

; ============================================================
; FUN_ram_5661
; вызовы из: 51D3 51DC 5561 55C4 55CD 55D3 55D9 55E7 5668
5661 7E          FUN_ram_5661:  MOV A,(HL)
5662 FE FF                      CPI 0xff
5664 C8                         RZ
5665 12                         STAX (DE)
5666 23                         INX HL
5667 13                         INX DE
5668 C3 61 56                   JMP 0x5661

; ============================================================
; FUN_ram_566b
; вызовы из: 4FC0 50DC 517F
566B 21 25 05    FUN_ram_566b:  LXI HL,0x525
566E 01 07 06                   LXI BC,0x607

; ============================================================
; FUN_ram_5671
; вызовы из: 4FC9 4FD2 4FDB 5129
5671 16 01       FUN_ram_5671:  MVI D,0x1
5673 CD 1D 56                   CALL 0x561d
5676 C9                         RET

; ============================================================
; FUN_ram_5677
; вызовы из: 4FDE 51BD
5677 3E 12       FUN_ram_5677:  MVI A,0x12
5679 32 E3 01                   STA (0x01e3)
567C 3E 0D                      MVI A,0xd
567E 32 E2 01                   STA (0x01e2)
5681 3A 69 05                   LDA (0x0569)
5684 32 E5 01                   STA (0x01e5)
5687 3E 0D                      MVI A,0xd
5689 CD 13 3C                   CALL 0x3c13
568C C9                         RET

; ============================================================
; bio_load_coef
; Копирует 4 float-коэффициента выбранного метода из bio_coef.
; вызовы из: 5203 520C 5215
568D 7E          bio_load_coef: MOV A,(HL)
568E 02                         STAX (BC)
568F 23                         INX HL
5690 03                         INX BC
5691 7E                         MOV A,(HL)
5692 02                         STAX (BC)
5693 11 05 00                   LXI DE,0x5
5696 19                         DAD HL,DE
5697 03                         INX BC
5698 03                         INX BC
5699 7E                         MOV A,(HL)
569A 02                         STAX (BC)
569B 23                         INX HL
569C 03                         INX BC
569D 7E                         MOV A,(HL)
569E 02                         STAX (BC)
569F 13                         INX DE
56A0 13                         INX DE
56A1 19                         DAD HL,DE
56A2 03                         INX BC
56A3 03                         INX BC
56A4 7E                         MOV A,(HL)
56A5 02                         STAX (BC)
56A6 23                         INX HL
56A7 03                         INX BC
56A8 7E                         MOV A,(HL)
56A9 02                         STAX (BC)
56AA C9                         RET

; Коэффициенты полиномов a+b*x+c*x^2+d*x^3, 13 методов x 4 float
56AB 8B 67 8C …  bio_coef:      float[52] 
577B 20 20 20 …                 ds "       biometriq$"  ;        БИОМЕТРИЯ
578C 31 2D 69 …                 ds "1-izmereniq$"  ; 1-ИЗМЕРЕНИЯ
5798 32 2D 64 …                 ds "2-dannye w protokol$"  ; 2-ДАННЫЕ В ПРОТОКОЛ
57AC 33 2D 6D …                 ds "3-metody izmereniq$"  ; 3-МЕТОДЫ ИЗМЕРЕНИЯ
57BF 34 2D 77 …                 ds "4-wyzow protokola$"  ; 4-ВЫЗОВ ПРОТОКОЛА
57D1 35 2D 73 …                 ds "5-stiranie rezulxtatow$"  ; 5-СТИРАНИЕ РЕЗУЛЬТАТОВ
57E8 36 2D 6E …                 ds "6-nowyj pacient$"  ; 6-НОВЫЙ ПАЦИЕНТ
57F8 6E 2F 70 …                 ds "n/p-wyhod iz men`$"  ; Н/П-ВЫХОД ИЗ МЕНЮ
580A 20 20 20 …                 ds "    dannye w protokol$"  ;     ДАННЫЕ В ПРОТОКОЛ
5820 31 2D 6B …                 ds "1-kod pacienta$"  ; 1-КОД ПАЦИЕНТА
582F 24                         ?? 24h    $
5830 32 2D 64 …                 ds "2-data rovdeniq$"  ; 2-ДАТА РОЖДЕНИЯ
5840 20 20 20 …                 ds "        denx  mesqc  god$"  ;         ДЕНЬ  МЕСЯЦ  ГОД
5859 24                         ?? 24h    $
585A 33 2D 70 …                 ds "3-poslednij cikl$"  ; 3-ПОСЛЕДНИЙ ЦИКЛ
586B 20 20 20 …                 ds "        denx  mesqc  god$"  ;         ДЕНЬ  МЕСЯЦ  ГОД
5884 24                         ?? 24h    $
5885 34 2D 64 …                 ds "4-data obsledowaniq$"  ; 4-ДАТА ОБСЛЕДОВАНИЯ
5899 20 20 20 …                 ds "        denx  mesqc  god$"  ;         ДЕНЬ  МЕСЯЦ  ГОД
58B2 24                         ?? 24h    $
58B3 35 2D 7E …                 ds "5-~islo beremennostej$"  ; 5-ЧИСЛО БЕРЕМЕННОСТЕЙ
58C9 24                         ?? 24h    $
58CA 6E 2F 70 …                 ds "n/p-wyhod iz men`$"  ; Н/П-ВЫХОД ИЗ МЕНЮ
58DC 2A                         ?? 2Ah    *
58DD 2A                         ?? 2Ah    *
58DE 20                         ?? 20h     
58DF 20                         ?? 20h     
58E0 20                         ?? 20h     
58E1 20                         ?? 20h     
58E2 2A                         ?? 2Ah    *
58E3 2A                         ?? 2Ah    *
58E4 20                         ?? 20h     
58E5 20                         ?? 20h     
58E6 20                         ?? 20h     
58E7 20                         ?? 20h     
58E8 2A                         ?? 2Ah    *
58E9 2A                         ?? 2Ah    *
58EA 2A                         ?? 2Ah    *
58EB 2A                         ?? 2Ah    *
58EC 24                         ?? 24h    $
58ED FF                         ?? FFh
58EE 48 41 4E …                 ds "HANSMANN$"  ; HANSMANN
58F7 48 45 4C …                 ds "HELLMAN $"  ; HELLMAN 
5900 52 4F 42 …                 ds "ROBINSON$"  ; ROBINSON
5909 4B 55 52 …                 ds "KURTZ   $"  ; KURTZ   
5912 48 41 44 …                 ds "HADLOCK $"  ; HADLOCK 
591B 4A 45 41 …                 ds "JEANTY  $"  ; JEANTY  
5924 46 45 53 …                 ds "FESCINA $"  ; FESCINA 
592D 57 41 52 …                 ds "WARSOF  $"  ; WARSOF  
5936 20 3C 47 …                 ds " <GSD>$"  ;  <GSD>
593D 20 3C 43 …                 ds " <CRL>$"  ;  <CRL>
5944 20 3C 42 …                 ds " <BPD>$"  ;  <BPD>
594B 20 20 3C …                 ds "  <HC>$"  ;   <HC>
5952 20 20 3C …                 ds "  <FL>$"  ;   <FL>
5959 20 3C 54 …                 ds " <TBD>$"  ;  <TBD>
5960 3C 41 50 …                 ds "<APBD>$"  ; <APBD>
5967 20 20 3C …                 ds "  <AC>$"  ;   <AC>
596E 6E 2F 70 …                 ds "n/p-wyhod$"  ; Н/П-ВЫХОД
5978 20 20 31 …                 ds "  1-GSD$"  ;   1-GSD
5980 20 20 32 …                 ds "  2-CRL$"  ;   2-CRL
5988 20 20 33 …                 ds "  3-BPD$"  ;   3-BPD
5990 20 20 34 …                 ds "  4-HC$"  ;   4-HC
5997 20 20 35 …                 ds "  5-FL$"  ;   5-FL
599E 20 20 36 …                 ds "  6-TBD$"  ;   6-TBD
59A6 20 20 37 …                 ds "  7-APBD$"  ;   7-APBD
59AF 20 20 38 …                 ds "  8-AC$"  ;   8-AC
59B6 20 20 39 …                 ds "  9-prot.$"  ;   9-ПРОТ.
59C0 6E 2F 70 …                 ds "n/p-wyhod$"  ; Н/П-ВЫХОД
59CA 20 20 20 …                 ds "     MEDELKOM    SLE-101   $"  ;      MEDELKOM    SLE-101   
59E6 24                         ?? 24h    $
59E7 6B                         ?? 6Bh    k
59E8 6F                         ?? 6Fh    o
59E9 64                         ?? 64h    d
59EA 3A                         ?? 3Ah    :
59EB 20                         ?? 20h     
59EC 20                         ?? 20h     
59ED 20                         ?? 20h     
59EE 20                         ?? 20h     
59EF 20                         ?? 20h     
59F0 20                         ?? 20h     
59F1 20                         ?? 20h     
59F2 20                         ?? 20h     
59F3 20                         ?? 20h     
59F4 20                         ?? 20h     
59F5 20                         ?? 20h     
59F6 20                         ?? 20h     
59F7 20                         ?? 20h     
59F8 20                         ?? 20h     
59F9 20                         ?? 20h     
59FA 20                         ?? 20h     
59FB 20                         ?? 20h     
59FC 20                         ?? 20h     
59FD 20                         ?? 20h     
59FE 62                         ?? 62h    b
59FF 65                         ?? 65h    e
5A00 72                         ?? 72h    r
5A01 2E                         ?? 2Eh    .
5A02 20                         ?? 20h     
5A03 24                         ?? 24h    $
5A04 72                         ?? 72h    r
5A05 6F                         ?? 6Fh    o
5A06 64                         ?? 64h    d
5A07 3A                         ?? 3Ah    :
5A08 20                         ?? 20h     
5A09 20                         ?? 20h     
5A0A 2F                         ?? 2Fh    /
5A0B 20                         ?? 20h     
5A0C 20                         ?? 20h     
5A0D 2F                         ?? 2Fh    /
5A0E 20                         ?? 20h     
5A0F 20                         ?? 20h     
5A10 20                         ?? 20h     
5A11 20                         ?? 20h     
5A12 20                         ?? 20h     
5A13 20                         ?? 20h     
5A14 20                         ?? 20h     
5A15 20                         ?? 20h     
5A16 20                         ?? 20h     
5A17 64                         ?? 64h    d
5A18 2F                         ?? 2Fh    /
5A19 6F                         ?? 6Fh    o
5A1A 3A                         ?? 3Ah    :
5A1B 20                         ?? 20h     
5A1C 20                         ?? 20h     
5A1D 2F                         ?? 2Fh    /
5A1E 20                         ?? 20h     
5A1F 20                         ?? 20h     
5A20 2F                         ?? 2Fh    /
5A21 20                         ?? 20h     
5A22 20                         ?? 20h     
5A23 24                         ?? 24h    $
5A24 70                         ?? 70h    p
5A25 2F                         ?? 2Fh    /
5A26 63                         ?? 63h    c
5A27 3A                         ?? 3Ah    :
5A28 20                         ?? 20h     
5A29 20                         ?? 20h     
5A2A 2F                         ?? 2Fh    /
5A2B 20                         ?? 20h     
5A2C 20                         ?? 20h     
5A2D 2F                         ?? 2Fh    /
5A2E 20                         ?? 20h     
5A2F 20                         ?? 20h     
5A30 20                         ?? 20h     
5A31 20                         ?? 20h     
5A32 20                         ?? 20h     
5A33 20                         ?? 20h     
5A34 20                         ?? 20h     
5A35 41                         ?? 41h    A
5A36 47                         ?? 47h    G
5A37 45                         ?? 45h    E
5A38 2A                         ?? 2Ah    *
5A39 20                         ?? 20h     
5A3A 20                         ?? 20h     
5A3B 2A                         ?? 2Ah    *
5A3C 2A                         ?? 2Ah    *
5A3D 57                         ?? 57h    W
5A3E 2A                         ?? 2Ah    *
5A3F 04                         ?? 04h
5A40 24                         ?? 24h    $
5A41 47                         ?? 47h    G
5A42 53                         ?? 53h    S
5A43 44                         ?? 44h    D
5A44 20                         ?? 20h     
5A45 20                         ?? 20h     
5A46 2F                         ?? 2Fh    /
5A47 20                         ?? 20h     
5A48 20                         ?? 20h     
5A49 20                         ?? 20h     
5A4A 20                         ?? 20h     
5A4B 20                         ?? 20h     
5A4C 20                         ?? 20h     
5A4D 20                         ?? 20h     
5A4E 20                         ?? 20h     
5A4F 20                         ?? 20h     
5A50 20                         ?? 20h     
5A51 2A                         ?? 2Ah    *
5A52 2A                         ?? 2Ah    *
5A53 2A                         ?? 2Ah    *
5A54 02                         ?? 02h
5A55 02                         ?? 02h
5A56 20                         ?? 20h     
5A57 20                         ?? 20h     
5A58 2A                         ?? 2Ah    *
5A59 2A                         ?? 2Ah    *
5A5A 57                         ?? 57h    W
5A5B 2A                         ?? 2Ah    *
5A5C 04                         ?? 04h
5A5D 24                         ?? 24h    $
5A5E 43                         ?? 43h    C
5A5F 52                         ?? 52h    R
5A60 4C                         ?? 4Ch    L
5A61 20                         ?? 20h     
5A62 20                         ?? 20h     
5A63 2F                         ?? 2Fh    /
5A64 20                         ?? 20h     
5A65 20                         ?? 20h     
5A66 20                         ?? 20h     
5A67 20                         ?? 20h     
5A68 20                         ?? 20h     
5A69 20                         ?? 20h     
5A6A 20                         ?? 20h     
5A6B 20                         ?? 20h     
5A6C 20                         ?? 20h     
5A6D 20                         ?? 20h     
5A6E 2A                         ?? 2Ah    *
5A6F 2A                         ?? 2Ah    *
5A70 2A                         ?? 2Ah    *
5A71 02                         ?? 02h
5A72 02                         ?? 02h
5A73 20                         ?? 20h     
5A74 20                         ?? 20h     
5A75 2A                         ?? 2Ah    *
5A76 2A                         ?? 2Ah    *
5A77 57                         ?? 57h    W
5A78 2A                         ?? 2Ah    *
5A79 04                         ?? 04h
5A7A 24                         ?? 24h    $
5A7B 42                         ?? 42h    B
5A7C 50                         ?? 50h    P
5A7D 44                         ?? 44h    D
5A7E 20                         ?? 20h     
5A7F 20                         ?? 20h     
5A80 2F                         ?? 2Fh    /
5A81 20                         ?? 20h     
5A82 20                         ?? 20h     
5A83 20                         ?? 20h     
5A84 20                         ?? 20h     
5A85 20                         ?? 20h     
5A86 20                         ?? 20h     
5A87 20                         ?? 20h     
5A88 20                         ?? 20h     
5A89 20                         ?? 20h     
5A8A 20                         ?? 20h     
5A8B 2A                         ?? 2Ah    *
5A8C 2A                         ?? 2Ah    *
5A8D 2A                         ?? 2Ah    *
5A8E 02                         ?? 02h
5A8F 02                         ?? 02h
5A90 20                         ?? 20h     
5A91 20                         ?? 20h     
5A92 2A                         ?? 2Ah    *
5A93 2A                         ?? 2Ah    *
5A94 57                         ?? 57h    W
5A95 2A                         ?? 2Ah    *
5A96 04                         ?? 04h
5A97 24                         ?? 24h    $
5A98 48                         ?? 48h    H
5A99 43                         ?? 43h    C
5A9A 20                         ?? 20h     
5A9B 20                         ?? 20h     
5A9C 20                         ?? 20h     
5A9D 2F                         ?? 2Fh    /
5A9E 20                         ?? 20h     
5A9F 20                         ?? 20h     
5AA0 20                         ?? 20h     
5AA1 20                         ?? 20h     
5AA2 20                         ?? 20h     
5AA3 20                         ?? 20h     
5AA4 20                         ?? 20h     
5AA5 20                         ?? 20h     
5AA6 20                         ?? 20h     
5AA7 20                         ?? 20h     
5AA8 2A                         ?? 2Ah    *
5AA9 2A                         ?? 2Ah    *
5AAA 2A                         ?? 2Ah    *
5AAB 02                         ?? 02h
5AAC 02                         ?? 02h
5AAD 20                         ?? 20h     
5AAE 20                         ?? 20h     
5AAF 2A                         ?? 2Ah    *
5AB0 2A                         ?? 2Ah    *
5AB1 57                         ?? 57h    W
5AB2 2A                         ?? 2Ah    *
5AB3 04                         ?? 04h
5AB4 24                         ?? 24h    $
5AB5 46                         ?? 46h    F
5AB6 4C                         ?? 4Ch    L
5AB7 20                         ?? 20h     
5AB8 20                         ?? 20h     
5AB9 20                         ?? 20h     
5ABA 2F                         ?? 2Fh    /
5ABB 20                         ?? 20h     
5ABC 20                         ?? 20h     
5ABD 20                         ?? 20h     
5ABE 20                         ?? 20h     
5ABF 20                         ?? 20h     
5AC0 20                         ?? 20h     
5AC1 20                         ?? 20h     
5AC2 20                         ?? 20h     
5AC3 20                         ?? 20h     
5AC4 20                         ?? 20h     
5AC5 2A                         ?? 2Ah    *
5AC6 2A                         ?? 2Ah    *
5AC7 2A                         ?? 2Ah    *
5AC8 02                         ?? 02h
5AC9 02                         ?? 02h
5ACA 20                         ?? 20h     
5ACB 20                         ?? 20h     
5ACC 2A                         ?? 2Ah    *
5ACD 2A                         ?? 2Ah    *
5ACE 57                         ?? 57h    W
5ACF 2A                         ?? 2Ah    *
5AD0 04                         ?? 04h
5AD1 24                         ?? 24h    $
5AD2 54                         ?? 54h    T
5AD3 42                         ?? 42h    B
5AD4 44                         ?? 44h    D
5AD5 20                         ?? 20h     
5AD6 20                         ?? 20h     
5AD7 2F                         ?? 2Fh    /
5AD8 20                         ?? 20h     
5AD9 20                         ?? 20h     
5ADA 20                         ?? 20h     
5ADB 20                         ?? 20h     
5ADC 20                         ?? 20h     
5ADD 20                         ?? 20h     
5ADE 20                         ?? 20h     
5ADF 20                         ?? 20h     
5AE0 20                         ?? 20h     
5AE1 20                         ?? 20h     
5AE2 2A                         ?? 2Ah    *
5AE3 2A                         ?? 2Ah    *
5AE4 2A                         ?? 2Ah    *
5AE5 02                         ?? 02h
5AE6 02                         ?? 02h
5AE7 20                         ?? 20h     
5AE8 20                         ?? 20h     
5AE9 2A                         ?? 2Ah    *
5AEA 2A                         ?? 2Ah    *
5AEB 57                         ?? 57h    W
5AEC 2A                         ?? 2Ah    *
5AED 04                         ?? 04h
5AEE 24                         ?? 24h    $
5AEF 41                         ?? 41h    A
5AF0 50                         ?? 50h    P
5AF1 42                         ?? 42h    B
5AF2 44                         ?? 44h    D
5AF3 20                         ?? 20h     
5AF4 2F                         ?? 2Fh    /
5AF5 20                         ?? 20h     
5AF6 20                         ?? 20h     
5AF7 20                         ?? 20h     
5AF8 20                         ?? 20h     
5AF9 20                         ?? 20h     
5AFA 20                         ?? 20h     
5AFB 20                         ?? 20h     
5AFC 20                         ?? 20h     
5AFD 20                         ?? 20h     
5AFE 20                         ?? 20h     
5AFF 2A                         ?? 2Ah    *
5B00 2A                         ?? 2Ah    *
5B01 2A                         ?? 2Ah    *
5B02 02                         ?? 02h
5B03 02                         ?? 02h
5B04 20                         ?? 20h     
5B05 20                         ?? 20h     
5B06 2A                         ?? 2Ah    *
5B07 2A                         ?? 2Ah    *
5B08 57                         ?? 57h    W
5B09 2A                         ?? 2Ah    *
5B0A 04                         ?? 04h
5B0B 24                         ?? 24h    $
5B0C 41                         ?? 41h    A
5B0D 43                         ?? 43h    C
5B0E 20                         ?? 20h     
5B0F 20                         ?? 20h     
5B10 20                         ?? 20h     
5B11 2F                         ?? 2Fh    /
5B12 20                         ?? 20h     
5B13 20                         ?? 20h     
5B14 20                         ?? 20h     
5B15 20                         ?? 20h     
5B16 20                         ?? 20h     
5B17 20                         ?? 20h     
5B18 20                         ?? 20h     
5B19 20                         ?? 20h     
5B1A 20                         ?? 20h     
5B1B 20                         ?? 20h     
5B1C 2A                         ?? 2Ah    *
5B1D 2A                         ?? 2Ah    *
5B1E 2A                         ?? 2Ah    *
5B1F 02                         ?? 02h
5B20 02                         ?? 02h
5B21 20                         ?? 20h     
5B22 20                         ?? 20h     
5B23 2A                         ?? 2Ah    *
5B24 2A                         ?? 2Ah    *
5B25 57                         ?? 57h    W
5B26 2A                         ?? 2Ah    *
5B27 04                         ?? 04h
5B28 24                         ?? 24h    $
5B29 43                         ?? 43h    C
5B2A 4F                         ?? 4Fh    O
5B2B 4D                         ?? 4Dh    M
5B2C 50                         ?? 50h    P
5B2D 4F                         ?? 4Fh    O
5B2E 53                         ?? 53h    S
5B2F 49                         ?? 49h    I
5B30 54                         ?? 54h    T
5B31 45                         ?? 45h    E
5B32 3A                         ?? 3Ah    :
5B33 20                         ?? 20h     
5B34 20                         ?? 20h     
5B35 20                         ?? 20h     
5B36 20                         ?? 20h     
5B37 20                         ?? 20h     
5B38 20                         ?? 20h     
5B39 20                         ?? 20h     
5B3A 41                         ?? 41h    A
5B3B 47                         ?? 47h    G
5B3C 45                         ?? 45h    E
5B3D 20                         ?? 20h     
5B3E 20                         ?? 20h     
5B3F 2A                         ?? 2Ah    *
5B40 2A                         ?? 2Ah    *
5B41 57                         ?? 57h    W
5B42 2A                         ?? 2Ah    *
5B43 04                         ?? 04h
5B44 24                         ?? 24h    $
5B45 48 43 2F …                 ds "HC/AC  *.**$"  ; HC/AC  *.**
5B51 46 4C 2F …                 ds "FL/AC  *.**$"  ; FL/AC  *.**
5B5D 45                         ?? 45h    E
5B5E 46                         ?? 46h    F
5B5F 42                         ?? 42h    B
5B60 57                         ?? 57h    W
5B61 20                         ?? 20h     
5B62 2F                         ?? 2Fh    /
5B63 20                         ?? 20h     
5B64 20                         ?? 20h     
5B65 20                         ?? 20h     
5B66 20                         ?? 20h     
5B67 20                         ?? 20h     
5B68 20                         ?? 20h     
5B69 20                         ?? 20h     
5B6A 20                         ?? 20h     
5B6B 20                         ?? 20h     
5B6C 2A                         ?? 2Ah    *
5B6D 2A                         ?? 2Ah    *
5B6E 2A                         ?? 2Ah    *
5B6F 2A                         ?? 2Ah    *
5B70 1A                         ?? 1Ah
5B71 24                         ?? 24h    $
5B72 FF                         ?? FFh
5B73 41                         ?? 41h    A
5B74 47                         ?? 47h    G
5B75 45                         ?? 45h    E
5B76 3D                         ?? 3Dh    =
5B77 2A                         ?? 2Ah    *
5B78 2A                         ?? 2Ah    *
5B79 57                         ?? 57h    W
5B7A 2A                         ?? 2Ah    *
5B7B 04                         ?? 04h
5B7C 24                         ?? 24h    $
5B7D 20                         ?? 20h     
5B7E 44                         ?? 44h    D
5B7F 3D                         ?? 3Dh    =
5B80 2A                         ?? 2Ah    *
5B81 2A                         ?? 2Ah    *
5B82 2A                         ?? 2Ah    *
5B83 02                         ?? 02h
5B84 02                         ?? 02h
5B85 24                         ?? 24h    $
5B86 2B                         ?? 2Bh    +
5B87 44                         ?? 44h    D
5B88 3D                         ?? 3Dh    =
5B89 2A                         ?? 2Ah    *
5B8A 2A                         ?? 2Ah    *
5B8B 2A                         ?? 2Ah    *
5B8C 02                         ?? 02h
5B8D 02                         ?? 02h
5B8E 24                         ?? 24h    $
5B8F 10                         ?? 10h
5B90 44                         ?? 44h    D
5B91 3D                         ?? 3Dh    =
5B92 2A                         ?? 2Ah    *
5B93 2A                         ?? 2Ah    *
5B94 2A                         ?? 2Ah    *
5B95 02                         ?? 02h
5B96 02                         ?? 02h
5B97 24                         ?? 24h    $
5B98 41                         ?? 41h    A
5B99 47                         ?? 47h    G
5B9A 45                         ?? 45h    E
5B9B 3D                         ?? 3Dh    =
5B9C 2A                         ?? 2Ah    *
5B9D 2A                         ?? 2Ah    *
5B9E 57                         ?? 57h    W
5B9F 2A                         ?? 2Ah    *
5BA0 04                         ?? 04h
5BA1 24                         ?? 24h    $
5BA2 50                         ?? 50h    P
5BA3 20                         ?? 20h     
5BA4 3D                         ?? 3Dh    =
5BA5 2A                         ?? 2Ah    *
5BA6 2A                         ?? 2Ah    *
5BA7 2A                         ?? 2Ah    *
5BA8 02                         ?? 02h
5BA9 02                         ?? 02h
5BAA 24                         ?? 24h    $
5BAB FF                         ?? FFh
5BAC 31 2D 47 …                 ds "1-GSD -$"  ; 1-GSD -
5BB4 32 2D 43 …                 ds "2-CRL -$"  ; 2-CRL -
5BBC 33 2D 42 …                 ds "3-BPD -$"  ; 3-BPD -
5BC4 34 2D 48 …                 ds "4-HC  -$"  ; 4-HC  -
5BCC 35 2D 46 …                 ds "5-FL  -$"  ; 5-FL  -
5BD4 36 2D 54 …                 ds "6-TBD -$"  ; 6-TBD -
5BDC 37 2D 41 …                 ds "7-APBD-$"  ; 7-APBD-
5BE4 38 2D 41 …                 ds "8-AC  -$"  ; 8-AC  -
5BEC 39 2D 45 …                 ds "9-EFBW-$"  ; 9-EFBW-
5BF4 6E 2F 70 …                 ds "n/p-wyhod$"  ; Н/П-ВЫХОД
5BFE 47 53 44 …                 ds "GSD(GESTATIONAL SAC DIAMETER)$"  ; GSD(GESTATIONAL SAC DIAMETER)
5C1C 31 2D 48 …                 ds "1-HANSMANN$"  ; 1-HANSMANN
5C27 32 2D 48 …                 ds "2-HELLMAN$"  ; 2-HELLMAN
5C31 24                         ?? 24h    $
5C32 77 79 62 …                 ds "wybor metoda$"  ; ВЫБОР МЕТОДА
5C3F 43 52 4C …                 ds "CRL(CROWN RUMP LENGTH)$"  ; CRL(CROWN RUMP LENGTH)
5C56 31 2D 48 …                 ds "1-HANSMANN$"  ; 1-HANSMANN
5C61 32 2D 52 …                 ds "2-ROBINSON$"  ; 2-ROBINSON
5C6C 24                         ?? 24h    $
5C6D 42 50 44 …                 ds "BPD(BIPARIETAL DIAMETER)$"  ; BPD(BIPARIETAL DIAMETER)
5C86 31 2D 48 …                 ds "1-HANSMANN$"  ; 1-HANSMANN
5C91 32 2D 4B …                 ds "2-KURTZ$"  ; 2-KURTZ
5C99 24                         ?? 24h    $
5C9A 48 43 28 …                 ds "HC(HEAD CIRCUMFERENCE)$"  ; HC(HEAD CIRCUMFERENCE)
5CB1 31 2D 48 …                 ds "1-HADLOCK$"  ; 1-HADLOCK
5CBB 24                         ?? 24h    $
5CBC 24                         ?? 24h    $
5CBD 46 4C 28 …                 ds "FL(FEMUR LENGTH)$"  ; FL(FEMUR LENGTH)
5CCE 31 2D 48 …                 ds "1-HANSMANN$"  ; 1-HANSMANN
5CD9 32 2D 4A …                 ds "2-JEANTY$"  ; 2-JEANTY
5CE2 24                         ?? 24h    $
5CE3 54 42 44 …                 ds "TBD(TRANSVERSE BODY DIAMETER)$"  ; TBD(TRANSVERSE BODY DIAMETER)
5D01 31 2D 46 …                 ds "1-FESCINA$"  ; 1-FESCINA
5D0B 24                         ?? 24h    $
5D0C 24                         ?? 24h    $
5D0D 41 50 42 …                 ds "APBD(ANTERIOR-POSTERIOR-BODY$"  ; APBD(ANTERIOR-POSTERIOR-BODY
5D2A 20 20 20 …                 ds "     DIAMETER)$"  ;      DIAMETER)
5D39 31 2D 48 …                 ds "1-HANSMANN$"  ; 1-HANSMANN
5D44 32 2D 46 …                 ds "2-FESCINA$"  ; 2-FESCINA
5D4E 41 43 2D …                 ds "AC-(ABDOMINAL CIRCUMFERENCE)$"  ; AC-(ABDOMINAL CIRCUMFERENCE)
5D6B 31 2D 48 …                 ds "1-HADLOCK$"  ; 1-HADLOCK
5D75 24                         ?? 24h    $
5D76 24                         ?? 24h    $
5D77 45 46 42 …                 ds "EFBW$"  ; EFBW
5D7C 31 2D 48 …                 ds "1-HANSMANN$"  ; 1-HANSMANN
5D87 32 2D 57 …                 ds "2-WARSOF$"  ; 2-WARSOF
5D90 24                         ?? 24h    $

; Шрифт 8x8, символы 0x00..0x91, MSB слева; кириллица КОИ-7 Н2
5D91 18 18 00 …  font8x8:       db[1168] 
