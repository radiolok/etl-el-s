; ROM1 2000-3FFF, экспорт Ghidra

; ============================================================
; main_start
; Точка входа основной программы (ROM1). Стек 0x0720.
; Первые 12 байт позиционно-независимы — ROM1 может стартовать из оверлея на 0x0000.
2000 31 20 07    main_start:    LXI SP,0x720
2003 21 41 00                   LXI HL,0x41
2006 3E 30                      MVI A,0x30
2008 36 00       LAB_ram_2008:  MVI (HL),0x0
200A 23                         INX HL
200B 3D                         DCR A
200C C2 08 20                   JNZ 0x2008
200F 21 6B 03                   LXI HL,0x36b
2012 06 09                      MVI B,0x9
2014 36 00       LAB_ram_2014:  MVI (HL),0x0
2016 23                         INX HL
2017 05                         DCR B
2018 C2 14 20                   JNZ 0x2014
201B 3E 0D                      MVI A,0xd
201D 32 5E 00                   STA (0x005e)
2020 3E 24                      MVI A,0x24
2022 32 5F 00                   STA (0x005f)
2025 AF                         XRA A
2026 D3 FF                      OUT (0xff)
2028 D3 FF                      OUT (0xff)
202A D3 FF                      OUT (0xff)
202C 3E 40                      MVI A,0x40
202E D3 FF                      OUT (0xff)
2030 3E CF                      MVI A,0xcf
2032 D3 FF                      OUT (0xff)
2034 3E 25                      MVI A,0x25
2036 D3 FF                      OUT (0xff)
2038 3E 30                      MVI A,0x30
203A D3 F8                      OUT (0xf8)
203C 32 49 00                   STA (0x0049)
203F 3E 80                      MVI A,0x80
2041 D3 FA                      OUT (0xfa)
2043 32 48 00                   STA (0x0048)
2046 3E FF                      MVI A,0xff
2048 32 65 00                   STA (0x0065)
204B CD 6E 2E                   CALL 0x2e6e
204E CD 8A 22                   CALL 0x228a
2051 3E C3                      MVI A,0xc3
2053 32 00 00                   STA (0x0000)
2056 21 3E 0C                   LXI HL,0xc3e
2059 22 01 00                   SHLD (0x0001)
205C FB                         EI
205D CD BE 55                   CALL 0x55be
2060 3E 01                      MVI A,0x1
2062 CD 13 3C                   CALL 0x3c13
2065 21 F1 2F                   LXI HL,0x2ff1
2068 11 80 00                   LXI DE,0x80
206B CD 17 24                   CALL 0x2417
206E 3E C0                      MVI A,0xc0
2070 30                         SIM
2071 3E 01                      MVI A,0x1
2073 32 DC 01                   STA (0x01dc)
2076 32 F7 00                   STA (0x00f7)
2079 32 40 00                   STA (0x0040)
207C 32 F6 01                   STA (0x01f6)
207F AF                         XRA A
2080 32 E0 01                   STA (0x01e0)
2083 32 F1 00                   STA (0x00f1)
2086 32 ED 01                   STA (0x01ed)
2089 32 EE 01                   STA (0x01ee)
208C 32 F5 01                   STA (0x01f5)
208F 32 6C 00                   STA (0x006c)
2092 3E 81                      MVI A,0x81
2094 32 7F 00                   STA (0x007f)
2097 3E 02                      MVI A,0x2
2099 32 7D 00                   STA (0x007d)
209C 32 7E 00                   STA (0x007e)
209F CD 63 2D                   CALL 0x2d63
20A2 AF                         XRA A
20A3 32 6B 00                   STA (0x006b)
20A6 21 AB 00                   LXI HL,0xab
20A9 22 ED 00                   SHLD (0x00ed)
20AC CD 45 30                   CALL 0x3045
20AF CD 60 25                   CALL 0x2560
20B2 CD AC 2A                   CALL 0x2aac
20B5 CD 03 22                   CALL 0x2203

; ============================================================
; main_loop
; вызовы из: 20C3 20CA 20EE
20B8 CD F1 20    main_loop:     CALL 0x20f1
20BB B7                         ORA A
20BC C2 D0 20                   JNZ 0x20d0
20BF DB FF                      IN (0xff)
20C1 E6 02                      ANI 0x2
20C3 CA B8 20                   JZ 0x20b8
20C6 DB FE                      IN (0xfe)
20C8 FE 0D                      CPI 0xd
20CA C2 B8 20                   JNZ 0x20b8
20CD C3 31 08                   JMP 0x0831  ; ВК с консоли -> тёплый вход в монитор
20D0 F5          LAB_ram_20d0:  PUSH AF
20D1 CD 58 2E                   CALL 0x2e58
20D4 F1                         POP AF
20D5 21 B8 20                   LXI HL,0x20b8
20D8 E5                         PUSH HL
20D9 47                         MOV B,A
20DA CD C0 2D    LAB_ram_20da:  CALL 0x2dc0
20DD 21 FE 22                   LXI HL,0x22fe
20E0 3A 65 00                   LDA (0x0065)
20E3 B7                         ORA A
20E4 CA EA 20                   JZ 0x20ea
20E7 21 E8 22                   LXI HL,0x22e8
20EA CD D3 22    LAB_ram_20ea:  CALL 0x22d3
20ED D1                         POP DE
20EE C3 B8 20                   JMP 0x20b8

; ============================================================
; kbd_scan
; Опрос клавиатуры: OUT FA — выбор столбца (биты 4-5, 4 столбца), IN F6 — строки (инверсно).
; вызовы из: 20B8 21C0 2A78 4E2A
20F1 06 05       kbd_scan:      MVI B,0x5
20F3 3A 48 00                   LDA (0x0048)
20F6 E6 CF                      ANI 0xcf
20F8 4F                         MOV C,A
20F9 3A 4B 00                   LDA (0x004b)
20FC B7                         ORA A
20FD 79                         MOV A,C
20FE C2 03 21                   JNZ 0x2103
2101 E6 F0                      ANI 0xf0
2103 05          LAB_ram_2103:  DCR B
2104 CA 1B 21                   JZ 0x211b
2107 32 51 00                   STA (0x0051)
210A D3 FA                      OUT (0xfa)
210C DB F6                      IN (0xf6)
210E 2F                         CMA
210F B7                         ORA A
2110 C2 24 21                   JNZ 0x2124
2113 3A 51 00    LAB_ram_2113:  LDA (0x0051)
2116 C6 10                      ADI 0x10
2118 C3 03 21                   JMP 0x2103
211B AF          LAB_ram_211b:  XRA A
211C 32 50 00                   STA (0x0050)
211F 32 7C 00                   STA (0x007c)
2122 AF          LAB_ram_2122:  XRA A
2123 C9                         RET
2124 CD F4 21    LAB_ram_2124:  CALL 0x21f4
2127 DB F6                      IN (0xf6)
2129 2F                         CMA
212A B7                         ORA A
212B CA 13 21                   JZ 0x2113
212E 11 08 00                   LXI DE,0x8
2131 32 7B 00                   STA (0x007b)
2134 C5                         PUSH BC
2135 1F          LAB_ram_2135:  RAR
2136 D2 3A 21                   JNC 0x213a
2139 14                         INR D
213A 1D          LAB_ram_213a:  DCR E
213B C2 35 21                   JNZ 0x2135
213E 7A                         MOV A,D
213F FE 01                      CPI 0x1
2141 C2 BF 21                   JNZ 0x21bf
2144 05          LAB_ram_2144:  DCR B
2145 CA 5D 21                   JZ 0x215d
2148 3A 51 00                   LDA (0x0051)
214B C6 10                      ADI 0x10
214D 32 51 00                   STA (0x0051)
2150 D3 FA                      OUT (0xfa)
2152 DB F6                      IN (0xf6)
2154 2F                         CMA
2155 B7                         ORA A
2156 C2 BF 21                   JNZ 0x21bf
2159 05                         DCR B
215A C2 44 21                   JNZ 0x2144
215D C1          LAB_ram_215d:  POP BC
215E 21 D4 21                   LXI HL,0x21d4
2161 11 08 00                   LXI DE,0x8
2164 05                         DCR B
2165 CA 6D 21                   JZ 0x216d
2168 19          LAB_ram_2168:  DAD HL,DE
2169 05                         DCR B
216A C2 68 21                   JNZ 0x2168
216D 3A 7B 00    LAB_ram_216d:  LDA (0x007b)
2170 01 00 00                   LXI BC,0x0
2173 1F          LAB_ram_2173:  RAR
2174 DA 7B 21                   JC 0x217b
2177 0C                         INR C
2178 C3 73 21                   JMP 0x2173
217B 09          LAB_ram_217b:  DAD HL,BC
217C 7E                         MOV A,(HL)
217D 47                         MOV B,A
217E 3A 7C 00                   LDA (0x007c)
2181 B8                         CMP B
2182 C2 9F 21                   JNZ 0x219f
2185 78                         MOV A,B
2186 17                         RAL
2187 D2 22 21                   JNC 0x2122
218A 3A 50 00                   LDA (0x0050)
218D B7                         ORA A
218E C2 9A 21                   JNZ 0x219a
2191 3C                         INR A
2192 32 50 00                   STA (0x0050)
2195 3E FF                      MVI A,0xff
2197 CD 08 24                   CALL 0x2408
219A 78          LAB_ram_219a:  MOV A,B
219B 32 7C 00                   STA (0x007c)
219E C9                         RET
219F 3A 49 00    LAB_ram_219f:  LDA (0x0049)
21A2 E6 EF                      ANI 0xef
21A4 32 49 00                   STA (0x0049)
21A7 D3 F8                      OUT (0xf8)
21A9 CD F4 21                   CALL 0x21f4
21AC CD F4 21                   CALL 0x21f4
21AF CD F4 21                   CALL 0x21f4
21B2 3A 49 00                   LDA (0x0049)
21B5 F6 10                      ORI 0x10
21B7 32 49 00                   STA (0x0049)
21BA D3 F8                      OUT (0xf8)
21BC C3 9A 21                   JMP 0x219a
21BF E1          LAB_ram_21bf:  POP HL
21C0 C3 F1 20                   JMP 0x20f1
21C3 7A          str_keys_stuck: MOV A,D
21C4 61                         MOV H,C
21C5 76                         HALT
21C6 61                         ?? 61h    a
21C7 74                         ?? 74h    t
21C8 79                         ?? 79h    y
21C9 20                         ?? 20h     
21CA 6B                         ?? 6Bh    k
21CB 6E                         ?? 6Eh    n
21CC 6F                         ?? 6Fh    o
21CD 70                         ?? 70h    p
21CE 6B                         ?? 6Bh    k
21CF 69                         ?? 69h    i
21D0 20                         ?? 20h     
21D1 70                         ?? 70h    p
21D2 75                         ?? 75h    u
21D3 24                         ?? 24h    $
21D4 13                         ?? 13h
21D5 12                         ?? 12h
21D6 14                         ?? 14h
21D7 31                         ?? 31h    1
21D8 36                         ?? 36h    6
21D9 55                         ?? 55h    U
21DA 55                         ?? 55h    U
21DB 55                         ?? 55h    U
21DC 86          DAT_ram_21dc:  ?? 86h
21DD 87                         ?? 87h
21DE 88                         ?? 88h
21DF 32                         ?? 32h    2
21E0 37                         ?? 37h    7
21E1 15                         ?? 15h
21E2 35                         ?? 35h    5
21E3 55                         ?? 55h    U
21E4 84                         ?? 84h
21E5 10                         ?? 10h
21E6 85                         ?? 85h
21E7 33                         ?? 33h    3
21E8 38                         ?? 38h    8
21E9 11                         ?? 11h
21EA 30                         ?? 30h    0
21EB 55                         ?? 55h    U
21EC 81                         ?? 81h
21ED 82                         ?? 82h
21EE 83                         ?? 83h
21EF 34                         ?? 34h    4
21F0 39                         ?? 39h    9
21F1 1A                         ?? 1Ah
21F2 16                         ?? 16h
21F3 55                         ?? 55h    U

; ============================================================
; FUN_ram_21f4
; вызовы из: 2124 21A9 21AC 21AF
21F4 C5          FUN_ram_21f4:  PUSH BC
21F5 0E 0B                      MVI C,0xb
21F7 06 64       LAB_ram_21f7:  MVI B,0x64
21F9 05          LAB_ram_21f9:  DCR B
21FA C2 F9 21                   JNZ 0x21f9
21FD 0D                         DCR C
21FE C2 F7 21                   JNZ 0x21f7
2201 C1                         POP BC
2202 C9                         RET

; ============================================================
; key_freeze_toggle
; вызовы из: 20B5 22E9 2305
2203 3A 65 00    key_freeze_toggle: LDA (0x0065)
2206 2F                         CMA
2207 32 65 00                   STA (0x0065)
220A B7                         ORA A
220B C2 25 22                   JNZ 0x2225
220E 3A 49 00                   LDA (0x0049)
2211 E6 FE                      ANI 0xfe
2213 32 49 00                   STA (0x0049)
2216 D3 F8                      OUT (0xf8)
2218 CD 63 2D                   CALL 0x2d63
221B 21 CF 2E                   LXI HL,0x2ecf
221E CD 9B 2A                   CALL 0x2a9b
2221 CD 44 29                   CALL 0x2944
2224 C9                         RET
2225 CD A9 2A    LAB_ram_2225:  CALL 0x2aa9
2228 3E 3B                      MVI A,0x3b
222A CD 13 3C                   CALL 0x3c13
222D CD 44 29                   CALL 0x2944
2230 3A 49 00                   LDA (0x0049)
2233 F6 01                      ORI 0x1
2235 32 49 00                   STA (0x0049)
2238 D3 F8                      OUT (0xf8)
223A C9                         RET

; ============================================================
; FUN_ram_223b
; вызовы из: 28E9 2AF8 2E32 4DFF 52F1
223B 21 41 00    FUN_ram_223b:  LXI HL,0x41
223E 06 07                      MVI B,0x7
2240 36 00       LAB_ram_2240:  MVI (HL),0x0
2242 23                         INX HL
2243 05                         DCR B
2244 C2 40 22                   JNZ 0x2240
2247 AF                         XRA A
2248 32 69 00                   STA (0x0069)
224B 32 6B 00                   STA (0x006b)
224E C9                         RET

; ============================================================
; rom_checksum
; Контрольная сумма ПЗУ 0x2000-0x7FFF (сумма байт), при ошибке «ОШИБКА ПЗУ».
; вызовы из: 2268 2276
224F 21 00 20    rom_checksum:  LXI HL,0x2000
2252 06 00                      MVI B,0x0
2254 7E          LAB_ram_2254:  MOV A,(HL)
2255 80                         ADD B
2256 47                         MOV B,A
2257 23                         INX HL
2258 7C                         MOV A,H
2259 FE 80                      CPI 0x80
225B C2 54 22                   JNZ 0x2254
225E 78                         MOV A,B
225F FE 01                      CPI 0x1
2261 CA 79 22                   JZ 0x2279
2264 3A 5B 00                   LDA (0x005b)
2267 B7                         ORA A
2268 C2 4F 22                   JNZ 0x224f
226B 21 7F 22                   LXI HL,0x227f
226E CD 9B 2A                   CALL 0x2a9b
2271 3E 01                      MVI A,0x1
2273 32 5B 00                   STA (0x005b)
2276 C3 4F 22                   JMP 0x224f

; ============================================================
; FUN_ram_2279
; вызовы из: 2261 22B0
2279 AF          FUN_ram_2279:  XRA A
227A 32 5B 00                   STA (0x005b)
227D C9                         RET
227E 00                         ?? 00h
227F 6F 7B 69 …                 ds "o{ibka pzu$"  ; ОШИБКА ПЗУ

; ============================================================
; xram_test_C800
; Тест видеоОЗУ (УВЗ) 0xC800-0xFFFF (запись H^L, проверка, инверсия), «ОШИБКА УВЗ».
; вызовы из: 204E
228A AF          xram_test_C800: XRA A
228B 32 5B 00                   STA (0x005b)
228E 21 00 C8    LAB_ram_228e:  LXI HL,0xc800
2291 E5                         PUSH HL
2292 7C          LAB_ram_2292:  MOV A,H
2293 AD                         XRA L
2294 77                         MOV (HL),A
2295 23                         INX HL
2296 7C                         MOV A,H
2297 B5                         ORA L
2298 C2 92 22                   JNZ 0x2292
229B E1                         POP HL
229C 7C          LAB_ram_229c:  MOV A,H
229D AD                         XRA L
229E BE                         CMP (HL)
229F C2 B3 22                   JNZ 0x22b3
22A2 2F                         CMA
22A3 77                         MOV (HL),A
22A4 BE                         CMP (HL)
22A5 C2 B3 22                   JNZ 0x22b3
22A8 2F                         CMA
22A9 77                         MOV (HL),A
22AA 23                         INX HL
22AB 7C                         MOV A,H
22AC B5                         ORA L
22AD C2 9C 22                   JNZ 0x229c
22B0 C3 79 22                   JMP 0x2279
22B3 3A 5B 00    LAB_ram_22b3:  LDA (0x005b)
22B6 B7                         ORA A
22B7 C2 8E 22                   JNZ 0x228e
22BA 21 C8 22                   LXI HL,0x22c8
22BD CD 9B 2A                   CALL 0x2a9b
22C0 3E 01                      MVI A,0x1
22C2 32 5B 00                   STA (0x005b)
22C5 C3 8E 22                   JMP 0x228e
22C8 6F                         ?? 6Fh    o
22C9 7B                         ?? 7Bh    {
22CA 69                         ?? 69h    i
22CB 62                         ?? 62h    b
22CC 6B                         ?? 6Bh    k
22CD 61                         ?? 61h    a
22CE 20                         ?? 20h     
22CF 75                         ?? 75h    u
22D0 77                         ?? 77h    w
22D1 7A                         ?? 7Ah    z
22D2 24                         ?? 24h    $

; ============================================================
; dispatch_key
; Поиск кода B в таблице {код,адрес}, 0xFF — конец; переход по адресу (PCHL).
; вызовы из: 20EA 22E5 290D 4E23 4E93 4FF3 533C
22D3 7E          dispatch_key:  MOV A,(HL)
22D4 B8                         CMP B
22D5 C2 DF 22                   JNZ 0x22df
22D8 D1                         POP DE
22D9 23                         INX HL
22DA 5E                         MOV E,(HL)
22DB 23                         INX HL
22DC 56                         MOV D,(HL)
22DD EB                         XCHG
22DE E9                         PCHL
22DF FE FF       LAB_ram_22df:  CPI 0xff
22E1 C8                         RZ
22E2 23                         INX HL
22E3 23                         INX HL
22E4 23                         INX HL
22E5 C3 D3 22                   JMP 0x22d3
22E8 1A          tbl_keys_frozen: db 1Ah
22E9 03 22                      addr ram:2203
22EB 14                         db 14h
22EC 04 25                      addr ram:2504
22EE 16                         db 16h
22EF 40 25                      addr ram:2540
22F1 85                         db 85h
22F2 74 23                      addr ram:2374
22F4 84                         db 84h
22F5 A1 23                      addr ram:23a1
22F7 11                         db 11h
22F8 AC 23                      addr ram:23ac
22FA 15                         db 15h
22FB 3E 23                      addr ram:233e
22FD FF                         db FFh
22FE 14          tbl_keys_live: db 14h
22FF 04 25                      addr ram:2504
2301 16                         db 16h
2302 40 25                      addr ram:2540
2304 1A                         db 1Ah
2305 03 22                      addr ram:2203
2307 10                         db 10h
2308 21 24                      addr ram:2421
230A 12                         db 12h
230B 93 24                      addr ram:2493
230D 13                         db 13h
230E 87 2D                      addr ram:2d87
2310 84                         db 84h
2311 A3 25                      addr ram:25a3
2313 81                         db 81h
2314 96 25                      addr ram:2596
2316 82                         db 82h
2317 8A 25                      addr ram:258a
2319 83                         db 83h
231A 7F 25                      addr ram:257f
231C 85                         db 85h
231D 73 25                      addr ram:2573
231F 88                         db 88h
2320 66 25                      addr ram:2566
2322 87                         db 87h
2323 BA 25                      addr ram:25ba
2325 86                         db 86h
2326 AF 25                      addr ram:25af
2328 30                         db 30h
2329 70 2D                      addr ram:2d70
232B 31                         db 31h
232C A9 2D                      addr ram:2da9
232E 32                         db 32h
232F 84 2E                      addr ram:2e84
2331 33                         db 33h
2332 A9 2A                      addr ram:2aa9
2334 34                         db 34h
2335 DC 28                      addr ram:28dc
2337 35                         db 35h
2338 37 25                      addr ram:2537
233A 15                         db 15h
233B D1 2A                      addr ram:2ad1
233D FF                         db FFh

; ============================================================
; key_frz_15
; вызовы из: 22FB
233E 3A 4A 00    key_frz_15:    LDA (0x004a)
2341 3C                         INR A
2342 FE 03                      CPI 0x3
2344 C2 48 23                   JNZ 0x2348
2347 AF                         XRA A
2348 32 4A 00    LAB_ram_2348:  STA (0x004a)
234B 32 EE 01                   STA (0x01ee)
234E B7                         ORA A
234F 06 00                      MVI B,0x0
2351 CA 5A 23                   JZ 0x235a
2354 1F                         RAR
2355 D2 6E 23                   JNC 0x236e
2358 06 08                      MVI B,0x8
235A 3E C0       LAB_ram_235a:  MVI A,0xc0
235C 30                         SIM
235D 3A 49 00                   LDA (0x0049)
2360 E6 F7                      ANI 0xf7
2362 B0                         ORA B
2363 32 49 00                   STA (0x0049)
2366 D3 F8                      OUT (0xf8)
2368 3E 2E       LAB_ram_2368:  MVI A,0x2e
236A CD 13 3C                   CALL 0x3c13
236D C9                         RET
236E 3E 40       LAB_ram_236e:  MVI A,0x40
2370 30                         SIM
2371 C3 68 23                   JMP 0x2368

; ============================================================
; key_frz_85
; вызовы из: 22F2
2374 3A 48 00    key_frz_85:    LDA (0x0048)
2377 E6 0F                      ANI 0xf
2379 FE 0F                      CPI 0xf
237B C8                         RZ
237C 3C                         INR A
237D F6 80       LAB_ram_237d:  ORI 0x80
237F 32 48 00                   STA (0x0048)
2382 32 ED 01                   STA (0x01ed)
2385 47                         MOV B,A
2386 3A 4B 00                   LDA (0x004b)
2389 B7                         ORA A
238A C2 93 23                   JNZ 0x2393
238D 3E 16                      MVI A,0x16
238F CD 13 3C                   CALL 0x3c13
2392 C9                         RET
2393 3E FF       LAB_ram_2393:  MVI A,0xff
2395 CD 08 24                   CALL 0x2408
2398 3E FF                      MVI A,0xff
239A CD 08 24                   CALL 0x2408
239D 78                         MOV A,B
239E D3 FA                      OUT (0xfa)
23A0 C9                         RET

; ============================================================
; key_frz_84
; вызовы из: 22F5
23A1 3A 48 00    key_frz_84:    LDA (0x0048)
23A4 E6 0F                      ANI 0xf
23A6 B7                         ORA A
23A7 C8                         RZ
23A8 3D                         DCR A
23A9 C3 7D 23                   JMP 0x237d

; ============================================================
; key_frz_11
; вызовы из: 22F8
23AC 3E 07       key_frz_11:    MVI A,0x7
23AE CD 13 3C                   CALL 0x3c13
23B1 3A 4B 00                   LDA (0x004b)
23B4 2F                         CMA
23B5 32 4B 00                   STA (0x004b)
23B8 E6 01                      ANI 0x1
23BA 32 E0 01                   STA (0x01e0)
23BD 32 F1 00                   STA (0x00f1)
23C0 B7                         ORA A
23C1 C2 EF 23                   JNZ 0x23ef
23C4 3A 48 00                   LDA (0x0048)
23C7 E6 F0                      ANI 0xf0
23C9 D3 FA                      OUT (0xfa)
23CB 3A 49 00                   LDA (0x0049)
23CE E6 FD                      ANI 0xfd
23D0 32 49 00                   STA (0x0049)
23D3 D3 F8                      OUT (0xf8)
23D5 3E 10                      MVI A,0x10
23D7 CD 13 3C                   CALL 0x3c13
23DA 3E 31                      MVI A,0x31
23DC 32 E5 01    LAB_ram_23dc:  STA (0x01e5)
23DF 3E 06                      MVI A,0x6
23E1 32 E3 01                   STA (0x01e3)
23E4 3E 2B                      MVI A,0x2b
23E6 32 E2 01                   STA (0x01e2)
23E9 3E 0D                      MVI A,0xd
23EB CD 13 3C                   CALL 0x3c13
23EE C9                         RET
23EF 3A 49 00    LAB_ram_23ef:  LDA (0x0049)
23F2 F6 02                      ORI 0x2
23F4 D3 F8                      OUT (0xf8)
23F6 32 49 00                   STA (0x0049)
23F9 3A 48 00                   LDA (0x0048)
23FC D3 FA                      OUT (0xfa)
23FE 3E 10                      MVI A,0x10
2400 CD 13 3C                   CALL 0x3c13
2403 3E 32                      MVI A,0x32
2405 C3 DC 23                   JMP 0x23dc

; ============================================================
; delay_A
; вызовы из: 2197 2395 239A 268C 26DD 28FC 5146
2408 C5          delay_A:       PUSH BC
2409 06 50       LAB_ram_2409:  MVI B,0x50
240B 0C          LAB_ram_240b:  INR C
240C 0D                         DCR C
240D 05                         DCR B
240E C2 0B 24                   JNZ 0x240b
2411 3D                         DCR A
2412 C2 09 24                   JNZ 0x2409
2415 C1                         POP BC
2416 C9                         RET

; ============================================================
; copy_until_FF
; вызовы из: 206B 241E
2417 7E          copy_until_FF: MOV A,(HL)
2418 FE FF                      CPI 0xff
241A C8                         RZ
241B 12                         STAX (DE)
241C 23                         INX HL
241D 13                         INX DE
241E C3 17 24                   JMP 0x2417

; ============================================================
; key_10
; вызовы из: 2308 537A
2421 3A 43 00    key_10:        LDA (0x0043)
2424 B7                         ORA A
2425 CA 5B 24                   JZ 0x245b
2428 3A 41 00                   LDA (0x0041)
242B FE 01                      CPI 0x1
242D C0                         RNZ
242E 3A 45 00                   LDA (0x0045)
2431 B7                         ORA A
2432 C2 4D 24                   JNZ 0x244d
2435 3C                         INR A
2436 32 45 00                   STA (0x0045)
2439 2A E7 01                   LHLD (0x01e7)
243C 22 EF 01                   SHLD (0x01ef)
243F 22 D5 00                   SHLD (0x00d5)
2442 3E 26                      MVI A,0x26
2444 CD 13 3C                   CALL 0x3c13
2447 3E 04       LAB_ram_2447:  MVI A,0x4
2449 32 44 00                   STA (0x0044)
244C C9                         RET
244D 3A 44 00    LAB_ram_244d:  LDA (0x0044)
2450 FE 01                      CPI 0x1
2452 CA 47 24                   JZ 0x2447
2455 3E 01                      MVI A,0x1
2457 32 44 00                   STA (0x0044)
245A C9                         RET
245B 3A 46 00    LAB_ram_245b:  LDA (0x0046)
245E B7                         ORA A
245F C2 6B 24                   JNZ 0x246b
2462 CD 2D 2E                   CALL 0x2e2d
2465 CD 44 29                   CALL 0x2944
2468 CD 63 2D                   CALL 0x2d63
246B 3A 6B 00    LAB_ram_246b:  LDA (0x006b)
246E B7                         ORA A
246F 3E 01                      MVI A,0x1
2471 C2 77 24                   JNZ 0x2477
2474 32 41 00                   STA (0x0041)
2477 32 44 00    LAB_ram_2477:  STA (0x0044)
247A 32 43 00                   STA (0x0043)
247D 32 42 00                   STA (0x0042)
2480 21 80 80                   LXI HL,0x8080
2483 22 E7 01                   SHLD (0x01e7)
2486 22 D3 00                   SHLD (0x00d3)
2489 3E 17                      MVI A,0x17
248B CD 13 3C                   CALL 0x3c13
248E AF                         XRA A
248F 32 69 00                   STA (0x0069)
2492 C9                         RET

; ============================================================
; key_12
; вызовы из: 230B 5381
2493 3A 6B 00    key_12:        LDA (0x006b)
2496 B7                         ORA A
2497 C0                         RNZ
2498 3A 46 00                   LDA (0x0046)
249B B7                         ORA A
249C CA D2 24                   JZ 0x24d2
249F 3A 41 00                   LDA (0x0041)
24A2 FE 01                      CPI 0x1
24A4 C0                         RNZ
24A5 3A 47 00                   LDA (0x0047)
24A8 B7                         ORA A
24A9 C2 C4 24                   JNZ 0x24c4
24AC 3C                         INR A
24AD 32 47 00                   STA (0x0047)
24B0 2A E9 01                   LHLD (0x01e9)
24B3 22 F1 01                   SHLD (0x01f1)
24B6 22 D9 00                   SHLD (0x00d9)
24B9 3E 29                      MVI A,0x29
24BB CD 13 3C                   CALL 0x3c13
24BE 3E 08       LAB_ram_24be:  MVI A,0x8
24C0 32 44 00                   STA (0x0044)
24C3 C9                         RET
24C4 3A 44 00    LAB_ram_24c4:  LDA (0x0044)
24C7 FE 02                      CPI 0x2
24C9 CA BE 24                   JZ 0x24be
24CC 3E 02                      MVI A,0x2
24CE 32 44 00                   STA (0x0044)
24D1 C9                         RET
24D2 3A 43 00    LAB_ram_24d2:  LDA (0x0043)
24D5 B7                         ORA A
24D6 C2 E2 24                   JNZ 0x24e2
24D9 CD 2D 2E                   CALL 0x2e2d
24DC CD 44 29                   CALL 0x2944
24DF CD 63 2D                   CALL 0x2d63
24E2 3E 01       LAB_ram_24e2:  MVI A,0x1
24E4 32 42 00                   STA (0x0042)
24E7 32 41 00                   STA (0x0041)
24EA 32 46 00                   STA (0x0046)
24ED 3C                         INR A
24EE 32 44 00                   STA (0x0044)
24F1 21 80 80                   LXI HL,0x8080
24F4 22 E9 01                   SHLD (0x01e9)
24F7 22 D7 00                   SHLD (0x00d7)
24FA 3E 23                      MVI A,0x23
24FC CD 13 3C                   CALL 0x3c13
24FF AF                         XRA A
2500 32 69 00                   STA (0x0069)
2503 C9                         RET

; ============================================================
; key_frz_14
; вызовы из: 22EC 22FF
2504 AF          key_frz_14:    XRA A
2505 32 69 00                   STA (0x0069)
2508 3A 40 00                   LDA (0x0040)
250B 3C                         INR A
250C FE 03                      CPI 0x3
250E C2 12 25                   JNZ 0x2512
2511 AF                         XRA A
2512 32 40 00    LAB_ram_2512:  STA (0x0040)
2515 32 F6 01                   STA (0x01f6)
2518 B7                         ORA A
2519 06 40                      MVI B,0x40
251B CA 26 25                   JZ 0x2526
251E 1F                         RAR
251F 06 00                      MVI B,0x0
2521 DA 26 25                   JC 0x2526
2524 06 80                      MVI B,0x80
2526 3A 49 00    LAB_ram_2526:  LDA (0x0049)
2529 E6 3F                      ANI 0x3f
252B B0                         ORA B
252C 32 49 00                   STA (0x0049)
252F D3 F8                      OUT (0xf8)
2531 3E 36                      MVI A,0x36
2533 CD 13 3C                   CALL 0x3c13
2536 C9                         RET

; ============================================================
; key_35
; вызовы из: 2338
2537 3E 01       key_35:        MVI A,0x1
2539 32 6C 00                   STA (0x006c)
253C CD FF 4D                   CALL 0x4dff
253F C9                         RET

; ============================================================
; key_frz_16
; вызовы из: 22EF 2302
2540 AF          key_frz_16:    XRA A
2541 32 69 00                   STA (0x0069)
2544 3A 49 00                   LDA (0x0049)
2547 47                         MOV B,A
2548 E6 FB                      ANI 0xfb
254A 4F                         MOV C,A
254B 78                         MOV A,B
254C 2F                         CMA
254D E6 04                      ANI 0x4
254F B1                         ORA C
2550 32 49 00                   STA (0x0049)
2553 D3 F8                      OUT (0xf8)
2555 AF                         XRA A
2556 32 69 00                   STA (0x0069)
2559 C9                         RET

; ============================================================
; FUN_ram_255a
255A 3E 07       FUN_ram_255a:  MVI A,0x7
255C CD 13 3C                   CALL 0x3c13
255F C9                         RET

; ============================================================
; FUN_ram_2560
; вызовы из: 20AF
2560 3E 10       FUN_ram_2560:  MVI A,0x10
2562 CD 13 3C                   CALL 0x3c13
2565 C9                         RET

; ============================================================
; key_88
; вызовы из: 2320
2566 3E FF       key_88:        MVI A,0xff
2568 32 4F 00                   STA (0x004f)
256B 3E 01                      MVI A,0x1
256D 32 4E 00                   STA (0x004e)
2570 C3 C2 25                   JMP 0x25c2

; ============================================================
; key_85
; вызовы из: 231D
2573 3E FF       key_85:        MVI A,0xff
2575 32 4F 00                   STA (0x004f)
2578 AF                         XRA A
2579 32 4E 00                   STA (0x004e)
257C C3 C2 25                   JMP 0x25c2

; ============================================================
; key_83
; вызовы из: 231A
257F 3E FF       key_83:        MVI A,0xff
2581 32 4E 00                   STA (0x004e)
2584 32 4F 00                   STA (0x004f)
2587 C3 C2 25                   JMP 0x25c2

; ============================================================
; key_82
; вызовы из: 2317
258A AF          key_82:        XRA A
258B 32 4F 00                   STA (0x004f)
258E 3E FF                      MVI A,0xff
2590 32 4E 00                   STA (0x004e)
2593 C3 C2 25                   JMP 0x25c2

; ============================================================
; key_81
; вызовы из: 2314
2596 3E 01       key_81:        MVI A,0x1
2598 32 4F 00                   STA (0x004f)
259B 3E FF                      MVI A,0xff
259D 32 4E 00                   STA (0x004e)
25A0 C3 C2 25                   JMP 0x25c2

; ============================================================
; key_84
; вызовы из: 2311
25A3 3E 01       key_84:        MVI A,0x1
25A5 32 4F 00                   STA (0x004f)
25A8 AF                         XRA A
25A9 32 4E 00                   STA (0x004e)
25AC C3 C2 25                   JMP 0x25c2

; ============================================================
; key_86
; вызовы из: 2326
25AF 3E 01       key_86:        MVI A,0x1
25B1 32 4E 00                   STA (0x004e)
25B4 32 4F 00                   STA (0x004f)
25B7 C3 C2 25                   JMP 0x25c2

; ============================================================
; key_87
; вызовы из: 2323
25BA AF          key_87:        XRA A
25BB 32 4F 00                   STA (0x004f)
25BE 3C                         INR A
25BF 32 4E 00                   STA (0x004e)
25C2 AF          LAB_ram_25c2:  XRA A
25C3 32 69 00                   STA (0x0069)
25C6 3A 44 00                   LDA (0x0044)
25C9 B7                         ORA A
25CA C8                         RZ
25CB 1F                         RAR
25CC D2 AD 27                   JNC 0x27ad
25CF 2A E7 01                   LHLD (0x01e7)
25D2 7D                         MOV A,L
25D3 B7                         ORA A
25D4 C2 DF 25                   JNZ 0x25df
25D7 3A 4E 00                   LDA (0x004e)
25DA B7                         ORA A
25DB 7D                         MOV A,L
25DC FA EB 25                   JM 0x25eb
25DF 2F          LAB_ram_25df:  CMA
25E0 B7                         ORA A
25E1 C2 EF 25                   JNZ 0x25ef
25E4 3A 4E 00                   LDA (0x004e)
25E7 B7                         ORA A
25E8 FA EF 25                   JM 0x25ef
25EB AF          LAB_ram_25eb:  XRA A
25EC 32 4E 00                   STA (0x004e)
25EF 7C          LAB_ram_25ef:  MOV A,H
25F0 B7                         ORA A
25F1 C2 FC 25                   JNZ 0x25fc
25F4 3A 4F 00                   LDA (0x004f)
25F7 B7                         ORA A
25F8 7C                         MOV A,H
25F9 FA 08 26                   JM 0x2608
25FC 2F          LAB_ram_25fc:  CMA
25FD B7                         ORA A
25FE C2 0C 26                   JNZ 0x260c
2601 3A 4F 00                   LDA (0x004f)
2604 B7                         ORA A
2605 FA 0C 26                   JM 0x260c
2608 AF          LAB_ram_2608:  XRA A
2609 32 4F 00                   STA (0x004f)
260C 3A 41 00    LAB_ram_260c:  LDA (0x0041)
260F FE 05                      CPI 0x5
2611 CA 6E 26                   JZ 0x266e
2614 2A E7 01                   LHLD (0x01e7)
2617 CD C9 28                   CALL 0x28c9
261A CD BE 2A                   CALL 0x2abe
261D 22 E7 01                   SHLD (0x01e7)
2620 3A 41 00                   LDA (0x0041)
2623 FE 05                      CPI 0x5
2625 D2 2B 26                   JNC 0x262b
2628 22 D3 00                   SHLD (0x00d3)
262B 3E 19       LAB_ram_262b:  MVI A,0x19
262D CD 13 3C                   CALL 0x3c13
2630 3A 41 00                   LDA (0x0041)
2633 FE 01                      CPI 0x1
2635 C0                         RNZ
2636 3A 6C 00    LAB_ram_2636:  LDA (0x006c)
2639 B7                         ORA A
263A C2 59 26                   JNZ 0x2659
263D 21 AB 00                   LXI HL,0xab
2640 3E 02                      MVI A,0x2
2642 22 ED 00                   SHLD (0x00ed)
2645 22 F3 01                   SHLD (0x01f3)
2648 32 E4 01                   STA (0x01e4)
264B CD 45 30                   CALL 0x3045
264E 3E 0D                      MVI A,0xd
2650 32 E3 01                   STA (0x01e3)
2653 3E 0B                      MVI A,0xb
2655 CD 13 3C                   CALL 0x3c13
2658 C9                         RET
2659 3E 09       LAB_ram_2659:  MVI A,0x9
265B CD 45 30                   CALL 0x3045
265E 3E 12                      MVI A,0x12
2660 32 E3 01                   STA (0x01e3)
2663 3E 04                      MVI A,0x4
2665 32 E4 01                   STA (0x01e4)
2668 3E 0B                      MVI A,0xb
266A CD 13 3C                   CALL 0x3c13
266D C9                         RET
266E 2A E7 01    LAB_ram_266e:  LHLD (0x01e7)
2671 CD C9 28                   CALL 0x28c9
2674 CD BE 2A                   CALL 0x2abe
2677 22 78 00                   SHLD (0x0078)
267A 3A 52 00                   LDA (0x0052)
267D B7                         ORA A
267E C2 8A 26                   JNZ 0x268a
2681 22 E7 01                   SHLD (0x01e7)
2684 3E 19                      MVI A,0x19
2686 CD 13 3C                   CALL 0x3c13
2689 C9                         RET
268A 3E 20       LAB_ram_268a:  MVI A,0x20
268C CD 08 24                   CALL 0x2408
268F EB                         XCHG
2690 2A E7 01                   LHLD (0x01e7)
2693 EB                         XCHG
2694 7A                         MOV A,D
2695 94                         SUB H
2696 2F                         CMA
2697 3C                         INR A
2698 32 4F 00                   STA (0x004f)
269B 7B                         MOV A,E
269C 95                         SUB L
269D 2F                         CMA
269E 3C                         INR A
269F 32 4E 00                   STA (0x004e)
26A2 CD FA 27                   CALL 0x27fa
26A5 3A 4E 00                   LDA (0x004e)
26A8 B7                         ORA A
26A9 F2 AE 26                   JP 0x26ae
26AC 2F                         CMA
26AD 3C                         INR A
26AE 47          LAB_ram_26ae:  MOV B,A
26AF 3A 4F 00                   LDA (0x004f)
26B2 B7                         ORA A
26B3 F2 B8 26                   JP 0x26b8
26B6 2F                         CMA
26B7 3C                         INR A
26B8 4F          LAB_ram_26b8:  MOV C,A
26B9 90                         SUB B
26BA C2 F2 26                   JNZ 0x26f2
26BD 78                         MOV A,B
26BE B7                         ORA A
26BF C8                         RZ
26C0 32 76 00                   STA (0x0076)
26C3 2A E7 01    LAB_ram_26c3:  LHLD (0x01e7)
26C6 3A 73 00                   LDA (0x0073)
26C9 85                         ADD L
26CA 6F                         MOV L,A
26CB 3A 74 00                   LDA (0x0074)
26CE 84                         ADD H
26CF 67                         MOV H,A
26D0 22 E7 01                   SHLD (0x01e7)
26D3 3E 20                      MVI A,0x20
26D5 CD 13 3C                   CALL 0x3c13
26D8 CD 22 28                   CALL 0x2822
26DB 3E 20                      MVI A,0x20
26DD CD 08 24                   CALL 0x2408
26E0 2A 55 00                   LHLD (0x0055)
26E3 23                         INX HL
26E4 22 55 00                   SHLD (0x0055)
26E7 3A 76 00                   LDA (0x0076)
26EA 3D                         DCR A
26EB 32 76 00                   STA (0x0076)
26EE C2 C3 26                   JNZ 0x26c3
26F1 C9                         RET
26F2 F2 60 27    LAB_ram_26f2:  JP 0x2760
26F5 78                         MOV A,B
26F6 32 76 00                   STA (0x0076)
26F9 41                         MOV B,C
26FA 4F                         MOV C,A
26FB CD 99 28                   CALL 0x2899
26FE 47                         MOV B,A
26FF 2A E7 01    LAB_ram_26ff:  LHLD (0x01e7)
2702 3A 73 00                   LDA (0x0073)
2705 85                         ADD L
2706 6F                         MOV L,A
2707 3A 75 00                   LDA (0x0075)
270A 80                         ADD B
270B 32 75 00                   STA (0x0075)
270E DA 4C 27                   JC 0x274c
2711 22 E7 01                   SHLD (0x01e7)
2714 2A 53 00                   LHLD (0x0053)
2717 23                         INX HL
2718 22 53 00                   SHLD (0x0053)
271B 3E 20       LAB_ram_271b:  MVI A,0x20
271D CD 13 3C                   CALL 0x3c13
2720 CD 22 28                   CALL 0x2822
2723 3A 76 00                   LDA (0x0076)
2726 3D                         DCR A
2727 32 76 00                   STA (0x0076)
272A C2 FF 26                   JNZ 0x26ff
272D 2A E7 01    LAB_ram_272d:  LHLD (0x01e7)
2730 EB                         XCHG
2731 2A 78 00                   LHLD (0x0078)
2734 7A                         MOV A,D
2735 2F                         CMA
2736 3C                         INR A
2737 57                         MOV D,A
2738 7B                         MOV A,E
2739 2F                         CMA
273A 3C                         INR A
273B 5F                         MOV E,A
273C 19                         DAD HL,DE
273D 7C                         MOV A,H
273E B5                         ORA L
273F C8                         RZ
2740 2A 78 00                   LHLD (0x0078)
2743 22 E7 01                   SHLD (0x01e7)
2746 3E 20                      MVI A,0x20
2748 CD 13 3C                   CALL 0x3c13
274B C9                         RET
274C EB          LAB_ram_274c:  XCHG
274D 2A 55 00                   LHLD (0x0055)
2750 23                         INX HL
2751 22 55 00                   SHLD (0x0055)
2754 EB                         XCHG
2755 3A 74 00                   LDA (0x0074)
2758 84                         ADD H
2759 67                         MOV H,A
275A 22 E7 01                   SHLD (0x01e7)
275D C3 1B 27                   JMP 0x271b
2760 79          LAB_ram_2760:  MOV A,C
2761 32 76 00                   STA (0x0076)
2764 CD 99 28                   CALL 0x2899
2767 47                         MOV B,A
2768 2A E7 01    LAB_ram_2768:  LHLD (0x01e7)
276B 3A 74 00                   LDA (0x0074)
276E 84                         ADD H
276F 67                         MOV H,A
2770 3A 75 00                   LDA (0x0075)
2773 80                         ADD B
2774 32 75 00                   STA (0x0075)
2777 DA 99 27                   JC 0x2799
277A 22 E7 01                   SHLD (0x01e7)
277D 2A 53 00                   LHLD (0x0053)
2780 23                         INX HL
2781 22 53 00                   SHLD (0x0053)
2784 3E 20       LAB_ram_2784:  MVI A,0x20
2786 CD 13 3C                   CALL 0x3c13
2789 CD 22 28                   CALL 0x2822
278C 3A 76 00                   LDA (0x0076)
278F 3D                         DCR A
2790 32 76 00                   STA (0x0076)
2793 C2 68 27                   JNZ 0x2768
2796 C3 2D 27                   JMP 0x272d
2799 EB          LAB_ram_2799:  XCHG
279A 2A 55 00                   LHLD (0x0055)
279D 23                         INX HL
279E 22 55 00                   SHLD (0x0055)
27A1 EB                         XCHG
27A2 3A 73 00                   LDA (0x0073)
27A5 85                         ADD L
27A6 6F                         MOV L,A
27A7 22 E7 01                   SHLD (0x01e7)
27AA C3 84 27                   JMP 0x2784
27AD 1F          LAB_ram_27ad:  RAR
27AE D2 C8 27                   JNC 0x27c8
27B1 2A E9 01                   LHLD (0x01e9)
27B4 CD C9 28                   CALL 0x28c9
27B7 CD BE 2A                   CALL 0x2abe
27BA 22 E9 01                   SHLD (0x01e9)
27BD 22 D7 00                   SHLD (0x00d7)
27C0 3E 25                      MVI A,0x25
27C2 CD 13 3C                   CALL 0x3c13
27C5 C3 36 26    LAB_ram_27c5:  JMP 0x2636
27C8 1F          LAB_ram_27c8:  RAR
27C9 D2 E3 27                   JNC 0x27e3
27CC 2A EF 01                   LHLD (0x01ef)
27CF CD C9 28                   CALL 0x28c9
27D2 CD BE 2A                   CALL 0x2abe
27D5 22 EF 01                   SHLD (0x01ef)
27D8 22 D5 00                   SHLD (0x00d5)
27DB 3E 28                      MVI A,0x28
27DD CD 13 3C                   CALL 0x3c13
27E0 C3 36 26                   JMP 0x2636
27E3 2A F1 01    LAB_ram_27e3:  LHLD (0x01f1)
27E6 CD C9 28                   CALL 0x28c9
27E9 CD BE 2A                   CALL 0x2abe
27EC 22 F1 01                   SHLD (0x01f1)
27EF 22 D9 00                   SHLD (0x00d9)
27F2 3E 2B                      MVI A,0x2b
27F4 CD 13 3C                   CALL 0x3c13
27F7 C3 C5 27                   JMP 0x27c5

; ============================================================
; FUN_ram_27fa
; вызовы из: 26A2
27FA 3A 52 00    FUN_ram_27fa:  LDA (0x0052)
27FD B7                         ORA A
27FE C8                         RZ
27FF 3A 4E 00                   LDA (0x004e)
2802 B7                         ORA A
2803 CA 0D 28                   JZ 0x280d
2806 3E 01                      MVI A,0x1
2808 F2 0D 28                   JP 0x280d
280B 3E FF                      MVI A,0xff
280D 32 73 00    LAB_ram_280d:  STA (0x0073)
2810 3A 4F 00                   LDA (0x004f)
2813 B7                         ORA A
2814 CA 1E 28                   JZ 0x281e
2817 3E 01                      MVI A,0x1
2819 F2 1E 28                   JP 0x281e
281C 3E FF                      MVI A,0xff
281E 32 74 00    LAB_ram_281e:  STA (0x0074)
2821 C9                         RET

; ============================================================
; FUN_ram_2822
; вызовы из: 26D8 2720 2789 2D0B 2D2B
2822 E5          FUN_ram_2822:  PUSH HL
2823 D5                         PUSH DE
2824 C5                         PUSH BC
2825 2A E7 01                   LHLD (0x01e7)
2828 5C                         MOV E,H
2829 01 00 00                   LXI BC,0x0
282C 26 00                      MVI H,0x0
282E 16 00                      MVI D,0x0
2830 3A 74 00                   LDA (0x0074)
2833 B7                         ORA A
2834 C2 3F 28                   JNZ 0x283f
2837 21 00 00                   LXI HL,0x0
283A 06 00                      MVI B,0x0
283C C3 53 28                   JMP 0x2853
283F 17          LAB_ram_283f:  RAL
2840 D2 53 28                   JNC 0x2853
2843 7D                         MOV A,L
2844 2F                         CMA
2845 6F                         MOV L,A
2846 7C                         MOV A,H
2847 2F                         CMA
2848 67                         MOV H,A
2849 06 FF                      MVI B,0xff
284B 23                         INX HL
284C 7C                         MOV A,H
284D B5                         ORA L
284E C2 53 28                   JNZ 0x2853
2851 06 00                      MVI B,0x0
2853 3A 73 00    LAB_ram_2853:  LDA (0x0073)
2856 B7                         ORA A
2857 C2 62 28                   JNZ 0x2862
285A 11 00 00                   LXI DE,0x0
285D 0E 00                      MVI C,0x0
285F C3 76 28                   JMP 0x2876
2862 17          LAB_ram_2862:  RAL
2863 DA 76 28                   JC 0x2876
2866 7B                         MOV A,E
2867 2F                         CMA
2868 5F                         MOV E,A
2869 7A                         MOV A,D
286A 2F                         CMA
286B 57                         MOV D,A
286C 0E FF                      MVI C,0xff
286E 13                         INX DE
286F 7A                         MOV A,D
2870 B3                         ORA E
2871 C2 76 28                   JNZ 0x2876
2874 0E 00                      MVI C,0x0
2876 CD 8F 28    LAB_ram_2876:  CALL 0x288f
2879 EB                         XCHG
287A 2A 59 00                   LHLD (0x0059)
287D 4D                         MOV C,L
287E 2A 57 00                   LHLD (0x0057)
2881 CD 8F 28                   CALL 0x288f
2884 22 57 00                   SHLD (0x0057)
2887 78                         MOV A,B
2888 32 59 00                   STA (0x0059)
288B C1                         POP BC
288C D1                         POP DE
288D E1                         POP HL
288E C9                         RET

; ============================================================
; FUN_ram_288f
; вызовы из: 2876 2881
288F 7D          FUN_ram_288f:  MOV A,L
2890 83                         ADD E
2891 6F                         MOV L,A
2892 7C                         MOV A,H
2893 8A                         ADC D
2894 67                         MOV H,A
2895 78                         MOV A,B
2896 89                         ADC C
2897 47                         MOV B,A
2898 C9                         RET

; ============================================================
; FUN_ram_2899
; вызовы из: 26FB 2764
2899 16 08       FUN_ram_2899:  MVI D,0x8
289B 2E 00                      MVI L,0x0
289D 78          LAB_ram_289d:  MOV A,B
289E B7                         ORA A
289F 17                         RAL
28A0 47                         MOV B,A
28A1 91                         SUB C
28A2 67                         MOV H,A
28A3 7D                         MOV A,L
28A4 17                         RAL
28A5 6F                         MOV L,A
28A6 7C                         MOV A,H
28A7 B7                         ORA A
28A8 FA AC 28                   JM 0x28ac
28AB 47                         MOV B,A
28AC 15          LAB_ram_28ac:  DCR D
28AD C2 9D 28                   JNZ 0x289d
28B0 7D                         MOV A,L
28B1 2F                         CMA
28B2 32 75 00                   STA (0x0075)
28B5 32 77 00                   STA (0x0077)
28B8 C9                         RET

; ============================================================
; shr16_hl
28B9 AF          shr16_hl:      XRA A
28BA 7C                         MOV A,H
28BB 1F                         RAR
28BC 67                         MOV H,A
28BD 7D                         MOV A,L
28BE 1F                         RAR
28BF 6F                         MOV L,A
28C0 C9                         RET

; ============================================================
; shl16_hl
28C1 AF          shl16_hl:      XRA A
28C2 7D                         MOV A,L
28C3 17                         RAL
28C4 6F                         MOV L,A
28C5 7C                         MOV A,H
28C6 17                         RAL
28C7 67                         MOV H,A
28C8 C9                         RET

; ============================================================
; FUN_ram_28c9
; вызовы из: 2617 2671 27B4 27CF 27E6
28C9 3A 4E 00    FUN_ram_28c9:  LDA (0x004e)
28CC B7                         ORA A
28CD F2 D6 28                   JP 0x28d6
28D0 85                         ADD L
28D1 6F                         MOV L,A
28D2 D8                         RC
28D3 AF                         XRA A
28D4 6F                         MOV L,A
28D5 C9                         RET
28D6 85          LAB_ram_28d6:  ADD L
28D7 6F                         MOV L,A
28D8 D0                         RNC
28D9 2E FF                      MVI L,0xff
28DB C9                         RET

; ============================================================
; picto_select
; вызовы из: 2335
28DC 3E 04       picto_select:  MVI A,0x4
28DE CD 13 3C                   CALL 0x3c13
28E1 3E 09                      MVI A,0x9
28E3 CD 13 3C                   CALL 0x3c13
28E6 CD 44 29                   CALL 0x2944
28E9 CD 3B 22                   CALL 0x223b
28EC CD 6E 2E                   CALL 0x2e6e
28EF 21 46 2F                   LXI HL,0x2f46
28F2 01 05 04                   LXI BC,0x405
28F5 16 0A                      MVI D,0xa
28F7 CD 63 2A                   CALL 0x2a63
28FA 3E FF       LAB_ram_28fa:  MVI A,0xff
28FC CD 08 24                   CALL 0x2408
28FF CD 78 2A                   CALL 0x2a78
2902 21 FA 28                   LXI HL,0x28fa
2905 E5                         PUSH HL
2906 3A 4D 00                   LDA (0x004d)
2909 47                         MOV B,A
290A 21 14 29                   LXI HL,0x2914
290D CD D3 22                   CALL 0x22d3
2910 E1                         POP HL
2911 C3 FA 28                   JMP 0x28fa
2914 10          tbl_keys_picto: db 10h
2915 66 29                      addr ram:2966
2917 86                         db 86h
2918 91 29                      addr ram:2991
291A 81                         db 81h
291B BB 29                      addr ram:29bb
291D 82                         db 82h
291E DD 29                      addr ram:29dd
2920 87                         db 87h
2921 05 2A                      addr ram:2a05
2923 84                         db 84h
2924 20 2A                      addr ram:2a20
2926 85                         db 85h
2927 47 2A                      addr ram:2a47
2929 16                         db 16h
292A 2D 29                      addr ram:292d
292C FF                         db FFh

; ============================================================
; kpic_16
; вызовы из: 292A
292D 3E 05       kpic_16:       MVI A,0x5
292F 32 E3 01                   STA (0x01e3)
2932 3E 0A                      MVI A,0xa
2934 32 E4 01                   STA (0x01e4)
2937 3E 3A                      MVI A,0x3a
2939 CD 13 3C                   CALL 0x3c13
293C CD 58 2E                   CALL 0x2e58
293F CD 43 2E                   CALL 0x2e43
2942 E1                         POP HL
2943 C9                         RET

; ============================================================
; FUN_ram_2944
; вызовы из: 2221 222D 2465 24DC 28E6 2AB7
2944 3E 3D       FUN_ram_2944:  MVI A,0x3d
2946 CD 13 3C                   CALL 0x3c13
2949 3A F5 01                   LDA (0x01f5)
294C B7                         ORA A
294D C8                         RZ
294E 3A 7D 00                   LDA (0x007d)
2951 32 E2 01                   STA (0x01e2)
2954 3A 7E 00                   LDA (0x007e)
2957 32 E3 01                   STA (0x01e3)
295A 3A 7F 00                   LDA (0x007f)
295D 32 E5 01                   STA (0x01e5)
2960 3E 3F                      MVI A,0x3f
2962 CD 13 3C                   CALL 0x3c13
2965 C9                         RET

; ============================================================
; kpic_10
; вызовы из: 2915
2966 3A F5 01    kpic_10:       LDA (0x01f5)
2969 3C                         INR A
296A E6 07                      ANI 0x7
296C 32 F5 01                   STA (0x01f5)
296F 3E 3D                      MVI A,0x3d
2971 CD 13 3C                   CALL 0x3c13
2974 3A 7D 00                   LDA (0x007d)
2977 32 E2 01                   STA (0x01e2)
297A 3A 7E 00                   LDA (0x007e)
297D 32 E3 01                   STA (0x01e3)
2980 3A 7F 00                   LDA (0x007f)
2983 32 E5 01                   STA (0x01e5)
2986 3A F5 01                   LDA (0x01f5)
2989 B7                         ORA A
298A C8                         RZ
298B 3E 3F                      MVI A,0x3f
298D CD 13 3C                   CALL 0x3c13
2990 C9                         RET

; ============================================================
; kpic_86
; вызовы из: 2918
2991 3A F5 01    kpic_86:       LDA (0x01f5)
2994 B7                         ORA A
2995 C8                         RZ
2996 CD 83 2A                   CALL 0x2a83
2999 3A 7F 00                   LDA (0x007f)
299C 3D                         DCR A
299D 32 7F 00                   STA (0x007f)
29A0 32 E5 01                   STA (0x01e5)
29A3 FE 7F                      CPI 0x7f
29A5 C2 B0 29                   JNZ 0x29b0
29A8 3E 87                      MVI A,0x87
29AA 32 7F 00                   STA (0x007f)
29AD 32 E5 01                   STA (0x01e5)
29B0 3A F5 01    LAB_ram_29b0:  LDA (0x01f5)
29B3 B7                         ORA A
29B4 C8                         RZ
29B5 3E 3F                      MVI A,0x3f
29B7 CD 13 3C                   CALL 0x3c13
29BA C9                         RET

; ============================================================
; kpic_81
; вызовы из: 291B
29BB 3A F5 01    kpic_81:       LDA (0x01f5)
29BE B7                         ORA A
29BF C8                         RZ
29C0 CD 83 2A                   CALL 0x2a83
29C3 3A 7F 00                   LDA (0x007f)
29C6 3C                         INR A
29C7 32 7F 00                   STA (0x007f)
29CA 32 E5 01                   STA (0x01e5)
29CD FE 88                      CPI 0x88
29CF C2 B0 29                   JNZ 0x29b0
29D2 3E 80                      MVI A,0x80
29D4 32 7F 00                   STA (0x007f)
29D7 32 E5 01                   STA (0x01e5)
29DA C3 B0 29                   JMP 0x29b0

; ============================================================
; kpic_82
; вызовы из: 291E
29DD 3A F5 01    kpic_82:       LDA (0x01f5)
29E0 B7                         ORA A
29E1 C8                         RZ
29E2 CD 83 2A                   CALL 0x2a83
29E5 3A 7D 00                   LDA (0x007d)
29E8 3C                         INR A
29E9 32 7D 00                   STA (0x007d)
29EC 32 E2 01                   STA (0x01e2)
29EF FE 05                      CPI 0x5
29F1 C2 B0 29                   JNZ 0x29b0
29F4 3E 01                      MVI A,0x1
29F6 32 7D 00    LAB_ram_29f6:  STA (0x007d)
29F9 32 E2 01                   STA (0x01e2)
29FC 3A 7F 00                   LDA (0x007f)
29FF 32 E5 01                   STA (0x01e5)
2A02 C3 B0 29                   JMP 0x29b0

; ============================================================
; kpic_87
; вызовы из: 2921
2A05 3A F5 01    kpic_87:       LDA (0x01f5)
2A08 B7                         ORA A
2A09 C8                         RZ
2A0A CD 83 2A                   CALL 0x2a83
2A0D 3A 7D 00                   LDA (0x007d)
2A10 3D                         DCR A
2A11 32 7D 00                   STA (0x007d)
2A14 32 E2 01                   STA (0x01e2)
2A17 B7                         ORA A
2A18 C2 B0 29                   JNZ 0x29b0
2A1B 3E 04                      MVI A,0x4
2A1D C3 F6 29                   JMP 0x29f6

; ============================================================
; kpic_84
; вызовы из: 2924
2A20 3A F5 01    kpic_84:       LDA (0x01f5)
2A23 B7                         ORA A
2A24 C8                         RZ
2A25 CD 83 2A                   CALL 0x2a83
2A28 3A 7E 00                   LDA (0x007e)
2A2B 3D                         DCR A
2A2C 32 7E 00                   STA (0x007e)
2A2F 32 E3 01                   STA (0x01e3)
2A32 B7                         ORA A
2A33 C2 B0 29                   JNZ 0x29b0
2A36 3E 04                      MVI A,0x4
2A38 32 7E 00    LAB_ram_2a38:  STA (0x007e)
2A3B 32 E3 01                   STA (0x01e3)
2A3E 3A 7F 00                   LDA (0x007f)
2A41 32 E5 01                   STA (0x01e5)
2A44 C3 B0 29                   JMP 0x29b0

; ============================================================
; kpic_85
; вызовы из: 2927
2A47 3A F5 01    kpic_85:       LDA (0x01f5)
2A4A B7                         ORA A
2A4B C8                         RZ
2A4C CD 83 2A                   CALL 0x2a83
2A4F 3A 7E 00                   LDA (0x007e)
2A52 3C                         INR A
2A53 32 7E 00                   STA (0x007e)
2A56 32 E3 01                   STA (0x01e3)
2A59 FE 05                      CPI 0x5
2A5B C2 B0 29                   JNZ 0x29b0
2A5E 3E 01                      MVI A,0x1
2A60 C3 38 2A                   JMP 0x2a38

; ============================================================
; FUN_ram_2a63
; вызовы из: 28F7
2A63 22 F3 01    FUN_ram_2a63:  SHLD (0x01f3)
2A66 78                         MOV A,B
2A67 32 E2 01                   STA (0x01e2)
2A6A 79                         MOV A,C
2A6B 32 E3 01                   STA (0x01e3)
2A6E 7A                         MOV A,D
2A6F 32 E4 01                   STA (0x01e4)
2A72 3E 2F                      MVI A,0x2f
2A74 CD 13 3C                   CALL 0x3c13
2A77 C9                         RET

; ============================================================
; FUN_ram_2a78
; вызовы из: 28FF 2A7C
2A78 CD F1 20    FUN_ram_2a78:  CALL 0x20f1
2A7B B7                         ORA A
2A7C CA 78 2A                   JZ 0x2a78
2A7F 32 4D 00                   STA (0x004d)
2A82 C9                         RET

; ============================================================
; FUN_ram_2a83
; вызовы из: 2996 29C0 29E2 2A0A 2A25 2A4C
2A83 3A 7D 00    FUN_ram_2a83:  LDA (0x007d)
2A86 32 E2 01                   STA (0x01e2)
2A89 3A 7E 00                   LDA (0x007e)
2A8C 32 E3 01                   STA (0x01e3)
2A8F 3A 7F 00                   LDA (0x007f)
2A92 32 E5 01                   STA (0x01e5)
2A95 3E 40                      MVI A,0x40
2A97 CD 13 3C                   CALL 0x3c13
2A9A C9                         RET

; ============================================================
; vid_print_str
; вызовы из: 221E 226E 22BD 2D73 2DAC 2E05
2A9B 22 F3 01    vid_print_str: SHLD (0x01f3)
2A9E 3E 3B                      MVI A,0x3b
2AA0 CD 13 3C                   CALL 0x3c13
2AA3 3E 3C                      MVI A,0x3c
2AA5 CD 13 3C                   CALL 0x3c13
2AA8 C9                         RET

; ============================================================
; key_33
; вызовы из: 2225 2332 4E57
2AA9 CD 2D 2E    key_33:        CALL 0x2e2d

; ============================================================
; FUN_ram_2aac
; вызовы из: 20B2
2AAC 21 80 00    FUN_ram_2aac:  LXI HL,0x80
2AAF 22 F3 01                   SHLD (0x01f3)
2AB2 3E 0A                      MVI A,0xa
2AB4 CD 13 3C                   CALL 0x3c13
2AB7 CD 44 29                   CALL 0x2944
2ABA CD 43 2E                   CALL 0x2e43
2ABD C9                         RET

; ============================================================
; FUN_ram_2abe
; вызовы из: 261A 2674 27B7 27D2 27E9
2ABE 3A 4F 00    FUN_ram_2abe:  LDA (0x004f)
2AC1 B7                         ORA A
2AC2 F2 CB 2A                   JP 0x2acb
2AC5 84                         ADD H
2AC6 67                         MOV H,A
2AC7 D8                         RC
2AC8 26 00                      MVI H,0x0
2ACA C9                         RET
2ACB 84          LAB_ram_2acb:  ADD H
2ACC 67                         MOV H,A
2ACD D0                         RNC
2ACE 26 FF                      MVI H,0xff
2AD0 C9                         RET

; ============================================================
; key_15
; вызовы из: 233B 53B7 5434 54D2
2AD1 3A 69 00    key_15:        LDA (0x0069)
2AD4 B7                         ORA A
2AD5 C0                         RNZ
2AD6 3A 6B 00                   LDA (0x006b)
2AD9 B7                         ORA A
2ADA CA FC 2A                   JZ 0x2afc
2ADD 3A 52 00                   LDA (0x0052)
2AE0 B7                         ORA A
2AE1 C2 EF 2A                   JNZ 0x2aef
2AE4 3C                         INR A
2AE5 32 52 00                   STA (0x0052)
2AE8 2A E7 01                   LHLD (0x01e7)
2AEB 22 60 00                   SHLD (0x0060)
2AEE C9                         RET
2AEF 2A E7 01    LAB_ram_2aef:  LHLD (0x01e7)
2AF2 22 62 00                   SHLD (0x0062)
2AF5 CD 43 2B                   CALL 0x2b43
2AF8 CD 3B 22                   CALL 0x223b
2AFB C9                         RET
2AFC AF          LAB_ram_2afc:  XRA A
2AFD 32 52 00                   STA (0x0052)
2B00 21 00 00                   LXI HL,0x0
2B03 22 53 00                   SHLD (0x0053)
2B06 22 55 00                   SHLD (0x0055)
2B09 22 57 00                   SHLD (0x0057)
2B0C 22 59 00                   SHLD (0x0059)
2B0F 21 FF FF                   LXI HL,0xffff
2B12 22 E3 00                   SHLD (0x00e3)
2B15 22 E5 00                   SHLD (0x00e5)
2B18 CD 2D 2E                   CALL 0x2e2d
2B1B 3E 01                      MVI A,0x1
2B1D 32 44 00                   STA (0x0044)
2B20 32 43 00                   STA (0x0043)
2B23 32 42 00                   STA (0x0042)
2B26 32 6B 00                   STA (0x006b)
2B29 3E 05                      MVI A,0x5
2B2B 32 41 00                   STA (0x0041)
2B2E 3A 6C 00                   LDA (0x006c)
2B31 B7                         ORA A
2B32 3E 09                      MVI A,0x9
2B34 CC 13 3C                   CZ 0x3c13
2B37 21 80 80                   LXI HL,0x8080
2B3A 22 E7 01                   SHLD (0x01e7)
2B3D 3E 17                      MVI A,0x17
2B3F CD 13 3C                   CALL 0x3c13
2B42 C9                         RET

; ============================================================
; FUN_ram_2b43
; вызовы из: 2AF5
2B43 2A 60 00    FUN_ram_2b43:  LHLD (0x0060)
2B46 EB                         XCHG
2B47 2A 62 00                   LHLD (0x0062)
2B4A AF                         XRA A
2B4B 32 73 00                   STA (0x0073)
2B4E 32 74 00                   STA (0x0074)
2B51 7D                         MOV A,L
2B52 93                         SUB E
2B53 32 6D 00                   STA (0x006d)
2B56 06 FF                      MVI B,0xff
2B58 CA 64 2B                   JZ 0x2b64
2B5B D2 60 2B                   JNC 0x2b60
2B5E 06 01                      MVI B,0x1
2B60 78          LAB_ram_2b60:  MOV A,B
2B61 32 73 00                   STA (0x0073)
2B64 7C          LAB_ram_2b64:  MOV A,H
2B65 92                         SUB D
2B66 32 6E 00                   STA (0x006e)
2B69 06 FF                      MVI B,0xff
2B6B CA 77 2B                   JZ 0x2b77
2B6E D2 73 2B                   JNC 0x2b73
2B71 06 01                      MVI B,0x1
2B73 78          LAB_ram_2b73:  MOV A,B
2B74 32 74 00                   STA (0x0074)
2B77 3A 6D 00    LAB_ram_2b77:  LDA (0x006d)
2B7A 4F                         MOV C,A
2B7B 3A 73 00                   LDA (0x0073)
2B7E B7                         ORA A
2B7F FA 86 2B                   JM 0x2b86
2B82 79                         MOV A,C
2B83 2F                         CMA
2B84 3C                         INR A
2B85 4F                         MOV C,A
2B86 79          LAB_ram_2b86:  MOV A,C
2B87 32 6D 00                   STA (0x006d)
2B8A 3A 6E 00                   LDA (0x006e)
2B8D 6F                         MOV L,A
2B8E 3A 74 00                   LDA (0x0074)
2B91 B7                         ORA A
2B92 FA 99 2B                   JM 0x2b99
2B95 7D                         MOV A,L
2B96 2F                         CMA
2B97 3C                         INR A
2B98 6F                         MOV L,A
2B99 7D          LAB_ram_2b99:  MOV A,L
2B9A 32 6E 00                   STA (0x006e)
2B9D 06 00                      MVI B,0x0
2B9F 26 00                      MVI H,0x0
2BA1 09                         DAD HL,BC
2BA2 EB                         XCHG
2BA3 2A 53 00                   LHLD (0x0053)
2BA6 19                         DAD HL,DE
2BA7 22 E3 00                   SHLD (0x00e3)
2BAA 3A 6E 00                   LDA (0x006e)
2BAD B7                         ORA A
2BAE CA 71 2C                   JZ 0x2c71
2BB1 6F                         MOV L,A
2BB2 91                         SUB C
2BB3 D2 85 2C                   JNC 0x2c85
2BB6 61                         MOV H,C
2BB7 CD DA 2C                   CALL 0x2cda
2BBA CA CD 2B    LAB_ram_2bba:  JZ 0x2bcd
2BBD 3A 6F 00                   LDA (0x006f)
2BC0 CD BF 2C                   CALL 0x2cbf
2BC3 3A 70 00                   LDA (0x0070)
2BC6 3D                         DCR A
2BC7 32 70 00                   STA (0x0070)
2BCA C2 BA 2B                   JNZ 0x2bba
2BCD 3A 6F 00    LAB_ram_2bcd:  LDA (0x006f)
2BD0 3D                         DCR A
2BD1 CD BF 2C                   CALL 0x2cbf
2BD4 C2 CD 2B                   JNZ 0x2bcd
2BD7 2A 55 00    LAB_ram_2bd7:  LHLD (0x0055)
2BDA 22 E5 00                   SHLD (0x00e5)
2BDD 3A 6C 00                   LDA (0x006c)
2BE0 B7                         ORA A
2BE1 C2 57 2C                   JNZ 0x2c57
2BE4 21 BF 00                   LXI HL,0xbf
2BE7 22 F3 01                   SHLD (0x01f3)
2BEA 22 ED 00                   SHLD (0x00ed)
2BED 3E 05                      MVI A,0x5
2BEF CD 45 30                   CALL 0x3045
2BF2 3E 01                      MVI A,0x1
2BF4 32 E4 01                   STA (0x01e4)
2BF7 3E 0D                      MVI A,0xd
2BF9 32 E3 01                   STA (0x01e3)
2BFC 3E 0B                      MVI A,0xb
2BFE CD 13 3C                   CALL 0x3c13
2C01 21 C9 00                   LXI HL,0xc9
2C04 22 F3 01                   SHLD (0x01f3)
2C07 22 ED 00                   SHLD (0x00ed)
2C0A 3A 59 00                   LDA (0x0059)
2C0D B7                         ORA A
2C0E 47                         MOV B,A
2C0F 2A 57 00                   LHLD (0x0057)
2C12 F2 24 2C                   JP 0x2c24
2C15 2F                         CMA
2C16 47                         MOV B,A
2C17 7C                         MOV A,H
2C18 2F                         CMA
2C19 67                         MOV H,A
2C1A 7D                         MOV A,L
2C1B 2F                         CMA
2C1C 6F                         MOV L,A
2C1D 23                         INX HL
2C1E 7C                         MOV A,H
2C1F B5                         ORA L
2C20 C2 24 2C                   JNZ 0x2c24
2C23 04                         INR B
2C24 B7          LAB_ram_2c24:  ORA A
2C25 78                         MOV A,B
2C26 1F                         RAR
2C27 47                         MOV B,A
2C28 7C                         MOV A,H
2C29 1F                         RAR
2C2A 67                         MOV H,A
2C2B 7D                         MOV A,L
2C2C 1F                         RAR
2C2D 6F                         MOV L,A
2C2E 78                         MOV A,B
2C2F 32 E5 00                   STA (0x00e5)
2C32 AF                         XRA A
2C33 32 E6 00                   STA (0x00e6)
2C36 22 E3 00                   SHLD (0x00e3)
2C39 3E 06                      MVI A,0x6
2C3B CD 45 30                   CALL 0x3045
2C3E 3E 0E                      MVI A,0xe
2C40 32 E3 01                   STA (0x01e3)
2C43 3E 0B                      MVI A,0xb
2C45 CD 13 3C                   CALL 0x3c13
2C48 21 00 00                   LXI HL,0x0
2C4B 22 41 00                   SHLD (0x0041)
2C4E 22 43 00                   SHLD (0x0043)
2C51 3E 18                      MVI A,0x18
2C53 CD 13 3C                   CALL 0x3c13
2C56 C9                         RET
2C57 3E 0A       LAB_ram_2c57:  MVI A,0xa
2C59 CD 45 30                   CALL 0x3045
2C5C 3E 12                      MVI A,0x12
2C5E 32 E3 01                   STA (0x01e3)
2C61 3E 02                      MVI A,0x2
2C63 32 E4 01                   STA (0x01e4)
2C66 3E 0B                      MVI A,0xb
2C68 CD 13 3C                   CALL 0x3c13
2C6B 3E 18                      MVI A,0x18
2C6D CD 13 3C                   CALL 0x3c13
2C70 C9                         RET
2C71 3A 6D 00    LAB_ram_2c71:  LDA (0x006d)
2C74 B7                         ORA A
2C75 CA D7 2B                   JZ 0x2bd7
2C78 CD 03 2D                   CALL 0x2d03
2C7B 3A 6D 00                   LDA (0x006d)
2C7E 3D                         DCR A
2C7F 32 6D 00                   STA (0x006d)
2C82 C3 71 2C                   JMP 0x2c71
2C85 65          LAB_ram_2c85:  MOV H,L
2C86 69                         MOV L,C
2C87 79                         MOV A,C
2C88 B7                         ORA A
2C89 CA AF 2C                   JZ 0x2caf
2C8C CD DA 2C                   CALL 0x2cda
2C8F CA A2 2C    LAB_ram_2c8f:  JZ 0x2ca2
2C92 3A 6F 00                   LDA (0x006f)
2C95 CD E8 2C                   CALL 0x2ce8
2C98 3A 70 00                   LDA (0x0070)
2C9B 3D                         DCR A
2C9C 32 70 00                   STA (0x0070)
2C9F C2 8F 2C                   JNZ 0x2c8f
2CA2 3A 6F 00    LAB_ram_2ca2:  LDA (0x006f)
2CA5 3D                         DCR A
2CA6 CD E8 2C                   CALL 0x2ce8
2CA9 C2 A2 2C                   JNZ 0x2ca2
2CAC C3 D7 2B                   JMP 0x2bd7
2CAF CD 23 2D    LAB_ram_2caf:  CALL 0x2d23
2CB2 3A 6E 00                   LDA (0x006e)
2CB5 3D                         DCR A
2CB6 32 6E 00                   STA (0x006e)
2CB9 C2 AF 2C                   JNZ 0x2caf
2CBC C3 D7 2B                   JMP 0x2bd7

; ============================================================
; FUN_ram_2cbf
; вызовы из: 2BC0 2BD1
2CBF 32 71 00    FUN_ram_2cbf:  STA (0x0071)
2CC2 CD 23 2D                   CALL 0x2d23
2CC5 CD 03 2D    LAB_ram_2cc5:  CALL 0x2d03
2CC8 3A 71 00                   LDA (0x0071)
2CCB 3D                         DCR A
2CCC 32 71 00                   STA (0x0071)
2CCF C2 C5 2C                   JNZ 0x2cc5
2CD2 3A 6E 00                   LDA (0x006e)
2CD5 3D                         DCR A
2CD6 32 6E 00                   STA (0x006e)
2CD9 C9                         RET

; ============================================================
; FUN_ram_2cda
; вызовы из: 2BB7 2C8C
2CDA CD 43 2D    FUN_ram_2cda:  CALL 0x2d43
2CDD 04                         INR B
2CDE 78                         MOV A,B
2CDF 32 6F 00                   STA (0x006f)
2CE2 79                         MOV A,C
2CE3 B7                         ORA A
2CE4 32 70 00                   STA (0x0070)
2CE7 C9                         RET

; ============================================================
; FUN_ram_2ce8
; вызовы из: 2C95 2CA6
2CE8 32 71 00    FUN_ram_2ce8:  STA (0x0071)
2CEB CD 03 2D                   CALL 0x2d03
2CEE CD 23 2D    LAB_ram_2cee:  CALL 0x2d23
2CF1 3A 71 00                   LDA (0x0071)
2CF4 3D                         DCR A
2CF5 32 71 00                   STA (0x0071)
2CF8 C2 EE 2C                   JNZ 0x2cee
2CFB 3A 6D 00                   LDA (0x006d)
2CFE 3D                         DCR A
2CFF 32 6D 00                   STA (0x006d)
2D02 C9                         RET

; ============================================================
; FUN_ram_2d03
; вызовы из: 2C78 2CC5 2CEB
2D03 3A 74 00    FUN_ram_2d03:  LDA (0x0074)
2D06 F5                         PUSH AF
2D07 AF                         XRA A
2D08 32 74 00                   STA (0x0074)
2D0B CD 22 28                   CALL 0x2822
2D0E F1                         POP AF
2D0F 32 74 00                   STA (0x0074)
2D12 3A E7 01                   LDA (0x01e7)
2D15 47                         MOV B,A
2D16 3A 73 00                   LDA (0x0073)
2D19 80                         ADD B
2D1A 32 E7 01                   STA (0x01e7)
2D1D 3E 20                      MVI A,0x20
2D1F CD 13 3C                   CALL 0x3c13
2D22 C9                         RET

; ============================================================
; FUN_ram_2d23
; вызовы из: 2CAF 2CC2 2CEE
2D23 3A 73 00    FUN_ram_2d23:  LDA (0x0073)
2D26 F5                         PUSH AF
2D27 AF                         XRA A
2D28 32 73 00                   STA (0x0073)
2D2B CD 22 28                   CALL 0x2822
2D2E F1                         POP AF
2D2F 32 73 00                   STA (0x0073)
2D32 3A E8 01                   LDA (0x01e8)
2D35 47                         MOV B,A
2D36 3A 74 00                   LDA (0x0074)
2D39 80                         ADD B
2D3A 32 E8 01                   STA (0x01e8)
2D3D 3E 20                      MVI A,0x20
2D3F CD 13 3C                   CALL 0x3c13
2D42 C9                         RET

; ============================================================
; FUN_ram_2d43
; вызовы из: 2CDA
2D43 16 09       FUN_ram_2d43:  MVI D,0x9
2D45 AF                         XRA A
2D46 4F                         MOV C,A
2D47 47                         MOV B,A
2D48 15          LAB_ram_2d48:  DCR D
2D49 C8                         RZ
2D4A 7C                         MOV A,H
2D4B 17                         RAL
2D4C 67                         MOV H,A
2D4D 79                         MOV A,C
2D4E 17                         RAL
2D4F 4F                         MOV C,A
2D50 95                         SUB L
2D51 D2 5B 2D                   JNC 0x2d5b
2D54 3F                         CMC
2D55 78                         MOV A,B
2D56 17                         RAL
2D57 47                         MOV B,A
2D58 C3 48 2D                   JMP 0x2d48
2D5B 4F          LAB_ram_2d5b:  MOV C,A
2D5C 37                         STC
2D5D 78                         MOV A,B
2D5E 17                         RAL
2D5F 47                         MOV B,A
2D60 C3 48 2D                   JMP 0x2d48

; ============================================================
; FUN_ram_2d63
; вызовы из: 209F 2218 2468 24DF 52F4
2D63 21 D3 00    FUN_ram_2d63:  LXI HL,0xd3
2D66 06 10                      MVI B,0x10
2D68 36 FF       LAB_ram_2d68:  MVI (HL),0xff
2D6A 23                         INX HL
2D6B 05                         DCR B
2D6C C2 68 2D                   JNZ 0x2d68
2D6F C9                         RET

; ============================================================
; input_patient_code
; вызовы из: 2329
2D70 21 BA 2E    input_patient_code: LXI HL,0x2eba
2D73 CD 9B 2A                   CALL 0x2a9b
2D76 3E 02                      MVI A,0x2
2D78 32 69 00                   STA (0x0069)
2D7B 3E 05                      MVI A,0x5
2D7D 32 66 00                   STA (0x0066)
2D80 21 A5 00                   LXI HL,0xa5
2D83 22 67 00                   SHLD (0x0067)
2D86 C9                         RET

; ============================================================
; menu_main
; вызовы из: 230E
2D87 AF          menu_main:     XRA A
2D88 32 69 00                   STA (0x0069)
2D8B CD 6E 2E                   CALL 0x2e6e
2D8E 21 D8 2E                   LXI HL,0x2ed8
2D91 22 F3 01                   SHLD (0x01f3)
2D94 3E 05                      MVI A,0x5
2D96 32 E2 01                   STA (0x01e2)
2D99 3E 05                      MVI A,0x5
2D9B 32 E3 01                   STA (0x01e3)
2D9E 3E 07                      MVI A,0x7
2DA0 32 E4 01                   STA (0x01e4)
2DA3 3E 2F                      MVI A,0x2f
2DA5 CD 13 3C                   CALL 0x3c13
2DA8 C9                         RET

; ============================================================
; input_date
; вызовы из: 232C
2DA9 21 AD 2E    input_date:    LXI HL,0x2ead
2DAC CD 9B 2A                   CALL 0x2a9b
2DAF 3E 01                      MVI A,0x1
2DB1 32 69 00                   STA (0x0069)
2DB4 3E 08                      MVI A,0x8
2DB6 32 66 00                   STA (0x0066)
2DB9 21 9A 00                   LXI HL,0x9a
2DBC 22 67 00                   SHLD (0x0067)
2DBF C9                         RET

; ============================================================
; FUN_ram_2dc0
; вызовы из: 20DA
2DC0 3A 69 00    FUN_ram_2dc0:  LDA (0x0069)
2DC3 B7                         ORA A
2DC4 C8                         RZ
2DC5 78                         MOV A,B
2DC6 D6 30                      SUI 0x30
2DC8 FA FE 2D                   JM 0x2dfe
2DCB 3E 39                      MVI A,0x39
2DCD 90                         SUB B
2DCE FA FE 2D                   JM 0x2dfe
2DD1 E1                         POP HL
2DD2 3A 69 00                   LDA (0x0069)
2DD5 1F                         RAR
2DD6 DA 09 2E                   JC 0x2e09
2DD9 2A 67 00                   LHLD (0x0067)
2DDC 70                         MOV (HL),B
2DDD 23                         INX HL
2DDE 22 67 00                   SHLD (0x0067)
2DE1 21 A3 00                   LXI HL,0xa3
2DE4 3E 05                      MVI A,0x5
2DE6 32 E3 01    LAB_ram_2de6:  STA (0x01e3)
2DE9 3E 25                      MVI A,0x25
2DEB 32 E2 01                   STA (0x01e2)
2DEE 22 F3 01                   SHLD (0x01f3)
2DF1 3E 0C                      MVI A,0xc
2DF3 CD 13 3C                   CALL 0x3c13
2DF6 3A 66 00                   LDA (0x0066)
2DF9 3D                         DCR A
2DFA 32 66 00                   STA (0x0066)
2DFD C0                         RNZ
2DFE AF          LAB_ram_2dfe:  XRA A
2DFF 32 69 00                   STA (0x0069)
2E02 21 CF 2E                   LXI HL,0x2ecf
2E05 CD 9B 2A                   CALL 0x2a9b
2E08 C9                         RET
2E09 2A 67 00    LAB_ram_2e09:  LHLD (0x0067)
2E0C 3A 66 00                   LDA (0x0066)
2E0F FE 06                      CPI 0x6
2E11 C2 16 2E                   JNZ 0x2e16
2E14 23                         INX HL
2E15 3D                         DCR A
2E16 FE 03       LAB_ram_2e16:  CPI 0x3
2E18 C2 1D 2E                   JNZ 0x2e1d
2E1B 23                         INX HL
2E1C 3D                         DCR A
2E1D 70          LAB_ram_2e1d:  MOV (HL),B
2E1E 23                         INX HL
2E1F 22 67 00                   SHLD (0x0067)
2E22 32 66 00                   STA (0x0066)
2E25 21 9A 00                   LXI HL,0x9a
2E28 3E 04                      MVI A,0x4
2E2A C3 E6 2D                   JMP 0x2de6

; ============================================================
; FUN_ram_2e2d
; вызовы из: 2462 24D9 2AA9 2B18
2E2D 3A 6C 00    FUN_ram_2e2d:  LDA (0x006c)
2E30 B7                         ORA A
2E31 C0                         RNZ
2E32 CD 3B 22                   CALL 0x223b
2E35 3E 04                      MVI A,0x4
2E37 CD 13 3C                   CALL 0x3c13
2E3A 3E 09                      MVI A,0x9
2E3C CD 13 3C                   CALL 0x3c13
2E3F CD 43 2E                   CALL 0x2e43
2E42 C9                         RET

; ============================================================
; FUN_ram_2e43
; вызовы из: 293F 2ABA 2E3F
2E43 3E 11       FUN_ram_2e43:  MVI A,0x11
2E45 32 E5 01                   STA (0x01e5)
2E48 3E 01                      MVI A,0x1
2E4A 32 E3 01                   STA (0x01e3)
2E4D 3E 20                      MVI A,0x20
2E4F 32 E2 01                   STA (0x01e2)
2E52 3E 0D                      MVI A,0xd
2E54 CD 13 3C                   CALL 0x3c13
2E57 C9                         RET

; ============================================================
; FUN_ram_2e58
; вызовы из: 20D1 293C 4E51 5301
2E58 3A 48 00    FUN_ram_2e58:  LDA (0x0048)
2E5B F6 80                      ORI 0x80
2E5D 32 48 00                   STA (0x0048)
2E60 4F                         MOV C,A
2E61 3A 4B 00                   LDA (0x004b)
2E64 B7                         ORA A
2E65 79                         MOV A,C
2E66 C2 6B 2E                   JNZ 0x2e6b
2E69 E6 F0                      ANI 0xf0
2E6B D3 FA       LAB_ram_2e6b:  OUT (0xfa)
2E6D C9                         RET

; ============================================================
; FUN_ram_2e6e
; вызовы из: 204B 28EC 2D8B 4E02 4E5B 4FA9 51EA 54D6
2E6E 3A 48 00    FUN_ram_2e6e:  LDA (0x0048)
2E71 E6 7F                      ANI 0x7f
2E73 32 48 00                   STA (0x0048)
2E76 4F                         MOV C,A
2E77 3A 4B 00                   LDA (0x004b)
2E7A B7                         ORA A
2E7B 79                         MOV A,C
2E7C C2 81 2E                   JNZ 0x2e81
2E7F E6 F0                      ANI 0xf0
2E81 D3 FA       LAB_ram_2e81:  OUT (0xfa)
2E83 C9                         RET

; ============================================================
; input_sex
; вызовы из: 232F
2E84 AF          input_sex:     XRA A
2E85 32 69 00                   STA (0x0069)
2E88 3A 4C 00                   LDA (0x004c)
2E8B 2F                         CMA
2E8C 32 4C 00                   STA (0x004c)
2E8F B7                         ORA A
2E90 3E 00                      MVI A,0x0
2E92 CA 97 2E                   JZ 0x2e97
2E95 3E 17                      MVI A,0x17
2E97 32 E5 01    LAB_ram_2e97:  STA (0x01e5)
2E9A 32 A3 00                   STA (0x00a3)
2E9D 3E 05                      MVI A,0x5
2E9F 32 E3 01                   STA (0x01e3)
2EA2 3E 25                      MVI A,0x25
2EA4 32 E2 01                   STA (0x01e2)
2EA7 3E 0D                      MVI A,0xd
2EA9 CD 13 3C                   CALL 0x3c13
2EAC C9                         RET
2EAD 77 77 65 …                 ds "wwedite datu$"  ; ВВЕДИТЕ ДАТУ
2EBA 77 77 65 …                 ds "wwedite kod pacienta$"  ; ВВЕДИТЕ КОД ПАЦИЕНТА
2ECF 66 69 6B …                 ds "fiksaciq$"  ; ФИКСАЦИЯ
2ED8 30 2D 6B …                 ds "0-kod pacienta$"  ; 0-КОД ПАЦИЕНТА
2EE7 31 2D 77 …                 ds "1-wwod daty$"  ; 1-ВВОД ДАТЫ
2EF3 32 2D 70 …                 ds "2-pol pacienta$"  ; 2-ПОЛ ПАЦИЕНТА
2F02 33 2D 73 …                 ds "3-stiranie$"  ; 3-СТИРАНИЕ
2F0D 34 2D 70 …                 ds "4-polovenie uzp$"  ; 4-ПОЛОЖЕНИЕ УЗП
2F1D 35 2D 72 …                 ds "5-revim biometrii$"  ; 5-РЕЖИМ БИОМЕТРИИ
2F2F 66 6F 6B …                 ds "fokus-perimetr/plo}adx$"  ; ФОКУС-ПЕРИМЕТР/ПЛОЩАДЬ
2F46 77 79 62 …                 ds "wybor piktogrammy: +$"  ; ВЫБОР ПИКТОГРАММЫ: +
2F5B 70 6F 6C …                 ds "polovenie uzp$"  ; ПОЛОЖЕНИЕ УЗП
2F69 20                         ?? 20h     
2F6A 20                         ?? 20h     
2F6B 20                         ?? 20h     
2F6C 20                         ?? 20h     
2F6D 20                         ?? 20h     
2F6E 77                         ?? 77h    w
2F6F 72                         ?? 72h    r
2F70 61                         ?? 61h    a
2F71 7D                         ?? 7Dh    }
2F72 2E                         ?? 2Eh    .
2F73 77                         ?? 77h    w
2F74 6C                         ?? 6Ch    l
2F75 65                         ?? 65h    e
2F76 77                         ?? 77h    w
2F77 6F                         ?? 6Fh    o
2F78 3A                         ?? 3Ah    :
2F79 20                         ?? 20h     
2F7A 20                         ?? 20h     
2F7B 87                         ?? 87h
2F7C 24                         ?? 24h    $
2F7D 20                         ?? 20h     
2F7E 20                         ?? 20h     
2F7F 20                         ?? 20h     
2F80 20                         ?? 20h     
2F81 20                         ?? 20h     
2F82 77                         ?? 77h    w
2F83 72                         ?? 72h    r
2F84 61                         ?? 61h    a
2F85 7D                         ?? 7Dh    }
2F86 2E                         ?? 2Eh    .
2F87 77                         ?? 77h    w
2F88 70                         ?? 70h    p
2F89 72                         ?? 72h    r
2F8A 61                         ?? 61h    a
2F8B 77                         ?? 77h    w
2F8C 6F                         ?? 6Fh    o
2F8D 3A                         ?? 3Ah    :
2F8E 20                         ?? 20h     
2F8F 81                         ?? 81h
2F90 24                         ?? 24h    $
2F91 73 64 77 …                 ds "sdwig po osqm X,Y$"  ; СДВИГ ПО ОСЯМ X,Y
2FA3 20                         ?? 20h     
2FA4 20                         ?? 20h     
2FA5 20                         ?? 20h     
2FA6 20                         ?? 20h     
2FA7 20                         ?? 20h     
2FA8 77                         ?? 77h    w
2FA9 70                         ?? 70h    p
2FAA 72                         ?? 72h    r
2FAB 61                         ?? 61h    a
2FAC 77                         ?? 77h    w
2FAD 6F                         ?? 6Fh    o
2FAE 3A                         ?? 3Ah    :
2FAF 20                         ?? 20h     
2FB0 82                         ?? 82h
2FB1 24                         ?? 24h    $
2FB2 20                         ?? 20h     
2FB3 20                         ?? 20h     
2FB4 20                         ?? 20h     
2FB5 20                         ?? 20h     
2FB6 20                         ?? 20h     
2FB7 77                         ?? 77h    w
2FB8 6C                         ?? 6Ch    l
2FB9 65                         ?? 65h    e
2FBA 77                         ?? 77h    w
2FBB 6F                         ?? 6Fh    o
2FBC 3A                         ?? 3Ah    :
2FBD 20                         ?? 20h     
2FBE 20                         ?? 20h     
2FBF 86                         ?? 86h
2FC0 24                         ?? 24h    $
2FC1 20                         ?? 20h     
2FC2 20                         ?? 20h     
2FC3 20                         ?? 20h     
2FC4 20                         ?? 20h     
2FC5 20                         ?? 20h     
2FC6 77                         ?? 77h    w
2FC7 77                         ?? 77h    w
2FC8 65                         ?? 65h    e
2FC9 72                         ?? 72h    r
2FCA 68                         ?? 68h    h
2FCB 3A                         ?? 3Ah    :
2FCC 20                         ?? 20h     
2FCD 20                         ?? 20h     
2FCE 80                         ?? 80h
2FCF 24                         ?? 24h    $
2FD0 20                         ?? 20h     
2FD1 20                         ?? 20h     
2FD2 20                         ?? 20h     
2FD3 20                         ?? 20h     
2FD4 20                         ?? 20h     
2FD5 77                         ?? 77h    w
2FD6 6E                         ?? 6Eh    n
2FD7 69                         ?? 69h    i
2FD8 7A                         ?? 7Ah    z
2FD9 3A                         ?? 3Ah    :
2FDA 20                         ?? 20h     
2FDB 20                         ?? 20h     
2FDC 20                         ?? 20h     
2FDD 84                         ?? 84h
2FDE 24                         ?? 24h    $
2FDF 77 79 62 …                 ds "wybor sdelan: n/p$"  ; ВЫБОР СДЕЛАН: Н/П
2FF1 4D 45 44 …                 ds "MEDELKOM$"  ; MEDELKOM
2FFA 53 4C 45 …                 ds "SLE-101$"  ; SLE-101
3002 46 52 20 …                 ds "FR 3.5MH$"  ; FR 3.5MH
300B 2A                         ?? 2Ah    *
300C 2A                         ?? 2Ah    *
300D 2F                         ?? 2Fh    /
300E 2A                         ?? 2Ah    *
300F 2A                         ?? 2Ah    *
3010 2F                         ?? 2Fh    /
3011 2A                         ?? 2Ah    *
3012 2A                         ?? 2Ah    *
3013 24                         ?? 24h    $
3014 00                         ?? 00h
3015 20                         ?? 20h     
3016 2A                         ?? 2Ah    *
3017 2A                         ?? 2Ah    *
3018 2A                         ?? 2Ah    *
3019 2A                         ?? 2Ah    *
301A 2A                         ?? 2Ah    *
301B 24                         ?? 24h    $
301C 4C                         ?? 4Ch    L
301D 2B                         ?? 2Bh    +
301E 20                         ?? 20h     
301F 2A                         ?? 2Ah    *
3020 2A                         ?? 2Ah    *
3021 2E                         ?? 2Eh    .
3022 2A                         ?? 2Ah    *
3023 18                         ?? 18h
3024 02                         ?? 02h
3025 24                         ?? 24h    $
3026 4C                         ?? 4Ch    L
3027 10                         ?? 10h
3028 20                         ?? 20h     
3029 2A                         ?? 2Ah    *
302A 2A                         ?? 2Ah    *
302B 2E                         ?? 2Eh    .
302C 2A                         ?? 2Ah    *
302D 18                         ?? 18h
302E 02                         ?? 02h
302F 24                         ?? 24h    $
3030 50                         ?? 50h    P
3031 20                         ?? 20h     
3032 2A                         ?? 2Ah    *
3033 2A                         ?? 2Ah    *
3034 2E                         ?? 2Eh    .
3035 2A                         ?? 2Ah    *
3036 18                         ?? 18h
3037 02                         ?? 02h
3038 20                         ?? 20h     
3039 24                         ?? 24h    $
303A 53                         ?? 53h    S
303B 20                         ?? 20h     
303C 2A                         ?? 2Ah    *
303D 2A                         ?? 2Ah    *
303E 2E                         ?? 2Eh    .
303F 2A                         ?? 2Ah    *
3040 18                         ?? 18h
3041 02                         ?? 02h
3042 1E                         ?? 1Eh
3043 24                         ?? 24h    $
3044 FF                         ?? FFh

