; ROM3 6000-7FFF, экспорт Ghidra

; ============================================================
; FUN_ram_6221
; вызовы из: 32D9 669C
6221 F5          FUN_ram_6221:  PUSH AF
6222 E5                         PUSH HL
6223 0A                         LDAX (BC)
6224 E6 17                      ANI 0x17
6226 FE 15                      CPI 0x15
6228 CA 34 62                   JZ 0x6234
622B 21 11 00                   LXI HL,0x11
622E 09                         DAD HL,BC
622F 36 00                      MVI (HL),0x0
6231 E1                         POP HL
6232 F1                         POP AF
6233 C9                         RET
6234 C5          LAB_ram_6234:  PUSH BC
6235 C5                         PUSH BC
6236 21 44 62                   LXI HL,0x6244
6239 E5                         PUSH HL
623A 03                         INX BC
623B 0A                         LDAX (BC)
623C 6F                         MOV L,A
623D 03                         INX BC
623E 0A                         LDAX (BC)
623F 67                         MOV H,A
6240 01 09 00                   LXI BC,0x9
6243 E9                         PCHL
6244 C1                         ?? C1h
6245 C3                         ?? C3h
6246 31                         ?? 31h    1
6247 62                         ?? 62h    b

; ============================================================
; FUN_ram_6248
; вызовы из: 3167 330A 3499 349F 34C6 34CC 3544 354A 3550 3556 355C 3562 3568 356E 3701 3707 37C6 3886 3994 3AE9 …
6248 F5          FUN_ram_6248:  PUSH AF
6249 3E 01                      MVI A,0x1
624B C3 51 62                   JMP 0x6251

; ============================================================
; FUN_ram_624e
; вызовы из: 32CA 32E3 32FB 34DB 36E6 3731 37CC 37D2 3820 385F
624E F5          FUN_ram_624e:  PUSH AF
624F 3E 02                      MVI A,0x2
6251 E5          LAB_ram_6251:  PUSH HL
6252 F5                         PUSH AF
6253 CD 7D 73                   CALL 0x737d
6256 FE 02                      CPI 0x2
6258 CA 72 62                   JZ 0x6272
625B DA 00 64                   JC 0x6400
625E FE 03                      CPI 0x3
6260 C2 3A 63                   JNZ 0x633a
6263 CD 54 6F                   CALL 0x6f54
6266 F1                         POP AF
6267 FE 01                      CPI 0x1
6269 CA 3B 63                   JZ 0x633b
626C CD 91 71                   CALL 0x7191
626F C3 3B 63                   JMP 0x633b
6272 F1          LAB_ram_6272:  POP AF
6273 F5                         PUSH AF
6274 F5                         PUSH AF
6275 C5                         PUSH BC
6276 D5                         PUSH DE
6277 C5                         PUSH BC
6278 FE 01                      CPI 0x1
627A 7C                         MOV A,H
627B CA 81 62                   JZ 0x6281
627E C6 80                      ADI 0x80
6280 67                         MOV H,A
6281 E5          LAB_ram_6281:  PUSH HL
6282 21 11 00                   LXI HL,0x11
6285 09                         DAD HL,BC
6286 BE                         CMP (HL)
6287 3E 00                      MVI A,0x0
6289 CA 8E 62                   JZ 0x628e
628C C6 03                      ADI 0x3
628E C1          LAB_ram_628e:  POP BC
628F 41                         MOV B,C
6290 4F                         MOV C,A
6291 78                         MOV A,B
6292 2B                         DCX HL
6293 96                         SUB (HL)
6294 CA A0 62                   JZ 0x62a0
6297 D2 A1 62                   JNC 0x62a1
629A 2F                         CMA
629B 3C                         INR A
629C 46                         MOV B,(HL)
629D C3 A2 62                   JMP 0x62a2
62A0 0C          LAB_ram_62a0:  INR C
62A1 0C          LAB_ram_62a1:  INR C
62A2 0C          LAB_ram_62a2:  INR C
62A3 C5                         PUSH BC
62A4 F5                         PUSH AF
62A5 79                         MOV A,C
62A6 F5                         PUSH AF
62A7 2B                         DCX HL
62A8 4E                         MOV C,(HL)
62A9 2B                         DCX HL
62AA 46                         MOV B,(HL)
62AB 2B                         DCX HL
62AC 7E                         MOV A,(HL)
62AD 60                         MOV H,B
62AE 6F                         MOV L,A
62AF EB                         XCHG
62B0 7E                         MOV A,(HL)
62B1 F5                         PUSH AF
62B2 23                         INX HL
62B3 46                         MOV B,(HL)
62B4 23                         INX HL
62B5 7E                         MOV A,(HL)
62B6 EB                         XCHG
62B7 F6 80                      ORI 0x80
62B9 50                         MOV D,B
62BA 47                         MOV B,A
62BB F1                         POP AF
62BC 5F                         MOV E,A
62BD F1                         POP AF
62BE FE 04                      CPI 0x4
62C0 D2 3E 63                   JNC 0x633e
62C3 FE 02                      CPI 0x2
62C5 CA D5 62                   JZ 0x62d5
62C8 DA D1 62                   JC 0x62d1
62CB F1                         POP AF
62CC 3E 00                      MVI A,0x0
62CE C3 E0 62                   JMP 0x62e0
62D1 EB          LAB_ram_62d1:  XCHG
62D2 78                         MOV A,B
62D3 41                         MOV B,C
62D4 4F                         MOV C,A
62D5 F1          LAB_ram_62d5:  POP AF
62D6 D5                         PUSH DE
62D7 C5                         PUSH BC
62D8 06 00                      MVI B,0x0
62DA CD DA 75                   CALL 0x75da
62DD D1                         POP DE
62DE 42                         MOV B,D
62DF D1                         POP DE
62E0 F5          LAB_ram_62e0:  PUSH AF
62E1 19                         DAD HL,DE
62E2 79                         MOV A,C
62E3 88                         ADC B
62E4 4F                         MOV C,A
62E5 06 00                      MVI B,0x0
62E7 D2 01 63                   JNC 0x6301
62EA 1F                         RAR
62EB 4F                         MOV C,A
62EC 7C                         MOV A,H
62ED 1F                         RAR
62EE 67                         MOV H,A
62EF 7D                         MOV A,L
62F0 1F                         RAR
62F1 6F                         MOV L,A
62F2 D1                         POP DE
62F3 7A                         MOV A,D
62F4 1F                         RAR
62F5 E6 E0                      ANI 0xe0
62F7 5F                         MOV E,A
62F8 7A                         MOV A,D
62F9 E6 20                      ANI 0x20
62FB B3                         ORA E
62FC 06 01                      MVI B,0x1
62FE C3 02 63                   JMP 0x6302
6301 F1          LAB_ram_6301:  POP AF
6302 CD B8 75    LAB_ram_6302:  CALL 0x75b8
6305 80                         ADD B
6306 57                         MOV D,A
6307 F1                         POP AF
6308 82                         ADD D
6309 51                         MOV D,C
630A C1                         POP BC
630B E5                         PUSH HL
630C 21 0D 00                   LXI HL,0xd
630F 09                         DAD HL,BC
6310 C1                         POP BC
6311 71                         MOV (HL),C
6312 23                         INX HL
6313 70                         MOV (HL),B
6314 23                         INX HL
6315 72                         MOV (HL),D
6316 23                         INX HL
6317 D1                         POP DE
6318 C1                         POP BC
6319 FE FF                      CPI 0xff
631B CA 24 63                   JZ 0x6324
631E 77                         MOV (HL),A
631F 3E 10                      MVI A,0x10
6321 C3 33 63                   JMP 0x6333
6324 DE BE       LAB_ram_6324:  SBI 0xbe
6326 77                         MOV (HL),A
6327 03                         INX BC
6328 03                         INX BC
6329 03                         INX BC
632A 0A                         LDAX (BC)
632B F6 40                      ORI 0x40
632D 02                         STAX (BC)
632E 0B                         DCX BC
632F 0B                         DCX BC
6330 0B                         DCX BC
6331 3E 13                      MVI A,0x13
6333 02          LAB_ram_6333:  STAX (BC)
6334 FE 13                      CPI 0x13
6336 CA FF 63                   JZ 0x63ff
6339 E1                         POP HL
633A E1          LAB_ram_633a:  POP HL
633B E1          LAB_ram_633b:  POP HL
633C F1                         POP AF
633D C9                         RET
633E CA 82 63    LAB_ram_633e:  JZ 0x6382
6341 FE 05                      CPI 0x5
6343 CA 8B 63                   JZ 0x638b
6346 7B                         MOV A,E
6347 95                         SUB L
6348 6F                         MOV L,A
6349 7A                         MOV A,D
634A 9C                         SBB H
634B 67                         MOV H,A
634C 78                         MOV A,B
634D 99                         SBB C
634E 4F                         MOV C,A
634F 3E 01                      MVI A,0x1
6351 D2 61 63                   JNC 0x6361
6354 97                         SUB A
6355 95                         SUB L
6356 6F                         MOV L,A
6357 3E 00                      MVI A,0x0
6359 9C                         SBB H
635A 67                         MOV H,A
635B 3E 00                      MVI A,0x0
635D 99                         SBB C
635E 4F                         MOV C,A
635F 3E 00                      MVI A,0x0
6361 E5          LAB_ram_6361:  PUSH HL
6362 21 0D 00                   LXI HL,0xd
6365 39                         DAD HL,SP
6366 77                         MOV (HL),A
6367 E1                         POP HL
6368 97                         SUB A
6369 B9                         CMP C
636A C2 B1 63                   JNZ 0x63b1
636D BC                         CMP H
636E C2 B1 63                   JNZ 0x63b1
6371 BD                         CMP L
6372 C2 B1 63                   JNZ 0x63b1
6375 C1                         POP BC
6376 C1                         POP BC
6377 C1                         POP BC
6378 CD 21 6A                   CALL 0x6a21
637B D1                         POP DE
637C C1                         POP BC
637D E1                         POP HL
637E E1                         POP HL
637F E1                         POP HL
6380 F1                         POP AF
6381 C9                         RET
6382 EB          LAB_ram_6382:  XCHG
6383 78                         MOV A,B
6384 41                         MOV B,C
6385 4F                         MOV C,A
6386 3E 00                      MVI A,0x0
6388 C3 8D 63                   JMP 0x638d
638B 3E 01       LAB_ram_638b:  MVI A,0x1
638D E5          LAB_ram_638d:  PUSH HL
638E 21 0D 00                   LXI HL,0xd
6391 39                         DAD HL,SP
6392 77                         MOV (HL),A
6393 E1                         POP HL
6394 97                         SUB A
6395 95                         SUB L
6396 6F                         MOV L,A
6397 3E 00                      MVI A,0x0
6399 9C                         SBB H
639A 67                         MOV H,A
639B 3E 00                      MVI A,0x0
639D 99                         SBB C
639E 4F                         MOV C,A
639F F1                         POP AF
63A0 F5                         PUSH AF
63A1 D5                         PUSH DE
63A2 C5                         PUSH BC
63A3 06 FF                      MVI B,0xff
63A5 CD DA 75                   CALL 0x75da
63A8 D1                         POP DE
63A9 42                         MOV B,D
63AA D1                         POP DE
63AB F5                         PUSH AF
63AC 19                         DAD HL,DE
63AD 79                         MOV A,C
63AE 88                         ADC B
63AF 4F                         MOV C,A
63B0 F1                         POP AF
63B1 CD 26 75    LAB_ram_63b1:  CALL 0x7526
63B4 CD B8 75                   CALL 0x75b8
63B7 5F                         MOV E,A
63B8 F1                         POP AF
63B9 F1                         POP AF
63BA 83                         ADD E
63BB 90                         SUB B
63BC 51                         MOV D,C
63BD C1                         POP BC
63BE F5                         PUSH AF
63BF E5                         PUSH HL
63C0 21 0D 00                   LXI HL,0xd
63C3 09                         DAD HL,BC
63C4 C1                         POP BC
63C5 71                         MOV (HL),C
63C6 23                         INX HL
63C7 70                         MOV (HL),B
63C8 23                         INX HL
63C9 72                         MOV (HL),D
63CA 23                         INX HL
63CB F1                         POP AF
63CC D1                         POP DE
63CD C1                         POP BC
63CE DA DB 63                   JC 0x63db
63D1 B7                         ORA A
63D2 CA DB 63                   JZ 0x63db
63D5 77                         MOV (HL),A
63D6 3E 10                      MVI A,0x10
63D8 C3 EA 63                   JMP 0x63ea
63DB C6 BE       LAB_ram_63db:  ADI 0xbe
63DD 77                         MOV (HL),A
63DE 03                         INX BC
63DF 03                         INX BC
63E0 03                         INX BC
63E1 0A                         LDAX (BC)
63E2 F6 20                      ORI 0x20
63E4 02                         STAX (BC)
63E5 0B                         DCX BC
63E6 0B                         DCX BC
63E7 0B                         DCX BC
63E8 3E 14                      MVI A,0x14
63EA 02          LAB_ram_63ea:  STAX (BC)
63EB F1                         POP AF
63EC B7                         ORA A
63ED CA F5 63                   JZ 0x63f5
63F0 23                         INX HL
63F1 7E                         MOV A,(HL)
63F2 C6 80                      ADI 0x80
63F4 77                         MOV (HL),A
63F5 0A          LAB_ram_63f5:  LDAX (BC)
63F6 E6 07                      ANI 0x7
63F8 C2 00 64                   JNZ 0x6400
63FB E1                         POP HL
63FC E1                         POP HL
63FD F1                         POP AF
63FE C9                         RET
63FF F1          LAB_ram_63ff:  POP AF
6400 F1          LAB_ram_6400:  POP AF
6401 C5                         PUSH BC
6402 C5                         PUSH BC
6403 21 14 64                   LXI HL,0x6414
6406 E5                         PUSH HL
6407 21 01 00                   LXI HL,0x1
640A 09                         DAD HL,BC
640B 4E                         MOV C,(HL)
640C 23                         INX HL
640D 46                         MOV B,(HL)
640E 60                         MOV H,B
640F 69                         MOV L,C
6410 4F                         MOV C,A
6411 06 00                      MVI B,0x0
6413 E9                         PCHL
6414 C1                         ?? C1h
6415 E1                         ?? E1h
6416 F1                         ?? F1h
6417 C9                         ?? C9h
6418 01                         ?? 01h
6419 02                         ?? 02h
641A 04                         ?? 04h
641B 08                         ?? 08h
641C 10          DAT_ram_641c:  undefined1 10h

; Степени 10 (float32) для форматного вывода
641D 20 00 00 …  rt_pow10_f:    float[20] 
646D 05                         ?? 05h

