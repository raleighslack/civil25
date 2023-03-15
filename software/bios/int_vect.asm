        CPU 8086
        BITS 16

        SECTION .text

        GLOBAL init_int_vectors

init_int_vectors:
        xor cx, cx
        mov si, int_vectors
        mov dx, cs
        mov ds, dx
        xor di, di
        mov es, di

.1:
        movsw
        mov [es:di], dx
        add di, 2

        inc cx
        cmp cx, (int_vectors_end - int_vectors) / 2
        jb .1

        mov ax, default_handler
.2:
        stosw
        mov [es:di], dx
        add di, 2

        inc cx
        cmp cx, 0x0100
        jb .2

        ret

default_handler:
        iret

int_vectors:
; divide by 0
        DW default_handler
; single step

; NMI

; breakpoint

; overflow

int_vectors_end: