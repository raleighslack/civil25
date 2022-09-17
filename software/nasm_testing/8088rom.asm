        CPU 8086
		
ROMSIZE equ 262144
ROMCS   equ 0C000h
INIT_SS equ 07000h
INIT_SP equ 0FFF0h


        org 10000h-ROMSIZE

start:
		mov al, 0x80
		out 03h, al
		mov al, 0xFF
		out 02h, al
loop:
		jmp loop
		
		
times ROMSIZE-16-($-$$) db 0FFh

        jmp     0xC000:0x0000

times ROMSIZE-($-$$) db 0x90