; ============================================================
; rt_format
; вызовы из: 30F3 3119 3184 31BD 35EE 361A 373C 39CB 3A1A 3A46 3AB1
646E 21 C7 FF    rt_format:     LXI HL,0xffc7
6471 39                         DAD HL,SP
6472 F9                         SPHL
6473 D5                         PUSH DE
6474 C5                         PUSH BC
6475 21 02 00                   LXI HL,0x2
6478 39                         DAD HL,SP
6479 4E                         MOV C,(HL)
647A 23                         INX HL
647B 46                         MOV B,(HL)
647C 21 04 00                   LXI HL,0x4
647F 39                         DAD HL,SP
6480 71                         MOV (HL),C
6481 23                         INX HL
6482 70                         MOV (HL),B
6483 03                         INX BC
6484 23                         INX HL
6485 71                         MOV (HL),C
6486 23                         INX HL
6487 70                         MOV (HL),B
6488 21 02 00                   LXI HL,0x2
648B 39                         DAD HL,SP
648C 4E                         MOV C,(HL)
648D 23                         INX HL
648E 46                         MOV B,(HL)
648F 03                         INX BC
6490 03                         INX BC
6491 03                         INX BC
6492 21 0C 00                   LXI HL,0xc
6495 39                         DAD HL,SP
6496 71                         MOV (HL),C
6497 23                         INX HL
6498 70                         MOV (HL),B
6499 3E 04                      MVI A,0x4
649B 21 02 00                   LXI HL,0x2
649E 39                         DAD HL,SP
649F CD 32 76                   CALL 0x7632
64A2 EB                         XCHG
64A3 21 0A 00                   LXI HL,0xa
64A6 39                         DAD HL,SP
64A7 73                         MOV (HL),E
64A8 23                         INX HL
64A9 72                         MOV (HL),D
64AA EB                         XCHG
64AB 4E                         MOV C,(HL)
64AC 23                         INX HL
64AD 46                         MOV B,(HL)
64AE EB                         XCHG
64AF 2B                         DCX HL
64B0 2B                         DCX HL
64B1 2B                         DCX HL
64B2 71                         MOV (HL),C
64B3 23                         INX HL
64B4 70                         MOV (HL),B
64B5 2E 12                      MVI L,0x12
64B7 E5                         PUSH HL
64B8 21 16 00                   LXI HL,0x16
64BB 39                         DAD HL,SP
64BC E5                         PUSH HL
64BD 21 04 00                   LXI HL,0x4
64C0 39                         DAD HL,SP
64C1 4E                         MOV C,(HL)
64C2 23                         INX HL
64C3 46                         MOV B,(HL)
64C4 D1                         POP DE
64C5 E1                         POP HL
64C6 0A          LAB_ram_64c6:  LDAX (BC)
64C7 12                         STAX (DE)
64C8 03                         INX BC
64C9 13                         INX DE
64CA 2D                         DCR L
64CB C2 C6 64                   JNZ 0x64c6
64CE 21 06 00                   LXI HL,0x6
64D1 39                         DAD HL,SP
64D2 4E                         MOV C,(HL)
64D3 23                         INX HL
64D4 46                         MOV B,(HL)
64D5 60                         MOV H,B
64D6 69                         MOV L,C
64D7 3E 00                      MVI A,0x0
64D9 77                         MOV (HL),A
64DA 23                         INX HL
64DB 36 00                      MVI (HL),0x0
64DD 21 0C 00                   LXI HL,0xc
64E0 39                         DAD HL,SP
64E1 4E                         MOV C,(HL)
64E2 23                         INX HL
64E3 46                         MOV B,(HL)
64E4 0A                         LDAX (BC)
64E5 23                         INX HL
64E6 77                         MOV (HL),A
64E7 23                         INX HL
64E8 36 00                      MVI (HL),0x0
64EA 3E 09                      MVI A,0x9
64EC 2B                         DCX HL
64ED BE                         CMP (HL)
64EE D2 FA 64                   JNC 0x64fa
64F1 21 0E 00                   LXI HL,0xe
64F4 39                         DAD HL,SP
64F5 36 09                      MVI (HL),0x9
64F7 23                         INX HL
64F8 36 01                      MVI (HL),0x1
64FA 21 0E 00    LAB_ram_64fa:  LXI HL,0xe
64FD 39                         DAD HL,SP
64FE 7E                         MOV A,(HL)
64FF D6 00                      SUI 0x0
6501 D6 01                      SUI 0x1
6503 9F                         SBB A
6504 F5                         PUSH AF
6505 21 16 00                   LXI HL,0x16
6508 39                         DAD HL,SP
6509 44                         MOV B,H
650A 4D                         MOV C,L
650B CD 1C 73                   CALL 0x731c
650E E6 05                      ANI 0x5
6510 D6 05                      SUI 0x5
6512 D6 01                      SUI 0x1
6514 9F                         SBB A
6515 C1                         POP BC
6516 48                         MOV C,B
6517 B1                         ORA C
6518 1F                         RAR
6519 D2 17 66                   JNC 0x6617
651C 21 22 00                   LXI HL,0x22
651F 39                         DAD HL,SP
6520 7E                         MOV A,(HL)
6521 21 21 00                   LXI HL,0x21
6524 39                         DAD HL,SP
6525 A6                         ANA (HL)
6526 23                         INX HL
6527 23                         INX HL
6528 A6                         ANA (HL)
6529 23                         INX HL
652A F5                         PUSH AF
652B 7E                         MOV A,(HL)
652C D6 FF                      SUI 0xff
652E D6 01                      SUI 0x1
6530 9F                         SBB A
6531 C1                         POP BC
6532 48                         MOV C,B
6533 A1                         ANA C
6534 1F                         RAR
6535 D2 5E 65                   JNC 0x655e
6538 21 25 00                   LXI HL,0x25
653B 39                         DAD HL,SP
653C 7E                         MOV A,(HL)
653D FE 80                      CPI 0x80
653F D2 50 65                   JNC 0x6550
6542 21 08 00                   LXI HL,0x8
6545 39                         DAD HL,SP
6546 4E                         MOV C,(HL)
6547 23                         INX HL
6548 46                         MOV B,(HL)
6549 60                         MOV H,B
654A 69                         MOV L,C
654B 36 2B                      MVI (HL),0x2b
654D C3 5B 65                   JMP 0x655b
6550 21 08 00    LAB_ram_6550:  LXI HL,0x8
6553 39                         DAD HL,SP
6554 4E                         MOV C,(HL)
6555 23                         INX HL
6556 46                         MOV B,(HL)
6557 60                         MOV H,B
6558 69                         MOV L,C
6559 36 2D                      MVI (HL),0x2d
655B C3 D4 65    LAB_ram_655b:  JMP 0x65d4
655E 21 22 00    LAB_ram_655e:  LXI HL,0x22
6561 39                         DAD HL,SP
6562 7E                         MOV A,(HL)
6563 21 21 00                   LXI HL,0x21
6566 39                         DAD HL,SP
6567 B6                         ORA (HL)
6568 23                         INX HL
6569 23                         INX HL
656A B6                         ORA (HL)
656B 23                         INX HL
656C 23                         INX HL
656D F5                         PUSH AF
656E 7E                         MOV A,(HL)
656F D6 00                      SUI 0x0
6571 D6 01                      SUI 0x1
6573 9F                         SBB A
6574 C1                         POP BC
6575 48                         MOV C,B
6576 B1                         ORA C
6577 2B                         DCX HL
6578 F5                         PUSH AF
6579 7E                         MOV A,(HL)
657A D6 FF                      SUI 0xff
657C D6 01                      SUI 0x1
657E 9F                         SBB A
657F C1                         POP BC
6580 48                         MOV C,B
6581 A1                         ANA C
6582 1F                         RAR
6583 D2 94 65                   JNC 0x6594
6586 21 08 00                   LXI HL,0x8
6589 39                         DAD HL,SP
658A 4E                         MOV C,(HL)
658B 23                         INX HL
658C 46                         MOV B,(HL)
658D 60                         MOV H,B
658E 69                         MOV L,C
658F 36 3F                      MVI (HL),0x3f
6591 C3 D4 65                   JMP 0x65d4
6594 21 22 00    LAB_ram_6594:  LXI HL,0x22
6597 39                         DAD HL,SP
6598 7E                         MOV A,(HL)
6599 21 21 00                   LXI HL,0x21
659C 39                         DAD HL,SP
659D B6                         ORA (HL)
659E 23                         INX HL
659F 23                         INX HL
65A0 B6                         ORA (HL)
65A1 23                         INX HL
65A2 F5                         PUSH AF
65A3 7E                         MOV A,(HL)
65A4 D6 00                      SUI 0x0
65A6 D6 01                      SUI 0x1
65A8 9F                         SBB A
65A9 C1                         POP BC
65AA 48                         MOV C,B
65AB B1                         ORA C
65AC 23                         INX HL
65AD F5                         PUSH AF
65AE 7E                         MOV A,(HL)
65AF D6 80                      SUI 0x80
65B1 D6 01                      SUI 0x1
65B3 9F                         SBB A
65B4 C1                         POP BC
65B5 48                         MOV C,B
65B6 A1                         ANA C
65B7 1F                         RAR
65B8 D2 C9 65                   JNC 0x65c9
65BB 21 08 00                   LXI HL,0x8
65BE 39                         DAD HL,SP
65BF 4E                         MOV C,(HL)
65C0 23                         INX HL
65C1 46                         MOV B,(HL)
65C2 60                         MOV H,B
65C3 69                         MOV L,C
65C4 36 30                      MVI (HL),0x30
65C6 C3 D4 65                   JMP 0x65d4
65C9 21 08 00    LAB_ram_65c9:  LXI HL,0x8
65CC 39                         DAD HL,SP
65CD 4E                         MOV C,(HL)
65CE 23                         INX HL
65CF 46                         MOV B,(HL)
65D0 60                         MOV H,B
65D1 69                         MOV L,C
65D2 36 2A                      MVI (HL),0x2a
65D4 21 04 00    LAB_ram_65d4:  LXI HL,0x4
65D7 39                         DAD HL,SP
65D8 4E                         MOV C,(HL)
65D9 23                         INX HL
65DA 46                         MOV B,(HL)
65DB 60                         MOV H,B
65DC 69                         MOV L,C
65DD 36 2A                      MVI (HL),0x2a
65DF 21 3B 00                   LXI HL,0x3b
65E2 39                         DAD HL,SP
65E3 36 01                      MVI (HL),0x1
65E5 21 0C 00    LAB_ram_65e5:  LXI HL,0xc
65E8 39                         DAD HL,SP
65E9 4E                         MOV C,(HL)
65EA 23                         INX HL
65EB 46                         MOV B,(HL)
65EC 0A                         LDAX (BC)
65ED 3D                         DCR A
65EE 21 3B 00                   LXI HL,0x3b
65F1 39                         DAD HL,SP
65F2 BE                         CMP (HL)
65F3 DA 11 66                   JC 0x6611
65F6 21 3B 00                   LXI HL,0x3b
65F9 39                         DAD HL,SP
65FA 4E                         MOV C,(HL)
65FB 06 00                      MVI B,0x0
65FD 21 08 00                   LXI HL,0x8
6600 39                         DAD HL,SP
6601 EB                         XCHG
6602 CD 29 76                   CALL 0x7629
6605 36 2A                      MVI (HL),0x2a
6607 21 3B 00                   LXI HL,0x3b
660A 39                         DAD HL,SP
660B 7E                         MOV A,(HL)
660C 3C                         INR A
660D 77                         MOV (HL),A
660E C2 E5 65                   JNZ 0x65e5
6611 21 3D 00    LAB_ram_6611:  LXI HL,0x3d
6614 39                         DAD HL,SP
6615 F9                         SPHL
6616 C9                         RET
6617 21 14 00    LAB_ram_6617:  LXI HL,0x14
661A 39                         DAD HL,SP
661B 44                         MOV B,H
661C 4D                         MOV C,L
661D CD 42 73                   CALL 0x7342
6620 21 39 00                   LXI HL,0x39
6623 39                         DAD HL,SP
6624 77                         MOV (HL),A
6625 21 39 00                   LXI HL,0x39
6628 39                         DAD HL,SP
6629 7E                         MOV A,(HL)
662A 07                         RLC
662B 1F                         RAR
662C D2 72 66                   JNC 0x6672
662F 21 04 00                   LXI HL,0x4
6632 39                         DAD HL,SP
6633 4E                         MOV C,(HL)
6634 23                         INX HL
6635 46                         MOV B,(HL)
6636 60                         MOV H,B
6637 69                         MOV L,C
6638 36 20                      MVI (HL),0x20
663A 21 3B 00                   LXI HL,0x3b
663D 39                         DAD HL,SP
663E 36 00                      MVI (HL),0x0
6640 21 0C 00    LAB_ram_6640:  LXI HL,0xc
6643 39                         DAD HL,SP
6644 4E                         MOV C,(HL)
6645 23                         INX HL
6646 46                         MOV B,(HL)
6647 0A                         LDAX (BC)
6648 3D                         DCR A
6649 21 3B 00                   LXI HL,0x3b
664C 39                         DAD HL,SP
664D BE                         CMP (HL)
664E DA 6C 66                   JC 0x666c
6651 21 3B 00                   LXI HL,0x3b
6654 39                         DAD HL,SP
6655 4E                         MOV C,(HL)
6656 06 00                      MVI B,0x0
6658 21 08 00                   LXI HL,0x8
665B 39                         DAD HL,SP
665C EB                         XCHG
665D CD 29 76                   CALL 0x7629
6660 36 30                      MVI (HL),0x30
6662 21 3B 00                   LXI HL,0x3b
6665 39                         DAD HL,SP
6666 7E                         MOV A,(HL)
6667 3C                         INR A
6668 77                         MOV (HL),A
6669 C2 40 66                   JNZ 0x6640
666C 21 3D 00    LAB_ram_666c:  LXI HL,0x3d
666F 39                         DAD HL,SP
6670 F9                         SPHL
6671 C9                         RET
6672 21 39 00    LAB_ram_6672:  LXI HL,0x39
6675 39                         DAD HL,SP
6676 7E                         MOV A,(HL)
6677 07                         RLC
6678 07                         RLC
6679 1F                         RAR
667A D2 8B 66                   JNC 0x668b
667D 21 04 00                   LXI HL,0x4
6680 39                         DAD HL,SP
6681 4E                         MOV C,(HL)
6682 23                         INX HL
6683 46                         MOV B,(HL)
6684 60                         MOV H,B
6685 69                         MOV L,C
6686 36 2B                      MVI (HL),0x2b
6688 C3 96 66                   JMP 0x6696
668B 21 04 00    LAB_ram_668b:  LXI HL,0x4
668E 39                         DAD HL,SP
668F 4E                         MOV C,(HL)
6690 23                         INX HL
6691 46                         MOV B,(HL)
6692 60                         MOV H,B
6693 69                         MOV L,C
6694 36 2D                      MVI (HL),0x2d
6696 21 14 00    LAB_ram_6696:  LXI HL,0x14
6699 39                         DAD HL,SP
669A 44                         MOV B,H
669B 4D                         MOV C,L
669C CD 21 62                   CALL 0x6221
669F 21 3B 00                   LXI HL,0x3b
66A2 39                         DAD HL,SP
66A3 36 05                      MVI (HL),0x5
66A5 3E 36                      MVI A,0x36
66A7 21 24 00                   LXI HL,0x24
66AA 39                         DAD HL,SP
66AB BE                         CMP (HL)
66AC D2 B5 66                   JNC 0x66b5
66AF 21 3B 00                   LXI HL,0x3b
66B2 39                         DAD HL,SP
66B3 36 04                      MVI (HL),0x4
66B5 21 14 00    LAB_ram_66b5:  LXI HL,0x14
66B8 39                         DAD HL,SP
66B9 E5                         PUSH HL
66BA 21 10 00                   LXI HL,0x10
66BD 39                         DAD HL,SP
66BE 7E                         MOV A,(HL)
66BF 3D                         DCR A
66C0 6F                         MOV L,A
66C1 26 00                      MVI H,0x0
66C3 29                         DAD HL,HL
66C4 29                         DAD HL,HL
66C5 01 22 64                   LXI BC,0x6422
66C8 09                         DAD HL,BC
66C9 EB                         XCHG
66CA C1                         POP BC
66CB CD 37 6A                   CALL 0x6a37
66CE 07                         RLC
66CF 07                         RLC
66D0 07                         RLC
66D1 1F                         RAR
66D2 D2 76 67                   JNC 0x6776
66D5 21 3B 00    LAB_ram_66d5:  LXI HL,0x3b
66D8 39                         DAD HL,SP
66D9 7E                         MOV A,(HL)
66DA FE FF                      CPI 0xff
66DC CA 76 67                   JZ 0x6776
66DF 2E 12                      MVI L,0x12
66E1 E5                         PUSH HL
66E2 21 16 00                   LXI HL,0x16
66E5 39                         DAD HL,SP
66E6 E5                         PUSH HL
66E7 21 2A 00                   LXI HL,0x2a
66EA 39                         DAD HL,SP
66EB EB                         XCHG
66EC C1                         POP BC
66ED E1                         POP HL
66EE 0A          LAB_ram_66ee:  LDAX (BC)
66EF 12                         STAX (DE)
66F0 03                         INX BC
66F1 13                         INX DE
66F2 2D                         DCR L
66F3 C2 EE 66                   JNZ 0x66ee
66F6 21 14 00                   LXI HL,0x14
66F9 39                         DAD HL,SP
66FA E5                         PUSH HL
66FB 21 3D 00                   LXI HL,0x3d
66FE 39                         DAD HL,SP
66FF 6E                         MOV L,(HL)
6700 26 00                      MVI H,0x0
6702 29                         DAD HL,HL
6703 29                         DAD HL,HL
6704 01 46 75                   LXI BC,0x7546
6707 09                         DAD HL,BC
6708 EB                         XCHG
6709 C1                         POP BC
670A CD 3B 70                   CALL 0x703b
670D 21 14 00                   LXI HL,0x14
6710 39                         DAD HL,SP
6711 E5                         PUSH HL
6712 21 10 00                   LXI HL,0x10
6715 39                         DAD HL,SP
6716 6E                         MOV L,(HL)
6717 26 00                      MVI H,0x0
6719 29                         DAD HL,HL
671A 29                         DAD HL,HL
671B 01 22 64                   LXI BC,0x6422
671E 09                         DAD HL,BC
671F EB                         XCHG
6720 C1                         POP BC
6721 CD 37 6A                   CALL 0x6a37
6724 07                         RLC
6725 07                         RLC
6726 07                         RLC
6727 2F                         CMA
6728 1F                         RAR
6729 D2 46 67                   JNC 0x6746
672C 2E 12                      MVI L,0x12
672E E5                         PUSH HL
672F 21 28 00                   LXI HL,0x28
6732 39                         DAD HL,SP
6733 E5                         PUSH HL
6734 21 18 00                   LXI HL,0x18
6737 39                         DAD HL,SP
6738 EB                         XCHG
6739 C1                         POP BC
673A E1                         POP HL
673B 0A          LAB_ram_673b:  LDAX (BC)
673C 12                         STAX (DE)
673D 03                         INX BC
673E 13                         INX DE
673F 2D                         DCR L
6740 C2 3B 67                   JNZ 0x673b
6743 C3 6C 67                   JMP 0x676c
6746 21 06 00    LAB_ram_6746:  LXI HL,0x6
6749 39                         DAD HL,SP
674A 4E                         MOV C,(HL)
674B 23                         INX HL
674C 46                         MOV B,(HL)
674D 21 3B 00                   LXI HL,0x3b
6750 39                         DAD HL,SP
6751 C5                         PUSH BC
6752 4E                         MOV C,(HL)
6753 06 00                      MVI B,0x0
6755 21 18 64                   LXI HL,0x6418
6758 09                         DAD HL,BC
6759 7E                         MOV A,(HL)
675A D1                         POP DE
675B CD 7C 76                   CALL 0x767c
675E E5                         PUSH HL
675F 21 08 00                   LXI HL,0x8
6762 39                         DAD HL,SP
6763 4E                         MOV C,(HL)
6764 23                         INX HL
6765 46                         MOV B,(HL)
6766 60                         MOV H,B
6767 69                         MOV L,C
6768 C1                         POP BC
6769 71                         MOV (HL),C
676A 23                         INX HL
676B 70                         MOV (HL),B
676C 21 3B 00    LAB_ram_676c:  LXI HL,0x3b
676F 39                         DAD HL,SP
6770 7E                         MOV A,(HL)
6771 3D                         DCR A
6772 77                         MOV (HL),A
6773 C3 D5 66                   JMP 0x66d5
6776 21 3B 00    LAB_ram_6776:  LXI HL,0x3b
6779 39                         DAD HL,SP
677A 36 05                      MVI (HL),0x5
677C 21 24 00                   LXI HL,0x24
677F 39                         DAD HL,SP
6780 7E                         MOV A,(HL)
6781 FE E9                      CPI 0xe9
6783 D2 8C 67                   JNC 0x678c
6786 21 3B 00                   LXI HL,0x3b
6789 39                         DAD HL,SP
678A 36 04                      MVI (HL),0x4
678C 21 14 00    LAB_ram_678c:  LXI HL,0x14
678F 39                         DAD HL,SP
6790 E5                         PUSH HL
6791 21 10 00                   LXI HL,0x10
6794 39                         DAD HL,SP
6795 6E                         MOV L,(HL)
6796 26 00                      MVI H,0x0
6798 29                         DAD HL,HL
6799 29                         DAD HL,HL
679A 01 22 64                   LXI BC,0x6422
679D 09                         DAD HL,BC
679E EB                         XCHG
679F C1                         POP BC
67A0 CD 37 6A                   CALL 0x6a37
67A3 07                         RLC
67A4 07                         RLC
67A5 07                         RLC
67A6 2F                         CMA
67A7 1F                         RAR
67A8 D2 4D 68                   JNC 0x684d
67AB 21 3B 00    LAB_ram_67ab:  LXI HL,0x3b
67AE 39                         DAD HL,SP
67AF 7E                         MOV A,(HL)
67B0 FE FF                      CPI 0xff
67B2 CA 4D 68                   JZ 0x684d
67B5 2E 12                      MVI L,0x12
67B7 E5                         PUSH HL
67B8 21 16 00                   LXI HL,0x16
67BB 39                         DAD HL,SP
67BC E5                         PUSH HL
67BD 21 2A 00                   LXI HL,0x2a
67C0 39                         DAD HL,SP
67C1 EB                         XCHG
67C2 C1                         POP BC
67C3 E1                         POP HL
67C4 0A          LAB_ram_67c4:  LDAX (BC)
67C5 12                         STAX (DE)
67C6 03                         INX BC
67C7 13                         INX DE
67C8 2D                         DCR L
67C9 C2 C4 67                   JNZ 0x67c4
67CC 21 14 00                   LXI HL,0x14
67CF 39                         DAD HL,SP
67D0 E5                         PUSH HL
67D1 21 3D 00                   LXI HL,0x3d
67D4 39                         DAD HL,SP
67D5 6E                         MOV L,(HL)
67D6 26 00                      MVI H,0x0
67D8 29                         DAD HL,HL
67D9 29                         DAD HL,HL
67DA 01 46 75                   LXI BC,0x7546
67DD 09                         DAD HL,BC
67DE EB                         XCHG
67DF C1                         POP BC
67E0 CD 3D 6D                   CALL 0x6d3d
67E3 21 14 00                   LXI HL,0x14
67E6 39                         DAD HL,SP
67E7 E5                         PUSH HL
67E8 21 10 00                   LXI HL,0x10
67EB 39                         DAD HL,SP
67EC 7E                         MOV A,(HL)
67ED 3D                         DCR A
67EE 6F                         MOV L,A
67EF 26 00                      MVI H,0x0
67F1 29                         DAD HL,HL
67F2 29                         DAD HL,HL
67F3 01 22 64                   LXI BC,0x6422
67F6 09                         DAD HL,BC
67F7 EB                         XCHG
67F8 C1                         POP BC
67F9 CD 37 6A                   CALL 0x6a37
67FC 07                         RLC
67FD 07                         RLC
67FE 07                         RLC
67FF 1F                         RAR
6800 D2 1D 68                   JNC 0x681d
6803 2E 12                      MVI L,0x12
6805 E5                         PUSH HL
6806 21 28 00                   LXI HL,0x28
6809 39                         DAD HL,SP
680A E5                         PUSH HL
680B 21 18 00                   LXI HL,0x18
680E 39                         DAD HL,SP
680F EB                         XCHG
6810 C1                         POP BC
6811 E1                         POP HL
6812 0A          LAB_ram_6812:  LDAX (BC)
6813 12                         STAX (DE)
6814 03                         INX BC
6815 13                         INX DE
6816 2D                         DCR L
6817 C2 12 68                   JNZ 0x6812
681A C3 43 68                   JMP 0x6843
681D 21 06 00    LAB_ram_681d:  LXI HL,0x6
6820 39                         DAD HL,SP
6821 4E                         MOV C,(HL)
6822 23                         INX HL
6823 46                         MOV B,(HL)
6824 21 3B 00                   LXI HL,0x3b
6827 39                         DAD HL,SP
6828 C5                         PUSH BC
6829 4E                         MOV C,(HL)
682A 06 00                      MVI B,0x0
682C 21 18 64                   LXI HL,0x6418
682F 09                         DAD HL,BC
6830 7E                         MOV A,(HL)
6831 D1                         POP DE
6832 CD 31 76                   CALL 0x7631
6835 E5                         PUSH HL
6836 21 08 00                   LXI HL,0x8
6839 39                         DAD HL,SP
683A 4E                         MOV C,(HL)
683B 23                         INX HL
683C 46                         MOV B,(HL)
683D 60                         MOV H,B
683E 69                         MOV L,C
683F C1                         POP BC
6840 71                         MOV (HL),C
6841 23                         INX HL
6842 70                         MOV (HL),B
6843 21 3B 00    LAB_ram_6843:  LXI HL,0x3b
6846 39                         DAD HL,SP
6847 7E                         MOV A,(HL)
6848 3D                         DCR A
6849 77                         MOV (HL),A
684A C3 AB 67                   JMP 0x67ab
684D 21 14 00    LAB_ram_684d:  LXI HL,0x14
6850 39                         DAD HL,SP
6851 44                         MOV B,H
6852 4D                         MOV C,L
6853 11 1E 64                   LXI DE,0x641e
6856 CD 48 62                   CALL 0x6248
6859 21 14 00                   LXI HL,0x14
685C 39                         DAD HL,SP
685D E5                         PUSH HL
685E 21 12 00                   LXI HL,0x12
6861 39                         DAD HL,SP
6862 EB                         XCHG
6863 C1                         POP BC
6864 CD 9F 6E                   CALL 0x6e9f
6867 21 0E 00                   LXI HL,0xe
686A 39                         DAD HL,SP
686B 7E                         MOV A,(HL)
686C 21 3A 00                   LXI HL,0x3a
686F 39                         DAD HL,SP
6870 77                         MOV (HL),A
6871 23                         INX HL
6872 36 00                      MVI (HL),0x0
6874 21 0E 00    LAB_ram_6874:  LXI HL,0xe
6877 39                         DAD HL,SP
6878 7E                         MOV A,(HL)
6879 3D                         DCR A
687A 21 3B 00                   LXI HL,0x3b
687D 39                         DAD HL,SP
687E BE                         CMP (HL)
687F DA 87 69                   JC 0x6987
6882 21 3A 00                   LXI HL,0x3a
6885 39                         DAD HL,SP
6886 7E                         MOV A,(HL)
6887 3D                         DCR A
6888 77                         MOV (HL),A
6889 23                         INX HL
688A 23                         INX HL
688B 36 30                      MVI (HL),0x30
688D 21 3A 00    LAB_ram_688d:  LXI HL,0x3a
6890 39                         DAD HL,SP
6891 6E                         MOV L,(HL)
6892 26 00                      MVI H,0x0
6894 29                         DAD HL,HL
6895 29                         DAD HL,HL
6896 01 4A 64                   LXI BC,0x644a
6899 09                         DAD HL,BC
689A 01 02 00                   LXI BC,0x2
689D 09                         DAD HL,BC
689E EB                         XCHG
689F 21 12 00                   LXI HL,0x12
68A2 39                         DAD HL,SP
68A3 CD 71 76                   CALL 0x7671
68A6 9F                         SBB A
68A7 21 3A 00                   LXI HL,0x3a
68AA 39                         DAD HL,SP
68AB 6E                         MOV L,(HL)
68AC 26 00                      MVI H,0x0
68AE 29                         DAD HL,HL
68AF 29                         DAD HL,HL
68B0 01 4A 64                   LXI BC,0x644a
68B3 09                         DAD HL,BC
68B4 01 02 00                   LXI BC,0x2
68B7 09                         DAD HL,BC
68B8 F5                         PUSH AF
68B9 E5                         PUSH HL
68BA 21 16 00                   LXI HL,0x16
68BD 39                         DAD HL,SP
68BE D1                         POP DE
68BF CD 71 76                   CALL 0x7671
68C2 B5                         ORA L
68C3 D6 01                      SUI 0x1
68C5 9F                         SBB A
68C6 21 3C 00                   LXI HL,0x3c
68C9 39                         DAD HL,SP
68CA 6E                         MOV L,(HL)
68CB 26 00                      MVI H,0x0
68CD 29                         DAD HL,HL
68CE 29                         DAD HL,HL
68CF 01 4A 64                   LXI BC,0x644a
68D2 09                         DAD HL,BC
68D3 F5                         PUSH AF
68D4 E5                         PUSH HL
68D5 21 16 00                   LXI HL,0x16
68D8 39                         DAD HL,SP
68D9 EB                         XCHG
68DA C1                         POP BC
68DB CD 6F 76                   CALL 0x766f
68DE 9F                         SBB A
68DF 2F                         CMA
68E0 C1                         POP BC
68E1 48                         MOV C,B
68E2 A1                         ANA C
68E3 C1                         POP BC
68E4 48                         MOV C,B
68E5 B1                         ORA C
68E6 1F                         RAR
68E7 D2 66 69                   JNC 0x6966
68EA 21 3A 00                   LXI HL,0x3a
68ED 39                         DAD HL,SP
68EE 6E                         MOV L,(HL)
68EF 26 00                      MVI H,0x0
68F1 29                         DAD HL,HL
68F2 29                         DAD HL,HL
68F3 01 4A 64                   LXI BC,0x644a
68F6 09                         DAD HL,BC
68F7 E5                         PUSH HL
68F8 21 12 00                   LXI HL,0x12
68FB 39                         DAD HL,SP
68FC EB                         XCHG
68FD C1                         POP BC
68FE CD 6F 76                   CALL 0x766f
6901 D2 0D 69                   JNC 0x690d
6904 21 38 00                   LXI HL,0x38
6907 39                         DAD HL,SP
6908 36 01                      MVI (HL),0x1
690A C3 13 69                   JMP 0x6913
690D 21 38 00    LAB_ram_690d:  LXI HL,0x38
6910 39                         DAD HL,SP
6911 36 00                      MVI (HL),0x0
6913 21 3A 00    LAB_ram_6913:  LXI HL,0x3a
6916 39                         DAD HL,SP
6917 6E                         MOV L,(HL)
6918 26 00                      MVI H,0x0
691A 29                         DAD HL,HL
691B 29                         DAD HL,HL
691C 01 4A 64                   LXI BC,0x644a
691F 09                         DAD HL,BC
6920 E5                         PUSH HL
6921 21 12 00                   LXI HL,0x12
6924 39                         DAD HL,SP
6925 EB                         XCHG
6926 C1                         POP BC
6927 CD 6F 76                   CALL 0x766f
692A EB                         XCHG
692B 2B                         DCX HL
692C 73                         MOV (HL),E
692D 23                         INX HL
692E 72                         MOV (HL),D
692F 21 3A 00                   LXI HL,0x3a
6932 39                         DAD HL,SP
6933 6E                         MOV L,(HL)
6934 26 00                      MVI H,0x0
6936 29                         DAD HL,HL
6937 29                         DAD HL,HL
6938 01 4A 64                   LXI BC,0x644a
693B 09                         DAD HL,BC
693C 01 02 00                   LXI BC,0x2
693F 09                         DAD HL,BC
6940 E5                         PUSH HL
6941 21 14 00                   LXI HL,0x14
6944 39                         DAD HL,SP
6945 EB                         XCHG
6946 C1                         POP BC
6947 CD 6F 76                   CALL 0x766f
694A E5                         PUSH HL
694B 21 3A 00                   LXI HL,0x3a
694E 39                         DAD HL,SP
694F 7E                         MOV A,(HL)
6950 D1                         POP DE
6951 CD 65 76                   CALL 0x7665
6954 EB                         XCHG
6955 21 12 00                   LXI HL,0x12
6958 39                         DAD HL,SP
6959 73                         MOV (HL),E
695A 23                         INX HL
695B 72                         MOV (HL),D
695C 21 3C 00                   LXI HL,0x3c
695F 39                         DAD HL,SP
6960 7E                         MOV A,(HL)
6961 3C                         INR A
6962 77                         MOV (HL),A
6963 C3 8D 68                   JMP 0x688d
6966 21 3B 00    LAB_ram_6966:  LXI HL,0x3b
6969 39                         DAD HL,SP
696A 4E                         MOV C,(HL)
696B 06 00                      MVI B,0x0
696D 21 08 00                   LXI HL,0x8
6970 39                         DAD HL,SP
6971 EB                         XCHG
6972 CD 29 76                   CALL 0x7629
6975 E5                         PUSH HL
6976 21 3E 00                   LXI HL,0x3e
6979 39                         DAD HL,SP
697A 7E                         MOV A,(HL)
697B E1                         POP HL
697C 77                         MOV (HL),A
697D 21 3B 00                   LXI HL,0x3b
6980 39                         DAD HL,SP
6981 7E                         MOV A,(HL)
6982 3C                         INR A
6983 77                         MOV (HL),A
6984 C2 74 68                   JNZ 0x6874
6987 21 08 00    LAB_ram_6987:  LXI HL,0x8
698A 39                         DAD HL,SP
698B 4E                         MOV C,(HL)
698C 23                         INX HL
698D 46                         MOV B,(HL)
698E 60                         MOV H,B
698F 69                         MOV L,C
6990 3E 39                      MVI A,0x39
6992 BE                         CMP (HL)
6993 D2 BC 69                   JNC 0x69bc
6996 21 08 00                   LXI HL,0x8
6999 39                         DAD HL,SP
699A 4E                         MOV C,(HL)
699B 23                         INX HL
699C 46                         MOV B,(HL)
699D 60                         MOV H,B
699E 69                         MOV L,C
699F 36 31                      MVI (HL),0x31
69A1 21 06 00                   LXI HL,0x6
69A4 39                         DAD HL,SP
69A5 4E                         MOV C,(HL)
69A6 23                         INX HL
69A7 46                         MOV B,(HL)
69A8 60                         MOV H,B
69A9 69                         MOV L,C
69AA 4E                         MOV C,(HL)
69AB 23                         INX HL
69AC 46                         MOV B,(HL)
69AD 03                         INX BC
69AE 21 06 00                   LXI HL,0x6
69B1 39                         DAD HL,SP
69B2 C5                         PUSH BC
69B3 4E                         MOV C,(HL)
69B4 23                         INX HL
69B5 46                         MOV B,(HL)
69B6 60                         MOV H,B
69B7 69                         MOV L,C
69B8 C1                         POP BC
69B9 71                         MOV (HL),C
69BA 23                         INX HL
69BB 70                         MOV (HL),B
69BC 21 0F 00    LAB_ram_69bc:  LXI HL,0xf
69BF 39                         DAD HL,SP
69C0 7E                         MOV A,(HL)
69C1 1F                         RAR
69C2 D2 1B 6A                   JNC 0x6a1b
69C5 21 3B 00                   LXI HL,0x3b
69C8 39                         DAD HL,SP
69C9 36 09                      MVI (HL),0x9
69CB 21 0C 00    LAB_ram_69cb:  LXI HL,0xc
69CE 39                         DAD HL,SP
69CF 4E                         MOV C,(HL)
69D0 23                         INX HL
69D1 46                         MOV B,(HL)
69D2 0A                         LDAX (BC)
69D3 3D                         DCR A
69D4 21 3B 00                   LXI HL,0x3b
69D7 39                         DAD HL,SP
69D8 BE                         CMP (HL)
69D9 DA F7 69                   JC 0x69f7
69DC 21 3B 00                   LXI HL,0x3b
69DF 39                         DAD HL,SP
69E0 4E                         MOV C,(HL)
69E1 06 00                      MVI B,0x0
69E3 21 08 00                   LXI HL,0x8
69E6 39                         DAD HL,SP
69E7 EB                         XCHG
69E8 CD 29 76                   CALL 0x7629
69EB 36 30                      MVI (HL),0x30
69ED 21 3B 00                   LXI HL,0x3b
69F0 39                         DAD HL,SP
69F1 7E                         MOV A,(HL)
69F2 3C                         INR A
69F3 77                         MOV (HL),A
69F4 C2 CB 69                   JNZ 0x69cb
69F7 21 06 00    LAB_ram_69f7:  LXI HL,0x6
69FA 39                         DAD HL,SP
69FB 4E                         MOV C,(HL)
69FC 23                         INX HL
69FD 46                         MOV B,(HL)
69FE 21 0C 00                   LXI HL,0xc
6A01 39                         DAD HL,SP
6A02 C5                         PUSH BC
6A03 4E                         MOV C,(HL)
6A04 23                         INX HL
6A05 46                         MOV B,(HL)
6A06 0A                         LDAX (BC)
6A07 D6 09                      SUI 0x9
6A09 D1                         POP DE
6A0A CD 7C 76                   CALL 0x767c
6A0D E5                         PUSH HL
6A0E 21 08 00                   LXI HL,0x8
6A11 39                         DAD HL,SP
6A12 4E                         MOV C,(HL)
6A13 23                         INX HL
6A14 46                         MOV B,(HL)
6A15 60                         MOV H,B
6A16 69                         MOV L,C
6A17 C1                         POP BC
6A18 71                         MOV (HL),C
6A19 23                         INX HL
6A1A 70                         MOV (HL),B
6A1B 21 3D 00    LAB_ram_6a1b:  LXI HL,0x3d
6A1E 39                         DAD HL,SP
6A1F F9                         SPHL
6A20 C9                         RET