; ============================================================
; fmt_value
; вызовы из: 20AC 264B 265B 2BEF 2C3B 2C59 51E6 5284 5295 55FF
3045 32 05 01    fmt_value:     STA (0x0105)
3048 C5                         PUSH BC
3049 D5                         PUSH DE
304A E5                         PUSH HL
304B F5                         PUSH AF
304C 01 06 01                   LXI BC,0x106
304F C5                         PUSH BC
3050 01 00 00                   LXI BC,0x0
3053 CD EA 71                   CALL 0x71ea
3056 21 20 20                   LXI HL,0x2020
3059 22 51 01                   SHLD (0x0151)
305C 3E 20                      MVI A,0x20
305E 32 50 01                   STA (0x0150)
3061 21 53 01                   LXI HL,0x153
3064 22 1C 01                   SHLD (0x011c)
3067 3E 03                      MVI A,0x3
3069 32 1B 01                   STA (0x011b)
306C 2A ED 00                   LHLD (0x00ed)
306F 22 1E 01                   SHLD (0x011e)
3072 3A 05 01                   LDA (0x0105)
3075 E6 7F                      ANI 0x7f
3077 5F                         MOV E,A
3078 16 00                      MVI D,0x0
307A 21 89 30                   LXI HL,0x3089
307D 19                         DAD HL,DE
307E 19                         DAD HL,DE
307F 5E                         MOV E,(HL)
3080 23                         INX HL
3081 56                         MOV D,(HL)
3082 EB                         XCHG
3083 E9          switchD:       PCHL

