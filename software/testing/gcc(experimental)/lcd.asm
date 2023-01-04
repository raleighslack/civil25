		CPU 8086
		BITS 16

		SECTION .text
		GLOBAL lcd_send_letter
		GLOBAL lcd_send_control
		GLOBAL lcd_print_string
		GLOBAL lcd_return_home
		GLOBAL lcd_clear_display
		GLOBAL lcd_entry_mode
		GLOBAL lcd_display_control
		GLOBAL lcd_function_set


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
		jz .2
.1:
		lodsb
		test al, al
		jz .2
		out 01h, al
		mov al, 00000001b
		out 02h, al
		mov al, 00000101b
		out 02h, al
		mov al, 00000001b
		out 02h, al 
		jmp .1
.2:
		add sp, 2

		pop si

		mov sp, bp
		pop bp
		ret

;--------------------------------------
; void lcd_entry_mode(bool cursor_move_dir, bool disp_shift);
;--------------------------------------
lcd_entry_mode:
		push bp
		mov bp, sp

		mov al, 0b00000100
		mov ah, [bp + 4]
		test ah, ah
		jz .1
		or al, 0b00000010
.1:
		mov ah, [bp + 6]
		test ah, ah
		jz .2
		or al, 0b00000001
.2:
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
; void lcd_display_control(bool onoff, bool onoffcursor, bool onoffblink);
;--------------------------------------
lcd_display_control:
		push bp
		mov bp, sp

		mov al, 0b00001000
		mov ah, [bp + 4]
		test ah, ah
		jz .1
		or al, 0b00000100
.1:
		mov ah, [bp + 6]
		test ah, ah
		jz .2
		or al, 0b00000010
.2:
		mov ah, [bp + 8]
		test ah, ah
		jz .3
		or al, 0b00000001
.3:
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
; void lcd_function_set(bool data_len, bool disp_lines, bool font);
;--------------------------------------
lcd_function_set:
		push bp
		mov bp, sp

		mov al, 0b00100000
		mov ah, [bp + 4]
		test ah, ah
		jz .1
		or al, 0b00010000
.1:
		mov ah, [bp + 6]
		test ah, ah
		jz .2
		or al, 0b00001000
.2:
		mov ah, [bp + 8]
		test ah, ah
		jz .3
		or al, 0b00000100
.3:
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
; void lcd_return_home();
;--------------------------------------
lcd_return_home:
		push bp
		mov bp, sp

        mov al, 00000010b
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
; void lcd_clear_display();
;--------------------------------------
lcd_clear_display:
		push bp
		mov bp, sp

        mov al, 00000001b
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