; ============================================================
; FUN_ram_6a21
; вызовы из: 6378 6BBE 6FDC 704D 7474
6A21 F5          FUN_ram_6a21:  PUSH AF
6A22 E5                         PUSH HL
6A23 D5                         PUSH DE
6A24 97                         SUB A
6A25 02                         STAX (BC)
6A26 21 11 00                   LXI HL,0x11
6A29 09                         DAD HL,BC
6A2A 57                         MOV D,A
6A2B 3E 0D                      MVI A,0xd
6A2D 72          LAB_ram_6a2d:  MOV (HL),D
6A2E 2B                         DCX HL
6A2F 3D                         DCR A
6A30 C2 2D 6A                   JNZ 0x6a2d
6A33 D1                         POP DE
6A34 E1                         POP HL
6A35 F1                         POP AF
6A36 C9                         RET

; ============================================================
; FUN_ram_6a37
; вызовы из: 37DD 37E6 66CB 6721 67A0 67F9
6A37 E5          FUN_ram_6a37:  PUSH HL
6A38 D5                         PUSH DE
6A39 CD 7D 73                   CALL 0x737d
6A3C FE 02                      CPI 0x2
6A3E CA 5A 6A                   JZ 0x6a5a
6A41 DA C4 6A                   JC 0x6ac4
6A44 FE 04                      CPI 0x4
6A46 CA 93 6A                   JZ 0x6a93
6A49 21 00 00                   LXI HL,0x0
6A4C D2 5A 6A                   JNC 0x6a5a
6A4F 13                         INX DE
6A50 13                         INX DE
6A51 13                         INX DE
6A52 1A                         LDAX (DE)
6A53 17                         RAL
6A54 DA 9B 6A                   JC 0x6a9b
6A57 C3 A3 6A                   JMP 0x6aa3
6A5A EB          LAB_ram_6a5a:  XCHG
6A5B 21 11 00                   LXI HL,0x11
6A5E 09                         DAD HL,BC
6A5F 7A                         MOV A,D
6A60 BE                         CMP (HL)
6A61 DA A3 6A                   JC 0x6aa3
6A64 C2 9B 6A                   JNZ 0x6a9b
6A67 7B                         MOV A,E
6A68 2B                         DCX HL
6A69 BE                         CMP (HL)
6A6A DA B8 6A                   JC 0x6ab8
6A6D C2 AC 6A                   JNZ 0x6aac
6A70 2B                         DCX HL
6A71 D1                         POP DE
6A72 D5                         PUSH DE
6A73 13                         INX DE
6A74 13                         INX DE
6A75 1A                         LDAX (DE)
6A76 F6 80                      ORI 0x80
6A78 BE                         CMP (HL)
6A79 DA B8 6A                   JC 0x6ab8
6A7C C2 AC 6A                   JNZ 0x6aac
6A7F 1B                         DCX DE
6A80 2B                         DCX HL
6A81 1A                         LDAX (DE)
6A82 BE                         CMP (HL)
6A83 DA B8 6A                   JC 0x6ab8
6A86 C2 AC 6A                   JNZ 0x6aac
6A89 2B                         DCX HL
6A8A 1B                         DCX DE
6A8B 1A                         LDAX (DE)
6A8C BE                         CMP (HL)
6A8D DA B8 6A                   JC 0x6ab8
6A90 C2 AC 6A                   JNZ 0x6aac
6A93 0A          LAB_ram_6a93:  LDAX (BC)
6A94 E6 10                      ANI 0x10
6A96 F6 80                      ORI 0x80
6A98 C3 A8 6A                   JMP 0x6aa8
6A9B 0A          LAB_ram_6a9b:  LDAX (BC)
6A9C E6 10                      ANI 0x10
6A9E F6 40                      ORI 0x40
6AA0 C3 A8 6A                   JMP 0x6aa8
6AA3 0A          LAB_ram_6aa3:  LDAX (BC)
6AA4 E6 10                      ANI 0x10
6AA6 F6 20                      ORI 0x20
6AA8 02          LAB_ram_6aa8:  STAX (BC)
6AA9 D1                         POP DE
6AAA E1                         POP HL
6AAB C9                         RET
6AAC 21 11 00    LAB_ram_6aac:  LXI HL,0x11
6AAF 09                         DAD HL,BC
6AB0 7E                         MOV A,(HL)
6AB1 17                         RAL
6AB2 DA 9B 6A                   JC 0x6a9b
6AB5 C3 A3 6A                   JMP 0x6aa3
6AB8 21 11 00    LAB_ram_6ab8:  LXI HL,0x11
6ABB 09                         DAD HL,BC
6ABC 7E                         MOV A,(HL)
6ABD 17                         RAL
6ABE DA A3 6A                   JC 0x6aa3
6AC1 C3 9B 6A                   JMP 0x6a9b
6AC4 C5          LAB_ram_6ac4:  PUSH BC
6AC5 C5                         PUSH BC
6AC6 21 D4 6A                   LXI HL,0x6ad4
6AC9 E5                         PUSH HL
6ACA 03                         INX BC
6ACB 0A                         LDAX (BC)
6ACC 6F                         MOV L,A
6ACD 03                         INX BC
6ACE 0A                         LDAX (BC)
6ACF 67                         MOV H,A
6AD0 01 06 00                   LXI BC,0x6
6AD3 E9                         PCHL
6AD4 C1                         ?? C1h
6AD5 0A                         ?? 0Ah
6AD6 C3                         ?? C3h
6AD7 A9                         ?? A9h
6AD8 6A                         ?? 6Ah    j

