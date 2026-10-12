; ======================================================================
;  ТЕТРИС для эхотомоскопа ЭТС-ЭЛ-С (Меделком SLE-101), процессор 80C85
;
;  Загружается в ОЗУ с 0040H через монитор (R или S) и запускается G40.
;  Сборка:  python3 tools/asm8085.py tetris/tetris.asm --lst tetris/tetris.lst
;  Эмулятор: python3 tools/etl_gui.py --hex tetris/tetris.hex --go 40
;
;  Пульт (коды из таблицы 21D4H, блок стрелок 3x3, в центре «+»):
;    ←, →     сдвиг (с автоповтором)
;    ↑, ↗     поворот по часовой, ↖ — против часовой
;    ↓        ускоренное падение
;    +        сбросить фигуру до упора
;    СТАРТ    начать игру / пауза
;    МЕНЮ     выход в основную программу (JMP 2000H)
;
;  Экран: видеоОЗУ, 45 байт в строке, кадр повёрнут на 180°.
;  Байт со столбцом bc (0..44) экранной строки sy (0..306) лежит по адресу
;      0FFFFH - 45*sy - bc,   старший бит — левая точка.
;  Шрифт 8x8 прошивки — 5D91H + 8*код, байты глифа идут сверху вниз.
; ======================================================================

ROWB    EQU 45                  ; байт в строке видеоОЗУ
FONT    EQU 5D91H               ; шрифт 8x8 в ПЗУ
KBTAB   EQU 21D4H               ; коды клавиш пульта: 4 столбца x 8 строк
MAIN    EQU 2000H               ; основная программа прибора
STACK   EQU 07C0H               ; 07C7-07FF — трамплин и регистры монитора
ZEROS   EQU 443AH               ; 26 нулевых байтов в ПЗУ №2 (внутри пиктограммы)

; Задержка кадра: цикл по 24 такта. 2200 -> ~53 тыс. тактов, т.е. ~20 мс
; при 3 МГц вместе с работой игры. Частота процессора на плате точно не
; известна: если игра идёт слишком быстро или медленно — поменять здесь.
FDEL    EQU 2200

DAS     EQU 10                  ; задержка автоповтора ←/→, кадров
ARR     EQU 3                   ; период автоповтора ←/→
SDR     EQU 2                   ; период повтора ↓

K_UP    EQU 84H
K_DOWN  EQU 85H
K_LEFT  EQU 87H
K_RIGHT EQU 82H
K_UL    EQU 86H
K_UR    EQU 81H
K_DROP  EQU 10H                 ; «+» в центре блока стрелок
K_START EQU 1AH
K_MENU  EQU 13H

; --- геометрия экрана ---
CELLH   EQU 13                  ; клетка 16 точек x 13 строк
WELLY   EQU 24                  ; экранная строка верха стакана
; клетка (столбец c=1..10, строка r=0..19): bc = 13+2c, sy = WELLY+13r
ROW0    EQU 0FFFFH-ROWB*WELLY-13 ; адрес столбца 0 строки 0 стакана
TX0     EQU 3                   ; левая панель: байты 3..13 (11 знаков)
PREVA   EQU 0FFFFH-ROWB*40-37   ; окно следующей фигуры: bc 37, sy 40
P_SCORE EQU 0FFFFH-ROWB*60-TX0
P_LINES EQU 0FFFFH-ROWB*96-TX0
P_LEVEL EQU 0FFFFH-ROWB*132-TX0
P_MSG1  EQU 0FFFFH-ROWB*164-TX0
P_MSG2  EQU 0FFFFH-ROWB*176-TX0

        ORG 0040H               ; 0000-0005 занят монитором, RST-векторы не нужны

; ======================================================================
START:  DI
        LXI SP,STACK
        MVI A,30H               ; как основная программа: F8 = 30, FA = 80
        OUT 0F8H
        MVI A,80H
        OUT 0FAH
        LXI H,0ACE1H
        SHLD SEED
        XRA A
        STA LASTK
        CALL SCREEN
        LXI H,M_TITLE
        CALL MSG
        JMP WAITST