; ============================================================
; caseD_1
; вызовы из: 3083 30D2 3126 3132 3191 31DB 31E8 31FC 3202 3583 35CB 3604 3623 36AE 36C2 3745 3790 3959 395F 39DB
3084 F1          caseD_1:       POP AF
3085 E1                         POP HL
3086 D1                         POP DE
3087 C1                         POP BC
3088 C9                         RET
3089 9F 30       tbl_fmt:       addr ram:309f
308B 84 30                      addr ram:3084
308D D5 30                      addr ram:30d5
308F 00 00                      addr ram:0000
3091 00 00                      addr ram:0000
3093 35 31                      addr ram:3135
3095 94 31                      addr ram:3194
3097 08 34                      addr ram:3408
3099 A1 36                      addr ram:36a1
309B 56 39                      addr ram:3956
309D 62 39                      addr ram:3962

; ============================================================
; caseD_0
; вызовы из: 3083
309F 21 FC 00    caseD_0:       LXI HL,0xfc
30A2 06 09                      MVI B,0x9
30A4 CD 55 32                   CALL 0x3255
30A7 21 95 01                   LXI HL,0x195
30AA 06 47                      MVI B,0x47
30AC CD 55 32                   CALL 0x3255
30AF CD 05 32                   CALL 0x3205
30B2 CD 14 32                   CALL 0x3214
30B5 2A ED 00                   LHLD (0x00ed)
30B8 2A ED 00                   LHLD (0x00ed)
30BB 11 14 00                   LXI DE,0x14
30BE 19                         DAD HL,DE
30BF 22 1E 01                   SHLD (0x011e)
30C2 CD 23 32                   CALL 0x3223
30C5 2A ED 00                   LHLD (0x00ed)
30C8 11 1E 00                   LXI DE,0x1e
30CB 19                         DAD HL,DE
30CC 22 1E 01                   SHLD (0x011e)
30CF CD 3C 32                   CALL 0x323c
30D2 C3 84 30                   JMP 0x3084