; ============================================================
; FUN_ram_6ad9
6AD9 21 EB FF    FUN_ram_6ad9:  LXI HL,0xffeb
6ADC 39                         DAD HL,SP
6ADD F9                         SPHL
6ADE D5                         PUSH DE
6ADF C5                         PUSH BC
6AE0 21 02 00                   LXI HL,0x2
6AE3 39                         DAD HL,SP
6AE4 4E                         MOV C,(HL)
6AE5 23                         INX HL
6AE6 46                         MOV B,(HL)
6AE7 21 06 00                   LXI HL,0x6
6AEA 39                         DAD HL,SP
6AEB 71                         MOV (HL),C
6AEC 23                         INX HL
6AED 70                         MOV (HL),B
6AEE 03                         INX BC
6AEF 21 0C 00                   LXI HL,0xc
6AF2 39                         DAD HL,SP
6AF3 71                         MOV (HL),C
6AF4 23                         INX HL
6AF5 70                         MOV (HL),B
6AF6 21 02 00                   LXI HL,0x2
6AF9 39                         DAD HL,SP
6AFA 4E                         MOV C,(HL)
6AFB 23                         INX HL
6AFC 46                         MOV B,(HL)
6AFD 03                         INX BC
6AFE 03                         INX BC
6AFF 03                         INX BC
6B00 21 0A 00                   LXI HL,0xa
6B03 39                         DAD HL,SP
6B04 71                         MOV (HL),C
6B05 23                         INX HL
6B06 70                         MOV (HL),B
6B07 3E 04                      MVI A,0x4
6B09 21 02 00                   LXI HL,0x2
6B0C 39                         DAD HL,SP
6B0D CD 32 76                   CALL 0x7632
6B10 EB                         XCHG
6B11 23                         INX HL
6B12 73                         MOV (HL),E
6B13 23                         INX HL
6B14 72                         MOV (HL),D
6B15 21 0C 00                   LXI HL,0xc
6B18 39                         DAD HL,SP
6B19 4E                         MOV C,(HL)
6B1A 23                         INX HL
6B1B 46                         MOV B,(HL)
6B1C E5                         PUSH HL
6B1D 60                         MOV H,B
6B1E 69                         MOV L,C
6B1F 4E                         MOV C,(HL)
6B20 23                         INX HL
6B21 46                         MOV B,(HL)
6B22 E1                         POP HL
6B23 23                         INX HL
6B24 71                         MOV (HL),C
6B25 23                         INX HL
6B26 70                         MOV (HL),B
6B27 21 0A 00                   LXI HL,0xa
6B2A 39                         DAD HL,SP
6B2B 4E                         MOV C,(HL)
6B2C 23                         INX HL
6B2D 46                         MOV B,(HL)
6B2E 0A                         LDAX (BC)
6B2F 21 10 00                   LXI HL,0x10
6B32 39                         DAD HL,SP
6B33 77                         MOV (HL),A
6B34 EB                         XCHG
6B35 4E                         MOV C,(HL)
6B36 23                         INX HL
6B37 46                         MOV B,(HL)
6B38 21 08 00                   LXI HL,0x8
6B3B 39                         DAD HL,SP
6B3C 71                         MOV (HL),C
6B3D 23                         INX HL
6B3E 70                         MOV (HL),B
6B3F 21 08 00    LAB_ram_6b3f:  LXI HL,0x8
6B42 39                         DAD HL,SP
6B43 4E                         MOV C,(HL)
6B44 23                         INX HL
6B45 46                         MOV B,(HL)
6B46 0A                         LDAX (BC)
6B47 D6 30                      SUI 0x30
6B49 D6 01                      SUI 0x1
6B4B 9F                         SBB A
6B4C 21 10 00                   LXI HL,0x10
6B4F 39                         DAD HL,SP
6B50 F5                         PUSH AF
6B51 7E                         MOV A,(HL)
6B52 D6 00                      SUI 0x0
6B54 C6 FF                      ADI 0xff
6B56 9F                         SBB A
6B57 C1                         POP BC
6B58 48                         MOV C,B
6B59 A1                         ANA C
6B5A 1F                         RAR
6B5B D2 72 6B                   JNC 0x6b72
6B5E 21 08 00                   LXI HL,0x8
6B61 39                         DAD HL,SP
6B62 4E                         MOV C,(HL)
6B63 23                         INX HL
6B64 46                         MOV B,(HL)
6B65 03                         INX BC
6B66 2B                         DCX HL
6B67 71                         MOV (HL),C
6B68 23                         INX HL
6B69 70                         MOV (HL),B
6B6A 21 10 00                   LXI HL,0x10
6B6D 39                         DAD HL,SP
6B6E 35                         DCR (HL)
6B6F C3 3F 6B                   JMP 0x6b3f
6B72 21 10 00    LAB_ram_6b72:  LXI HL,0x10
6B75 39                         DAD HL,SP
6B76 7E                         MOV A,(HL)
6B77 3D                         DCR A
6B78 4F                         MOV C,A
6B79 06 00                      MVI B,0x0
6B7B 21 08 00                   LXI HL,0x8
6B7E 39                         DAD HL,SP
6B7F EB                         XCHG
6B80 CD 29 76                   CALL 0x7629
6B83 7E                         MOV A,(HL)
6B84 D6 30                      SUI 0x30
6B86 D6 01                      SUI 0x1
6B88 9F                         SBB A
6B89 21 10 00                   LXI HL,0x10
6B8C 39                         DAD HL,SP
6B8D F5                         PUSH AF
6B8E 7E                         MOV A,(HL)
6B8F D6 00                      SUI 0x0
6B91 C6 FF                      ADI 0xff
6B93 9F                         SBB A
6B94 C1                         POP BC
6B95 48                         MOV C,B
6B96 A1                         ANA C
6B97 1F                         RAR
6B98 D2 AD 6B                   JNC 0x6bad
6B9B 21 10 00                   LXI HL,0x10
6B9E 39                         DAD HL,SP
6B9F 35                         DCR (HL)
6BA0 2B                         DCX HL
6BA1 2B                         DCX HL
6BA2 4E                         MOV C,(HL)
6BA3 23                         INX HL
6BA4 46                         MOV B,(HL)
6BA5 03                         INX BC
6BA6 2B                         DCX HL
6BA7 71                         MOV (HL),C
6BA8 23                         INX HL
6BA9 70                         MOV (HL),B
6BAA C3 72 6B                   JMP 0x6b72
6BAD 21 10 00    LAB_ram_6bad:  LXI HL,0x10
6BB0 39                         DAD HL,SP
6BB1 7E                         MOV A,(HL)
6BB2 FE 00                      CPI 0x0
6BB4 C2 C7 6B                   JNZ 0x6bc7
6BB7 21 00 00                   LXI HL,0x0
6BBA 39                         DAD HL,SP
6BBB 4E                         MOV C,(HL)
6BBC 23                         INX HL
6BBD 46                         MOV B,(HL)
6BBE CD 21 6A                   CALL 0x6a21
6BC1 21 19 00                   LXI HL,0x19
6BC4 39                         DAD HL,SP
6BC5 F9                         SPHL
6BC6 C9                         RET
6BC7 21 13 00    LAB_ram_6bc7:  LXI HL,0x13
6BCA 39                         DAD HL,SP
6BCB 36 00                      MVI (HL),0x0
6BCD 23                         INX HL
6BCE 36 00                      MVI (HL),0x0
6BD0 23                         INX HL
6BD1 36 00                      MVI (HL),0x0
6BD3 23                         INX HL
6BD4 36 00                      MVI (HL),0x0
6BD6 3E 09                      MVI A,0x9
6BD8 21 10 00                   LXI HL,0x10
6BDB 39                         DAD HL,SP
6BDC BE                         CMP (HL)
6BDD D2 E9 6B                   JNC 0x6be9
6BE0 21 17 00                   LXI HL,0x17
6BE3 39                         DAD HL,SP
6BE4 36 09                      MVI (HL),0x9
6BE6 C3 F3 6B                   JMP 0x6bf3
6BE9 21 10 00    LAB_ram_6be9:  LXI HL,0x10
6BEC 39                         DAD HL,SP
6BED 7E                         MOV A,(HL)
6BEE 21 17 00                   LXI HL,0x17
6BF1 39                         DAD HL,SP
6BF2 77                         MOV (HL),A
6BF3 21 18 00    LAB_ram_6bf3:  LXI HL,0x18
6BF6 39                         DAD HL,SP
6BF7 36 00                      MVI (HL),0x0
6BF9 21 17 00    LAB_ram_6bf9:  LXI HL,0x17
6BFC 39                         DAD HL,SP
6BFD 7E                         MOV A,(HL)
6BFE 3D                         DCR A
6BFF 23                         INX HL
6C00 BE                         CMP (HL)
6C01 DA 28 6C                   JC 0x6c28
6C04 21 13 00                   LXI HL,0x13
6C07 39                         DAD HL,SP
6C08 E5                         PUSH HL
6C09 21 1A 00                   LXI HL,0x1a
6C0C 39                         DAD HL,SP
6C0D 4E                         MOV C,(HL)
6C0E 06 00                      MVI B,0x0
6C10 21 0A 00                   LXI HL,0xa
6C13 39                         DAD HL,SP
6C14 EB                         XCHG
6C15 CD 29 76                   CALL 0x7629
6C18 7E                         MOV A,(HL)
6C19 D6 30                      SUI 0x30
6C1B 5F                         MOV E,A
6C1C C1                         POP BC
6C1D CD 5E 75                   CALL 0x755e
6C20 21 18 00                   LXI HL,0x18
6C23 39                         DAD HL,SP
6C24 34                         INR (HL)
6C25 C2 F9 6B                   JNZ 0x6bf9
6C28 21 13 00    LAB_ram_6c28:  LXI HL,0x13
6C2B 39                         DAD HL,SP
6C2C E5                         PUSH HL
6C2D 21 02 00                   LXI HL,0x2
6C30 39                         DAD HL,SP
6C31 4E                         MOV C,(HL)
6C32 23                         INX HL
6C33 46                         MOV B,(HL)
6C34 D1                         POP DE
6C35 CD AF 6F                   CALL 0x6faf
6C38 21 10 00                   LXI HL,0x10
6C3B 39                         DAD HL,SP
6C3C 7E                         MOV A,(HL)
6C3D 21 0E 00                   LXI HL,0xe
6C40 39                         DAD HL,SP
6C41 CD 32 76                   CALL 0x7632
6C44 E5                         PUSH HL
6C45 21 19 00                   LXI HL,0x19
6C48 39                         DAD HL,SP
6C49 7E                         MOV A,(HL)
6C4A D1                         POP DE
6C4B CD 65 76                   CALL 0x7665
6C4E EB                         XCHG
6C4F 21 0E 00                   LXI HL,0xe
6C52 39                         DAD HL,SP
6C53 73                         MOV (HL),E
6C54 23                         INX HL
6C55 72                         MOV (HL),D
6C56 EB                         XCHG
6C57 11 00 80                   LXI DE,0x8000
6C5A CD 5E 76                   CALL 0x765e
6C5D 9F                         SBB A
6C5E 21 11 00                   LXI HL,0x11
6C61 39                         DAD HL,SP
6C62 77                         MOV (HL),A
6C63 1F                         RAR
6C64 D2 73 6C                   JNC 0x6c73
6C67 21 0E 00                   LXI HL,0xe
6C6A 39                         DAD HL,SP
6C6B CD 41 76                   CALL 0x7641
6C6E EB                         XCHG
6C6F 2B                         DCX HL
6C70 73                         MOV (HL),E
6C71 23                         INX HL
6C72 72                         MOV (HL),D
6C73 3E 3F       LAB_ram_6c73:  MVI A,0x3f
6C75 21 0E 00                   LXI HL,0xe
6C78 39                         DAD HL,SP
6C79 CD 87 76                   CALL 0x7687
6C7C D2 89 6C                   JNC 0x6c89
6C7F 3E 3F                      MVI A,0x3f
6C81 21 0E 00                   LXI HL,0xe
6C84 39                         DAD HL,SP
6C85 77                         MOV (HL),A
6C86 23                         INX HL
6C87 36 00                      MVI (HL),0x0
6C89 21 12 00    LAB_ram_6c89:  LXI HL,0x12
6C8C 39                         DAD HL,SP
6C8D 36 00                      MVI (HL),0x0
6C8F 2B                         DCX HL
6C90 7E                         MOV A,(HL)
6C91 1F                         RAR
6C92 D2 DC 6C                   JNC 0x6cdc
6C95 3E 00       LAB_ram_6c95:  MVI A,0x0
6C97 21 0E 00                   LXI HL,0xe
6C9A 39                         DAD HL,SP
6C9B CD 87 76                   CALL 0x7687
6C9E B5                         ORA L
6C9F CA D9 6C                   JZ 0x6cd9
6CA2 21 0E 00                   LXI HL,0xe
6CA5 39                         DAD HL,SP
6CA6 7E                         MOV A,(HL)
6CA7 1F                         RAR
6CA8 D2 C4 6C                   JNC 0x6cc4
6CAB 21 12 00                   LXI HL,0x12
6CAE 39                         DAD HL,SP
6CAF 6E                         MOV L,(HL)
6CB0 26 00                      MVI H,0x0
6CB2 29                         DAD HL,HL
6CB3 29                         DAD HL,HL
6CB4 01 46 75                   LXI BC,0x7546
6CB7 09                         DAD HL,BC
6CB8 E5                         PUSH HL
6CB9 21 02 00                   LXI HL,0x2
6CBC 39                         DAD HL,SP
6CBD 4E                         MOV C,(HL)
6CBE 23                         INX HL
6CBF 46                         MOV B,(HL)
6CC0 D1                         POP DE
6CC1 CD 3D 6D                   CALL 0x6d3d
6CC4 0E 01       LAB_ram_6cc4:  MVI C,0x1
6CC6 21 0E 00                   LXI HL,0xe
6CC9 39                         DAD HL,SP
6CCA CD 4B 76                   CALL 0x764b
6CCD EB                         XCHG
6CCE 2B                         DCX HL
6CCF 73                         MOV (HL),E
6CD0 23                         INX HL
6CD1 72                         MOV (HL),D
6CD2 23                         INX HL
6CD3 23                         INX HL
6CD4 23                         INX HL
6CD5 34                         INR (HL)
6CD6 C3 95 6C                   JMP 0x6c95
6CD9 C3 20 6D    LAB_ram_6cd9:  JMP 0x6d20
6CDC 3E 00       LAB_ram_6cdc:  MVI A,0x0
6CDE 21 0E 00                   LXI HL,0xe
6CE1 39                         DAD HL,SP
6CE2 CD 87 76                   CALL 0x7687
6CE5 B5                         ORA L
6CE6 CA 20 6D                   JZ 0x6d20
6CE9 21 0E 00                   LXI HL,0xe
6CEC 39                         DAD HL,SP
6CED 7E                         MOV A,(HL)
6CEE 1F                         RAR
6CEF D2 0B 6D                   JNC 0x6d0b
6CF2 21 12 00                   LXI HL,0x12
6CF5 39                         DAD HL,SP
6CF6 6E                         MOV L,(HL)
6CF7 26 00                      MVI H,0x0
6CF9 29                         DAD HL,HL
6CFA 29                         DAD HL,HL
6CFB 01 46 75                   LXI BC,0x7546
6CFE 09                         DAD HL,BC
6CFF E5                         PUSH HL
6D00 21 02 00                   LXI HL,0x2
6D03 39                         DAD HL,SP
6D04 4E                         MOV C,(HL)
6D05 23                         INX HL
6D06 46                         MOV B,(HL)
6D07 D1                         POP DE
6D08 CD 3B 70                   CALL 0x703b
6D0B 0E 01       LAB_ram_6d0b:  MVI C,0x1
6D0D 21 0E 00                   LXI HL,0xe
6D10 39                         DAD HL,SP
6D11 CD 4B 76                   CALL 0x764b
6D14 EB                         XCHG
6D15 2B                         DCX HL
6D16 73                         MOV (HL),E
6D17 23                         INX HL
6D18 72                         MOV (HL),D
6D19 23                         INX HL
6D1A 23                         INX HL
6D1B 23                         INX HL
6D1C 34                         INR (HL)
6D1D C3 DC 6C                   JMP 0x6cdc
6D20 21 06 00    LAB_ram_6d20:  LXI HL,0x6
6D23 39                         DAD HL,SP
6D24 4E                         MOV C,(HL)
6D25 23                         INX HL
6D26 46                         MOV B,(HL)
6D27 0A                         LDAX (BC)
6D28 FE 2D                      CPI 0x2d
6D2A C2 37 6D                   JNZ 0x6d37
6D2D 21 00 00                   LXI HL,0x0
6D30 39                         DAD HL,SP
6D31 4E                         MOV C,(HL)
6D32 23                         INX HL
6D33 46                         MOV B,(HL)
6D34 CD 91 71                   CALL 0x7191
6D37 21 19 00    LAB_ram_6d37:  LXI HL,0x19
6D3A 39                         DAD HL,SP
6D3B F9                         SPHL
6D3C C9                         RET