; ----------------------------------------------------------------------
; Конец игры: сообщение и ожидание СТАРТ
GOVER:  LXI SP,STACK
        LXI H,M_OVER
        CALL MSG
WAITST: CALL FDELAY
        CALL RND                ; ГСЧ крутится, пока игрок не нажмёт СТАРТ
        CALL GETKEY
        CPI K_START
        JZ NEWG
        CPI K_MENU
        JZ EXIT
        JMP WAITST

EXIT:   JMP MAIN

; ----------------------------------------------------------------------
; Новая игра
NEWG:   LXI SP,STACK
        CALL SCREEN
        CALL RND7
        STA NT
        CALL SPAWN

; ----------------------------------------------------------------------
; Главный цикл: один проход — один кадр
LOOP:   CALL FDELAY
        CALL KSCAN
        MOV B,A
        LDA LASTK
        CMP B
        JZ LPHELD
        MOV A,B                 ; новое нажатие (или отпускание)
        STA LASTK
        ORA A
        JZ LPGRAV
        CPI K_DOWN
        MVI A,DAS
        JNZ LP1
        MVI A,SDR
LP1:    STA REP
        MOV A,B
        CALL ACTION
        JMP LPGRAV

LPHELD: ORA A                   ; та же клавиша держится: автоповтор
        JZ LPGRAV
        CPI K_LEFT
        JZ LPREP
        CPI K_RIGHT
        JZ LPREP
        CPI K_DOWN
        JNZ LPGRAV
LPREP:  LDA REP
        DCR A
        STA REP
        JNZ LPGRAV
        MOV A,B
        CPI K_DOWN
        MVI A,ARR
        JNZ LP2
        MVI A,SDR
LP2:    STA REP
        MOV A,B
        CALL ACTION

LPGRAV: LDA GCNT                ; падение
        DCR A
        STA GCNT
        JNZ LOOP
        LDA SPEED
        STA GCNT
        CALL DOWN1
        JMP LOOP

; ----------------------------------------------------------------------
; Действие по коду клавиши в A
ACTION: CPI K_LEFT
        JZ MLEFT
        CPI K_RIGHT
        JZ MRIGHT
        CPI K_UP
        JZ ROTCW
        CPI K_UR
        JZ ROTCW
        CPI K_UL
        JZ ROTCCW
        CPI K_DOWN
        JZ SDROP
        CPI K_DROP
        JZ HDROP
        CPI K_START
        JZ PAUSE
        CPI K_MENU
        JZ EXIT
        RET

PAUSE:  LXI H,M_PAUSE
        CALL MSG
PA1:    CALL FDELAY
        CALL GETKEY
        CPI K_START
        JZ PA2
        CPI K_MENU
        JZ EXIT
        JMP PA1
PA2:    JMP CLRMSG

MLEFT:  CALL SETT
        DCR M                   ; SETT оставляет HL = TX
        JMP TRY

MRIGHT: CALL SETT
        INR M
        JMP TRY

ROTCW:  MVI B,1
        JMP ROT
ROTCCW: MVI B,3
ROT:    CALL SETT
        LDA PR
        ADD B
        ANI 3
        STA TR
        LXI H,KICKS             ; пробуем сдвиги 0, -1, +1, -2, +2
ROT1:   MOV A,M
        CPI 80H
        RZ
        PUSH H
        MOV B,A
        LDA PX
        ADD B
        STA TX
        CALL TRY
        POP H
        RZ
        INX H
        JMP ROT1

SDROP:  LDA SPEED
        STA GCNT
        JMP DOWN1

; Сброс до упора
HDROP:  XRA A
        CALL DRAWP              ; стереть, чтобы не мешала сама себе
        CALL SETT
HD1:    LXI H,TY
        INR M
        CALL FITS
        JZ HD1
        LXI H,TY
        DCR M
        CALL TRY
        JMP LOCKP

; Шаг вниз; если некуда — фигура ложится, новая фигура
DOWN1:  CALL SETT
        INX H
        INR M                   ; TY
        CALL TRY
        RZ
