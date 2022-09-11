        CPU 8086
		
ROMSIZE equ 262144
ROMCS   equ 0xC0000
INIT_SS equ 07000h
INIT_SP equ 0FFF0h

        org 10000h-ROMSIZE

start:
		mov ah, 0x12
		mov al, 0x34
		jmp start
		
		
times ROMSIZE-16-($-$$) db 0xFF

        jmp     0xC000:0x0000

times ROMSIZE-($-$$) db 0xFF