; ============================================================
; FUN_ram_6d3d
; вызовы из: 3173 31A9 31AC 32D6 331C 359B 35DE 360A 3871 39A0 3AEF 67E0 6CC1
6D3D F5          FUN_ram_6d3d:  PUSH AF
6D3E E5                         PUSH HL
6D3F CD 7D 73                   CALL 0x737d
6D42 FE 02                      CPI 0x2
6D44 CA 63 6D                   JZ 0x6d63
6D47 DA 80 6E                   JC 0x6e80
6D4A FE 03                      CPI 0x3
6D4C C2 52 6D                   JNZ 0x6d52
6D4F C3 91 6E                   JMP 0x6e91
6D52 0A          LAB_ram_6d52:  LDAX (BC)
6D53 F6 01                      ORI 0x1
6D55 E6 F9                      ANI 0xf9
6D57 02                         STAX (BC)
6D58 21 03 00                   LXI HL,0x3
6D5B 09                         DAD HL,BC
6D5C 7E                         MOV A,(HL)
6D5D F6 10                      ORI 0x10
6D5F 77                         MOV (HL),A
6D60 C3 80 6E                   JMP 0x6e80
6D63 D5          LAB_ram_6d63:  PUSH DE
6D64 C5                         PUSH BC
6D65 E5                         PUSH HL
6D66 7C                         MOV A,H
6D67 21 11 00                   LXI HL,0x11
6D6A 09                         DAD HL,BC
6D6B 86                         ADD (HL)
6D6C 77                         MOV (HL),A
6D6D 2B                         DCX HL
6D6E 7E                         MOV A,(HL)
6D6F F5                         PUSH AF
6D70 2B                         DCX HL
6D71 7E                         MOV A,(HL)
6D72 2B                         DCX HL
6D73 46                         MOV B,(HL)
6D74 2B                         DCX HL
6D75 4E                         MOV C,(HL)
6D76 E5                         PUSH HL
6D77 21 02 00                   LXI HL,0x2
6D7A E5                         PUSH HL
6D7B E5                         PUSH HL
6D7C 21 01 00                   LXI HL,0x1
6D7F E5                         PUSH HL
6D80 EB                         XCHG
6D81 5E                         MOV E,(HL)
6D82 23                         INX HL
6D83 56                         MOV D,(HL)
6D84 F5                         PUSH AF
6D85 23                         INX HL
6D86 7E                         MOV A,(HL)
6D87 F6 80                      ORI 0x80
6D89 69                         MOV L,C
6D8A 60                         MOV H,B
6D8B 47                         MOV B,A
6D8C F1                         POP AF
6D8D 37                         STC
6D8E 3F                         CMC
6D8F E5          LAB_ram_6d8f:  PUSH HL
6D90 F5                         PUSH AF
6D91 F5                         PUSH AF
6D92 4F                         MOV C,A
6D93 7D                         MOV A,L
6D94 93                         SUB E
6D95 6F                         MOV L,A
6D96 7C                         MOV A,H
6D97 9A                         SBB D
6D98 67                         MOV H,A
6D99 79                         MOV A,C
6D9A 98                         SBB B
6D9B D2 AF 6D                   JNC 0x6daf
6D9E 4F                         MOV C,A
6D9F F1                         POP AF
6DA0 79                         MOV A,C
6DA1 DA B1 6D                   JC 0x6db1
6DA4 F1                         POP AF
6DA5 E1                         POP HL
6DA6 E3                         XTHL
6DA7 29                         DAD HL,HL
6DA8 DA C1 6D                   JC 0x6dc1
6DAB E3                         XTHL
6DAC C3 BC 6D                   JMP 0x6dbc
6DAF 33          LAB_ram_6daf:  INX SP
6DB0 33                         INX SP
6DB1 33          LAB_ram_6db1:  INX SP
6DB2 33                         INX SP
6DB3 33                         INX SP
6DB4 33                         INX SP
6DB5 E3                         XTHL
6DB6 29                         DAD HL,HL
6DB7 23                         INX HL
6DB8 DA C1 6D                   JC 0x6dc1
6DBB E3                         XTHL
6DBC 29          LAB_ram_6dbc:  DAD HL,HL
6DBD 8F                         ADC A
6DBE C3 8F 6D                   JMP 0x6d8f
6DC1 E3          LAB_ram_6dc1:  XTHL
6DC2 3B                         DCX SP
6DC3 3B                         DCX SP
6DC4 E5                         PUSH HL
6DC5 F5                         PUSH AF
6DC6 21 0A 00                   LXI HL,0xa
6DC9 39                         DAD HL,SP
6DCA 7E                         MOV A,(HL)
6DCB 3D                         DCR A
6DCC CA E1 6D                   JZ 0x6de1
6DCF 2B                         DCX HL
6DD0 2B                         DCX HL
6DD1 77                         MOV (HL),A
6DD2 2B                         DCX HL
6DD3 2B                         DCX HL
6DD4 2B                         DCX HL
6DD5 36 00                      MVI (HL),0x0
6DD7 2B                         DCX HL
6DD8 36 7F                      MVI (HL),0x7f
6DDA F1                         POP AF
6DDB E1                         POP HL
6DDC 29                         DAD HL,HL
6DDD 8F                         ADC A
6DDE C3 8F 6D                   JMP 0x6d8f
6DE1 0E 20       LAB_ram_6de1:  MVI C,0x20
6DE3 F1                         POP AF
6DE4 E1                         POP HL
6DE5 B7                         ORA A
6DE6 C2 F5 6D                   JNZ 0x6df5
6DE9 7C                         MOV A,H
6DEA B7                         ORA A
6DEB C2 F5 6D                   JNZ 0x6df5
6DEE 7D                         MOV A,L
6DEF B7                         ORA A
6DF0 C2 F5 6D                   JNZ 0x6df5
6DF3 0E 00                      MVI C,0x0
6DF5 E1          LAB_ram_6df5:  POP HL
6DF6 E1                         POP HL
6DF7 D1                         POP DE
6DF8 06 00                      MVI B,0x0
6DFA 29                         DAD HL,HL
6DFB 29                         DAD HL,HL
6DFC 29                         DAD HL,HL
6DFD 29                         DAD HL,HL
6DFE 29                         DAD HL,HL
6DFF 29                         DAD HL,HL
6E00 7A                         MOV A,D
6E01 17                         RAL
6E02 DA 13 6E                   JC 0x6e13
6E05 06 01                      MVI B,0x1
6E07 29                         DAD HL,HL
6E08 EB                         XCHG
6E09 DA 10 6E                   JC 0x6e10
6E0C 29                         DAD HL,HL
6E0D C3 12 6E                   JMP 0x6e12
6E10 29          LAB_ram_6e10:  DAD HL,HL
6E11 23                         INX HL
6E12 EB          LAB_ram_6e12:  XCHG
6E13 7D          LAB_ram_6e13:  MOV A,L
6E14 B1                         ORA C
6E15 6C                         MOV L,H
6E16 63                         MOV H,E
6E17 4A                         MOV C,D
6E18 CD B8 75                   CALL 0x75b8
6E1B EB                         XCHG
6E1C E1                         POP HL
6E1D E1                         POP HL
6E1E E1                         POP HL
6E1F 73                         MOV (HL),E
6E20 23                         INX HL
6E21 72                         MOV (HL),D
6E22 23                         INX HL
6E23 71                         MOV (HL),C
6E24 23                         INX HL
6E25 4F                         MOV C,A
6E26 3E 7F                      MVI A,0x7f
6E28 81                         ADD C
6E29 90                         SUB B
6E2A 47                         MOV B,A
6E2B F1                         POP AF
6E2C 80                         ADD B
6E2D 4F                         MOV C,A
6E2E 06 01                      MVI B,0x1
6E30 DA 35 6E                   JC 0x6e35
6E33 06 00                      MVI B,0x0
6E35 D1          LAB_ram_6e35:  POP DE
6E36 79                         MOV A,C
6E37 93                         SUB E
6E38 5F                         MOV E,A
6E39 78                         MOV A,B
6E3A DA 49 6E                   JC 0x6e49
6E3D B7                         ORA A
6E3E C2 6F 6E                   JNZ 0x6e6f
6E41 7B                         MOV A,E
6E42 B7                         ORA A
6E43 CA 5C 6E                   JZ 0x6e5c
6E46 C3 53 6E                   JMP 0x6e53
6E49 B7          LAB_ram_6e49:  ORA A
6E4A CA 5C 6E                   JZ 0x6e5c
6E4D 7B                         MOV A,E
6E4E FE FF                      CPI 0xff
6E50 CA 6F 6E                   JZ 0x6e6f
6E53 77          LAB_ram_6e53:  MOV (HL),A
6E54 C1                         POP BC
6E55 3E 10                      MVI A,0x10
6E57 02                         STAX (BC)
6E58 D1                         POP DE
6E59 E1                         POP HL
6E5A F1                         POP AF
6E5B C9                         RET
6E5C 7B          LAB_ram_6e5c:  MOV A,E
6E5D C6 BE                      ADI 0xbe
6E5F 77                         MOV (HL),A
6E60 C1                         POP BC
6E61 21 03 00                   LXI HL,0x3
6E64 09                         DAD HL,BC
6E65 7E                         MOV A,(HL)
6E66 F6 20                      ORI 0x20
6E68 77                         MOV (HL),A
6E69 3E 14                      MVI A,0x14
6E6B 02                         STAX (BC)
6E6C C3 7F 6E                   JMP 0x6e7f
6E6F 7B          LAB_ram_6e6f:  MOV A,E
6E70 DE BE                      SBI 0xbe
6E72 77                         MOV (HL),A
6E73 C1                         POP BC
6E74 21 03 00                   LXI HL,0x3
6E77 09                         DAD HL,BC
6E78 7E                         MOV A,(HL)
6E79 F6 40                      ORI 0x40
6E7B 77                         MOV (HL),A
6E7C 3E 13                      MVI A,0x13
6E7E 02                         STAX (BC)
6E7F D1          LAB_ram_6e7f:  POP DE
6E80 C5          LAB_ram_6e80:  PUSH BC
6E81 C5                         PUSH BC
6E82 21 90 6E                   LXI HL,0x6e90
6E85 E5                         PUSH HL
6E86 03                         INX BC
6E87 0A                         LDAX (BC)
6E88 6F                         MOV L,A
6E89 03                         INX BC
6E8A 0A                         LDAX (BC)
6E8B 67                         MOV H,A
6E8C 01 04 00                   LXI BC,0x4
6E8F E9                         PCHL
6E90 C1                         ?? C1h
6E91 E1          LAB_ram_6e91:  POP HL
6E92 F1                         POP AF
6E93 C9                         RET

; ============================================================
; FUN_ram_6e94
6E94 D5          FUN_ram_6e94:  PUSH DE
6E95 21 03 00                   LXI HL,0x3
6E98 09                         DAD HL,BC
6E99 5E                         MOV E,(HL)
6E9A 23                         INX HL
6E9B 56                         MOV D,(HL)
6E9C EB                         XCHG
6E9D D1                         POP DE
6E9E C9                         RET

; ============================================================
; FUN_ram_6e9f
; вызовы из: 34E7 35A1 39AC 3A92 3BAD 6864
6E9F F5          FUN_ram_6e9f:  PUSH AF
6EA0 E5                         PUSH HL
6EA1 C5                         PUSH BC
6EA2 D5                         PUSH DE
6EA3 0A                         LDAX (BC)
6EA4 E6 17                      ANI 0x17
6EA6 FE 15                      CPI 0x15
6EA8 CA 3F 6F                   JZ 0x6f3f
6EAB 21 11 00                   LXI HL,0x11
6EAE 09                         DAD HL,BC
6EAF 7E                         MOV A,(HL)
6EB0 F5                         PUSH AF
6EB1 2B                         DCX HL
6EB2 7E                         MOV A,(HL)
6EB3 FE 7F                      CPI 0x7f
6EB5 DA 14 6F                   JC 0x6f14
6EB8 2B                         DCX HL
6EB9 46                         MOV B,(HL)
6EBA 2B                         DCX HL
6EBB 4E                         MOV C,(HL)
6EBC 2B                         DCX HL
6EBD 56                         MOV D,(HL)
6EBE 1E 00                      MVI E,0x0
6EC0 FE 9E                      CPI 0x9e
6EC2 CA F7 6E                   JZ 0x6ef7
6EC5 D2 2B 6F                   JNC 0x6f2b
6EC8 D6 7F                      SUI 0x7f
6ECA 6F                         MOV L,A
6ECB 3E 1F                      MVI A,0x1f
6ECD 95                         SUB L
6ECE 6F                         MOV L,A
6ECF 97          LAB_ram_6ecf:  SUB A
6ED0 78                         MOV A,B
6ED1 1F                         RAR
6ED2 47                         MOV B,A
6ED3 79                         MOV A,C
6ED4 1F                         RAR
6ED5 4F                         MOV C,A
6ED6 7A                         MOV A,D
6ED7 1F                         RAR
6ED8 57                         MOV D,A
6ED9 7B                         MOV A,E
6EDA 1F                         RAR
6EDB 5F                         MOV E,A
6EDC 2D                         DCR L
6EDD C2 CF 6E                   JNZ 0x6ecf
6EE0 F1                         POP AF
6EE1 B7                         ORA A
6EE2 CA 1B 6F                   JZ 0x6f1b
6EE5 97                         SUB A
6EE6 93                         SUB E
6EE7 5F                         MOV E,A
6EE8 3E 00                      MVI A,0x0
6EEA 9A                         SBB D
6EEB 57                         MOV D,A
6EEC 3E 00                      MVI A,0x0
6EEE 99                         SBB C
6EEF 4F                         MOV C,A
6EF0 3E 00                      MVI A,0x0
6EF2 98                         SBB B
6EF3 47                         MOV B,A
6EF4 C3 1B 6F                   JMP 0x6f1b
6EF7 F1          LAB_ram_6ef7:  POP AF
6EF8 B7                         ORA A
6EF9 CA 2C 6F                   JZ 0x6f2c
6EFC 78                         MOV A,B
6EFD FE 80                      CPI 0x80
6EFF C2 2C 6F                   JNZ 0x6f2c
6F02 79                         MOV A,C
6F03 B7                         ORA A
6F04 C2 2C 6F                   JNZ 0x6f2c
6F07 7A                         MOV A,D
6F08 B7                         ORA A
6F09 C2 2C 6F                   JNZ 0x6f2c
6F0C 7B                         MOV A,E
6F0D B7                         ORA A
6F0E C2 2C 6F                   JNZ 0x6f2c
6F11 C3 1B 6F                   JMP 0x6f1b
6F14 01 00 00    LAB_ram_6f14:  LXI BC,0x0
6F17 11 00 00                   LXI DE,0x0
6F1A F1                         POP AF
6F1B E1          LAB_ram_6f1b:  POP HL
6F1C 73                         MOV (HL),E
6F1D 23                         INX HL
6F1E 72                         MOV (HL),D
6F1F 23                         INX HL
6F20 71                         MOV (HL),C
6F21 23                         INX HL
6F22 70                         MOV (HL),B
6F23 2B                         DCX HL
6F24 2B                         DCX HL
6F25 2B                         DCX HL
6F26 EB                         XCHG
6F27 C1                         POP BC
6F28 E1                         POP HL
6F29 F1                         POP AF
6F2A C9                         RET
6F2B F1          LAB_ram_6f2b:  POP AF
6F2C D1          LAB_ram_6f2c:  POP DE
6F2D C1                         POP BC
6F2E C5                         PUSH BC
6F2F C5                         PUSH BC
6F30 3E 13                      MVI A,0x13
6F32 02                         STAX (BC)
6F33 03                         INX BC
6F34 03                         INX BC
6F35 03                         INX BC
6F36 0A                         LDAX (BC)
6F37 F6 40                      ORI 0x40
6F39 02                         STAX (BC)
6F3A 0B                         DCX BC
6F3B 0B                         DCX BC
6F3C C3 44 6F                   JMP 0x6f44
6F3F D1          LAB_ram_6f3f:  POP DE
6F40 C1                         POP BC
6F41 C5                         PUSH BC
6F42 C5                         PUSH BC
6F43 03                         INX BC
6F44 0A          LAB_ram_6f44:  LDAX (BC)
6F45 6F                         MOV L,A
6F46 03                         INX BC
6F47 0A                         LDAX (BC)
6F48 67                         MOV H,A
6F49 01 51 6F                   LXI BC,0x6f51
6F4C C5                         PUSH BC
6F4D 01 05 00                   LXI BC,0x5
6F50 E9                         PCHL
6F51 C3                         ?? C3h
6F52 27                         ?? 27h    '
6F53 6F                         ?? 6Fh    o