LOCKP:  CALL CLICK              ; фигура остаётся нарисованной — это и есть стакан
        CALL CLRLN
        JMP SPAWN

; Новая фигура вверху стакана; не помещается — конец игры
SPAWN:  LDA NT
        STA PT
        CALL RND7
        STA NT
        LXI H,0004H             ; PX=4, PY=0
        SHLD PX
        SHLD TX
        XRA A
        STA PR
        STA TR
        CALL PREVIEW
        CALL FITS
        JNZ GOVER
        MVI A,1
        CALL DRAWP
        LDA SPEED
        STA GCNT
        RET

; ----------------------------------------------------------------------
; Фигура: PT — тип 0..6, PR — поворот, PX/PY — левый верхний угол рамки
; 4x4 в клетках стакана. TX/TY/TR — проверяемое положение.

; T <- P; на выходе HL = TX
SETT:   LXI H,PX
        LXI D,TX
COPY3:  MVI C,3
CP1:    MOV A,M
        STAX D
        INX H
        INX D
        DCR C
        JNZ CP1
        LXI H,TX
        RET

; Перенести фигуру в TX/TY/TR, если там свободно. Z — получилось.
TRY:    XRA A
        CALL DRAWP              ; стереть, чтобы не мешала сама себе
        CALL FITS
        PUSH PSW
        JNZ TR1
        LXI H,TX
        LXI D,PX
        CALL COPY3
TR1:    MVI A,1
        CALL DRAWP
        POP PSW
        RET

; Проверка положения TX/TY/TR. Z (A=0) — свободно.
; Отдельного массива стакана нет: занятость клетки читается из видеоОЗУ
; (первый байт кубика 0FFH, пустой клетки — 0). Текущая фигура должна быть стёрта.
FITS:   LDA TR
        CALL SHPTR
        MVI C,4
FT1:    LXI D,TX
        CALL CELLXY
        CPI 20                  ; дно
        JNC FTBAD
        MOV D,A
        MOV A,B
        DCR A                   ; столбцы 1..10
        CPI 10
        JNC FTBAD
        MOV A,D
        PUSH H
        CALL CELLA
        MOV A,M
        POP H
        ORA A
        RNZ
        INX H
        DCR C
        JNZ FT1
        RET
FTBAD:  MVI A,1
        ORA A
        RET

; Клетка фигуры: (HL) = dy*16+dx, DE -> X, Y (PX/PY или TX/TY)
; -> B = X+dx, A = Y+dy. HL, C не портит.
CELLXY: LDAX D
        ADD M
        ANI 0FH                 ; X+dx (X от -3 до 12 — по модулю 16)
        MOV B,A
        INX D
        MOV A,M
        RRC
        RRC
        RRC
        RRC
        ANI 0FH
        XCHG
        ADD M
        XCHG
        RET

; HL = SHAPES + (тип*4 + поворот)*4.  SHPTR: A = поворот, тип из PT;
; SHPTR2: A = тип, B = поворот.
SHPTR:  MOV B,A
        LDA PT
SHPTR2: ADD A
        ADD A
        ADD B
        ADD A
        ADD A
        MOV E,A
        MVI D,0
        LXI H,SHAPES
        DAD D
        RET

; Нарисовать (A<>0) или стереть (A=0) текущую фигуру
DRAWP:  STA FILL
        LDA PR
        CALL SHPTR
        MVI C,4
DP1:    LXI D,PX
        CALL CELLXY
        PUSH H
        PUSH B
        CALL CELLA
        LDA FILL
        CALL BLK
        POP B
        POP H
        INX H
        DCR C
        JNZ DP1
        RET

; ----------------------------------------------------------------------
; Стакан

; Убрать заполненные строки, начислить очки
CLRLN:  XRA A
        STA NCLR
        MVI A,19
        STA CROW
CL1:    MVI B,10
CL2:    LDA CROW
        CALL CELLA
        MOV A,M
        ORA A
        JZ CL4
        DCR B
        JNZ CL2
        LXI H,NCLR              ; строка заполнена
        INR M
        LDA CROW
        CALL DELROW
        JMP CL1                 ; ту же строку — ещё раз
