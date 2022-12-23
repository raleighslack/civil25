        CPU 8086
        BITS 16

        SECTION .text

main:
        cli
        mov ax, 0x7000          ;loads where stack will be; has to be 64k
        mov ss, ax
        xor sp, sp              ;sets stack pointer to 0

        mov ax, 0x0000
        mov ds, ax

        mov al, 10010000b       ;move 10000010 into AL
        out 03h, al             ;Move AL into 82c55 control register; setting I/O chip to mode 0, all ports are output except for PORTB (keyboard) 
        mov al, 0x00            ;Sets control register of lcd to 0; just to be safe
        out 02h, al

        mov al, 00111000b       ;Set 8 bit mode, 2-line display, 5x8 font
        call writeControl

        mov al, 00001111b       ;Display on, cursor on, blink on
        call writeControl

        mov al, 00000110b       ;Increment and shift cursor; don't shift display
        call writeControl       ;Write to control register of LCD

        mov al, 00000010b       ;Go to home
        call writeControl

init_irq_vectors:               ;sets up irq_handler for interrupts
	mov di, 32 * 4
	mov ax, irq_handler
	stosw
	mov ax, cs
	stosw

	mov ax, 0xC000          ;sets data segment to C000 - Will change
        mov ds, ax

init_pic:
	mov al, 00010111b      ; ICW1
        out 0x20, al
        mov al, (32 & 11111000b)  ; ICW2, offset of 0x08, anding it is just for safety
        out 0x21, al
        mov al, 00000011b      ; ICW4
        out 0x21, al

        mov al, 11111110b      ; mask all interrupts execpt for IRQ0
        out 0x21, al

        mov al, 00001000b
        out 0x20, al

init_avdc:                      ;init video chip; Refer to SCN2674 Datasheet for more info on initlization; https://www.jameco.com/Jameco/Products/ProdDS/2303183.pdf
        xor al, al
        out 0x31, al            ;Master reset; its all zeroes
        out 0x31, al
        mov al, 00011000b       ;Double Height|Scan lines per character row|sync select(vsync or csync)|Buffer select mode; = DSSSSVBB
        out 0x30, al            ;Registers auto increment, so following out's will be to 0x30, 0x31, 0x32 etc. (not actually, just in the AVDC's eyes); IR0
        mov al, 00011001b       ;Interlace Enable|Horizontal front porch control; =  IPPPPPPP (in this case front porch is 26 character clocks -1 = 25 = 0011001)
        out 0x30, al            ;really sees it as 0x31; IR1
        mov al, 00101010b       ;Row Table|Hsync width|Horizontal Back Porch; = RHHHHPPP
        out 0x30, al            ;AVDC sees this as 0x32; IR2
        mov al, 01001101b       ;Vertical Front Porch|Vertical Back Porch; = FFFBBBBB
        out 0x30, al            ;AVDC sees this as 0x33; IR3
        mov al, 01110111b       ;Character Blink rate|Active character rows per screen; = CAAAAAAA
        out 0x30, al            ;AVDC sees this as 0x34; IR4
        mov al, 01001111b       ;Active Characters Per Row; = AAAAAAAA
        out 0x30, al            ;AVDC sees this as 0x35; IR5
        mov al, 00000000b       ;First Line Of Cursor|Last line of cursor; = FFFFLLLL
        out 0x30, al            ;AVDC sees this as 0x36: IR6
        mov al, 00000000b       ;Vsync Width|Cursor Blink|Cursor Rate|Underline Position; = VVBRUUUU
        out 0x30, al            ;AVDC sees this as 0x37; IR7
        out 0x30, al            ;AVDC sees this as 0x38; IR8
        mov al, 11110000b
        out 0x30, al            ;AVDC sees this as 0x39; IR9
        xor al, al
        out 0x30, al            ;AVDC sees this as 0x3A; IR10
        out 0x30, al            ;AVDC sees this as 0x3B; IR11
        out 0x30, al            ;AVDC sees this as 0x3C; IR12
        out 0x30, al            ;AVDC sees this as 0x3D; IR13
        out 0x30, al            ;AVDC sees this as 0x3E; IR14

        mov al, 00111111b       ;turn display on command
        out 0x31, al