; ============================================================
; FUN_ram_6f54
; вызовы из: 32C4 32F5 3316 348D 34A8 34BA 34D5 3595 35C4 35D1 35FD 3626 36A7 36BB 36C8 36DA 36EF 3713 372B 3789 …
6F54 E5          FUN_ram_6f54:  PUSH HL
6F55 F5                         PUSH AF
6F56 D5                         PUSH DE
6F57 21 0D 00                   LXI HL,0xd
6F5A 09                         DAD HL,BC
6F5B 1A                         LDAX (DE)
6F5C 77                         MOV (HL),A
6F5D 23                         INX HL
6F5E 13                         INX DE
6F5F 1A                         LDAX (DE)
6F60 77                         MOV (HL),A
6F61 23                         INX HL
6F62 13                         INX DE
6F63 1A                         LDAX (DE)
6F64 F6 80                      ORI 0x80
6F66 77                         MOV (HL),A
6F67 1A                         LDAX (DE)
6F68 17                         RAL
6F69 13                         INX DE
6F6A 23                         INX HL
6F6B 1A                         LDAX (DE)
6F6C 17                         RAL
6F6D 77                         MOV (HL),A
6F6E F5                         PUSH AF
6F6F 23                         INX HL
6F70 1A                         LDAX (DE)
6F71 E6 80                      ANI 0x80
6F73 77                         MOV (HL),A
6F74 F1                         POP AF
6F75 B7                         ORA A
6F76 CA 85 6F                   JZ 0x6f85
6F79 FE FF                      CPI 0xff
6F7B CA A2 6F                   JZ 0x6fa2
6F7E 3E 10                      MVI A,0x10
6F80 02          LAB_ram_6f80:  STAX (BC)
6F81 D1                         POP DE
6F82 F1                         POP AF
6F83 E1                         POP HL
6F84 C9                         RET
6F85 2B          LAB_ram_6f85:  DCX HL
6F86 2B                         DCX HL
6F87 7E                         MOV A,(HL)
6F88 E6 7F                      ANI 0x7f
6F8A 77                         MOV (HL),A
6F8B 23                         INX HL
6F8C 23                         INX HL
6F8D 97                         SUB A
6F8E BE                         CMP (HL)
6F8F C2 A2 6F                   JNZ 0x6fa2
6F92 2B                         DCX HL
6F93 2B                         DCX HL
6F94 BE                         CMP (HL)
6F95 C2 A2 6F                   JNZ 0x6fa2
6F98 2B                         DCX HL
6F99 BE                         CMP (HL)
6F9A C2 A2 6F                   JNZ 0x6fa2
6F9D 2B                         DCX HL
6F9E BE                         CMP (HL)
6F9F CA 80 6F                   JZ 0x6f80
6FA2 21 03 00    LAB_ram_6fa2:  LXI HL,0x3
6FA5 09                         DAD HL,BC
6FA6 7E                         MOV A,(HL)
6FA7 F6 80                      ORI 0x80
6FA9 77                         MOV (HL),A
6FAA 3E 15                      MVI A,0x15
6FAC C3 80 6F                   JMP 0x6f80

; ============================================================
; FUN_ram_6faf
; вызовы из: 314F 3161 319A 3299 32A2 32AB 32B4 3636 3898 397C 398E 39B5 3A9B 6C35
6FAF F5          FUN_ram_6faf:  PUSH AF
6FB0 E5                         PUSH HL
6FB1 D5                         PUSH DE
6FB2 C5                         PUSH BC
6FB3 21 11 00                   LXI HL,0x11
6FB6 09                         DAD HL,BC
6FB7 E5                         PUSH HL
6FB8 EB                         XCHG
6FB9 5E                         MOV E,(HL)
6FBA 23                         INX HL
6FBB 56                         MOV D,(HL)
6FBC 23                         INX HL
6FBD 4E                         MOV C,(HL)
6FBE 23                         INX HL
6FBF 46                         MOV B,(HL)
6FC0 7B                         MOV A,E
6FC1 B7                         ORA A
6FC2 C2 EA 6F                   JNZ 0x6fea
6FC5 7A                         MOV A,D
6FC6 B7                         ORA A
6FC7 C2 EA 6F                   JNZ 0x6fea
6FCA 79                         MOV A,C
6FCB B7                         ORA A
6FCC C2 EA 6F                   JNZ 0x6fea
6FCF 78                         MOV A,B
6FD0 FE 80                      CPI 0x80
6FD2 CA E2 6F                   JZ 0x6fe2
6FD5 B7                         ORA A
6FD6 C2 EA 6F                   JNZ 0x6fea
6FD9 C1                         POP BC
6FDA C1                         POP BC
6FDB D1                         POP DE
6FDC CD 21 6A                   CALL 0x6a21
6FDF C3 38 70                   JMP 0x7038
6FE2 3E 80       LAB_ram_6fe2:  MVI A,0x80
6FE4 48                         MOV C,B
6FE5 06 9E                      MVI B,0x9e
6FE7 C3 29 70                   JMP 0x7029
6FEA 78          LAB_ram_6fea:  MOV A,B
6FEB E6 80                      ANI 0x80
6FED F5                         PUSH AF
6FEE CA 00 70                   JZ 0x7000
6FF1 97                         SUB A
6FF2 93                         SUB E
6FF3 5F                         MOV E,A
6FF4 3E 00                      MVI A,0x0
6FF6 9A                         SBB D
6FF7 57                         MOV D,A
6FF8 3E 00                      MVI A,0x0
6FFA 99                         SBB C
6FFB 4F                         MOV C,A
6FFC 3E 00                      MVI A,0x0
6FFE 98                         SBB B
6FFF 47                         MOV B,A
7000 EB          LAB_ram_7000:  XCHG
7001 1E 00                      MVI E,0x0
7003 29          LAB_ram_7003:  DAD HL,HL
7004 79                         MOV A,C
7005 8F                         ADC A
7006 4F                         MOV C,A
7007 78                         MOV A,B
7008 8F                         ADC A
7009 47                         MOV B,A
700A 1C                         INR E
700B 17                         RAL
700C D2 03 70                   JNC 0x7003
700F 55                         MOV D,L
7010 6C                         MOV L,H
7011 61                         MOV H,C
7012 48                         MOV C,B
7013 7A                         MOV A,D
7014 E6 1F                      ANI 0x1f
7016 7A                         MOV A,D
7017 CA 1E 70                   JZ 0x701e
701A E6 E0                      ANI 0xe0
701C F6 20                      ORI 0x20
701E CD B8 75    LAB_ram_701e:  CALL 0x75b8
7021 57                         MOV D,A
7022 3E 9E                      MVI A,0x9e
7024 93                         SUB E
7025 82                         ADD D
7026 EB                         XCHG
7027 47                         MOV B,A
7028 F1                         POP AF
7029 E1          LAB_ram_7029:  POP HL
702A 77                         MOV (HL),A
702B 2B                         DCX HL
702C 70                         MOV (HL),B
702D 2B                         DCX HL
702E 71                         MOV (HL),C
702F 2B                         DCX HL
7030 72                         MOV (HL),D
7031 2B                         DCX HL
7032 73                         MOV (HL),E
7033 C1                         POP BC
7034 3E 10                      MVI A,0x10
7036 02                         STAX (BC)
7037 D1                         POP DE
7038 E1          LAB_ram_7038:  POP HL
7039 F1                         POP AF
703A C9                         RET

; ============================================================
; FUN_ram_703b
; вызовы из: 3155 316D 31A0 31A3 32D0 32EC 3304 3322 3481 3493 34AE 34C0 36CE 36E0 36F5 36FB 3719 371F 3796 379C …
703B F5          FUN_ram_703b:  PUSH AF
703C E5                         PUSH HL
703D CD 7D 73                   CALL 0x737d
7040 FE 02                      CPI 0x2
7042 CA 53 70                   JZ 0x7053
7045 DA 7B 71                   JC 0x717b
7048 FE 05                      CPI 0x5
704A C2 8E 71                   JNZ 0x718e
704D CD 21 6A                   CALL 0x6a21
7050 C3 8E 71                   JMP 0x718e
7053 D5          LAB_ram_7053:  PUSH DE
7054 C5                         PUSH BC
7055 E5                         PUSH HL
7056 7C                         MOV A,H
7057 21 11 00                   LXI HL,0x11
705A 09                         DAD HL,BC
705B 86                         ADD (HL)
705C 77                         MOV (HL),A
705D 2B                         DCX HL
705E 4E                         MOV C,(HL)
705F 06 00                      MVI B,0x0
7061 E3                         XTHL
7062 26 00                      MVI H,0x0
7064 09                         DAD HL,BC
7065 23                         INX HL
7066 E3                         XTHL
7067 2B                         DCX HL
7068 46                         MOV B,(HL)
7069 2B                         DCX HL
706A 4E                         MOV C,(HL)
706B 2B                         DCX HL
706C 7E                         MOV A,(HL)
706D E5                         PUSH HL
706E EB                         XCHG
706F 5F                         MOV E,A
7070 23                         INX HL
7071 23                         INX HL
7072 7E                         MOV A,(HL)
7073 F6 80                      ORI 0x80
7075 57                         MOV D,A
7076 D5                         PUSH DE
7077 2B                         DCX HL
7078 56                         MOV D,(HL)
7079 2B                         DCX HL
707A 5E                         MOV E,(HL)
707B 21 00 00                   LXI HL,0x0
707E CD E6 74                   CALL 0x74e6
7081 E5                         PUSH HL
7082 F5                         PUSH AF
7083 21 00 00                   LXI HL,0x0
7086 7A                         MOV A,D
7087 CD E6 74                   CALL 0x74e6
708A E5                         PUSH HL
708B F5                         PUSH AF
708C 21 00 00                   LXI HL,0x0
708F 7B                         MOV A,E
7090 CD E6 74                   CALL 0x74e6
7093 E5                         PUSH HL
7094 F5                         PUSH AF
7095 21 0C 00                   LXI HL,0xc
7098 39                         DAD HL,SP
7099 7E                         MOV A,(HL)
709A 23                         INX HL
709B 46                         MOV B,(HL)
709C 4A                         MOV C,D
709D 57                         MOV D,A
709E 21 00 00                   LXI HL,0x0
70A1 CD E6 74                   CALL 0x74e6
70A4 E5                         PUSH HL
70A5 F5                         PUSH AF
70A6 21 00 00                   LXI HL,0x0
70A9 06 00                      MVI B,0x0
70AB 4B                         MOV C,E
70AC 7A                         MOV A,D
70AD CD E6 74                   CALL 0x74e6
70B0 7D                         MOV A,L
70B1 0E 80                      MVI C,0x80
70B3 B7                         ORA A
70B4 C2 B9 70                   JNZ 0x70b9
70B7 0E 00                      MVI C,0x0
70B9 6C          LAB_ram_70b9:  MOV L,H
70BA 26 00                      MVI H,0x0
70BC F1                         POP AF
70BD D1                         POP DE
70BE 19                         DAD HL,DE
70BF CE 00                      ACI 0x0
70C1 47                         MOV B,A
70C2 D2 C6 70                   JNC 0x70c6
70C5 0C                         INR C
70C6 F1          LAB_ram_70c6:  POP AF
70C7 D1                         POP DE
70C8 19                         DAD HL,DE
70C9 88                         ADC B
70CA D2 CE 70                   JNC 0x70ce
70CD 0C                         INR C
70CE 47          LAB_ram_70ce:  MOV B,A
70CF 7D                         MOV A,L
70D0 6C                         MOV L,H
70D1 60                         MOV H,B
70D2 B7                         ORA A
70D3 CA DA 70                   JZ 0x70da
70D6 79                         MOV A,C
70D7 F6 80                      ORI 0x80
70D9 4F                         MOV C,A
70DA F1          LAB_ram_70da:  POP AF
70DB D1                         POP DE
70DC 19                         DAD HL,DE
70DD CE 00                      ACI 0x0
70DF 47                         MOV B,A
70E0 D2 E7 70                   JNC 0x70e7
70E3 79                         MOV A,C
70E4 F6 40                      ORI 0x40
70E6 4F                         MOV C,A
70E7 F1          LAB_ram_70e7:  POP AF
70E8 D1                         POP DE
70E9 E5                         PUSH HL
70EA 6C                         MOV L,H
70EB 60                         MOV H,B
70EC 19                         DAD HL,DE
70ED CE 00                      ACI 0x0
70EF 47                         MOV B,A
70F0 79                         MOV A,C
70F1 E6 3F                      ANI 0x3f
70F3 84                         ADD H
70F4 67                         MOV H,A
70F5 78                         MOV A,B
70F6 CE 00                      ACI 0x0
70F8 D1                         POP DE
70F9 41                         MOV B,C
70FA 4F                         MOV C,A
70FB 78                         MOV A,B
70FC E6 40                      ANI 0x40
70FE CA 02 71                   JZ 0x7102
7101 0C                         INR C
7102 78          LAB_ram_7102:  MOV A,B
7103 1F                         RAR
7104 1F                         RAR
7105 E6 20                      ANI 0x20
7107 B3                         ORA E
7108 5F                         MOV E,A
7109 E6 3F                      ANI 0x3f
710B 7B                         MOV A,E
710C CA 13 71                   JZ 0x7113
710F E6 E0                      ANI 0xe0
7111 F6 20                      ORI 0x20
7113 5F          LAB_ram_7113:  MOV E,A
7114 79                         MOV A,C
7115 E6 80                      ANI 0x80
7117 7B                         MOV A,E
7118 06 00                      MVI B,0x0
711A C2 22 71                   JNZ 0x7122
711D 06 01                      MVI B,0x1
711F CD 26 75                   CALL 0x7526
7122 CD B8 75    LAB_ram_7122:  CALL 0x75b8
7125 EB                         XCHG
7126 E1                         POP HL
7127 E1                         POP HL
7128 73                         MOV (HL),E
7129 23                         INX HL
712A 72                         MOV (HL),D
712B 23                         INX HL
712C 71                         MOV (HL),C
712D 23                         INX HL
712E D1                         POP DE
712F 4F                         MOV C,A
7130 3E 7F                      MVI A,0x7f
7132 80                         ADD B
7133 91                         SUB C
7134 47                         MOV B,A
7135 7B                         MOV A,E
7136 90                         SUB B
7137 5F                         MOV E,A
7138 C1                         POP BC
7139 3E 10                      MVI A,0x10
713B 02                         STAX (BC)
713C 7A                         MOV A,D
713D DA 4C 71                   JC 0x714c
7140 B7                         ORA A
7141 C2 6B 71                   JNZ 0x716b
7144 7B                         MOV A,E
7145 B7                         ORA A
7146 CA 5A 71                   JZ 0x715a
7149 C3 56 71                   JMP 0x7156
714C B7          LAB_ram_714c:  ORA A
714D CA 5A 71                   JZ 0x715a
7150 7B                         MOV A,E
7151 FE FF                      CPI 0xff
7153 CA 6B 71                   JZ 0x716b
7156 73          LAB_ram_7156:  MOV (HL),E
7157 C3 8D 71                   JMP 0x718d
715A 7B          LAB_ram_715a:  MOV A,E
715B C6 BE                      ADI 0xbe
715D 77                         MOV (HL),A
715E 21 03 00                   LXI HL,0x3
7161 09                         DAD HL,BC
7162 7E                         MOV A,(HL)
7163 F6 20                      ORI 0x20
7165 77                         MOV (HL),A
7166 3E 14                      MVI A,0x14
7168 C3 79 71                   JMP 0x7179
716B 7B          LAB_ram_716b:  MOV A,E
716C DE BE                      SBI 0xbe
716E 77                         MOV (HL),A
716F 21 03 00                   LXI HL,0x3
7172 09                         DAD HL,BC
7173 7E                         MOV A,(HL)
7174 F6 40                      ORI 0x40
7176 77                         MOV (HL),A
7177 3E 13                      MVI A,0x13
7179 02          LAB_ram_7179:  STAX (BC)
717A D1                         POP DE
717B D5          LAB_ram_717b:  PUSH DE
717C C5                         PUSH BC
717D C5                         PUSH BC
717E 21 8C 71                   LXI HL,0x718c
7181 E5                         PUSH HL
7182 03                         INX BC
7183 0A                         LDAX (BC)
7184 6F                         MOV L,A
7185 03                         INX BC
7186 0A                         LDAX (BC)
7187 67                         MOV H,A
7188 01 03 00                   LXI BC,0x3
718B E9                         PCHL
718C C1                         ?? C1h
718D D1          LAB_ram_718d:  POP DE
718E E1          LAB_ram_718e:  POP HL
718F F1                         POP AF
7190 C9                         RET

; ============================================================
; FUN_ram_7191
; вызовы из: 626C 6D34
7191 F5          FUN_ram_7191:  PUSH AF
7192 E5                         PUSH HL
7193 0A                         LDAX (BC)
7194 E6 17                      ANI 0x17
7196 FE 15                      CPI 0x15
7198 CA AB 71                   JZ 0x71ab
719B E6 10                      ANI 0x10
719D CA A8 71                   JZ 0x71a8
71A0 21 11 00                   LXI HL,0x11
71A3 09                         DAD HL,BC
71A4 7E                         MOV A,(HL)
71A5 C6 80                      ADI 0x80
71A7 77                         MOV (HL),A
71A8 E1          LAB_ram_71a8:  POP HL
71A9 F1                         POP AF
71AA C9                         RET
71AB C5          LAB_ram_71ab:  PUSH BC
71AC C5                         PUSH BC
71AD 21 BB 71                   LXI HL,0x71bb
71B0 E5                         PUSH HL
71B1 03                         INX BC
71B2 0A                         LDAX (BC)
71B3 6F                         MOV L,A
71B4 03                         INX BC
71B5 0A                         LDAX (BC)
71B6 67                         MOV H,A
71B7 01 08 00                   LXI BC,0x8
71BA E9                         PCHL
71BB C1                         ?? C1h
71BC C3                         ?? C3h
71BD A8                         ?? A8h
71BE 71                         ?? 71h    q