CL4:    LXI H,CROW
        DCR M
        JP CL1
        LDA NCLR
        ORA A
        RZ
        ; очки: PTS[n-1] * (уровень+1)
        DCR A
        ADD A
        MOV E,A
        MVI D,0
        LXI H,PTS
        DAD D
        MOV E,M
        INX H
        MOV D,M
        LDA LEVEL
        INR A
        MOV C,A
CL5:    CALL ADDSC
        DCR C
        JNZ CL5
        ; линии (BCD)
        LXI H,LINES
        LDA NCLR
        ADD M
        DAA
        MOV M,A
        INX H
        MOV A,M
        ACI 0
        DAA
        MOV M,A
        ; уровень — каждые 10 линий
        LDA NCLR
        MOV B,A
        LDA LCNT
        SUB B
        STA LCNT
        JZ CL6
        JP CL7
CL6:    ADI 10
        STA LCNT
        LDA LEVEL
        INR A
        STA LEVEL
        CALL SETSPD
CL7:    JMP SHOWST

; Удалить строку A: всё, что выше, сдвинуть на строку вниз прямо в видеоОЗУ.
; Вниз по экрану — к младшим адресам, поэтому копируем от младших к старшим.
DELROW: PUSH PSW
        MVI B,10
        CALL CELLA
        LXI D,-(ROWB*(CELLH-1)+1)
        DAD D                   ; HL — самый младший адрес строки стакана
        POP PSW
        MOV B,A
        ADD A
        ADD B
        ADD A
        ADD A
        ADD B                   ; 13*строка экранных строк
        JZ DR3
        MOV C,A
DR1:    PUSH H
        LXI D,ROWB*CELLH
        DAD D                   ; HL — та же строка клетками выше
        POP D
        PUSH D
        MVI B,20
DR2:    MOV A,M
        STAX D
        INX H
        INX D
        DCR B
        JNZ DR2
        POP H
        LXI D,ROWB
        DAD D
        DCR C
        JNZ DR1
DR3:    MVI B,10                ; верхняя строка — пустая
DR4:    XRA A
        CALL CELLA
        XRA A
        PUSH B
        CALL BLK
        POP B
        DCR B
        JNZ DR4
        RET

; ----------------------------------------------------------------------
; Счёт

CLRST:  LXI H,SCORE               ; SCORE, LINES, LCNT, LEVEL
        MVI B,7
CS1:    MVI M,0
        INX H
        DCR B
        JNZ CS1
        MVI A,10
        STA LCNT
        RET

; SCORE += DE (BCD); C, D, E не портит
ADDSC:  LXI H,SCORE
        MOV A,M
        ADD E
        DAA
        MOV M,A
        INX H
        MOV A,M
        ADC D
        DAA
        MOV M,A
        INX H
        MOV A,M
        ACI 0
        DAA
        MOV M,A
        RET

SETSPD: LDA LEVEL
        CPI 15
        JC SS1
        MVI A,15
SS1:    MOV E,A
        MVI D,0
        LXI H,GTAB
        DAD D
        MOV A,M
        STA SPEED
        STA GCNT
        RET

SHOWST: LXI H,SCORE+2
        MVI C,3
        LXI D,P_SCORE
        CALL PBCD
        LXI H,LINES+1
        MVI C,2
        LXI D,P_LINES
        CALL PBCD
        LDA LEVEL               ; уровень -> BCD
        MVI B,0
SH1:    CPI 10
        JC SH2
        SUI 10
        INR B
        JMP SH1
SH2:    MOV C,A
        MOV A,B
        RLC
        RLC
        RLC
        RLC
        ORA C
        STA TMP
        LXI H,TMP
        MVI C,1
        LXI D,P_LEVEL
        JMP PBCD

; ----------------------------------------------------------------------
; Графика

; Клетка стакана: A = строка, B = столбец -> HL = адрес на экране
; (ROW0 - 45*13*строка - 2*столбец)
CELLA:  LXI H,ROW0
        LXI D,-ROWB*CELLH
        INR A
