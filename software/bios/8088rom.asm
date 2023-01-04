        CPU 8086
        BITS 16

        SECTION .text


main:
        mov ax, 0x7000          ;loads where stack will be; has to be 64k
        mov ss, ax
        xor sp, sp              ;sets stack pointer to 0

        mov ax, 0x0000
        mov ds, ax

        mov al, 10010000b       ;move 10000010 into AL
        out 03h, al             ;Move AL into 82c55 control register; setting I/O chip to mode 0, all ports are output except for PORTB (keyboard) 
        mov al, 0x00            ;Sets control register of lcd to 0; just to be safe
        out 02h, al

        mov al, 00111000b       ;Set 8 bit mode, 2-line display, 5x8 font;38
        call writeControl

        mov al, 00001111b       ;Display on, cursor on, blink on;0f
        call writeControl

        mov al, 00000110b       ;Increment and shift cursor; don't shift display;06
        call writeControl       ;Write to control register of LCD

        mov al, 00000010b       ;Go to home
        call writeControl

memtest:
        xor bx, bx
        mov ax, 0xF800
        mov ds, ax
ramLoop:
        mov ax, ds
        add ax, 0800h
        mov ds, ax
        mov al, 07h
        mov ds:[0], al
        mov al, ds:[0]
        cmp al, 07h
        je ramSuccess
        jne ramFail
ramSuccess:
        inc al
        mov ds:[0], al
        mov al, ds:[0]
        cmp al, 08h
        jne ramFail
        inc bx
ramFail:
        mov ax, ds
        cmp ax, 0xF800
        jne ramLoop

        xchg ax, bx
        mov bx, 0x0020
        mul bx

        mov cx, 10
        xor bx, bx
divide:
        xor dx, dx
        div cx
        push dx
        inc bx
        test ax, ax
        jnz divide

        mov cx, bx
        lea si, strResult

next_digit:
        pop ax
        add al, '0'
        mov [si], al
        inc si
        loop next_digit

        jmp $

writeControl:                   ;writes to control register of LCD
        out 01h, al
        xor al, al              ;Turn off register select pin
        out 02h, al
        mov al, 00000100b       ;Turn on enable pin, sending the instruction 
        out 02h, al
        mov al, 0x00            ;Reset pin state; Should be replaced with xor al, al
        out 02h, al
        ret

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

strResult: db 16 dup (0)