; ============================================================
; FUN_ram_71bf
71BF E5          FUN_ram_71bf:  PUSH HL
71C0 F5                         PUSH AF
71C1 D5                         PUSH DE
71C2 C5                         PUSH BC
71C3 21 08 00                   LXI HL,0x8
71C6 39                         DAD HL,SP
71C7 4E                         MOV C,(HL)
71C8 23                         INX HL
71C9 46                         MOV B,(HL)
71CA 23                         INX HL
71CB 5E                         MOV E,(HL)
71CC 23                         INX HL
71CD 56                         MOV D,(HL)
71CE 70                         MOV (HL),B
71CF 2B                         DCX HL
71D0 71                         MOV (HL),C
71D1 C1                         POP BC
71D2 EB                         XCHG
71D3 D1                         POP DE
71D4 D5                         PUSH DE
71D5 78                         MOV A,B
71D6 E6 01                      ANI 0x1
71D8 C2 DE 71                   JNZ 0x71de
71DB 11 F8 73                   LXI DE,0x73f8
71DE 23          LAB_ram_71de:  INX HL
71DF 73                         MOV (HL),E
71E0 23                         INX HL
71E1 72                         MOV (HL),D
71E2 23                         INX HL
71E3 71                         MOV (HL),C
71E4 D1                         POP DE
71E5 F1                         POP AF
71E6 E1                         POP HL
71E7 33                         INX SP
71E8 33                         INX SP
71E9 C9                         RET

; ============================================================
; FUN_ram_71ea
; вызовы из: 3053
71EA F5          FUN_ram_71ea:  PUSH AF
71EB E5                         PUSH HL
71EC D5                         PUSH DE
71ED C5                         PUSH BC
71EE 21 08 00                   LXI HL,0x8
71F1 39                         DAD HL,SP
71F2 4E                         MOV C,(HL)
71F3 23                         INX HL
71F4 46                         MOV B,(HL)
71F5 23                         INX HL
71F6 5E                         MOV E,(HL)
71F7 23                         INX HL
71F8 56                         MOV D,(HL)
71F9 70                         MOV (HL),B
71FA 2B                         DCX HL
71FB 71                         MOV (HL),C
71FC C1                         POP BC
71FD 21 11 00                   LXI HL,0x11
7200 19                         DAD HL,DE
7201 16 00                      MVI D,0x0
7203 3E 0E                      MVI A,0xe
7205 72          LAB_ram_7205:  MOV (HL),D
7206 2B                         DCX HL
7207 3D                         DCR A
7208 C2 05 72                   JNZ 0x7205
720B 71                         MOV (HL),C
720C 2B                         DCX HL
720D 78                         MOV A,B
720E E6 01                      ANI 0x1
7210 D1                         POP DE
7211 D5                         PUSH DE
7212 C2 18 72                   JNZ 0x7218
7215 11 F8 73                   LXI DE,0x73f8
7218 72          LAB_ram_7218:  MOV (HL),D
7219 2B                         DCX HL
721A 73                         MOV (HL),E
721B 2B                         DCX HL
721C 36 00                      MVI (HL),0x0
721E D1                         POP DE
721F E1                         POP HL
7220 F1                         POP AF
7221 33                         INX SP
7222 33                         INX SP
7223 C9                         RET

; ============================================================
; FUN_ram_7224
; вызовы из: 330D
7224 F5          FUN_ram_7224:  PUSH AF
7225 E5                         PUSH HL
7226 C5                         PUSH BC
7227 D5                         PUSH DE
7228 60                         MOV H,B
7229 69                         MOV L,C
722A 7E                         MOV A,(HL)
722B E6 17                      ANI 0x17
722D FE 15                      CPI 0x15
722F CA F1 72                   JZ 0x72f1
7232 FE 00                      CPI 0x0
7234 CA DC 72                   JZ 0x72dc
7237 11 11 00                   LXI DE,0x11
723A 19                         DAD HL,DE
723B B6                         ORA (HL)
723C 17                         RAL
723D DA E1 72                   JC 0x72e1
7240 2B                         DCX HL
7241 7E                         MOV A,(HL)
7242 3C                         INR A
7243 1F                         RAR
7244 F5                         PUSH AF
7245 2B                         DCX HL
7246 4E                         MOV C,(HL)
7247 2B                         DCX HL
7248 56                         MOV D,(HL)
7249 2B                         DCX HL
724A E5                         PUSH HL
724B 5E                         MOV E,(HL)
724C 06 00                      MVI B,0x0
724E DC 00 73                   CC 0x7300
7251 CD 00 73                   CALL 0x7300
7254 CD 00 73                   CALL 0x7300
7257 D5                         PUSH DE
7258 59                         MOV E,C
7259 D5                         PUSH DE
725A 0E 00                      MVI C,0x0
725C C5                         PUSH BC
725D 41                         MOV B,C
725E C5                         PUSH BC
725F 11 02 00                   LXI DE,0x2
7262 3E 19                      MVI A,0x19
7264 F5                         PUSH AF
7265 21 05 00                   LXI HL,0x5
7268 39                         DAD HL,SP
7269 EB                         XCHG
726A 1A                         LDAX (DE)
726B C3 7B 72                   JMP 0x727b
726E F5          LAB_ram_726e:  PUSH AF
726F 21 05 00                   LXI HL,0x5
7272 39                         DAD HL,SP
7273 7B                         MOV A,E
7274 E6 08                      ANI 0x8
7276 EB                         XCHG
7277 1A                         LDAX (DE)
7278 CA 8D 72                   JZ 0x728d
727B 95          LAB_ram_727b:  SUB L
727C 12                         STAX (DE)
727D 1B                         DCX DE
727E 1A                         LDAX (DE)
727F 9C                         SBB H
7280 12                         STAX (DE)
7281 1B                         DCX DE
7282 1A                         LDAX (DE)
7283 99                         SBB C
7284 12                         STAX (DE)
7285 1B                         DCX DE
7286 1A                         LDAX (DE)
7287 98                         SBB B
7288 12                         STAX (DE)
7289 3F                         CMC
728A C3 9B 72                   JMP 0x729b
728D 85          LAB_ram_728d:  ADD L
728E 12                         STAX (DE)
728F 1B                         DCX DE
7290 1A                         LDAX (DE)
7291 8C                         ADC H
7292 12                         STAX (DE)
7293 1B                         DCX DE
7294 1A                         LDAX (DE)
7295 89                         ADC C
7296 12                         STAX (DE)
7297 1B                         DCX DE
7298 1A                         LDAX (DE)
7299 88                         ADC B
729A 12                         STAX (DE)
729B EB          LAB_ram_729b:  XCHG
729C 3E 00                      MVI A,0x0
729E 17                         RAL
729F 3C                         INR A
72A0 37                         STC
72A1 17                         RAL
72A2 67                         MOV H,A
72A3 7B                         MOV A,E
72A4 E6 F9                      ANI 0xf9
72A6 B4                         ORA H
72A7 5F                         MOV E,A
72A8 CD 0A 73                   CALL 0x730a
72AB CD 0A 73                   CALL 0x730a
72AE CD 00 73                   CALL 0x7300
72B1 F1                         POP AF
72B2 3D                         DCR A
72B3 C2 6E 72                   JNZ 0x726e
72B6 CD 00 73                   CALL 0x7300
72B9 CD 00 73                   CALL 0x7300
72BC CD 00 73                   CALL 0x7300
72BF CD 00 73                   CALL 0x7300
72C2 E1                         POP HL
72C3 E1                         POP HL
72C4 E1                         POP HL
72C5 E1                         POP HL
72C6 E1                         POP HL
72C7 7B                         MOV A,E
72C8 1E 00                      MVI E,0x0
72CA C6 80                      ADI 0x80
72CC 7A                         MOV A,D
72CD 8B                         ADC E
72CE 77                         MOV (HL),A
72CF 79                         MOV A,C
72D0 8B                         ADC E
72D1 23                         INX HL
72D2 77                         MOV (HL),A
72D3 78                         MOV A,B
72D4 8B                         ADC E
72D5 23                         INX HL
72D6 77                         MOV (HL),A
72D7 F1                         POP AF
72D8 C6 3F                      ADI 0x3f
72DA 23                         INX HL
72DB 77                         MOV (HL),A
72DC D1          LAB_ram_72dc:  POP DE
72DD C1                         POP BC
72DE E1                         POP HL
72DF F1                         POP AF
72E0 C9                         RET
72E1 0A          LAB_ram_72e1:  LDAX (BC)
72E2 E6 F8                      ANI 0xf8
72E4 F6 02                      ORI 0x2
72E6 02                         STAX (BC)
72E7 03                         INX BC
72E8 03                         INX BC
72E9 03                         INX BC
72EA 0A                         LDAX (BC)
72EB F6 08                      ORI 0x8
72ED 02                         STAX (BC)
72EE 0B                         DCX BC
72EF 0B                         DCX BC
72F0 0B                         DCX BC
72F1 C5          LAB_ram_72f1:  PUSH BC
72F2 21 DC 72                   LXI HL,0x72dc
72F5 E5                         PUSH HL
72F6 03                         INX BC
72F7 0A                         LDAX (BC)
72F8 6F                         MOV L,A
72F9 03                         INX BC
72FA 0A                         LDAX (BC)
72FB 67                         MOV H,A
72FC 01 0A 00                   LXI BC,0xa
72FF E9                         PCHL

; ============================================================
; FUN_ram_7300
; вызовы из: 724E 7251 7254 72AE 72B6 72B9 72BC 72BF
7300 EB          FUN_ram_7300:  XCHG
7301 29                         DAD HL,HL
7302 EB                         XCHG
7303 79                         MOV A,C
7304 8F                         ADC A
7305 4F                         MOV C,A
7306 78                         MOV A,B
7307 8F                         ADC A
7308 47                         MOV B,A
7309 C9                         RET

; ============================================================
; FUN_ram_730a
; вызовы из: 72A8 72AB
730A D5          FUN_ram_730a:  PUSH DE
730B 21 0C 00                   LXI HL,0xc
730E 39                         DAD HL,SP
730F EB                         XCHG
7310 26 07                      MVI H,0x7
7312 1A          LAB_ram_7312:  LDAX (DE)
7313 8F                         ADC A
7314 12                         STAX (DE)
7315 1B                         DCX DE
7316 25                         DCR H
7317 C2 12 73                   JNZ 0x7312
731A D1                         POP DE
731B C9                         RET

; ============================================================
; FUN_ram_731c
; вызовы из: 650B
731C 0A          FUN_ram_731c:  LDAX (BC)
731D C9                         RET

; ============================================================
; FUN_ram_731e
; вызовы из: 30E8 3113 315B 3179 31B2 329C 32A5 32AE 32B7 32E9 32EF 3301 3310 3487 34A2 34B4 34CF 34E1 3574 3639 …
731E F5          FUN_ram_731e:  PUSH AF
731F E5                         PUSH HL
7320 D5                         PUSH DE
7321 21 0D 00                   LXI HL,0xd
7324 09                         DAD HL,BC
7325 7E                         MOV A,(HL)
7326 12                         STAX (DE)
7327 13                         INX DE
7328 23                         INX HL
7329 7E                         MOV A,(HL)
732A 12                         STAX (DE)
732B 13                         INX DE
732C 23                         INX HL
732D 23                         INX HL
732E 7E                         MOV A,(HL)
732F 1F                         RAR
7330 2B                         DCX HL
7331 7E                         MOV A,(HL)
7332 17                         RAL
7333 0F                         RRC
7334 12                         STAX (DE)
7335 13                         INX DE
7336 23                         INX HL
7337 23                         INX HL
7338 7E                         MOV A,(HL)
7339 17                         RAL
733A 2B                         DCX HL
733B 7E                         MOV A,(HL)
733C 1F                         RAR
733D 12                         STAX (DE)
733E D1                         POP DE
733F E1                         POP HL
7340 F1                         POP AF
7341 C9                         RET

; ============================================================
; FUN_ram_7342
; вызовы из: 31D1 333B 3372 35C7 35D4 3600 3629 3665 36AA 36BE 374E 378C 3AFB 661D
7342 E5          FUN_ram_7342:  PUSH HL
7343 0A                         LDAX (BC)
7344 E6 17                      ANI 0x17
7346 FE 15                      CPI 0x15
7348 CA 68 73                   JZ 0x7368
734B E6 10                      ANI 0x10
734D CA 63 73                   JZ 0x7363
7350 21 11 00                   LXI HL,0x11
7353 09                         DAD HL,BC
7354 7E                         MOV A,(HL)
7355 17                         RAL
7356 D2 5E 73                   JNC 0x735e
7359 3E 30                      MVI A,0x30
735B C3 65 73                   JMP 0x7365
735E 3E 50       LAB_ram_735e:  MVI A,0x50
7360 C3 65 73                   JMP 0x7365
7363 3E 80       LAB_ram_7363:  MVI A,0x80
7365 02          LAB_ram_7365:  STAX (BC)
7366 E1                         POP HL
7367 C9                         RET
7368 C5          LAB_ram_7368:  PUSH BC
7369 C5                         PUSH BC
736A 21 78 73                   LXI HL,0x7378
736D E5                         PUSH HL
736E 03                         INX BC
736F 0A                         LDAX (BC)
7370 6F                         MOV L,A
7371 03                         INX BC
7372 0A                         LDAX (BC)
7373 67                         MOV H,A
7374 01 07 00                   LXI BC,0x7
7377 E9                         PCHL
7378 C1                         ?? C1h
7379 0A                         ?? 0Ah
737A C3                         ?? C3h
737B 65                         ?? 65h    e
737C 73                         ?? 73h    s

; ============================================================
; FUN_ram_737d
; вызовы из: 6253 6A39 6D3F 703D
737D 0A          FUN_ram_737d:  LDAX (BC)
737E E6 17                      ANI 0x17
7380 FE 15                      CPI 0x15
7382 CA E3 73                   JZ 0x73e3
7385 21 02 00                   LXI HL,0x2
7388 19                         DAD HL,DE
7389 7E                         MOV A,(HL)
738A 17                         RAL
738B 23                         INX HL
738C 7E                         MOV A,(HL)
738D 17                         RAL
738E 26 00                      MVI H,0x0
7390 D2 95 73                   JNC 0x7395
7393 26 80                      MVI H,0x80
7395 B7          LAB_ram_7395:  ORA A
7396 CA C4 73                   JZ 0x73c4
7399 FE FF                      CPI 0xff
739B CA E6 73                   JZ 0x73e6
739E 6F                         MOV L,A
739F E5                         PUSH HL
73A0 26 01                      MVI H,0x1
73A2 0A          LAB_ram_73a2:  LDAX (BC)
73A3 E6 10                      ANI 0x10
73A5 7C                         MOV A,H
73A6 CA B6 73                   JZ 0x73b6
73A9 B7                         ORA A
73AA CA B1 73                   JZ 0x73b1
73AD 3E 02                      MVI A,0x2
73AF E1          LAB_ram_73af:  POP HL
73B0 C9                         RET
73B1 3E 05       LAB_ram_73b1:  MVI A,0x5
73B3 C3 AF 73                   JMP 0x73af
73B6 B7          LAB_ram_73b6:  ORA A
73B7 CA BF 73                   JZ 0x73bf
73BA 3E 03                      MVI A,0x3
73BC C3 AF 73                   JMP 0x73af
73BF 3E 04       LAB_ram_73bf:  MVI A,0x4
73C1 C3 AF 73                   JMP 0x73af
73C4 21 03 00    LAB_ram_73c4:  LXI HL,0x3
73C7 19                         DAD HL,DE
73C8 3E 00                      MVI A,0x0
73CA BE                         CMP (HL)
73CB C2 E6 73                   JNZ 0x73e6
73CE 2B                         DCX HL
73CF BE                         CMP (HL)
73D0 C2 E6 73                   JNZ 0x73e6
73D3 2B                         DCX HL
73D4 BE                         CMP (HL)
73D5 C2 E6 73                   JNZ 0x73e6
73D8 2B                         DCX HL
73D9 BE                         CMP (HL)
73DA C2 E6 73                   JNZ 0x73e6
73DD 26 00                      MVI H,0x0
73DF E5                         PUSH HL
73E0 C3 A2 73                   JMP 0x73a2
73E3 3E 01       LAB_ram_73e3:  MVI A,0x1
73E5 C9                         RET
73E6 03          LAB_ram_73e6:  INX BC
73E7 03                         INX BC
73E8 03                         INX BC
73E9 0A                         LDAX (BC)
73EA F6 80                      ORI 0x80
73EC 02                         STAX (BC)
73ED 0B                         DCX BC
73EE 0B                         DCX BC
73EF 0B                         DCX BC
73F0 0A                         LDAX (BC)
73F1 E6 16                      ANI 0x16
73F3 F6 06                      ORI 0x6
73F5 02                         STAX (BC)
73F6 97                         SUB A
73F7 C9                         RET

