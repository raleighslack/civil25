	CPU 8086
	BITS 16

	SECTION .text
	GLOBAL lcd_send_letter
	GLOBAL lcd_send_control
	GLOBAL lcd_print_string
	GLOBAL lcd_return_home

lcd_send_letter:
		mov bx, sp
		mov al, [bx + 2]
		out 00h, al
		mov al, 00000001b
		out 01h, al
		mov al, 00000101b
		out 01h, al
		mov al, 00000001b
		out 01h, al
		ret

lcd_send_control:
		mov bx, sp
		mov al, [bx + 2]
		out 00h, al
		mov al, 00000000b
		out 01h, al
		mov al, 00000001b
		out 01h, al
		mov al, 00000000b
		out 01h, al
		ret

lcd_print_string:
		ret

lcd_return_home:
        mov al, 00000010b
        out 00h, al
		mov al, 00000000b
		out 01h, al
		mov al, 00000001b
		out 01h, al
		mov al, 00000000b
		out 01h, al
		ret