; ============================================================
; caseD_2
; вызовы из: 3083
30D5 01 D3 00    caseD_2:       LXI BC,0xd3
30D8 11 D5 00                   LXI DE,0xd5
30DB CD 5D 32                   CALL 0x325d
30DE B7                         ORA A
30DF C2 29 31                   JNZ 0x3129
30E2 CD DD 32                   CALL 0x32dd
30E5 11 69 01                   LXI DE,0x169
30E8 CD 1E 73                   CALL 0x731e
30EB 3E 03                      MVI A,0x3
30ED 32 1B 01                   STA (0x011b)
30F0 11 18 01                   LXI DE,0x118
30F3 CD 6E 64                   CALL 0x646e
30F6 2A 1E 01                   LHLD (0x011e)
30F9 11 03 00                   LXI DE,0x3
30FC 19                         DAD HL,DE
30FD CD 35 33                   CALL 0x3335
3100 01 D7 00    LAB_ram_3100:  LXI BC,0xd7
3103 11 D9 00                   LXI DE,0xd9
3106 CD 5D 32                   CALL 0x325d
3109 B7                         ORA A
310A C2 2F 31                   JNZ 0x312f
310D CD DD 32                   CALL 0x32dd
3110 11 6D 01                   LXI DE,0x16d
3113 CD 1E 73                   CALL 0x731e
3116 11 18 01                   LXI DE,0x118
3119 CD 6E 64                   CALL 0x646e
311C 2A 1E 01                   LHLD (0x011e)
311F 11 0D 00                   LXI DE,0xd
3122 19                         DAD HL,DE
3123 CD 35 33                   CALL 0x3335
3126 C3 84 30                   JMP 0x3084
3129 CD 05 32    LAB_ram_3129:  CALL 0x3205
312C C3 00 31                   JMP 0x3100
312F CD 14 32    LAB_ram_312f:  CALL 0x3214
3132 C3 84 30                   JMP 0x3084

; ============================================================
; fmt_5
3135 06 08       fmt_5:         MVI B,0x8
3137 21 20 01                   LXI HL,0x120
313A CD 55 32                   CALL 0x3255
313D 2A E3 00                   LHLD (0x00e3)
3140 22 20 01                   SHLD (0x0120)
3143 2A E5 00                   LHLD (0x00e5)
3146 22 24 01                   SHLD (0x0124)
3149 01 06 01                   LXI BC,0x106
314C 11 24 01                   LXI DE,0x124
314F CD AF 6F                   CALL 0x6faf
3152 11 DF 3B                   LXI DE,0x3bdf
3155 CD 3B 70                   CALL 0x703b
3158 11 24 01                   LXI DE,0x124
315B CD 1E 73                   CALL 0x731e
315E 11 20 01                   LXI DE,0x120
3161 CD AF 6F                   CALL 0x6faf
3164 11 24 01                   LXI DE,0x124
3167 CD 48 62                   CALL 0x6248
316A CD 26 33                   CALL 0x3326
316D CD 3B 70                   CALL 0x703b
3170 11 D7 3B                   LXI DE,0x3bd7
3173 CD 3D 6D                   CALL 0x6d3d
3176 11 89 01                   LXI DE,0x189
3179 CD 1E 73                   CALL 0x731e
317C 3E 03                      MVI A,0x3
317E 32 1B 01                   STA (0x011b)
3181 11 18 01                   LXI DE,0x118
3184 CD 6E 64                   CALL 0x646e
3187 2A 1E 01                   LHLD (0x011e)
318A 11 02 00                   LXI DE,0x2
318D 19                         DAD HL,DE
318E CD 35 33                   CALL 0x3335
3191 C3 84 30                   JMP 0x3084

; ============================================================
; fmt_6
3194 01 06 01    fmt_6:         LXI BC,0x106
3197 11 E3 00                   LXI DE,0xe3
319A CD AF 6F                   CALL 0x6faf
319D CD 26 33                   CALL 0x3326
31A0 CD 3B 70                   CALL 0x703b
31A3 CD 3B 70                   CALL 0x703b
31A6 11 D7 3B                   LXI DE,0x3bd7
31A9 CD 3D 6D                   CALL 0x6d3d
31AC CD 3D 6D                   CALL 0x6d3d
31AF 11 8D 01                   LXI DE,0x18d
31B2 CD 1E 73                   CALL 0x731e
31B5 3E 03                      MVI A,0x3
31B7 32 1B 01                   STA (0x011b)
31BA 11 18 01                   LXI DE,0x118
31BD CD 6E 64                   CALL 0x646e
31C0 2A 1E 01                   LHLD (0x011e)
31C3 11 02 00                   LXI DE,0x2
31C6 19                         DAD HL,DE
31C7 3A 19 01                   LDA (0x0119)
31CA B7                         ORA A
31CB C2 EB 31                   JNZ 0x31eb
31CE 01 06 01                   LXI BC,0x106
31D1 CD 42 73                   CALL 0x7342
31D4 07                         RLC
31D5 D2 DE 31                   JNC 0x31de
31D8 CD 42 33                   CALL 0x3342
31DB C3 84 30                   JMP 0x3084
31DE 11 52 01    LAB_ram_31de:  LXI DE,0x152
31E1 06 04                      MVI B,0x4
31E3 0E 00                      MVI C,0x0
31E5 CD BB 33                   CALL 0x33bb
31E8 C3 84 30                   JMP 0x3084
31EB C6 03       LAB_ram_31eb:  ADI 0x3
31ED DA FF 31                   JC 0x31ff
31F0 3E 30                      MVI A,0x30
31F2 32 53 01                   STA (0x0153)
31F5 06 03                      MVI B,0x3
31F7 0E 02                      MVI C,0x2
31F9 CD 61 33                   CALL 0x3361
31FC C3 84 30                   JMP 0x3084
31FF CD 35 33    LAB_ram_31ff:  CALL 0x3335
3202 C3 84 30                   JMP 0x3084

; ============================================================
; FUN_ram_3205
; вызовы из: 30AF 3129
3205 06 03       FUN_ram_3205:  MVI B,0x3
3207 0E 02                      MVI C,0x2
3209 2A 1E 01                   LHLD (0x011e)
320C 11 03 00                   LXI DE,0x3
320F 19                         DAD HL,DE
3210 CD B8 33                   CALL 0x33b8
3213 C9                         RET

; ============================================================
; FUN_ram_3214
; вызовы из: 30B2 312F
3214 06 03       FUN_ram_3214:  MVI B,0x3
3216 0E 02                      MVI C,0x2
3218 2A 1E 01                   LHLD (0x011e)
321B 11 0D 00                   LXI DE,0xd
321E 19                         DAD HL,DE
321F CD B8 33                   CALL 0x33b8
3222 C9                         RET

; ============================================================
; FUN_ram_3223
; вызовы из: 30C2
3223 06 03       FUN_ram_3223:  MVI B,0x3
3225 0E 02                      MVI C,0x2
3227 2A 1E 01                   LHLD (0x011e)
322A 11 02 00                   LXI DE,0x2
322D 19                         DAD HL,DE
322E CD B8 33                   CALL 0x33b8
3231 2A 1E 01                   LHLD (0x011e)
3234 11 19 00                   LXI DE,0x19
3237 19                         DAD HL,DE
3238 CD B8 33                   CALL 0x33b8
323B C9                         RET

; ============================================================
; FUN_ram_323c
; вызовы из: 30CF
323C 06 03       FUN_ram_323c:  MVI B,0x3
323E 0E 02                      MVI C,0x2
3240 2A 1E 01                   LHLD (0x011e)
3243 11 02 00                   LXI DE,0x2
3246 19                         DAD HL,DE
3247 CD B8 33                   CALL 0x33b8
324A 2A 1E 01                   LHLD (0x011e)
324D 11 19 00                   LXI DE,0x19
3250 19                         DAD HL,DE
3251 CD B8 33                   CALL 0x33b8
3254 C9                         RET

; ============================================================
; FUN_ram_3255
; вызовы из: 30A4 30AC 313A 327C 3414 357C 3967
3255 AF          FUN_ram_3255:  XRA A
3256 77          LAB_ram_3256:  MOV (HL),A
3257 23                         INX HL
3258 05                         DCR B
3259 C2 56 32                   JNZ 0x3256
325C C9                         RET

; ============================================================
; FUN_ram_325d
; вызовы из: 30DB 3106 39FC 3A2D
325D 2E FF       FUN_ram_325d:  MVI L,0xff
325F 0A                         LDAX (BC)
3260 BD                         CMP L
3261 C2 69 32                   JNZ 0x3269
3264 03                         INX BC
3265 0A                         LDAX (BC)
3266 0B                         DCX BC
3267 BD                         CMP L
3268 C8                         RZ
3269 1A          LAB_ram_3269:  LDAX (DE)
326A BD                         CMP L
326B C2 73 32                   JNZ 0x3273
326E 13                         INX DE
326F 1A                         LDAX (DE)
3270 1B                         DCX DE
3271 BD                         CMP L
3272 C8                         RZ
3273 AF          LAB_ram_3273:  XRA A
3274 C9                         RET

; ============================================================
; FUN_ram_3275
; вызовы из: 32BB 32DD
3275 C5          FUN_ram_3275:  PUSH BC
3276 D5                         PUSH DE
3277 06 10                      MVI B,0x10
3279 21 20 01                   LXI HL,0x120
327C CD 55 32                   CALL 0x3255
327F D1                         POP DE
3280 C1                         POP BC
3281 0A                         LDAX (BC)
3282 32 20 01                   STA (0x0120)
3285 03                         INX BC
3286 0A                         LDAX (BC)
3287 32 28 01                   STA (0x0128)
328A 1A                         LDAX (DE)
328B 32 24 01                   STA (0x0124)
328E 13                         INX DE
328F 1A                         LDAX (DE)
3290 32 2C 01                   STA (0x012c)
3293 01 06 01                   LXI BC,0x106
3296 11 20 01                   LXI DE,0x120
3299 CD AF 6F                   CALL 0x6faf
329C CD 1E 73                   CALL 0x731e
329F 11 24 01                   LXI DE,0x124
32A2 CD AF 6F                   CALL 0x6faf
32A5 CD 1E 73                   CALL 0x731e
32A8 11 28 01                   LXI DE,0x128
32AB CD AF 6F                   CALL 0x6faf
32AE CD 1E 73                   CALL 0x731e
32B1 11 2C 01                   LXI DE,0x12c
32B4 CD AF 6F                   CALL 0x6faf
32B7 CD 1E 73                   CALL 0x731e
32BA C9                         RET

; ============================================================
; FUN_ram_32bb
32BB CD 75 32    FUN_ram_32bb:  CALL 0x3275
32BE 01 06 01                   LXI BC,0x106
32C1 11 2C 01                   LXI DE,0x12c
32C4 CD 54 6F                   CALL 0x6f54
32C7 11 28 01                   LXI DE,0x128
32CA CD 4E 62                   CALL 0x624e
32CD CD 26 33                   CALL 0x3326
32D0 CD 3B 70                   CALL 0x703b
32D3 11 D7 3B                   LXI DE,0x3bd7
32D6 CD 3D 6D                   CALL 0x6d3d
32D9 CD 21 62                   CALL 0x6221
32DC C9                         RET

; ============================================================
; FUN_ram_32dd
; вызовы из: 30E2 310D 3A03 3A34
32DD CD 75 32    FUN_ram_32dd:  CALL 0x3275
32E0 11 28 01                   LXI DE,0x128
32E3 CD 4E 62                   CALL 0x624e
32E6 11 34 01                   LXI DE,0x134
32E9 CD 1E 73                   CALL 0x731e
32EC CD 3B 70                   CALL 0x703b
32EF CD 1E 73                   CALL 0x731e
32F2 11 24 01                   LXI DE,0x124
32F5 CD 54 6F                   CALL 0x6f54
32F8 11 20 01                   LXI DE,0x120
32FB CD 4E 62                   CALL 0x624e
32FE 11 38 01                   LXI DE,0x138
3301 CD 1E 73                   CALL 0x731e
3304 CD 3B 70                   CALL 0x703b
3307 11 34 01                   LXI DE,0x134
330A CD 48 62                   CALL 0x6248
330D CD 24 72                   CALL 0x7224
3310 CD 1E 73                   CALL 0x731e
3313 CD 26 33                   CALL 0x3326
3316 CD 54 6F                   CALL 0x6f54
3319 11 D7 3B                   LXI DE,0x3bd7
331C CD 3D 6D                   CALL 0x6d3d
331F 11 34 01                   LXI DE,0x134
3322 CD 3B 70                   CALL 0x703b
3325 C9                         RET

; ============================================================
; FUN_ram_3326
; вызовы из: 316A 319D 32CD 3313 3997
3326 21 CB 3B    FUN_ram_3326:  LXI HL,0x3bcb
3329 3A F1 00                   LDA (0x00f1)
332C B7                         ORA A
332D CA 33 33                   JZ 0x3333
3330 21 CF 3B                   LXI HL,0x3bcf
3333 EB          LAB_ram_3333:  XCHG
3334 C9                         RET

; ============================================================
; FUN_ram_3335
; вызовы из: 30FD 3123 318E 31FF
3335 11 DB 3B    FUN_ram_3335:  LXI DE,0x3bdb
3338 01 06 01                   LXI BC,0x106
333B CD 42 73                   CALL 0x7342
333E 07                         RLC
333F D2 45 33                   JNC 0x3345

; ============================================================
; FUN_ram_3342
; вызовы из: 31D8
3342 11 52 01    FUN_ram_3342:  LXI DE,0x152
3345 06 03       LAB_ram_3345:  MVI B,0x3
3347 0E 02                      MVI C,0x2
3349 3A 19 01                   LDA (0x0119)
334C FE FF                      CPI 0xff
334E C2 54 33                   JNZ 0x3354
3351 11 53 01                   LXI DE,0x153
3354 FE FE       LAB_ram_3354:  CPI 0xfe
3356 C2 5C 33                   JNZ 0x335c
3359 11 52 01                   LXI DE,0x152
335C FE FD       LAB_ram_335c:  CPI 0xfd
335E C2 BB 33                   JNZ 0x33bb

; ============================================================
; FUN_ram_3361
; вызовы из: 31F9
3361 11 51 01    FUN_ram_3361:  LXI DE,0x151
3364 3E 30                      MVI A,0x30
3366 32 52 01                   STA (0x0152)
3369 C3 BB 33                   JMP 0x33bb

