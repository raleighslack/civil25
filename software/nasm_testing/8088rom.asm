        cpu 8086
		
ROMSIZE equ 262144
ROMCS   equ 0F000h
INIT_SS equ 07000h
INIT_SP equ 0FFF0h

        org 10000h-ROMSIZE

start:
		mov	ax, INIT_SS
		mov bx, INIT_SP
		mov ss, ax
		mov sp, bx
		jmp start
		
		
times ROMSIZE-16-($-$$) db 0FFh
; reset vector
        jmp     ROMCS:start
; pad out the rest of the ROM with NOPs
times ROMSIZE-($-$$) db 0x90