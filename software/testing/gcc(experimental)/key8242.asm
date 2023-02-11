		CPU 8086
		BITS 16

		SECTION .text
		GLOBAL key_status
        GLOBAL key_controller_test
        GLOBAL key_write_command
        GLOBAL key_read_command
        GLOBAL key_get_output
        GLOBAL key_disable
        GLOBAL key_enable
        GLOBAL key_reset


;--------------------------------------
; uint8_t key_status();
;--------------------------------------
key_status:
		push bp
		mov bp, sp

        in ax, 41

		mov sp, bp
		pop bp
		ret

;--------------------------------------
; char key_read_command();
;--------------------------------------
key_read_command:
		push bp
		mov bp, sp

        mov al, 20h
        out 41, al

        in al, 41

		mov sp, bp
		pop bp
		ret

;--------------------------------------
; uint8_t key_controller_test();
;--------------------------------------
key_controller_test:
		push bp
		mov bp, sp

        mov al, 0xaa
        out 41, al

        in al, 41

		mov sp, bp
		pop bp
		ret

;--------------------------------------
; uint8_t key_write_command(uint8_t command);
;--------------------------------------
key_write_command:
		push bp
		mov bp, sp

        mov al, 0x60
        out 41, al

        mov al, [bp + 4]
        out 41, al

        in al, 41

		mov sp, bp
		pop bp
		ret

;--------------------------------------
; char key_get_output();
;--------------------------------------
key_get_output:
		push bp
		mov bp, sp

        in al, 41

		mov sp, bp
		pop bp
		ret

;--------------------------------------
; void key_disable();
;--------------------------------------
key_disable:
		push bp
		mov bp, sp

        mov al, 0xad
        out 41, al

		mov sp, bp
		pop bp
		ret

;--------------------------------------
; void key_enable();
;--------------------------------------
key_enable:
		push bp
		mov bp, sp

        mov al, 0xae
        out 41, al

		mov sp, bp
		pop bp
		ret

;--------------------------------------
; void key_reset();
;--------------------------------------
key_reset:
		push bp
		mov bp, sp

        mov al, 0xFF
        out 40, al

		mov sp, bp
		pop bp
		ret