; ============================================================
; FUN_ram_336c
336C 11 DB 3B    FUN_ram_336c:  LXI DE,0x3bdb
336F 01 06 01                   LXI BC,0x106
3372 CD 42 73                   CALL 0x7342
3375 07                         RLC
3376 D2 7C 33                   JNC 0x337c
3379 11 52 01                   LXI DE,0x152
337C 06 04       LAB_ram_337c:  MVI B,0x4
337E 0E 02                      MVI C,0x2
3380 3A 19 01                   LDA (0x0119)
3383 FE FF                      CPI 0xff
3385 CA BB 33                   JZ 0x33bb
3388 FE FE                      CPI 0xfe
338A C2 90 33                   JNZ 0x3390
338D 11 53 01                   LXI DE,0x153
3390 FE FD       LAB_ram_3390:  CPI 0xfd
3392 C2 98 33                   JNZ 0x3398
3395 11 52 01                   LXI DE,0x152
3398 FE FC       LAB_ram_3398:  CPI 0xfc
339A C2 A5 33                   JNZ 0x33a5
339D 11 51 01                   LXI DE,0x151
33A0 3E 30                      MVI A,0x30
33A2 32 52 01                   STA (0x0152)
33A5 FE FB       LAB_ram_33a5:  CPI 0xfb
33A7 C2 BB 33                   JNZ 0x33bb
33AA 3E 30                      MVI A,0x30
33AC 32 52 01                   STA (0x0152)
33AF 32 51 01                   STA (0x0151)
33B2 11 50 01                   LXI DE,0x150
33B5 C3 BB 33                   JMP 0x33bb

; ============================================================
; FUN_ram_33b8
; вызовы из: 3210 321F 322E 3238 3247 3251
33B8 11 DB 3B    FUN_ram_33b8:  LXI DE,0x3bdb

; ============================================================
; FUN_ram_33bb
; вызовы из: 31E5 335E 3369 3385 33A7 33B5 367B 3688 3698 369E
33BB C5          FUN_ram_33bb:  PUSH BC
33BC D5                         PUSH DE
33BD E5                         PUSH HL
33BE 1A          LAB_ram_33be:  LDAX (DE)
33BF 77                         MOV (HL),A
33C0 13                         INX DE
33C1 23                         INX HL
33C2 0D                         DCR C
33C3 C2 C9 33                   JNZ 0x33c9
33C6 36 2E                      MVI (HL),0x2e
33C8 23                         INX HL
33C9 05          LAB_ram_33c9:  DCR B
33CA C2 BE 33                   JNZ 0x33be
33CD 21 20 20                   LXI HL,0x2020
33D0 22 51 01                   SHLD (0x0151)
33D3 E1                         POP HL
33D4 D1                         POP DE
33D5 C1                         POP BC
33D6 C9                         RET

; ============================================================
; FUN_ram_33d7
33D7 C5          FUN_ram_33d7:  PUSH BC
33D8 E5                         PUSH HL
33D9 1E 03                      MVI E,0x3
33DB 0A          LAB_ram_33db:  LDAX (BC)
33DC D6 30                      SUI 0x30
33DE 77                         MOV (HL),A
33DF 23                         INX HL
33E0 03                         INX BC
33E1 1D                         DCR E
33E2 C2 DB 33                   JNZ 0x33db
33E5 E1                         POP HL
33E6 C1                         POP BC
33E7 C9                         RET

; ============================================================
; FUN_ram_33e8
33E8 7A          FUN_ram_33e8:  MOV A,D
33E9 17                         RAL
33EA 7B          LAB_ram_33ea:  MOV A,E
33EB 17                         RAL
33EC 5F                         MOV E,A
33ED 7A                         MOV A,D
33EE 17                         RAL
33EF 57                         MOV D,A
33F0 2D                         DCR L
33F1 C2 EA 33                   JNZ 0x33ea
33F4 7B                         MOV A,E
33F5 DA FC 33                   JC 0x33fc
33F8 E6 FE                      ANI 0xfe
33FA 5F                         MOV E,A
33FB C9                         RET
33FC F6 01       LAB_ram_33fc:  ORI 0x1
33FE 5F                         MOV E,A
33FF C9                         RET
3400 7C                         ?? 7Ch    |
3401 2F                         ?? 2Fh    /
3402 67                         ?? 67h    g
3403 7D                         ?? 7Dh    }
3404 2F                         ?? 2Fh    /
3405 6F                         ?? 6Fh    o
3406 23                         ?? 23h    #
3407 C9                         ?? C9h

; ============================================================
; fmt_7
3408 3A D3 00    fmt_7:         LDA (0x00d3)
340B B7                         ORA A
340C CA 04 35                   JZ 0x3504
340F 06 18                      MVI B,0x18
3411 21 71 01                   LXI HL,0x171
3414 CD 55 32                   CALL 0x3255
3417 3A D3 00                   LDA (0x00d3)
341A 32 71 01                   STA (0x0171)
341D 3A D4 00                   LDA (0x00d4)
3420 3C                         INR A
3421 2A D5 00                   LHLD (0x00d5)
3424 FE 03                      CPI 0x3
3426 CA 2E 34                   JZ 0x342e
3429 FE 02                      CPI 0x2
342B C2 31 34                   JNZ 0x3431
342E C6 0C       LAB_ram_342e:  ADI 0xc
3430 2B                         DCX HL
3431 32 75 01    LAB_ram_3431:  STA (0x0175)
3434 22 79 01                   SHLD (0x0179)
3437 3A D7 00                   LDA (0x00d7)
343A 32 7D 01                   STA (0x017d)
343D 3A D8 00                   LDA (0x00d8)
3440 3C                         INR A
3441 2A D9 00                   LHLD (0x00d9)
3444 FE 03                      CPI 0x3
3446 CA 4E 34                   JZ 0x344e
3449 FE 02                      CPI 0x2
344B C2 51 34                   JNZ 0x3451
344E C6 0C       LAB_ram_344e:  ADI 0xc
3450 2B                         DCX HL
3451 32 81 01    LAB_ram_3451:  STA (0x0181)
3454 22 85 01                   SHLD (0x0185)
3457 01 06 01                   LXI BC,0x106
345A 11 71 01                   LXI DE,0x171
345D CD 36 36                   CALL 0x3636
3460 11 75 01                   LXI DE,0x175
3463 CD 36 36                   CALL 0x3636
3466 11 79 01                   LXI DE,0x179
3469 CD 36 36                   CALL 0x3636
346C 11 7D 01                   LXI DE,0x17d
346F CD 36 36                   CALL 0x3636
3472 11 81 01                   LXI DE,0x181
3475 CD 36 36                   CALL 0x3636
3478 11 85 01                   LXI DE,0x185
347B CD 36 36                   CALL 0x3636
347E 11 E3 3B                   LXI DE,0x3be3
3481 CD 3B 70                   CALL 0x703b
3484 11 85 01                   LXI DE,0x185
3487 CD 1E 73                   CALL 0x731e
348A 11 81 01                   LXI DE,0x181
348D CD 54 6F                   CALL 0x6f54
3490 11 E7 3B                   LXI DE,0x3be7
3493 CD 3B 70                   CALL 0x703b
3496 11 85 01                   LXI DE,0x185
3499 CD 48 62                   CALL 0x6248
349C 11 7D 01                   LXI DE,0x17d
349F CD 48 62                   CALL 0x6248
34A2 CD 1E 73                   CALL 0x731e
34A5 11 79 01                   LXI DE,0x179
34A8 CD 54 6F                   CALL 0x6f54
34AB 11 E3 3B                   LXI DE,0x3be3
34AE CD 3B 70                   CALL 0x703b
34B1 11 79 01                   LXI DE,0x179
34B4 CD 1E 73                   CALL 0x731e
34B7 11 75 01                   LXI DE,0x175
34BA CD 54 6F                   CALL 0x6f54
34BD 11 E7 3B                   LXI DE,0x3be7
34C0 CD 3B 70                   CALL 0x703b
34C3 11 79 01                   LXI DE,0x179
34C6 CD 48 62                   CALL 0x6248
34C9 11 71 01                   LXI DE,0x171
34CC CD 48 62                   CALL 0x6248
34CF CD 1E 73                   CALL 0x731e
34D2 11 7D 01                   LXI DE,0x17d
34D5 CD 54 6F                   CALL 0x6f54
34D8 11 71 01                   LXI DE,0x171
34DB CD 4E 62                   CALL 0x624e
34DE 11 D5 01                   LXI DE,0x1d5
34E1 CD 1E 73                   CALL 0x731e
34E4 11 7D 01                   LXI DE,0x17d
34E7 CD 9F 6E                   CALL 0x6e9f
34EA 2A 7D 01                   LHLD (0x017d)
34ED 1E 07                      MVI E,0x7
34EF CD 3D 36                   CALL 0x363d
34F2 2A ED 00                   LHLD (0x00ed)
34F5 11 03 00                   LXI DE,0x3
34F8 19                         DAD HL,DE
34F9 79                         MOV A,C
34FA F6 30                      ORI 0x30
34FC 77                         MOV (HL),A
34FD 2A ED 00                   LHLD (0x00ed)
3500 78                         MOV A,B
3501 CD 32 56                   CALL 0x5632
3504 AF          LAB_ram_3504:  XRA A
3505 32 DB 01                   STA (0x01db)
3508 01 06 01                   LXI BC,0x106
350B 11 99 01                   LXI DE,0x199
350E CD 26 36                   CALL 0x3626
3511 11 D5 01                   LXI DE,0x1d5
3514 CD 26 36                   CALL 0x3626
3517 11 A1 01                   LXI DE,0x1a1
351A CD 26 36                   CALL 0x3626
351D 11 A9 01                   LXI DE,0x1a9
3520 CD 26 36                   CALL 0x3626
3523 11 B1 01                   LXI DE,0x1b1
3526 CD 26 36                   CALL 0x3626
3529 11 B9 01                   LXI DE,0x1b9
352C CD 26 36                   CALL 0x3626
352F 11 C1 01                   LXI DE,0x1c1
3532 CD 26 36                   CALL 0x3626
3535 11 C9 01                   LXI DE,0x1c9
3538 CD 26 36                   CALL 0x3626
353B 11 D1 01                   LXI DE,0x1d1
353E CD 26 36                   CALL 0x3626
3541 11 D5 01                   LXI DE,0x1d5
3544 CD 48 62                   CALL 0x6248
3547 11 99 01                   LXI DE,0x199
354A CD 48 62                   CALL 0x6248
354D 11 A1 01                   LXI DE,0x1a1
3550 CD 48 62                   CALL 0x6248
3553 11 A9 01                   LXI DE,0x1a9
3556 CD 48 62                   CALL 0x6248
3559 11 B1 01                   LXI DE,0x1b1
355C CD 48 62                   CALL 0x6248
355F 11 B9 01                   LXI DE,0x1b9
3562 CD 48 62                   CALL 0x6248
3565 11 C1 01                   LXI DE,0x1c1
3568 CD 48 62                   CALL 0x6248
356B 11 C9 01                   LXI DE,0x1c9
356E CD 48 62                   CALL 0x6248
3571 11 7D 01                   LXI DE,0x17d
3574 CD 1E 73                   CALL 0x731e
3577 06 04                      MVI B,0x4
3579 21 71 01                   LXI HL,0x171
357C CD 55 32                   CALL 0x3255
357F 3A DB 01                   LDA (0x01db)
3582 B7                         ORA A
3583 CA 84 30                   JZ 0x3084
3586 32 71 01                   STA (0x0171)
3589 01 06 01                   LXI BC,0x106
358C 11 71 01                   LXI DE,0x171
358F CD 36 36                   CALL 0x3636
3592 11 7D 01                   LXI DE,0x17d
3595 CD 54 6F                   CALL 0x6f54
3598 11 71 01                   LXI DE,0x171
359B CD 3D 6D                   CALL 0x6d3d
359E 11 7D 01                   LXI DE,0x17d
35A1 CD 9F 6E                   CALL 0x6e9f
35A4 2A 7D 01                   LHLD (0x017d)
35A7 1E 07                      MVI E,0x7
35A9 CD 3D 36                   CALL 0x363d
35AC 2A ED 00                   LHLD (0x00ed)
35AF 11 07 01                   LXI DE,0x107
35B2 19                         DAD HL,DE
35B3 79                         MOV A,C
35B4 F6 30                      ORI 0x30
35B6 77                         MOV (HL),A
35B7 2B                         DCX HL
35B8 2B                         DCX HL
35B9 2B                         DCX HL
35BA 78                         MOV A,B
35BB CD 32 56                   CALL 0x5632
35BE 01 06 01                   LXI BC,0x106
35C1 11 CD 01                   LXI DE,0x1cd
35C4 CD 54 6F                   CALL 0x6f54
35C7 CD 42 73                   CALL 0x7342
35CA B7                         ORA A
35CB FA 84 30                   JM 0x3084
35CE 11 AD 01                   LXI DE,0x1ad
35D1 CD 54 6F                   CALL 0x6f54
35D4 CD 42 73                   CALL 0x7342
35D7 B7                         ORA A
35D8 FA F7 35                   JM 0x35f7
35DB 11 CD 01                   LXI DE,0x1cd
35DE CD 3D 6D                   CALL 0x6d3d
35E1 2A ED 00                   LHLD (0x00ed)
35E4 11 11 01                   LXI DE,0x111
35E7 19                         DAD HL,DE
35E8 22 1E 01                   SHLD (0x011e)
35EB 11 18 01                   LXI DE,0x118
35EE CD 6E 64                   CALL 0x646e
35F1 2A 1E 01                   LHLD (0x011e)
35F4 CD 5F 36                   CALL 0x365f
35F7 01 06 01    LAB_ram_35f7:  LXI BC,0x106
35FA 11 B5 01                   LXI DE,0x1b5
35FD CD 54 6F                   CALL 0x6f54
3600 CD 42 73                   CALL 0x7342
3603 B7                         ORA A
3604 FA 84 30                   JM 0x3084
3607 11 CD 01                   LXI DE,0x1cd
360A CD 3D 6D                   CALL 0x6d3d
360D 2A 1E 01                   LHLD (0x011e)
3610 11 0C 00                   LXI DE,0xc
3613 19                         DAD HL,DE
3614 22 1E 01                   SHLD (0x011e)
3617 11 18 01                   LXI DE,0x118
361A CD 6E 64                   CALL 0x646e
361D 2A 1E 01                   LHLD (0x011e)
3620 CD 5F 36                   CALL 0x365f
3623 C3 84 30                   JMP 0x3084

; ============================================================
; FUN_ram_3626
; вызовы из: 350E 3514 351A 3520 3526 352C 3532 3538 353E
3626 CD 54 6F    FUN_ram_3626:  CALL 0x6f54
3629 CD 42 73                   CALL 0x7342
362C B7                         ORA A
362D F8                         RM
362E 3A DB 01                   LDA (0x01db)
3631 3C                         INR A
3632 32 DB 01                   STA (0x01db)
3635 C9                         RET

; ============================================================
; FUN_ram_3636
; вызовы из: 345D 3463 3469 346F 3475 347B 358F
3636 CD AF 6F    FUN_ram_3636:  CALL 0x6faf
3639 CD 1E 73                   CALL 0x731e
363C C9                         RET

; ============================================================
; FUN_ram_363d
; вызовы из: 34EF 35A9 3BB5
363D 01 00 00    FUN_ram_363d:  LXI BC,0x0
3640 16 09                      MVI D,0x9
3642 7C                         MOV A,H
3643 1F                         RAR
3644 79          LAB_ram_3644:  MOV A,C
3645 17                         RAL
3646 4F                         MOV C,A
3647 93                         SUB E
3648 D2 52 36                   JNC 0x3652
364B 3F                         CMC
364C 78                         MOV A,B
364D 17                         RAL
364E 47                         MOV B,A
364F C3 57 36                   JMP 0x3657
3652 4F          LAB_ram_3652:  MOV C,A
3653 37                         STC
3654 78                         MOV A,B
3655 17                         RAL
3656 47                         MOV B,A
3657 15          LAB_ram_3657:  DCR D
3658 C8                         RZ
3659 7D                         MOV A,L
365A 17                         RAL
365B 6F                         MOV L,A
365C C3 44 36                   JMP 0x3644

; ============================================================
; FUN_ram_365f
; вызовы из: 35F4 3620
365F 11 DB 3B    FUN_ram_365f:  LXI DE,0x3bdb
3662 01 06 01                   LXI BC,0x106
3665 CD 42 73                   CALL 0x7342
3668 07                         RLC
3669 D2 6F 36                   JNC 0x366f
366C 11 52 01                   LXI DE,0x152
366F 06 03       LAB_ram_366f:  MVI B,0x3
3671 0E 01                      MVI C,0x1
3673 3A 19 01                   LDA (0x0119)
3676 11 53 01                   LXI DE,0x153
3679 FE FE                      CPI 0xfe
367B CA BB 33                   JZ 0x33bb
367E 11 52 01                   LXI DE,0x152
3681 FE FD                      CPI 0xfd
3683 3E 30                      MVI A,0x30
3685 32 52 01                   STA (0x0152)
3688 CA BB 33                   JZ 0x33bb
368B 3A 19 01                   LDA (0x0119)
368E FE FC                      CPI 0xfc
3690 11 51 01                   LXI DE,0x151
3693 3E 30                      MVI A,0x30
3695 32 51 01                   STA (0x0151)
3698 CA BB 33                   JZ 0x33bb
369B 11 DB 3B                   LXI DE,0x3bdb
369E C3 BB 33                   JMP 0x33bb

; ============================================================
; fmt_8
36A1 01 06 01    fmt_8:         LXI BC,0x106
36A4 11 A5 01                   LXI DE,0x1a5
36A7 CD 54 6F                   CALL 0x6f54
36AA CD 42 73                   CALL 0x7342
36AD 17                         RAL
36AE DA 84 30                   JC 0x3084
36B1 3A F2 00                   LDA (0x00f2)
36B4 1F                         RAR
36B5 DA 83 37                   JC 0x3783
36B8 11 C5 01                   LXI DE,0x1c5
36BB CD 54 6F                   CALL 0x6f54
36BE CD 42 73                   CALL 0x7342
36C1 17                         RAL
36C2 DA 84 30                   JC 0x3084
36C5 11 A5 01                   LXI DE,0x1a5
36C8 CD 54 6F                   CALL 0x6f54
36CB 11 EF 3B                   LXI DE,0x3bef
36CE CD 3B 70                   CALL 0x703b
36D1 11 71 01                   LXI DE,0x171
36D4 CD 1E 73                   CALL 0x731e
36D7 11 C5 01                   LXI DE,0x1c5
36DA CD 54 6F                   CALL 0x6f54
36DD 11 F3 3B                   LXI DE,0x3bf3
36E0 CD 3B 70                   CALL 0x703b
36E3 11 71 01                   LXI DE,0x171
36E6 CD 4E 62                   CALL 0x624e
36E9 CD 1E 73                   CALL 0x731e
36EC 11 A5 01                   LXI DE,0x1a5
36EF CD 54 6F                   CALL 0x6f54
36F2 11 A5 01                   LXI DE,0x1a5
36F5 CD 3B 70                   CALL 0x703b
36F8 11 F7 3B                   LXI DE,0x3bf7
36FB CD 3B 70                   CALL 0x703b
36FE 11 71 01                   LXI DE,0x171
3701 CD 48 62                   CALL 0x6248
3704 11 FB 3B                   LXI DE,0x3bfb
3707 CD 48 62                   CALL 0x6248
370A 11 71 01                   LXI DE,0x171
370D CD 1E 73                   CALL 0x731e
3710 11 C5 01                   LXI DE,0x1c5
3713 CD 54 6F                   CALL 0x6f54
3716 11 C5 01                   LXI DE,0x1c5
3719 CD 3B 70                   CALL 0x703b
371C 11 FF 3B                   LXI DE,0x3bff
371F CD 3B 70                   CALL 0x703b
3722 11 7D 01                   LXI DE,0x17d
3725 CD 1E 73                   CALL 0x731e
3728 11 71 01                   LXI DE,0x171
372B CD 54 6F                   CALL 0x6f54
372E 11 7D 01                   LXI DE,0x17d
3731 CD 4E 62                   CALL 0x624e
3734 3E 04       LAB_ram_3734:  MVI A,0x4
3736 32 1B 01                   STA (0x011b)
3739 11 18 01                   LXI DE,0x118
373C CD 6E 64                   CALL 0x646e
373F 2A ED 00                   LHLD (0x00ed)
3742 CD 48 37                   CALL 0x3748
3745 C3 84 30                   JMP 0x3084

