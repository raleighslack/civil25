        cpu 8086
		
ROMSIZE equ 262144
ROMCS   equ 0F000h
INIT_SS equ 07000h
INIT_SP equ 0FFF0h

        org 10000h-ROMSIZE

start:
		mov al, 0x01
		mov ah, 0xFF
		xor al, al
		mov ah, 0x90
		jmp start
		
		
times ROMSIZE-16-($-$$) db 0FFh
; reset vector
        jmp     0xC0000
; pad out the rest of the ROM with NOPs
times ROMSIZE-($-$$) db 0x90