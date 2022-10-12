	CPU 8086
	BITS 16

	SECTION .text
	GLOBAL lcd_send_letter
	GLOBAL load_al
	GLOBAL lcd_send_control
	GLOBAL lcd_print_string
	GLOBAL lcd_home	

lcd_send_letter:
	pop ax
	out 00h, al
	mov al, 00000001b
	out 01h, al
	mov al, 00000101b
	out 01h, al
	mov al, 00000001b
	out 01h, al
	ret

lcd_send_control:
	pop ax
	out 00h, al
	mov al, 00000000b
	out 01h, al
	mov al, 00000001b
	out 01h, al
	mov al, 00000000b
	out 01h, al
	ret

load_al:
	pop ax
	mov bx, sp
	mov al, [bx + 2]
	ret

lcd_print_string:
	ret

lcd_home:
	ret
