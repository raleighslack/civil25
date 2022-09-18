        CPU 8086
		
ROMSIZE equ 262144
ROMCS   equ 0C000h
INIT_SS equ 07000h
INIT_SP equ 0FFF0h


        org 10000h-ROMSIZE

start:
		mov al, 0x80 ;move 10000000 into AL
		out 03h, al ;Move AL into 82c55 control register, mode 0, all ports are output
		mov al, 0x00 ;Sets control register to 0; just to be safe
		out 01h, al

		mov al, 00111000b ;Set 8 bit mode, 2-line display, 5x8 font
		out 00h, al ;send to LCD
		call writeControl

		mov al, 00001111b ;Display on, cursor on, blink on
		out 00h, al
		call writeControl

		mov al, 00000110b ;Increment and shift cursor; don't shift display
		out 00h, al
		call writeControl ;Write to control register of LCD

		mov al, "H" ;Write H to LCD
		out 00h, al
		call writeLetter ;Jumps to writeLetter, then returns

		mov al, "e" ;Write e to LCD
		out 00h, al
		call writeLetter

		mov al, "l" ;Write l to LCD
		out 00h, al
		call writeLetter

		mov al, "l" ;Write l to LCD
		out 00h, al
		call writeLetter
		
		mov al, "o" ;Write o to LCD
		out 00h, al
		call writeLetter

		mov al, "," ;Write , to LCD
		out 00h, al
		call writeLetter
		
		mov al, " " ;Write ( ) to LCD
		out 00h, al
		call writeLetter

		mov al, "W" ;Write W to LCD
		out 00h, al	
		call writeLetter

		mov al, "o" ;Write o to LCD
		out 00h, al
		call writeLetter

		mov al, "r" ;Write r to LCD
		out 00h, al
		call writeLetter

		mov al, "l" ;write l to LCD
		out 00h, al
		call writeLetter

		mov al, "d" ;Write d to LCD
		out 00h, al
		call writeLetter

		mov al, "!" ;Write ! to LCD
		out 00h, al
		call writeLetter

writeControl: ;writes to control register of LCD
		mov al, 0x00 ;Turn off register select pin
		out 01h, al
		mov al, 00000100b ;Turn on enable pin, sending the instruction 
		out 01h, al
		mov al, 0x00 ;Reset pin state; Should be replaced with xor al, al
		out 01h, al
		ret

writeLetter: ;writes to data register of LCD
		mov al, 00000001b ;Turn on register select pin
		out 01h, al
		mov al, 00000101b ;Turn on register select pin + enable pin
		out 01h, al
		mov al, 00000001b ;Reset back to original state
		out 01h, al
		ret

loop: ;Flashes LED connected to PORTC
		mov al, 11111111b ;set AL all high
		out 02h, al ;set all of PORT C pins high
		mov al, 00000000b ;set AL all low
		out 02h, al ;set all of PORT C pins low
		jmp loop
		
		
times ROMSIZE-16-($-$$) db 0xFF

        jmp     0xC000:0x0000 ;Jumps to start of code in ROM

times ROMSIZE-($-$$) db 0xFF
