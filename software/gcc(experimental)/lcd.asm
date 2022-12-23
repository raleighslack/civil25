		CPU 8086
		BITS 16

		SECTION .text
		GLOBAL lcd_send_letter
		GLOBAL lcd_send_control
		GLOBAL lcd_print_string
		GLOBAL lcd_return_home
		GLOBAL lcd_clear_display


;--------------------------------------
; void lcd_send_letter(char c);
;--------------------------------------
lcd_send_letter:
		push bp
		mov bp, sp

		mov al, [bp + 4]
		out 01h, al
		mov al, 00000001b
		out 02h, al
		mov al, 00000101b
		out 02h, al
		mov al, 00000001b
		out 02h, al

		mov sp, bp
		pop bp
		ret


;--------------------------------------
; void lcd_send_control(char c);
;--------------------------------------
lcd_send_control:
		push bp
		mov bp, sp

		mov al, [bp + 4]
		out 01h, al
		xor al, al
		out 02h, al
		mov al, 00000100b
		out 02h, al
		xor al, al
		out 02h, al

		mov sp, bp
		pop bp
		ret


;--------------------------------------
; void lcd_print_string(const char *string);
;--------------------------------------
lcd_print_string:
		push bp
		mov bp, sp

		push si
		mov si, [bp + 4]
		test si, si
		jz end_of_string
string_loop:		
		lodsb
		test al, al
		jz end_of_string
		push ax
		call lcd_send_letter
		add sp, 2
		jmp string_loop
end_of_string:
		add sp, 2

		pop si

		mov sp, bp
		pop bp
		ret


;--------------------------------------
; void lcd_return_home();
;--------------------------------------
lcd_return_home:
		push bp
		mov bp, sp

        mov al, 00000010b
        out 01h, al
		mov al, 00000000b
		out 02h, al
		mov al, 00000100b
		out 02h, al
		mov al, 00000000b
		out 02h, al

		mov sp, bp
		pop bp
		ret

;--------------------------------------
; void lcd_clear_display();
;--------------------------------------
lcd_clear_display:
		push bp
		mov bp, sp

        mov al, 00000001b
        out 01h, al
		mov al, 00000000b
		out 02h, al
		mov al, 00000100b
		out 02h, al
		mov al, 00000000b
		out 02h, al

		mov sp, bp
		pop bp
		ret