        CPU 8086
		
ROMSIZE equ 262144
ROMCS   equ 0C000h
INIT_SS equ 07000h
INIT_SP equ 0FFF0h

        org 10000h-ROMSIZE

start:
		mov ax, 0xffff
		mov bx, 0x1234
		jmp start
		
		
times ROMSIZE-16-($-$$) db 0xFF

        jmp     0xC0000

times ROMSIZE-($-$$) db 0xFF