; ============================================================
; FUN_ram_3748
; вызовы из: 3742
3748 11 DB 3B    FUN_ram_3748:  LXI DE,0x3bdb
374B 01 06 01                   LXI BC,0x106
374E CD 42 73                   CALL 0x7342
3751 07                         RLC
3752 D2 58 37                   JNC 0x3758
3755 11 52 01                   LXI DE,0x152
3758 06 04       LAB_ram_3758:  MVI B,0x4
375A 3A 19 01                   LDA (0x0119)
375D FE 00                      CPI 0x0
375F 11 53 01                   LXI DE,0x153
3762 CA 27 3B                   JZ 0x3b27
3765 FE FF                      CPI 0xff
3767 11 52 01                   LXI DE,0x152
376A CA 27 3B                   JZ 0x3b27
376D FE FE                      CPI 0xfe
376F 11 51 01                   LXI DE,0x151
3772 CA 27 3B                   JZ 0x3b27
3775 FE FD                      CPI 0xfd
3777 11 50 01                   LXI DE,0x150
377A CA 27 3B                   JZ 0x3b27
377D 11 DB 3B                   LXI DE,0x3bdb
3780 C3 27 3B                   JMP 0x3b27
3783 01 06 01    LAB_ram_3783:  LXI BC,0x106
3786 11 CD 01                   LXI DE,0x1cd
3789 CD 54 6F                   CALL 0x6f54
378C CD 42 73                   CALL 0x7342
378F 17                         RAL
3790 DA 84 30                   JC 0x3084
3793 11 0B 3C                   LXI DE,0x3c0b
3796 CD 3B 70                   CALL 0x703b
3799 11 A5 01                   LXI DE,0x1a5
379C CD 3B 70                   CALL 0x703b
379F 11 5C 01                   LXI DE,0x15c
37A2 CD 1E 73                   CALL 0x731e
37A5 11 A5 01                   LXI DE,0x1a5
37A8 CD 54 6F                   CALL 0x6f54
37AB 11 03 3C                   LXI DE,0x3c03
37AE CD 3B 70                   CALL 0x703b
37B1 11 60 01                   LXI DE,0x160
37B4 CD 1E 73                   CALL 0x731e
37B7 11 CD 01                   LXI DE,0x1cd
37BA CD 54 6F                   CALL 0x6f54
37BD 11 07 3C                   LXI DE,0x3c07
37C0 CD 3B 70                   CALL 0x703b
37C3 11 60 01                   LXI DE,0x160
37C6 CD 48 62                   CALL 0x6248
37C9 11 5C 01                   LXI DE,0x15c
37CC CD 4E 62                   CALL 0x624e
37CF 11 0F 3C                   LXI DE,0x3c0f
37D2 CD 4E 62                   CALL 0x624e
37D5 3E 1F                      MVI A,0x1f
37D7 32 68 01                   STA (0x0168)
37DA 11 9C 38                   LXI DE,0x389c
37DD CD 37 6A                   CALL 0x6a37
37E0 17                         RAL
37E1 17                         RAL
37E2 17                         RAL
37E3 DA ED 37                   JC 0x37ed
37E6 CD 37 6A    LAB_ram_37e6:  CALL 0x6a37
37E9 17                         RAL
37EA D2 FB 37                   JNC 0x37fb
37ED 21 04 00    LAB_ram_37ed:  LXI HL,0x4
37F0 19          LAB_ram_37f0:  DAD HL,DE
37F1 5E                         MOV E,(HL)
37F2 23                         INX HL
37F3 56                         MOV D,(HL)
37F4 EB                         XCHG
37F5 CD 8C 38                   CALL 0x388c
37F8 C3 89 38                   JMP 0x3889
37FB 17          LAB_ram_37fb:  RAL
37FC D2 14 38                   JNC 0x3814
37FF 21 06 00                   LXI HL,0x6
3802 19                         DAD HL,DE
3803 EB                         XCHG
3804 3A 68 01                   LDA (0x0168)
3807 3D                         DCR A
3808 32 68 01                   STA (0x0168)
380B C2 E6 37                   JNZ 0x37e6
380E 21 FE FF                   LXI HL,0xfffe
3811 C3 F0 37                   JMP 0x37f0
3814 EB          LAB_ram_3814:  XCHG
3815 22 66 01                   SHLD (0x0166)
3818 11 FA FF                   LXI DE,0xfffa
381B 19                         DAD HL,DE
381C 22 64 01                   SHLD (0x0164)
381F EB                         XCHG
3820 CD 4E 62                   CALL 0x624e
3823 11 5C 01                   LXI DE,0x15c
3826 CD 1E 73                   CALL 0x731e
3829 2A 64 01                   LHLD (0x0164)
382C 11 04 00                   LXI DE,0x4
382F 19                         DAD HL,DE
3830 5E                         MOV E,(HL)
3831 23                         INX HL
3832 56                         MOV D,(HL)
3833 EB                         XCHG
3834 22 38 01                   SHLD (0x0138)
3837 EB                         XCHG
3838 37                         STC
3839 7B                         MOV A,E
383A 2F                         CMA
383B CE 00                      ACI 0x0
383D 5F                         MOV E,A
383E 7A                         MOV A,D
383F 2F                         CMA
3840 CE 00                      ACI 0x0
3842 57                         MOV D,A
3843 D5                         PUSH DE
3844 23                         INX HL
3845 11 04 00                   LXI DE,0x4
3848 19                         DAD HL,DE
3849 5E                         MOV E,(HL)
384A 23                         INX HL
384B 56                         MOV D,(HL)
384C E1                         POP HL
384D 19                         DAD HL,DE
384E CD 8C 38                   CALL 0x388c
3851 CD 1E 73                   CALL 0x731e
3854 2A 66 01                   LHLD (0x0166)
3857 EB                         XCHG
3858 CD 54 6F                   CALL 0x6f54
385B 2A 64 01                   LHLD (0x0164)
385E EB                         XCHG
385F CD 4E 62                   CALL 0x624e
3862 11 34 01                   LXI DE,0x134
3865 CD 1E 73                   CALL 0x731e
3868 11 60 01                   LXI DE,0x160
386B CD 54 6F                   CALL 0x6f54
386E 11 34 01                   LXI DE,0x134
3871 CD 3D 6D                   CALL 0x6d3d
3874 11 5C 01                   LXI DE,0x15c
3877 CD 3B 70                   CALL 0x703b
387A CD 1E 73                   CALL 0x731e
387D 2A 38 01                   LHLD (0x0138)
3880 CD 8C 38                   CALL 0x388c
3883 11 5C 01                   LXI DE,0x15c
3886 CD 48 62                   CALL 0x6248
3889 C3 34 37    LAB_ram_3889:  JMP 0x3734

; ============================================================
; FUN_ram_388c
; вызовы из: 37F5 384E 3880
388C 22 60 01    FUN_ram_388c:  SHLD (0x0160)
388F 21 00 00                   LXI HL,0x0
3892 22 62 01                   SHLD (0x0162)
3895 11 60 01                   LXI DE,0x160
3898 CD AF 6F                   CALL 0x6faf
389B C9          LAB_ram_389b:  RET
389C 00                         ?? 00h
389D 00                         ?? 00h
389E 00                         ?? 00h
389F C0                         ?? C0h
38A0 0A          DAT_ram_38a0:  undefined1 0Ah
38A1 00          DAT_ram_38a1:  undefined1 00h
38A2 33                         ?? 33h    3
38A3 33                         ?? 33h    3
38A4 F3                         ?? F3h
38A5 BF                         ?? BFh
38A6 0C          DAT_ram_38a6:  undefined1 0Ch
38A7 00          DAT_ram_38a7:  undefined1 00h

; Константы форматирования (float32 + смещения)
38A8 66 66 E6 …  fmt_tables_38A8: db[174] 

; ============================================================
; fmt_9
3956 CD EF 39    fmt_9:         CALL 0x39ef
3959 CA 84 30                   JZ 0x3084
395C CD 30 3B                   CALL 0x3b30
395F C3 84 30                   JMP 0x3084

; ============================================================
; fmt_10
3962 06 08       fmt_10:        MVI B,0x8
3964 21 20 01                   LXI HL,0x120
3967 CD 55 32                   CALL 0x3255
396A 2A E3 00                   LHLD (0x00e3)
396D 22 20 01                   SHLD (0x0120)
3970 2A E5 00                   LHLD (0x00e5)
3973 22 24 01                   SHLD (0x0124)
3976 01 06 01                   LXI BC,0x106
3979 11 24 01                   LXI DE,0x124
397C CD AF 6F                   CALL 0x6faf
397F 11 DF 3B                   LXI DE,0x3bdf
3982 CD 3B 70                   CALL 0x703b
3985 11 24 01                   LXI DE,0x124
3988 CD 1E 73                   CALL 0x731e
398B 11 20 01                   LXI DE,0x120
398E CD AF 6F                   CALL 0x6faf
3991 11 24 01                   LXI DE,0x124
3994 CD 48 62                   CALL 0x6248
3997 CD 26 33                   CALL 0x3326
399A CD 3B 70                   CALL 0x703b
399D 11 D7 3B                   LXI DE,0x3bd7
39A0 CD 3D 6D                   CALL 0x6d3d
39A3 11 EB 3B                   LXI DE,0x3beb
39A6 CD 3B 70                   CALL 0x703b
39A9 11 24 01                   LXI DE,0x124
39AC CD 9F 6E                   CALL 0x6e9f
39AF 01 06 01                   LXI BC,0x106
39B2 11 24 01                   LXI DE,0x124
39B5 CD AF 6F                   CALL 0x6faf
39B8 CD DE 39                   CALL 0x39de
39BB 22 FA 00                   SHLD (0x00fa)
39BE 21 89 01                   LXI HL,0x189
39C1 22 F8 00                   SHLD (0x00f8)
39C4 EB                         XCHG
39C5 CD 1E 73                   CALL 0x731e
39C8 11 18 01                   LXI DE,0x118
39CB CD 6E 64                   CALL 0x646e
39CE 2A 1E 01                   LHLD (0x011e)
39D1 01 0D 00                   LXI BC,0xd
39D4 09                         DAD HL,BC
39D5 CD F5 3A                   CALL 0x3af5
39D8 CD 30 3B                   CALL 0x3b30
39DB C3 84 30                   JMP 0x3084

; ============================================================
; FUN_ram_39de
; вызовы из: 39B8 3A9E
39DE 21 95 01    FUN_ram_39de:  LXI HL,0x195
39E1 3A F3 00                   LDA (0x00f3)
39E4 3D                         DCR A
39E5 C8                         RZ
39E6 11 08 00                   LXI DE,0x8
39E9 19          LAB_ram_39e9:  DAD HL,DE
39EA 3D                         DCR A
39EB C2 E9 39                   JNZ 0x39e9
39EE C9                         RET

; ============================================================
; FUN_ram_39ef
; вызовы из: 3956
39EF AF          FUN_ram_39ef:  XRA A
39F0 32 D9 01                   STA (0x01d9)
39F3 32 DA 01                   STA (0x01da)
39F6 01 D3 00                   LXI BC,0xd3
39F9 11 D5 00                   LXI DE,0xd5
39FC CD 5D 32                   CALL 0x325d
39FF B7                         ORA A
3A00 C2 5B 3A                   JNZ 0x3a5b
3A03 CD DD 32                   CALL 0x32dd
3A06 11 EB 3B                   LXI DE,0x3beb
3A09 CD 3B 70                   CALL 0x703b
3A0C 11 69 01                   LXI DE,0x169
3A0F CD 1E 73                   CALL 0x731e
3A12 3E 03                      MVI A,0x3
3A14 32 D9 01                   STA (0x01d9)
3A17 11 18 01                   LXI DE,0x118
3A1A CD 6E 64                   CALL 0x646e
3A1D 2A 1E 01                   LHLD (0x011e)
3A20 11 16 00                   LXI DE,0x16
3A23 19                         DAD HL,DE
3A24 CD F5 3A                   CALL 0x3af5
3A27 01 D7 00    LAB_ram_3a27:  LXI BC,0xd7
3A2A 11 D9 00                   LXI DE,0xd9
3A2D CD 5D 32                   CALL 0x325d
3A30 B7                         ORA A
3A31 C2 6B 3A                   JNZ 0x3a6b
3A34 CD DD 32                   CALL 0x32dd
3A37 11 EB 3B                   LXI DE,0x3beb
3A3A CD 3B 70                   CALL 0x703b
3A3D 11 6D 01                   LXI DE,0x16d
3A40 CD 1E 73                   CALL 0x731e
3A43 11 18 01                   LXI DE,0x118
3A46 CD 6E 64                   CALL 0x646e
3A49 2A 1E 01                   LHLD (0x011e)
3A4C 11 1F 00                   LXI DE,0x1f
3A4F 19                         DAD HL,DE
3A50 CD F5 3A                   CALL 0x3af5
3A53 3E 01                      MVI A,0x1
3A55 32 DA 01                   STA (0x01da)
3A58 C3 78 3A                   JMP 0x3a78
3A5B 2A 1E 01    LAB_ram_3a5b:  LHLD (0x011e)
3A5E 11 16 00                   LXI DE,0x16
3A61 19                         DAD HL,DE
3A62 11 DB 3B                   LXI DE,0x3bdb
3A65 CD 25 3B                   CALL 0x3b25
3A68 C3 27 3A                   JMP 0x3a27
3A6B 2A 1E 01    LAB_ram_3a6b:  LHLD (0x011e)
3A6E 11 1F 00                   LXI DE,0x1f
3A71 19                         DAD HL,DE
3A72 11 DB 3B                   LXI DE,0x3bdb
3A75 CD 25 3B                   CALL 0x3b25
3A78 3A D9 01    LAB_ram_3a78:  LDA (0x01d9)
3A7B B7                         ORA A
3A7C CA C2 3A                   JZ 0x3ac2
3A7F 3A DA 01                   LDA (0x01da)
3A82 B7                         ORA A
3A83 C2 DD 3A                   JNZ 0x3add
3A86 11 69 01                   LXI DE,0x169
3A89 01 06 01    LAB_ram_3a89:  LXI BC,0x106
3A8C CD 54 6F                   CALL 0x6f54
3A8F 11 24 01    LAB_ram_3a8f:  LXI DE,0x124
3A92 CD 9F 6E                   CALL 0x6e9f
3A95 01 06 01                   LXI BC,0x106
3A98 11 24 01                   LXI DE,0x124
3A9B CD AF 6F                   CALL 0x6faf
3A9E CD DE 39                   CALL 0x39de
3AA1 22 FA 00                   SHLD (0x00fa)
3AA4 21 89 01                   LXI HL,0x189
3AA7 22 F8 00                   SHLD (0x00f8)
3AAA EB                         XCHG
3AAB CD 1E 73                   CALL 0x731e
3AAE 11 18 01                   LXI DE,0x118
3AB1 CD 6E 64                   CALL 0x646e
3AB4 2A 1E 01                   LHLD (0x011e)
3AB7 01 0D 00                   LXI BC,0xd
3ABA 09                         DAD HL,BC
3ABB CD F5 3A                   CALL 0x3af5
3ABE 3E 01                      MVI A,0x1
3AC0 B7                         ORA A
3AC1 C9                         RET
3AC2 11 6D 01    LAB_ram_3ac2:  LXI DE,0x16d
3AC5 3A DA 01                   LDA (0x01da)
3AC8 B7                         ORA A
3AC9 C2 89 3A                   JNZ 0x3a89
3ACC 2A 1E 01                   LHLD (0x011e)
3ACF 01 04 00                   LXI BC,0x4
3AD2 09                         DAD HL,BC
3AD3 3E 2A                      MVI A,0x2a
3AD5 77                         MOV (HL),A
3AD6 23                         INX HL
3AD7 77                         MOV (HL),A
3AD8 23                         INX HL
3AD9 23                         INX HL
3ADA 77                         MOV (HL),A
3ADB AF                         XRA A
3ADC C9                         RET
3ADD 01 06 01    LAB_ram_3add:  LXI BC,0x106
3AE0 11 69 01                   LXI DE,0x169
3AE3 CD 54 6F                   CALL 0x6f54
3AE6 11 6D 01                   LXI DE,0x16d
3AE9 CD 48 62                   CALL 0x6248
3AEC 11 D3 3B                   LXI DE,0x3bd3
3AEF CD 3D 6D                   CALL 0x6d3d
3AF2 C3 8F 3A                   JMP 0x3a8f

; ============================================================
; FUN_ram_3af5
; вызовы из: 39D5 3A24 3A50 3ABB
3AF5 11 DB 3B    FUN_ram_3af5:  LXI DE,0x3bdb
3AF8 01 06 01                   LXI BC,0x106
3AFB CD 42 73                   CALL 0x7342
3AFE 07                         RLC
3AFF D2 05 3B                   JNC 0x3b05
3B02 11 51 01                   LXI DE,0x151
3B05 3A 19 01    LAB_ram_3b05:  LDA (0x0119)
3B08 FE 00                      CPI 0x0
3B0A 11 53 01                   LXI DE,0x153
3B0D CA 25 3B                   JZ 0x3b25
3B10 FE FF                      CPI 0xff
3B12 11 52 01                   LXI DE,0x152
3B15 CA 25 3B                   JZ 0x3b25
3B18 FE FE                      CPI 0xfe
3B1A 11 51 01                   LXI DE,0x151
3B1D CA 25 3B                   JZ 0x3b25
3B20 3E 30                      MVI A,0x30
3B22 32 53 01                   STA (0x0153)

; ============================================================
; FUN_ram_3b25
; вызовы из: 3A65 3A75 3B0D 3B15 3B1D
3B25 06 03       FUN_ram_3b25:  MVI B,0x3
3B27 1A          LAB_ram_3b27:  LDAX (DE)
3B28 77                         MOV (HL),A
3B29 23                         INX HL
3B2A 13                         INX DE
3B2B 05                         DCR B
3B2C C2 27 3B                   JNZ 0x3b27
3B2F C9                         RET

; ============================================================
; FUN_ram_3b30
; вызовы из: 395C 39D8
3B30 2A EB 00    FUN_ram_3b30:  LHLD (0x00eb)
3B33 E5                         PUSH HL
3B34 01 06 01                   LXI BC,0x106
3B37 11 7D 01                   LXI DE,0x17d
3B3A CD 1E 73                   CALL 0x731e
3B3D E1                         POP HL
3B3E 11 00 00                   LXI DE,0x0
3B41 3A F2 00                   LDA (0x00f2)
3B44 1F                         RAR
3B45 D2 4B 3B                   JNC 0x3b4b
3B48 11 10 00                   LXI DE,0x10
3B4B 19          LAB_ram_3b4b:  DAD HL,DE
3B4C E5                         PUSH HL
3B4D EB                         XCHG
3B4E CD 3B 70                   CALL 0x703b
3B51 E1                         POP HL
3B52 11 04 00                   LXI DE,0x4
3B55 19                         DAD HL,DE
3B56 E5                         PUSH HL
3B57 EB                         XCHG
3B58 CD 48 62                   CALL 0x6248
3B5B 11 71 01                   LXI DE,0x171
3B5E CD 1E 73                   CALL 0x731e
3B61 11 7D 01                   LXI DE,0x17d
3B64 CD 54 6F                   CALL 0x6f54
3B67 11 7D 01                   LXI DE,0x17d
3B6A CD 3B 70                   CALL 0x703b
3B6D 11 81 01                   LXI DE,0x181
3B70 CD 1E 73                   CALL 0x731e
3B73 E1                         POP HL
3B74 11 04 00                   LXI DE,0x4
3B77 19                         DAD HL,DE
3B78 E5                         PUSH HL
3B79 EB                         XCHG
3B7A CD 3B 70                   CALL 0x703b
3B7D 11 71 01                   LXI DE,0x171
3B80 CD 48 62                   CALL 0x6248
3B83 11 71 01                   LXI DE,0x171
3B86 CD 1E 73                   CALL 0x731e
3B89 11 81 01                   LXI DE,0x181
3B8C CD 54 6F                   CALL 0x6f54
3B8F 11 7D 01                   LXI DE,0x17d
3B92 CD 3B 70                   CALL 0x703b
3B95 E1                         POP HL
3B96 11 04 00                   LXI DE,0x4
3B99 19                         DAD HL,DE
3B9A EB                         XCHG
3B9B CD 3B 70                   CALL 0x703b
3B9E 11 71 01                   LXI DE,0x171
3BA1 CD 48 62                   CALL 0x6248
3BA4 11 8D 01                   LXI DE,0x18d
3BA7 CD 1E 73                   CALL 0x731e
3BAA 11 85 01                   LXI DE,0x185
3BAD CD 9F 6E                   CALL 0x6e9f
3BB0 2A 85 01                   LHLD (0x0185)
3BB3 1E 07                      MVI E,0x7
3BB5 CD 3D 36                   CALL 0x363d
3BB8 2A 1E 01                   LHLD (0x011e)
3BBB 11 07 00                   LXI DE,0x7
3BBE 19                         DAD HL,DE
3BBF 79                         MOV A,C
3BC0 F6 30                      ORI 0x30
3BC2 77                         MOV (HL),A
3BC3 2B                         DCX HL
3BC4 2B                         DCX HL
3BC5 2B                         DCX HL
3BC6 78                         MOV A,B
3BC7 CD 32 56                   CALL 0x5632
3BCA C9                         RET
3BCB 2D B2 9D …  fmt_const_3BCB: float[4] 
3BDB 2A          DAT_ram_3bdb:  undefined1 2Ah
3BDC 2A          DAT_ram_3bdc:  undefined1 2Ah

; float-константы расчётов (периметр/площадь и т.п.)
3BDD 2A 2A F3 …  fmt_const_3BDD: db[54] 

; ============================================================
; vid_call
; Диспетчер графических функций: A = номер, таблица 0x3C38 {номер,адрес}, 0 — конец.
; вызовы из: 2062 222A 236A 238F 23AE 23D7 23EB 2400 2444 248B 24BB 24FC 2533 255C 2562 262D 2655 266A 2686 26D5 …
3C13 F5          vid_call:      PUSH AF
3C14 E5                         PUSH HL
3C15 D5                         PUSH DE
3C16 C5                         PUSH BC
3C17 47                         MOV B,A
3C18 21 38 3C                   LXI HL,0x3c38
3C1B 7E          LAB_ram_3c1b:  MOV A,(HL)
3C1C B7                         ORA A
3C1D C2 25 3C                   JNZ 0x3c25
3C20 C1                         POP BC
3C21 D1                         POP DE
3C22 E1                         POP HL
3C23 F1                         POP AF
3C24 C9                         RET
3C25 B8          LAB_ram_3c25:  CMP B
3C26 23                         INX HL
3C27 CA 2F 3C                   JZ 0x3c2f
3C2A 23                         INX HL
3C2B 23                         INX HL
3C2C C3 1B 3C                   JMP 0x3c1b
3C2F 5E          LAB_ram_3c2f:  MOV E,(HL)
3C30 23                         INX HL
3C31 56                         MOV D,(HL)
3C32 EB                         XCHG
3C33 01 D5 3C                   LXI BC,0x3cd5
3C36 C5                         PUSH BC
3C37 E9                         PCHL
3C38 01          tbl_vid_cmd:   db 1h
3C39 DA 3C       PTR_vid_01_ram_3c39: addr ram:3cda
3C3B 02          BYTE_ram_3c3b: db 2h
3C3C EA 3C                      addr ram:3cea
3C3E 03                         db 3h
3C3F F7 3C                      addr ram:3cf7
3C41 04                         db 4h
3C42 30 3D                      addr ram:3d30
3C44 05                         db 5h
3C45 7D 3D                      addr ram:3d7d
3C47 06                         db 6h
3C48 B6 3D                      addr ram:3db6
3C4A 07                         db 7h
3C4B E0 3D                      addr ram:3de0
3C4D 08                         db 8h
3C4E F3 3D                      addr ram:3df3
3C50 09                         db 9h
3C51 04 3E                      addr ram:3e04
3C53 0A                         db Ah
3C54 78 3E                      addr ram:3e78
3C56 0B                         db Bh
3C57 AE 3E                      addr ram:3eae
3C59 0C                         db Ch
3C5A D8 3E                      addr ram:3ed8
3C5C 0D                         db Dh
3C5D ED 3E                      addr ram:3eed
3C5F 0E                         db Eh
3C60 FF 3E                      addr ram:3eff
3C62 0F                         db Fh
3C63 81 3F                      addr ram:3f81
3C65 10                         db 10h
3C66 32 3F                      addr ram:3f32
3C68 11                         db 11h
3C69 B3 3F                      addr ram:3fb3
3C6B 12                         db 12h
3C6C CC 3F                      addr ram:3fcc
3C6E 13                         db 13h
3C6F FD 3F                      addr ram:3ffd
3C71 14                         db 14h
3C72 5E 40                      addr ram:405e
3C74 15                         db 15h
3C75 AC 40                      addr ram:40ac
3C77 16                         db 16h
3C78 B5 40                      addr ram:40b5
3C7A 17                         db 17h
3C7B 03 41                      addr ram:4103
3C7D 18                         db 18h
3C7E 1B 41                      addr ram:411b
3C80 19                         db 19h
3C81 08 41                      addr ram:4108
3C83 20                         db 20h
3C84 20 41                      addr ram:4120
3C86 21                         db 21h
3C87 39 41                      addr ram:4139
3C89 22                         db 22h
3C8A E4                         ?? E4h
3C8B 41 23 60 …                 ds "A#`A$"  ; A#ЮA
3C90 7B 41                      addr ram:417b
3C92 25                         db 25h
3C93 68 41                      addr ram:4168
3C95 26                         db 26h
3C96 80 41                      addr ram:4180
3C98 27                         db 27h
3C99 9C 41                      addr ram:419c
3C9B 28                         db 28h
3C9C 88 41                      addr ram:4188
3C9E 29                         db 29h
3C9F A1 41                      addr ram:41a1
3CA1 2A                         db 2Ah
3CA2 BD 41                      addr ram:41bd
3CA4 2B                         db 2Bh
3CA5 A9 41                      addr ram:41a9
3CA7 2C                         db 2Ch
3CA8 04 42                      addr ram:4204
3CAA 2D                         db 2Dh
3CAB 1F 42                      addr ram:421f
3CAD 2E                         db 2Eh
3CAE BF 40                      addr ram:40bf
3CB0 2F                         db 2Fh
3CB1 C2 41                      addr ram:41c2
3CB3 33                         db 33h
3CB4 19 40                      addr ram:4019
3CB6 34                         db 34h
3CB7 24 42                      addr ram:4224
3CB9 35                         db 35h
3CBA 41 41                      addr ram:4141
3CBC 36                         db 36h
3CBD 11 3E                      addr ram:3e11
3CBF 3A                         db 3Ah
3CC0 A7 3D                      addr ram:3da7
3CC2 3B                         db 3Bh
3CC3 8B 3D                      addr ram:3d8b
3CC5 3C                         db 3Ch
3CC6 98 3D                      addr ram:3d98
3CC8 3D                         db 3Dh
3CC9 48 42                      addr ram:4248
3CCB 3E                         db 3Eh
3CCC 3B 42                      addr ram:423b
3CCE 3F                         db 3Fh
3CCF A6 42                      addr ram:42a6
3CD1 40                         db 40h
3CD2 BE 42                      addr ram:42be
3CD4 00                         db 0h
3CD5 C1                         ?? C1h
3CD6 D1                         ?? D1h
3CD7 E1                         ?? E1h
3CD8 F1                         ?? F1h
3CD9 C9                         ?? C9h