CA1:    DCR A
        JZ CA2
        DAD D
        JMP CA1
CA2:    MOV A,L
        SUB B
        JNC CA3
        DCR H
CA3:    SUB B
        MOV L,A
        RNC
        DCR H
        RET

; Клетка 16x13 по адресу HL: A<>0 — кубик, A=0 — пусто. B не портит.
BLK:    XCHG
        LXI H,BPAT
        ORA A
        JNZ BK1
        LXI H,ZEROS
BK1:    MVI C,CELLH
BK2:    MOV A,M
        STAX D
        INX H
        DCX D
        MOV A,M
        STAX D
        INX H
        MOV A,E                 ; DE = DE+1-45
        SUI ROWB-1
        MOV E,A
        JNC BK3
        DCR D
BK3:    DCR C
        JNZ BK2
        RET

; Следующая фигура в окне справа
PREVIEW:
        LXI H,PREVA
        MVI C,4
PV1:    PUSH H
        PUSH B
        MVI B,4
PV2:    PUSH H
        XRA A
        CALL BLK
        POP H
        DCX H
        DCX H
        DCR B
        JNZ PV2
        POP B
        POP H
        LXI D,-ROWB*CELLH
        DAD D
        DCR C
        JNZ PV1
        MVI B,0
        LDA NT
        CALL SHPTR2
        MVI C,4
PV3:    PUSH H
        PUSH B
        MOV A,M
        ANI 0FH
        ADD A
        MOV B,A                 ; B = 2*dx
        MOV A,M
        RRC
        RRC
        RRC
        RRC
        ANI 0FH
        MOV C,A                 ; C = dy
        LXI H,PREVA
        MOV A,L
        SUB B
        MOV L,A
        JNC PV4
        DCR H
PV4:    MOV A,C
        ORA A
        JZ PV6
        LXI D,-ROWB*CELLH
PV5:    DAD D
        DCR C
        JNZ PV5
PV6:    MVI A,1
        CALL BLK
        POP B
        POP H
        INX H
        DCR C
        JNZ PV3
        RET

; Экран новой игры: очистка, стакан, надписи, счёт
SCREEN: CALL CLS
        CALL DECOR
        CALL CLRST
        CALL SETSPD
        JMP SHOWST

; Очистка видеоОЗУ C700-FFFF
CLS:    LXI H,0C700H
        LXI B,10000H-0C700H
CLS1:   MVI M,0
        INX H
        DCX B
        MOV A,B
        ORA C
        JNZ CLS1
        RET

; Стенки, дно и постоянные надписи
DECOR:  LXI H,0FFFFH-ROWB*20-14
        MVI A,06H
        MVI C,133               ; строки 20..285
        CALL VLINE
        LXI H,0FFFFH-ROWB*20-35
        MVI A,0C0H
        MVI C,133
        CALL VLINE
        LXI H,0FFFFH-ROWB*284-14
        CALL HLINE
        LXI H,0FFFFH-ROWB*285-14
        CALL HLINE
        LXI H,S_STATIC
        JMP PRLIST

; Вертикаль байтом A, 2*C строк вниз от HL
VLINE:  LXI D,-ROWB
VL1:    MOV M,A
        DAD D
        MOV M,A
        DAD D
        DCR C
        JNZ VL1
        RET

; Дно стакана от байта HL (bc 14) вправо
HLINE:  MVI M,07H
        DCX H
        MVI B,20
HL1:    MVI M,0FFH
        DCX H
        DCR B
        JNZ HL1
        MVI M,0C0H
        RET

; ----------------------------------------------------------------------
; Текст

; Символ A по экранному адресу DE; DE сдвигается на знакоместо вправо.
; HL, BC не портит.
PUTC:   PUSH H
        PUSH B
        PUSH D
        MOV L,A
        MVI H,0
        DAD H
        DAD H
        DAD H
        LXI B,FONT
        DAD B
        MVI C,8
PC1:    MOV A,M
        STAX D
        INX H
        MOV A,E
        SUI ROWB
        MOV E,A
        JNC PC2
        DCR D
