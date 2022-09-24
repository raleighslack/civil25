        CPU 8086
		
ROMSIZE equ 262144
ROMCS   equ 0C000h
INIT_SS equ 07000h
INIT_SP equ 0FFF0h


        org 10000h-ROMSIZE

start:
		mov ax, 0x7000 ;loads where stack will be; has to be 64k
		mov ss, ax
		xor sp, sp ;sets stack pointer to 0

		mov ax, 0xc000 ;sets data segment to C000 - Will change
		mov ds, ax

		mov al, 0x80 ;move 10000000 into AL
		out 03h, al ;Move AL into 82c55 control register; setting I/O chip to mode 0, all ports are output
		mov al, 0x00 ;Sets control register of lcd to 0; just to be safe
		out 01h, al

		mov al, 00111000b ;Set 8 bit mode, 2-line display, 5x8 font
		call writeControl

		mov al, 00001111b ;Display on, cursor on, blink on
		call writeControl

		mov al, 00000110b ;Increment and shift cursor; don't shift display
		call writeControl ;Write to control register of LCD

		mov al, 00000010b
		call writeControl

writeLCDString:
		mov cx, message_end - message ;loads CX with # of characters
		mov si, message ;loads pointer into appropriate register
writeLoop:
		lodsb ;wierd instruction; loads AL with data from DS:SI with offset
		call writeLetter ;writes letter from AL
		dec cx ;decreses # of characters to write
		jnz writeLoop ;if its not done, jump back up
		jmp loop ;otherwise jump to loop

writeControl: ;writes to control register of LCD
		out 00h, al
		xor al, al ;Turn off register select pin
		out 01h, al
		mov al, 00000100b ;Turn on enable pin, sending the instruction 
		out 01h, al
		mov al, 0x00 ;Reset pin state; Should be replaced with xor al, al
		out 01h, al
		ret

writeLetter: ;writes to data register of LCD
		out 00h, al
		mov al, 00000001b ;Turn on register select pin
		out 01h, al
		mov al, 00000101b ;Turn on register select pin + enable pin
		out 01h, al
		mov al, 00000001b ;Reset back to original state
		out 01h, al
		ret

loop:
		jmp loop

message: 
	db "Hello, world!"
message_end:
		
times ROMSIZE-16-($-$$) db 0xFF

        jmp     0xC000:0x0000 ;Jumps to start of code in ROM

times ROMSIZE-($-$$) db 0xFF