; ============================================================
; vid_01
; вызовы из: 3C37 3C39
3CDA 21 00 C7    vid_01:        LXI HL,0xc700
3CDD AF          LAB_ram_3cdd:  XRA A
3CDE 77                         MOV (HL),A
3CDF 23                         INX HL
3CE0 7C                         MOV A,H
3CE1 FE 00                      CPI 0x0
3CE3 C2 DD 3C                   JNZ 0x3cdd
3CE6 CD 59 47                   CALL 0x4759
3CE9 C9                         RET

; ============================================================
; vid_02
; вызовы из: 3C3C
3CEA 11 0F 01    vid_02:        LXI DE,0x10f
3CED 06 FF                      MVI B,0xff
3CEF 21 4F 00    LAB_ram_3cef:  LXI HL,0x4f
3CF2 3E 0A                      MVI A,0xa
3CF4 C3 5A 3D                   JMP 0x3d5a

; ============================================================
; vid_03
; вызовы из: 3C3F
3CF7 CD F2 46    vid_03:        CALL 0x46f2
3CFA D5                         PUSH DE
3CFB 3A E4 01                   LDA (0x01e4)
3CFE 47                         MOV B,A
3CFF 1E 0C                      MVI E,0xc
3D01 CD 2A 47                   CALL 0x472a
3D04 45                         MOV B,L
3D05 D1                         POP DE
3D06 C3 EF 3C                   JMP 0x3cef

; ============================================================
; FUN_ram_3d09
; вызовы из: 3D88 3D95 3DB3
3D09 32 05 02    FUN_ram_3d09:  STA (0x0205)
3D0C 3E 40                      MVI A,0x40
3D0E 32 DF 02                   STA (0x02df)
3D11 3A 05 02    LAB_ram_3d11:  LDA (0x0205)
3D14 4F                         MOV C,A
3D15 E5                         PUSH HL
3D16 3E 20       LAB_ram_3d16:  MVI A,0x20
3D18 CD 64 4D                   CALL 0x4d64
3D1B C5                         PUSH BC
3D1C 01 F8 FF                   LXI BC,0xfff8
3D1F 09                         DAD HL,BC
3D20 C1                         POP BC
3D21 0D                         DCR C
3D22 C2 16 3D                   JNZ 0x3d16
3D25 21 F4 FF                   LXI HL,0xfff4
3D28 19                         DAD HL,DE
3D29 EB                         XCHG
3D2A E1                         POP HL
3D2B 05                         DCR B
3D2C C2 11 3D                   JNZ 0x3d11
3D2F C9                         RET

; ============================================================
; vid_04
; вызовы из: 3C42
3D30 21 5E 01    vid_04:        LXI HL,0x15e
3D33 11 0F 01                   LXI DE,0x10f
3D36 D5                         PUSH DE
3D37 E5                         PUSH HL
3D38 06 FF                      MVI B,0xff
3D3A CD 58 3D                   CALL 0x3d58
3D3D E1                         POP HL
3D3E 11 10 00                   LXI DE,0x10
3D41 06 03                      MVI B,0x3
3D43 CD 58 3D                   CALL 0x3d58
3D46 D1                         POP DE
3D47 0E F8                      MVI C,0xf8
3D49 CD CF 3D                   CALL 0x3dcf
3D4C 11 10 00                   LXI DE,0x10
3D4F 06 03                      MVI B,0x3
3D51 CD D1 3D                   CALL 0x3dd1
3D54 CD 59 47                   CALL 0x4759
3D57 C9                         RET

; ============================================================
; FUN_ram_3d58
; вызовы из: 3D3A 3D43
3D58 3E 20       FUN_ram_3d58:  MVI A,0x20

; ============================================================
; FUN_ram_3d5a
; вызовы из: 3CF4 3DC8 3E0E 400A 4015 422F 4245
3D5A 32 05 02    FUN_ram_3d5a:  STA (0x0205)
3D5D CD 09 48                   CALL 0x4809
3D60 E5          LAB_ram_3d60:  PUSH HL
3D61 3A 05 02                   LDA (0x0205)
3D64 4F                         MOV C,A
3D65 AF          LAB_ram_3d65:  XRA A
3D66 77                         MOV (HL),A
3D67 2B                         DCX HL
3D68 0D                         DCR C
3D69 C2 65 3D                   JNZ 0x3d65
3D6C E1                         POP HL
3D6D CD 75 3D                   CALL 0x3d75
3D70 C2 60 3D                   JNZ 0x3d60
3D73 C9                         RET

; ============================================================
; FUN_ram_3d74
; вызовы из: 3DD9
3D74 77          FUN_ram_3d74:  MOV (HL),A

; ============================================================
; FUN_ram_3d75
; вызовы из: 3D6D
3D75 C5          FUN_ram_3d75:  PUSH BC
3D76 01 D3 FF                   LXI BC,0xffd3
3D79 09                         DAD HL,BC
3D7A C1                         POP BC
3D7B 05                         DCR B
3D7C C9                         RET

; ============================================================
; vid_05
; вызовы из: 3C45
3D7D CD F2 46    vid_05:        CALL 0x46f2
3D80 CD 16 47                   CALL 0x4716
3D83 06 01                      MVI B,0x1
3D85 3A E1 01                   LDA (0x01e1)
3D88 C3 09 3D                   JMP 0x3d09

; ============================================================
; vid_3B
; вызовы из: 3CC3
3D8B 21 52 01    vid_3B:        LXI HL,0x152
3D8E 11 0D 00                   LXI DE,0xd
3D91 06 01                      MVI B,0x1
3D93 3E 20                      MVI A,0x20
3D95 C3 09 3D                   JMP 0x3d09

; ============================================================
; vid_3C
; вызовы из: 3CC6
3D98 2A F3 01    vid_3C:        LHLD (0x01f3)
3D9B 22 E3 02                   SHLD (0x02e3)
3D9E 21 52 01                   LXI HL,0x152
3DA1 11 0D 00                   LXI DE,0xd
3DA4 C3 E4 3E                   JMP 0x3ee4

; ============================================================
; vid_3A
; вызовы из: 3CC0
3DA7 CD F2 46    vid_3A:        CALL 0x46f2
3DAA 21 5A 01                   LXI HL,0x15a
3DAD 3A E4 01                   LDA (0x01e4)
3DB0 47                         MOV B,A
3DB1 3E 1F                      MVI A,0x1f
3DB3 C3 09 3D                   JMP 0x3d09

; ============================================================
; vid_06
; вызовы из: 3C48
3DB6 CD BA 3D    vid_06:        CALL 0x3dba
3DB9 C9                         RET

; ============================================================
; FUN_ram_3dba
; вызовы из: 3DB6
3DBA 06 02       FUN_ram_3dba:  MVI B,0x2
3DBC CD C0 3D                   CALL 0x3dc0
3DBF C9                         RET

; ============================================================
; FUN_ram_3dc0
; вызовы из: 3DBC
3DC0 11 12 01    FUN_ram_3dc0:  LXI DE,0x112
3DC3 3E 20                      MVI A,0x20

; ============================================================
; FUN_ram_3dc5
; вызовы из: 3DE9
3DC5 21 66 01    FUN_ram_3dc5:  LXI HL,0x166
3DC8 CD 5A 3D                   CALL 0x3d5a
3DCB C9                         RET
3DCC 11                         ?? 11h
3DCD 10                         ?? 10h
3DCE 01                         ?? 01h

; ============================================================
; FUN_ram_3dcf
; вызовы из: 3D49
3DCF 06 FF       FUN_ram_3dcf:  MVI B,0xff

; ============================================================
; FUN_ram_3dd1
; вызовы из: 3D51 4237
3DD1 21 66 01    FUN_ram_3dd1:  LXI HL,0x166

; ============================================================
; FUN_ram_3dd4
; вызовы из: 40FD
3DD4 CD 09 48    FUN_ram_3dd4:  CALL 0x4809
3DD7 7E          LAB_ram_3dd7:  MOV A,(HL)
3DD8 A1                         ANA C
3DD9 CD 74 3D                   CALL 0x3d74
3DDC C2 D7 3D                   JNZ 0x3dd7
3DDF C9                         RET

; ============================================================
; vid_07
; вызовы из: 3C4B
3DE0 11 12 01    vid_07:        LXI DE,0x112
3DE3 06 04                      MVI B,0x4
3DE5 0E 00                      MVI C,0x0
3DE7 3E 23                      MVI A,0x23
3DE9 CD C5 3D                   CALL 0x3dc5
3DEC CD 59 47                   CALL 0x4759
3DEF CD FD 3F                   CALL 0x3ffd
3DF2 C9                         RET

; ============================================================
; vid_08
; вызовы из: 3C4E
3DF3 3E 40       vid_08:        MVI A,0x40
3DF5 32 DF 02                   STA (0x02df)
3DF8 CD F2 46                   CALL 0x46f2
3DFB CD 16 47                   CALL 0x4716
3DFE 3E 20                      MVI A,0x20
3E00 CD 64 4D                   CALL 0x4d64
3E03 C9                         RET

; ============================================================
; vid_09
; вызовы из: 3C51
3E04 21 4F 00    vid_09:        LXI HL,0x4f
3E07 11 7F 00                   LXI DE,0x7f
3E0A 06 48                      MVI B,0x48
3E0C 3E 0A                      MVI A,0xa
3E0E C3 5A 3D                   JMP 0x3d5a

; ============================================================
; vid_36
; вызовы из: 3CBD 3EAA
3E11 3E 40       vid_36:        MVI A,0x40
3E13 32 DF 02                   STA (0x02df)
3E16 21 48 00                   LXI HL,0x48
3E19 E5                         PUSH HL
3E1A 11 D4 00                   LXI DE,0xd4
3E1D AF                         XRA A
3E1E 32 E2 02                   STA (0x02e2)
3E21 2F                         CMA
3E22 32 E1 02                   STA (0x02e1)
3E25 3E 12                      MVI A,0x12
3E27 32 E0 02                   STA (0x02e0)
3E2A CD 6A 4A                   CALL 0x4a6a
3E2D E1                         POP HL
3E2E E5                         PUSH HL
3E2F 11 C2 00                   LXI DE,0xc2
3E32 CD 6A 4A                   CALL 0x4a6a
3E35 E1                         POP HL
3E36 11 D4 00                   LXI DE,0xd4
3E39 D5                         PUSH DE
3E3A AF                         XRA A
3E3B 32 E1 02                   STA (0x02e1)
3E3E 2F                         CMA
3E3F 32 E2 02                   STA (0x02e2)
3E42 CD 6A 4A                   CALL 0x4a6a
3E45 D1                         POP DE
3E46 21 36 00                   LXI HL,0x36
3E49 CD 6A 4A                   CALL 0x4a6a
3E4C 3A F6 01                   LDA (0x01f6)
3E4F B7                         ORA A
3E50 06 05                      MVI B,0x5
3E52 CA 5E 3E                   JZ 0x3e5e
3E55 FE 01                      CPI 0x1
3E57 06 09                      MVI B,0x9
3E59 CA 5E 3E                   JZ 0x3e5e
3E5C 06 13                      MVI B,0x13
3E5E 11 D3 00    LAB_ram_3e5e:  LXI DE,0xd3
3E61 CD 67 3E                   CALL 0x3e67
3E64 11 CB 00                   LXI DE,0xcb

; ============================================================
; FUN_ram_3e67
; вызовы из: 3E61
3E67 21 47 00    FUN_ram_3e67:  LXI HL,0x47
3E6A 78                         MOV A,B
3E6B CD 64 4D                   CALL 0x4d64
3E6E 04                         INR B
3E6F 21 3F 00                   LXI HL,0x3f
3E72 78                         MOV A,B
3E73 CD 64 4D                   CALL 0x4d64
3E76 04                         INR B
3E77 C9                         RET

; ============================================================
; vid_0A
; вызовы из: 3C54
3E78 3E 40       vid_0A:        MVI A,0x40
3E7A 32 DF 02                   STA (0x02df)
3E7D 2A F3 01                   LHLD (0x01f3)
3E80 22 E3 02                   SHLD (0x02e3)
3E83 11 0F 01                   LXI DE,0x10f
3E86 06 05                      MVI B,0x5
3E88 21 4F 00    LAB_ram_3e88:  LXI HL,0x4f
3E8B CD CA 3E                   CALL 0x3eca
3E8E C2 88 3E                   JNZ 0x3e88
3E91 21 27 00                   LXI HL,0x27
3E94 3E 10                      MVI A,0x10
3E96 CD 64 4D                   CALL 0x4d64
3E99 3A E0 01                   LDA (0x01e0)
3E9C B7                         ORA A
3E9D 3E 31                      MVI A,0x31
3E9F CA A4 3E                   JZ 0x3ea4
3EA2 3E 32                      MVI A,0x32
3EA4 21 1F 00    LAB_ram_3ea4:  LXI HL,0x1f
3EA7 CD 64 4D                   CALL 0x4d64
3EAA CD 11 3E                   CALL 0x3e11
3EAD C9                         RET

; ============================================================
; vid_0B
; вызовы из: 3C57
3EAE 3E 40       vid_0B:        MVI A,0x40
3EB0 32 DF 02                   STA (0x02df)
3EB3 2A F3 01                   LHLD (0x01f3)
3EB6 22 E3 02                   SHLD (0x02e3)
3EB9 CD F2 46                   CALL 0x46f2
3EBC 3A E4 01                   LDA (0x01e4)
3EBF 47                         MOV B,A
3EC0 21 4F 00    LAB_ram_3ec0:  LXI HL,0x4f
3EC3 CD CA 3E                   CALL 0x3eca
3EC6 C2 C0 3E                   JNZ 0x3ec0
3EC9 C9                         RET

; ============================================================
; FUN_ram_3eca
; вызовы из: 3E8B 3EC3
3ECA D5          FUN_ram_3eca:  PUSH DE
3ECB C5                         PUSH BC
3ECC CD 45 4D                   CALL 0x4d45
3ECF C1                         POP BC
3ED0 D1                         POP DE
3ED1 21 F4 FF                   LXI HL,0xfff4
3ED4 19                         DAD HL,DE
3ED5 EB                         XCHG
3ED6 05                         DCR B
3ED7 C9                         RET

; ============================================================
; vid_0C
; вызовы из: 3C5A
3ED8 2A F3 01    vid_0C:        LHLD (0x01f3)
3EDB 22 E3 02                   SHLD (0x02e3)
3EDE CD F2 46                   CALL 0x46f2
3EE1 CD 16 47                   CALL 0x4716
3EE4 3E 40       LAB_ram_3ee4:  MVI A,0x40
3EE6 32 DF 02                   STA (0x02df)
3EE9 CD 45 4D                   CALL 0x4d45
3EEC C9                         RET

; ============================================================
; vid_0D
; вызовы из: 3C5D
3EED CD F2 46    vid_0D:        CALL 0x46f2
3EF0 CD 16 47                   CALL 0x4716
3EF3 3E 40                      MVI A,0x40
3EF5 32 DF 02                   STA (0x02df)
3EF8 3A E5 01                   LDA (0x01e5)
3EFB CD 64 4D                   CALL 0x4d64
3EFE C9                         RET

; ============================================================
; vid_0E
; вызовы из: 3C60
3EFF 2A F3 01    vid_0E:        LHLD (0x01f3)
3F02 22 FF 01                   SHLD (0x01ff)
3F05 CD F2 46                   CALL 0x46f2
3F08 CD 16 47                   CALL 0x4716
3F0B 3A DF 01                   LDA (0x01df)
3F0E 32 F9 01                   STA (0x01f9)
3F11 3E 41                      MVI A,0x41
3F13 32 DF 02                   STA (0x02df)
3F16 E5          LAB_ram_3f16:  PUSH HL
3F17 2A FF 01                   LHLD (0x01ff)
3F1A 7E                         MOV A,(HL)
3F1B 23                         INX HL
3F1C 22 FF 01                   SHLD (0x01ff)
3F1F E1                         POP HL
3F20 CD 64 4D                   CALL 0x4d64
3F23 01 F8 FF                   LXI BC,0xfff8
3F26 09                         DAD HL,BC
3F27 3A F9 01                   LDA (0x01f9)
3F2A 3D                         DCR A
3F2B 32 F9 01                   STA (0x01f9)
3F2E C2 16 3F                   JNZ 0x3f16
3F31 C9                         RET

; ============================================================
; vid_10
; вызовы из: 3C66
3F32 CD 45 3F    vid_10:        CALL 0x3f45
3F35 CD 81 3F                   CALL 0x3f81
3F38 CD CC 3F                   CALL 0x3fcc
3F3B CD 19 40                   CALL 0x4019
3F3E CD 5E 40                   CALL 0x405e
3F41 CD BF 40                   CALL 0x40bf
3F44 C9                         RET

; ============================================================
; FUN_ram_3f45
; вызовы из: 3F32
3F45 3E 40       FUN_ram_3f45:  MVI A,0x40
3F47 32 DF 02                   STA (0x02df)
3F4A 11 10 01                   LXI DE,0x110
3F4D CD 63 3F                   CALL 0x3f63
3F50 C9                         RET
3F51 21                         ?? 21h    !
3F52 63                         ?? 63h    c
3F53 01                         ?? 01h

; ============================================================
; FUN_ram_3f54
; вызовы из: 3FF0
3F54 32 E0 02    FUN_ram_3f54:  STA (0x02e0)
3F57 AF                         XRA A
3F58 32 E1 02                   STA (0x02e1)
3F5B 2F                         CMA
3F5C 32 E2 02                   STA (0x02e2)
3F5F CD 6A 4A                   CALL 0x4a6a
3F62 C9                         RET

; ============================================================
; FUN_ram_3f63
; вызовы из: 3F4D
3F63 21 63 00    FUN_ram_3f63:  LXI HL,0x63
3F66 3A E0 01                   LDA (0x01e0)
3F69 B7                         ORA A
3F6A 3E DC                      MVI A,0xdc
3F6C C2 71 3F                   JNZ 0x3f71
3F6F 3E A0                      MVI A,0xa0
3F71 32 E0 02    LAB_ram_3f71:  STA (0x02e0)
3F74 AF                         XRA A
3F75 32 E2 02                   STA (0x02e2)
3F78 3E 01                      MVI A,0x1
3F7A 32 E1 02                   STA (0x02e1)
3F7D CD 6A 4A                   CALL 0x4a6a
3F80 C9                         RET

; ============================================================
; vid_0F
; вызовы из: 3C63 3F35
3F81 3E 40       vid_0F:        MVI A,0x40
3F83 32 DF 02                   STA (0x02df)
3F86 3A E0 01                   LDA (0x01e0)
3F89 B7                         ORA A
3F8A C2 94 3F                   JNZ 0x3f94
3F8D 06 0D                      MVI B,0xd
3F8F 3E 0D                      MVI A,0xd
3F91 C3 98 3F                   JMP 0x3f98
3F94 06 1A       LAB_ram_3f94:  MVI B,0x1a
3F96 3E 09                      MVI A,0x9
3F98 32 E0 02    LAB_ram_3f98:  STA (0x02e0)
3F9B 78                         MOV A,B
3F9C 32 E1 02                   STA (0x02e1)
3F9F AF                         XRA A
3FA0 32 E2 02                   STA (0x02e2)
3FA3 11 12 01                   LXI DE,0x112
3FA6 21 63 00                   LXI HL,0x63
3FA9 E5                         PUSH HL
3FAA CD 6A 4A                   CALL 0x4a6a
3FAD E1                         POP HL
3FAE 1B                         DCX DE
3FAF CD 6A 4A                   CALL 0x4a6a
3FB2 C9                         RET

; ============================================================
; vid_11
; вызовы из: 3C69
3FB3 CD F2 46    vid_11:        CALL 0x46f2
3FB6 CD 16 47                   CALL 0x4716
3FB9 3E 40                      MVI A,0x40
3FBB 32 DF 02                   STA (0x02df)
3FBE 01 F9 FF                   LXI BC,0xfff9
3FC1 EB                         XCHG
3FC2 09                         DAD HL,BC
3FC3 EB                         XCHG
3FC4 01 FA FF                   LXI BC,0xfffa
3FC7 09                         DAD HL,BC
3FC8 CD 5B 48                   CALL 0x485b
3FCB C9                         RET

; ============================================================
; vid_12
; вызовы из: 3C6C 3F38
3FCC 3E 40       vid_12:        MVI A,0x40
3FCE 32 DF 02                   STA (0x02df)
3FD1 21 5F 00                   LXI HL,0x5f
3FD4 E5                         PUSH HL
3FD5 CD EB 3F                   CALL 0x3feb
3FD8 21 58 00                   LXI HL,0x58
3FDB CD EB 3F                   CALL 0x3feb
3FDE E1                         POP HL
3FDF E5                         PUSH HL
3FE0 CD F4 3F                   CALL 0x3ff4
3FE3 E1                         POP HL
3FE4 11 10 00                   LXI DE,0x10
3FE7 CD F7 3F                   CALL 0x3ff7
3FEA C9                         RET

; ============================================================
; FUN_ram_3feb
; вызовы из: 3FD5 3FDB
3FEB 3E FF       FUN_ram_3feb:  MVI A,0xff
3FED 11 0F 01                   LXI DE,0x10f
3FF0 CD 54 3F                   CALL 0x3f54
3FF3 C9                         RET

; ============================================================
; FUN_ram_3ff4
; вызовы из: 3FE0
3FF4 11 10 01    FUN_ram_3ff4:  LXI DE,0x110

; ============================================================
; FUN_ram_3ff7
; вызовы из: 3FE7
3FF7 3E 08       FUN_ram_3ff7:  MVI A,0x8
3FF9 CD 4F 40                   CALL 0x404f
3FFC C9                         RET

; ============================================================
; vid_13
; вызовы из: 3C6F 3DEF
3FFD 11 10 01    vid_13:        LXI DE,0x110