;writeLCDString:
;        mov si, message         ;loads pointer into SI, used with lodsb (load string byte)
;writeLoop:
;        lodsb                   ;wierd instruction; loads AL with data from DS:SI, and then increments SI and DI
;        cmp al, al            ;sets flags register, if al is 0 (end of null terminated string)
;        jz playSound            ;jump to play sound
;        call writeLetter        ;writes letter from AL
;        jmp writeLoop           ;if its not 0, then continue in the loop


writeLCDString:
        mov cx, message_end - message ;loads CX with # of characters
        mov si, message         ;loads pointer into appropriate register
writeLoop:
        lodsb                   ;wierd instruction; loads AL with data from DS:SI, and then increments SI and DI
        call writeLetter        ;writes letter from AL
        dec cx                  ;decreses # of characters to write
        jnz writeLoop           ;if its not done, jump back up
        jmp playSound           ;otherwise jump to loop


playSound:
        mov al, 0x20            ;set register 20
        out 0x10, al
        mov al, 00000001b       ;defines sound MULTI/KSR/EG_TYPE/VIB/AM
        out 0x11, al

        mov al, 0x23            ;set register 23
        out 0x10, al
        mov al, 00000001b
        out 0x11, al

        mov al, 0x40            ;set register 40
        out 0x10, al
        mov al, 00011111b       ;Volume/Key scale level
        out 0x11, al

        mov al, 0x43            ;set register 43
        out 0x10, al
        mov al, 0x00
        out 0x11, al

        mov al, 0x60            ;set register 60
        out 0x10, al
        mov al, 0xe4
        out 0x11, al

        mov al, 0x63            ;set register 63
        out 0x10, al
        mov al, 0xe4
        out 0x11, al

        mov al, 0x80            ;set register 80
        out 0x10, al
        mov al, 0x9d
        out 0x11, al

        mov al, 0x83            ;set register 83
        out 0x10, al
        mov al, 0x9d
        out 0x11, al

        mov al, 0xa0            ;set register a0
        out 0x10, al
        mov al, 0xae
        out 0x11, al

        mov al, 0xb0
        out 0x10, al
        mov al, 00111110b            ;UUSOOOFF; 00101010
        out 0x11, al

        call delay

        mov al, 0xb0
        out 0x10, al
        mov al, 0x00
        out 0x11, al

        mov al, 0xb0
        out 0x10, al
        mov al, 00100010b            ;UUSOOOFF; 00101010
        out 0x11, al

        call delay

        mov al, 0xb0
        out 0x10, al
        mov al, 0x00
        out 0x11, al

        sti

        jmp loop



writeControl:                   ;writes to control register of LCD
        out 01h, al
        xor al, al              ;Turn off register select pin
        out 02h, al
        mov al, 00000100b       ;Turn on enable pin, sending the instruction 
        out 02h, al
        mov al, 0x00            ;Reset pin state; Should be replaced with xor al, al
        out 02h, al
        ret

irq_handler:                    ;irq handler is for 0x32
        in al, 00h
        call writeLetter
        iret

delay:
        mov cx, 0xff00
.1:     dec cx
        jnz .1

        ret

writeLetter:                    ;writes to data register of LCD
        out 01h, al
        mov al, 00000001b       ;Turn on register select pin
        out 02h, al
        mov al, 00000101b       ;Turn on register select pin + enable pin
        out 02h, al
        mov al, 00000001b       ;Reset back to original state
        out 02h, al
        ret

loop:                           ;this just plays the YM3812 in a loop
        mov al, 0xb0
        out 0x10, al
        mov al, 00101110b       ;UUSOOOFF; 00101010
        out 0x11, al

        call delay

        mov al, 0xb0
        out 0x10, al
        mov al, 0x00
        out 0x11, al

        jmp loop

message: 
    db "it work:)"
message_end: