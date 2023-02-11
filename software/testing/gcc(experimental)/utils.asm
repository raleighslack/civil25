		CPU 8086
		BITS 16

		SECTION .text
		GLOBAL ramtest
                GLOBAL delay

;--------------------------------------
; void delay(uint16_t steps);
;--------------------------------------
delay:
        push bp
        mov bp, sp

        mov cx, [bp + 2]
.1:     dec cx
        jnz .1

        mov sp, bp
        pop bp
        ret

;--------------------------------------
; uint16_t ramtest();
;--------------------------------------
ramtest:
	push bp
	mov bp, sp
        push ds

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

        pop ds
	mov sp, bp
	pop bp
	ret