; ============================================================
; FUN_ram_73f8
73F8 F5          FUN_ram_73f8:  PUSH AF
73F9 C5                         PUSH BC
73FA E5                         PUSH HL
73FB 79                         MOV A,C
73FC D5                         PUSH DE
73FD 21 08 00                   LXI HL,0x8
7400 39                         DAD HL,SP
7401 5E                         MOV E,(HL)
7402 23                         INX HL
7403 56                         MOV D,(HL)
7404 23                         INX HL
7405 4E                         MOV C,(HL)
7406 23                         INX HL
7407 46                         MOV B,(HL)
7408 72                         MOV (HL),D
7409 2B                         DCX HL
740A 73                         MOV (HL),E
740B D1                         POP DE
740C FE 01                      CPI 0x1
740E CA 32 74                   JZ 0x7432
7411 FE 02                      CPI 0x2
7413 CA 32 74                   JZ 0x7432
7416 FE 03                      CPI 0x3
7418 CA 32 74                   JZ 0x7432
741B FE 04                      CPI 0x4
741D CA 32 74                   JZ 0x7432
7420 FE 05                      CPI 0x5
7422 CA 7A 74                   JZ 0x747a
7425 FE 06                      CPI 0x6
7427 CA A6 74                   JZ 0x74a6
742A FE 0A                      CPI 0xa
742C CA 32 74                   JZ 0x7432
742F C3 E0 74                   JMP 0x74e0
7432 0A          LAB_ram_7432:  LDAX (BC)
7433 E6 07                      ANI 0x7
7435 FE 01                      CPI 0x1
7437 CA 4C 74                   JZ 0x744c
743A FE 02                      CPI 0x2
743C CA 4C 74                   JZ 0x744c
743F FE 03                      CPI 0x3
7441 CA 5F 74                   JZ 0x745f
7444 FE 04                      CPI 0x4
7446 CA 74 74                   JZ 0x7474
7449 C3 E0 74                   JMP 0x74e0
744C 21 80 7F    LAB_ram_744c:  LXI HL,0x7f80
744F E5                         PUSH HL
7450 21 00 00                   LXI HL,0x0
7453 E5                         PUSH HL
7454 39                         DAD HL,SP
7455 EB                         XCHG
7456 CD 54 6F                   CALL 0x6f54
7459 EB                         XCHG
745A E1                         POP HL
745B E1                         POP HL
745C C3 E0 74                   JMP 0x74e0
745F 21 10 00    LAB_ram_745f:  LXI HL,0x10
7462 09                         DAD HL,BC
7463 36 FE                      MVI (HL),0xfe
7465 2B                         DCX HL
7466 36 FF                      MVI (HL),0xff
7468 2B                         DCX HL
7469 36 FF                      MVI (HL),0xff
746B 2B                         DCX HL
746C 36 FF                      MVI (HL),0xff
746E 3E 10                      MVI A,0x10
7470 02                         STAX (BC)
7471 C3 E0 74                   JMP 0x74e0
7474 CD 21 6A    LAB_ram_7474:  CALL 0x6a21
7477 C3 E0 74                   JMP 0x74e0
747A 0A          LAB_ram_747a:  LDAX (BC)
747B E6 07                      ANI 0x7
747D FE 03                      CPI 0x3
747F C2 E0 74                   JNZ 0x74e0
7482 3E 10                      MVI A,0x10
7484 02                         STAX (BC)
7485 21 11 00                   LXI HL,0x11
7488 09                         DAD HL,BC
7489 7E                         MOV A,(HL)
748A B7                         ORA A
748B 3E 00                      MVI A,0x0
748D C2 92 74                   JNZ 0x7492
7490 3E FF                      MVI A,0xff
7492 12          LAB_ram_7492:  STAX (DE)
7493 13                         INX DE
7494 12                         STAX (DE)
7495 13                         INX DE
7496 12                         STAX (DE)
7497 13                         INX DE
7498 7E                         MOV A,(HL)
7499 B7                         ORA A
749A C2 9F 74                   JNZ 0x749f
749D 3E 7F                      MVI A,0x7f
749F 12          LAB_ram_749f:  STAX (DE)
74A0 1B                         DCX DE
74A1 1B                         DCX DE
74A2 1B                         DCX DE
74A3 C3 E0 74                   JMP 0x74e0
74A6 0A          LAB_ram_74a6:  LDAX (BC)
74A7 E6 1F                      ANI 0x1f
74A9 02                         STAX (BC)
74AA E6 07                      ANI 0x7
74AC FE 06                      CPI 0x6
74AE CA E0 74                   JZ 0x74e0
74B1 D5                         PUSH DE
74B2 21 0D 00                   LXI HL,0xd
74B5 09                         DAD HL,BC
74B6 1A                         LDAX (DE)
74B7 BE                         CMP (HL)
74B8 C2 DF 74                   JNZ 0x74df
74BB 13                         INX DE
74BC 23                         INX HL
74BD 1A                         LDAX (DE)
74BE BE                         CMP (HL)
74BF C2 DF 74                   JNZ 0x74df
74C2 13                         INX DE
74C3 23                         INX HL
74C4 EB                         XCHG
74C5 13                         INX DE
74C6 1A                         LDAX (DE)
74C7 1F                         RAR
74C8 1B                         DCX DE
74C9 1A                         LDAX (DE)
74CA 17                         RAL
74CB 0F                         RRC
74CC BE                         CMP (HL)
74CD C2 DF 74                   JNZ 0x74df
74D0 23                         INX HL
74D1 13                         INX DE
74D2 13                         INX DE
74D3 1A                         LDAX (DE)
74D4 17                         RAL
74D5 1B                         DCX DE
74D6 1A                         LDAX (DE)
74D7 1F                         RAR
74D8 BE                         CMP (HL)
74D9 C2 DF 74                   JNZ 0x74df
74DC 3E 95                      MVI A,0x95
74DE 02                         STAX (BC)
74DF D1          LAB_ram_74df:  POP DE
74E0 E1          LAB_ram_74e0:  POP HL
74E1 C1                         POP BC
74E2 F1                         POP AF
74E3 33                         INX SP
74E4 33                         INX SP
74E5 C9                         RET

; ============================================================
; FUN_ram_74e6
; вызовы из: 707E 7087 7090 70A1 70AD
74E6 17          FUN_ram_74e6:  RAL
74E7 D2 ED 74                   JNC 0x74ed
74EA 09                         DAD HL,BC
74EB CE 00                      ACI 0x0
74ED 29          LAB_ram_74ed:  DAD HL,HL
74EE 17                         RAL
74EF D2 F5 74                   JNC 0x74f5
74F2 09                         DAD HL,BC
74F3 CE 00                      ACI 0x0
74F5 29          LAB_ram_74f5:  DAD HL,HL
74F6 17                         RAL
74F7 D2 FD 74                   JNC 0x74fd
74FA 09                         DAD HL,BC
74FB CE 00                      ACI 0x0
74FD 29          LAB_ram_74fd:  DAD HL,HL
74FE 17                         RAL
74FF D2 05 75                   JNC 0x7505
7502 09                         DAD HL,BC
7503 CE 00                      ACI 0x0
7505 29          LAB_ram_7505:  DAD HL,HL
7506 17                         RAL
7507 D2 0D 75                   JNC 0x750d
750A 09                         DAD HL,BC
750B CE 00                      ACI 0x0
750D 29          LAB_ram_750d:  DAD HL,HL
750E 17                         RAL
750F D2 15 75                   JNC 0x7515
7512 09                         DAD HL,BC
7513 CE 00                      ACI 0x0
7515 29          LAB_ram_7515:  DAD HL,HL
7516 17                         RAL
7517 D2 1D 75                   JNC 0x751d
751A 09                         DAD HL,BC
751B CE 00                      ACI 0x0
751D 29          LAB_ram_751d:  DAD HL,HL
751E 17                         RAL
751F D2 25 75                   JNC 0x7525
7522 09                         DAD HL,BC
7523 CE 00                      ACI 0x0
7525 C9          LAB_ram_7525:  RET

; ============================================================
; FUN_ram_7526
; вызовы из: 63B1 711F
7526 06 00       FUN_ram_7526:  MVI B,0x0
7528 57                         MOV D,A
7529 79                         MOV A,C
752A 17                         RAL
752B 7A                         MOV A,D
752C D8                         RC
752D E6 C0                      ANI 0xc0
752F 5F                         MOV E,A
7530 7B          LAB_ram_7530:  MOV A,E
7531 17                         RAL
7532 5F                         MOV E,A
7533 7D                         MOV A,L
7534 17                         RAL
7535 6F                         MOV L,A
7536 7C                         MOV A,H
7537 17                         RAL
7538 67                         MOV H,A
7539 79                         MOV A,C
753A 17                         RAL
753B 4F                         MOV C,A
753C 04                         INR B
753D 17                         RAL
753E D2 30 75                   JNC 0x7530
7541 7A                         MOV A,D
7542 E6 20                      ANI 0x20
7544 B3                         ORA E
7545 C9                         RET
7546 00          DAT_ram_7546:  ?? 00h
7547 00                         ?? 00h
7548 20                         ?? 20h     
7549 41          DAT_ram_7549:  ?? 41h    A
754A 00                         ?? 00h
754B 00                         ?? 00h
754C C8                         ?? C8h
754D 42                         ?? 42h    B
754E 00                         ?? 00h
754F 40                         ?? 40h    @
7550 1C                         ?? 1Ch
7551 46                         ?? 46h    F
7552 20                         ?? 20h     
7553 BC                         ?? BCh
7554 BE                         ?? BEh
7555 4C                         ?? 4Ch    L
7556 CA                         ?? CAh
7557 1B                         ?? 1Bh
7558 0E                         ?? 0Eh
7559 5A                         ?? 5Ah    Z
755A AE                         ?? AEh
755B C5                         ?? C5h
755C 9D                         ?? 9Dh
755D 74                         ?? 74h    t

; ============================================================
; FUN_ram_755e
; вызовы из: 6C1D
755E 16 00       FUN_ram_755e:  MVI D,0x0
7560 C5                         PUSH BC
7561 D5                         PUSH DE
7562 60                         MOV H,B
7563 69                         MOV L,C
7564 5E                         MOV E,(HL)
7565 E5                         PUSH HL
7566 23                         INX HL
7567 56                         MOV D,(HL)
7568 23                         INX HL
7569 4E                         MOV C,(HL)
756A 23                         INX HL
756B 46                         MOV B,(HL)
756C E1                         POP HL
756D EB                         XCHG
756E CD B0 75                   CALL 0x75b0
7571 DA AB 75                   JC 0x75ab
7574 CD B0 75                   CALL 0x75b0
7577 DA AB 75                   JC 0x75ab
757A 1A                         LDAX (DE)
757B 85                         ADD L
757C 6F                         MOV L,A
757D 13                         INX DE
757E 1A                         LDAX (DE)
757F 8C                         ADC H
7580 67                         MOV H,A
7581 13                         INX DE
7582 1A                         LDAX (DE)
7583 89                         ADC C
7584 4F                         MOV C,A
7585 13                         INX DE
7586 1A                         LDAX (DE)
7587 88                         ADC B
7588 47                         MOV B,A
7589 DA AB 75                   JC 0x75ab
758C CD B0 75                   CALL 0x75b0
758F DA AB 75                   JC 0x75ab
7592 D1                         POP DE
7593 19                         DAD HL,DE
7594 3E 00                      MVI A,0x0
7596 89                         ADC C
7597 4F                         MOV C,A
7598 3E 00                      MVI A,0x0
759A 88                         ADC B
759B 47                         MOV B,A
759C DA AC 75                   JC 0x75ac
759F EB                         XCHG
75A0 E1                         POP HL
75A1 73                         MOV (HL),E
75A2 23                         INX HL
75A3 72                         MOV (HL),D
75A4 23                         INX HL
75A5 71                         MOV (HL),C
75A6 23                         INX HL
75A7 70                         MOV (HL),B
75A8 3E 00                      MVI A,0x0
75AA C9                         RET
75AB E1          LAB_ram_75ab:  POP HL
75AC D1          LAB_ram_75ac:  POP DE
75AD 3E FF                      MVI A,0xff
75AF C9                         RET

; ============================================================
; FUN_ram_75b0
; вызовы из: 756E 7574 758C
75B0 29          FUN_ram_75b0:  DAD HL,HL
75B1 79                         MOV A,C
75B2 17                         RAL
75B3 4F                         MOV C,A
75B4 78                         MOV A,B
75B5 17                         RAL
75B6 47                         MOV B,A
75B7 C9                         RET

; ============================================================
; FUN_ram_75b8
; вызовы из: 6302 63B4 6E18 701E 7122
75B8 C6 80       FUN_ram_75b8:  ADI 0x80
75BA 57                         MOV D,A
75BB 7D                         MOV A,L
75BC CE 00                      ACI 0x0
75BE 6F                         MOV L,A
75BF 7C                         MOV A,H
75C0 CE 00                      ACI 0x0
75C2 67                         MOV H,A
75C3 79                         MOV A,C
75C4 CE 00                      ACI 0x0
75C6 4F                         MOV C,A
75C7 DA D5 75                   JC 0x75d5
75CA 7A                         MOV A,D
75CB B7                         ORA A
75CC C2 D3 75                   JNZ 0x75d3
75CF 7D                         MOV A,L
75D0 E6 FE                      ANI 0xfe
75D2 6F                         MOV L,A
75D3 97          LAB_ram_75d3:  SUB A
75D4 C9                         RET
75D5 0E 80       LAB_ram_75d5:  MVI C,0x80
75D7 3E 01                      MVI A,0x1
75D9 C9                         RET

; ============================================================
; FUN_ram_75da
; вызовы из: 62DA 63A5
75DA 16 00       FUN_ram_75da:  MVI D,0x0
75DC FE 20                      CPI 0x20
75DE DA E3 75                   JC 0x75e3
75E1 3E 20                      MVI A,0x20
75E3 FE 08       LAB_ram_75e3:  CPI 0x8
75E5 DA 02 76                   JC 0x7602
75E8 5F                         MOV E,A
75E9 7D                         MOV A,L
75EA E6 3F                      ANI 0x3f
75EC B2                         ORA D
75ED 16 20                      MVI D,0x20
75EF C2 F4 75                   JNZ 0x75f4
75F2 16 00                      MVI D,0x0
75F4 7D          LAB_ram_75f4:  MOV A,L
75F5 E6 C0                      ANI 0xc0
75F7 B2                         ORA D
75F8 57                         MOV D,A
75F9 6C                         MOV L,H
75FA 61                         MOV H,C
75FB 48                         MOV C,B
75FC 7B                         MOV A,E
75FD D6 08                      SUI 0x8
75FF C3 E3 75                   JMP 0x75e3
7602 B7          LAB_ram_7602:  ORA A
7603 CA 22 76                   JZ 0x7622
7606 5F                         MOV E,A
7607 78                         MOV A,B
7608 0F                         RRC
7609 47                         MOV B,A
760A 79                         MOV A,C
760B 1F                         RAR
760C 4F                         MOV C,A
760D 7C                         MOV A,H
760E 1F                         RAR
760F 67                         MOV H,A
7610 7D                         MOV A,L
7611 1F                         RAR
7612 6F                         MOV L,A
7613 7A                         MOV A,D
7614 1F                         RAR
7615 57                         MOV D,A
7616 17                         RAL
7617 E6 20                      ANI 0x20
7619 B2                         ORA D
761A E6 E0                      ANI 0xe0
761C 57                         MOV D,A
761D 7B                         MOV A,E
761E 3D                         DCR A
761F C3 02 76                   JMP 0x7602
7622 7A          LAB_ram_7622:  MOV A,D
7623 C9                         RET

; ============================================================
; FUN_ram_7624
7624 69          FUN_ram_7624:  MOV L,C
7625 60                         MOV H,B
7626 4E                         MOV C,(HL)
7627 23                         INX HL
7628 46                         MOV B,(HL)

; ============================================================
; FUN_ram_7629
; вызовы из: 6602 665D 6972 69E8 6B80 6C15
7629 1A          FUN_ram_7629:  LDAX (DE)
762A 81                         ADD C
762B 6F                         MOV L,A
762C 13                         INX DE
762D 1A                         LDAX (DE)
762E 88                         ADC B
762F 67                         MOV H,A
7630 C9                         RET

; ============================================================
; FUN_ram_7631
; вызовы из: 6832
7631 EB          FUN_ram_7631:  XCHG

; ============================================================
; FUN_ram_7632
; вызовы из: 649F 6B0D 6C41
7632 5F          FUN_ram_7632:  MOV E,A
7633 16 00                      MVI D,0x0
7635 EB                         XCHG
7636 1A                         LDAX (DE)
7637 85                         ADD L
7638 6F                         MOV L,A
7639 13                         INX DE
763A 1A                         LDAX (DE)
763B 8C                         ADC H
763C 67                         MOV H,A
763D C9                         RET

; ============================================================
; FUN_ram_763e
763E 59          FUN_ram_763e:  MOV E,C
763F 50                         MOV D,B
7640 EB                         XCHG

; ============================================================
; FUN_ram_7641
; вызовы из: 6C6B
7641 97          FUN_ram_7641:  SUB A
7642 96                         SUB (HL)
7643 5F                         MOV E,A
7644 3E 00                      MVI A,0x0
7646 23                         INX HL
7647 9E                         SBB (HL)
7648 57                         MOV D,A
7649 EB                         XCHG
764A C9                         RET

; ============================================================
; FUN_ram_764b
; вызовы из: 6CCA 6D11
764B 5E          FUN_ram_764b:  MOV E,(HL)
764C 23                         INX HL
764D 56                         MOV D,(HL)
764E EB                         XCHG
764F 7C          LAB_ram_764f:  MOV A,H
7650 B7                         ORA A
7651 1F                         RAR
7652 67                         MOV H,A
7653 7D                         MOV A,L
7654 1F                         RAR
7655 6F                         MOV L,A
7656 0D                         DCR C
7657 C2 4F 76                   JNZ 0x764f
765A C9                         RET

; ============================================================
; FUN_ram_765b
765B 5F          FUN_ram_765b:  MOV E,A
765C 16 00                      MVI D,0x0

; ============================================================
; FUN_ram_765e
; вызовы из: 6C5A
765E 7B          FUN_ram_765e:  MOV A,E
765F 95                         SUB L
7660 6F                         MOV L,A
7661 7A                         MOV A,D
7662 9C                         SBB H
7663 67                         MOV H,A
7664 C9                         RET

; ============================================================
; FUN_ram_7665
; вызовы из: 6951 6C4B
7665 4F          FUN_ram_7665:  MOV C,A
7666 06 00                      MVI B,0x0
7668 7B                         MOV A,E
7669 91                         SUB C
766A 6F                         MOV L,A
766B 7A                         MOV A,D
766C 98                         SBB B
766D 67                         MOV H,A
766E C9                         RET

; ============================================================
; FUN_ram_766f
; вызовы из: 68DB 68FE 6927 6947
766F 69          FUN_ram_766f:  MOV L,C
7670 60                         MOV H,B

; ============================================================
; FUN_ram_7671
; вызовы из: 68A3 68BF
7671 4E          FUN_ram_7671:  MOV C,(HL)
7672 23                         INX HL
7673 46                         MOV B,(HL)
7674 1A                         LDAX (DE)
7675 91                         SUB C
7676 6F                         MOV L,A
7677 13                         INX DE
7678 1A                         LDAX (DE)
7679 98                         SBB B
767A 67                         MOV H,A
767B C9                         RET

; ============================================================
; FUN_ram_767c
; вызовы из: 675B 6A0A
767C 6F          FUN_ram_767c:  MOV L,A
767D 26 00                      MVI H,0x0
767F 1A                         LDAX (DE)
7680 95                         SUB L
7681 6F                         MOV L,A
7682 13                         INX DE
7683 1A                         LDAX (DE)
7684 9C                         SBB H
7685 67                         MOV H,A
7686 C9                         RET

; ============================================================
; FUN_ram_7687
; вызовы из: 6C79 6C9B 6CE2
7687 5F          FUN_ram_7687:  MOV E,A
7688 16 00                      MVI D,0x0
768A 7B                         MOV A,E
768B 96                         SUB (HL)
768C 5F                         MOV E,A
768D 7A                         MOV A,D
768E 23                         INX HL
768F 9E                         SBB (HL)
7690 57                         MOV D,A
7691 EB                         XCHG
7692 C9                         RET
7693 FF                         ?? FFh
;   … FF …
7C13 FF          DAT_ram_7c13:  undefined1 FFh
7C14 FF          DAT_ram_7c14:  undefined1 FFh
7C15 FF                         ?? FFh
;   … FF …
7FFF FF          DAT_ram_7fff:  undefined1 FFh
