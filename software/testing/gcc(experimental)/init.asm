        CPU 8086
        BITS 16

        SECTION .text
        GLOBAL init

        EXTERN __dataoffset
        EXTERN __ldata
        EXTERN __lbss
        EXTERN __sbss

        EXTERN main
init:
        mov ax, 0x7000 ;loads where stack will be; has to be 64k
        mov ss, ax
        xor sp, sp ;sets stack pointer to 0
        mov es, ax

        mov ax, cs
        mov ds, ax

        mov si, __dataoffset
        mov di, __dataoffset
        mov cx, __ldata
        rep movsb

        mov al, 0x80 ;move 10000000 into AL
        out 03h, al ;Move AL into 82c55 control register; setting I/O chip to mode 0, all ports are output
        mov al, 0x00 ;Sets control register of lcd to 0; just to be safe
        out 02h, al

        xor ax, ax
        mov di, __sbss
        mov cx, __lbss
        rep stosb

        mov ax, ss
        mov ds, ax
        mov es, ax

        call main
        jmp $