PC2:    DCR C
        JNZ PC1
        POP D
        DCX D
        POP B
        POP H
        RET

; Строка HL (до 0) по адресу DE; на выходе HL указывает на 0
PUTS:   MOV A,M
        ORA A
        RZ
        CALL PUTC
        INX H
        JMP PUTS

; Сообщение HL (две строки) в левую панель; CLRMSG — стереть
MSG:    PUSH H
        CALL CLRMSG
        POP H
        LXI D,P_MSG1
        CALL PUTS
        INX H
        LXI D,P_MSG2
        JMP PUTS
CLRMSG: LXI H,S_SPC
        LXI D,P_MSG1
        CALL PUTS
        LXI H,S_SPC
        LXI D,P_MSG2
        JMP PUTS

; Список: DW адрес, DB 'строка',0 ... DW 0
PRLIST: MOV E,M
        INX H
        MOV D,M
        INX H
        MOV A,D
        ORA E
        RZ
        CALL PUTS
        INX H
        JMP PRLIST

; C байтов BCD, начиная со старшего (HL), по адресу DE
PBCD:   MOV A,M
        RRC
        RRC
        RRC
        RRC
        CALL PDIG
        MOV A,M
        CALL PDIG
        DCX H
        DCR C
        JNZ PBCD
        RET
PDIG:   ANI 0FH
        ADI '0'
        JMP PUTC

; ----------------------------------------------------------------------
; Пульт

; Опрос матрицы: A = код нажатой клавиши или 0
KSCAN:  LXI H,KBTAB
        MVI C,80H               ; FA: бит 7 как у прошивки, биты 4-5 — столбец
KS1:    MOV A,C
        OUT 0FAH
        IN 0F6H
        CMA
        ORA A
        JNZ KS3
        LXI D,8
        DAD D
        MOV A,C
        ADI 10H
        MOV C,A
        CPI 0C0H
        JNZ KS1
        XRA A
        RET
KS3:    RAR
        JC KS4
        INX H
        JMP KS3
KS4:    MOV A,M
        CPI 55H                 ; 55 — нет клавиши
        RNZ
        XRA A
        RET

; Новое нажатие: A = код или 0
GETKEY: CALL KSCAN
        MOV B,A
        LDA LASTK
        CMP B
        MOV A,B
        STA LASTK
        RNZ
        XRA A
        RET

; Щелчок: короткий импульс 0 на бите 4 порта F8 (как у прошивки)
CLICK:  MVI A,20H
        OUT 0F8H
        LXI B,300
CK1:    DCX B
        MOV A,B
        ORA C
        JNZ CK1
        MVI A,30H
        OUT 0F8H
        RET

FDELAY: LXI B,FDEL
FD1:    DCX B
        MOV A,B
        ORA C
        JNZ FD1
        RET

; ----------------------------------------------------------------------
; Случайные числа: 16-битный РСЛОС (Галуа, x^16+x^5+x^3+x^2+1)
RND:    LHLD SEED
        MVI B,8
RN1:    DAD H
        JNC RN2
        MOV A,L
        XRI 2DH
        MOV L,A
RN2:    DCR B
        JNZ RN1
        SHLD SEED
        MOV A,L
        XRA H
        RET

; Тип фигуры 0..6; повтор предыдущей перевыбирается один раз
RND7:   CALL RND
        ANI 7
        CPI 7
        JZ RND7
        MOV B,A
        LDA NT
        CMP B
        MOV A,B
        RNZ
R7B:    CALL RND
        ANI 7
        CPI 7
        JZ R7B
        RET

; ======================================================================
; Данные

; Фигуры: 4 поворота по 4 клетки, байт = dy*16+dx (повороты SRS)
SHAPES: DB 10H,11H,12H,13H, 02H,12H,22H,32H, 23H,22H,21H,20H, 31H,21H,11H,01H  ; I
        DB 00H,10H,11H,12H, 02H,01H,11H,21H, 22H,12H,11H,10H, 20H,21H,11H,01H  ; J
        DB 02H,10H,11H,12H, 22H,01H,11H,21H, 20H,12H,11H,10H, 00H,21H,11H,01H  ; L
        DB 01H,02H,11H,12H, 01H,02H,11H,12H, 01H,02H,11H,12H, 01H,02H,11H,12H  ; O
        DB 01H,02H,10H,11H, 12H,22H,01H,11H, 21H,20H,12H,11H, 10H,00H,21H,11H  ; S
        DB 01H,10H,11H,12H, 12H,01H,11H,21H, 21H,12H,11H,10H, 10H,21H,11H,01H  ; T
        DB 00H,01H,11H,12H, 02H,12H,11H,21H, 22H,21H,11H,10H, 20H,10H,11H,01H  ; Z

KICKS:  DB 0,-1,1,-2,2,80H

; Очки за 1-4 линии (BCD), умножаются на (уровень+1)
PTS:    DW 0040H,0100H,0300H,1200H

; Кадров на одну строку падения по уровням
GTAB:   DB 40,34,29,24,20,16,13,10,8,7,6,5,4,3,3,2

; Кубик 16x13: рамка, внутри сплошной квадрат, справа и снизу зазор
BPAT:   DB 0FFH,0FEH
        DB 080H,002H
        DB 0BFH,0FAH, 0BFH,0FAH, 0BFH,0FAH, 0BFH,0FAH
        DB 0BFH,0FAH, 0BFH,0FAH, 0BFH,0FAH, 0BFH,0FAH
        DB 080H,002H
        DB 0FFH,0FEH
        DB 000H,000H

; Надписи: экранный адрес, текст (КОИ-7 Н2). Стрелки шрифта: 80 ↑, 82 →, 84 ↓, 86 ←
S_STATIC:
        DW 0FFFFH-ROWB*24-TX0
        DB 'ТЕТРИС',0
        DW 0FFFFH-ROWB*48-TX0
        DB 'ОЧКИ',0
        DW 0FFFFH-ROWB*84-TX0
        DB 'ЛИНИИ',0
        DW 0FFFFH-ROWB*120-TX0
        DB 'УРОВЕНЬ',0
        DW 0FFFFH-ROWB*24-37
        DB 'ДАЛЕЕ',0
        DW 0FFFFH-ROWB*212-TX0
        DB 86H,82H,' СДВИГ',0
        DW 0FFFFH-ROWB*224-TX0
        DB 80H,'  ПОВОРОТ',0
        DW 0FFFFH-ROWB*236-TX0
        DB 84H,'  ВНИЗ',0
        DW 0FFFFH-ROWB*248-TX0
        DB '+  БРОСОК',0
        DW 0FFFFH-ROWB*260-TX0
        DB 'СТАРТ ПАУЗА',0
        DW 0FFFFH-ROWB*272-TX0
        DB 'МЕНЮ  ВЫХОД',0
        DW 0

; Сообщения в левой панели (строка 1, строка 2)
M_TITLE:
        DB '  НАЖМИТЕ',0,'   СТАРТ',0
M_PAUSE:
        DB '   ПАУЗА',0,0
M_OVER: DB 'КОНЕЦ ИГРЫ',0,'СТАРТ-СНОВА',0
S_SPC:  DB '           ',0

CODEEND:

; ======================================================================
; Переменные (ОЗУ, не загружаются)
SEED:   DS 2
LASTK:  DS 1
REP:    DS 1
GCNT:   DS 1
SPEED:  DS 1
PT:     DS 1
PX:     DS 1                    ; PX, PY, PR и TX, TY, TR — подряд (COPY3, SHLD)
PY:     DS 1
PR:     DS 1
TX:     DS 1
TY:     DS 1
TR:     DS 1
NT:     DS 1
FILL:   DS 1
NCLR:   DS 1
CROW:   DS 1
TMP:    DS 1
SCORE:  DS 3                    ; BCD, младший байт первым; дальше подряд
LINES:  DS 2                    ; BCD                         ; обнуляет CLRST
LCNT:   DS 1                    ; линий до следующего уровня
LEVEL:  DS 1
VAREND:
