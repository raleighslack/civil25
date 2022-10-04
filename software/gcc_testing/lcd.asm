	CPU 8086
	BITS 16

	SECTION .text
	GLOBAL send_letter
	GLOBAL load_al
	GLOBAL send_control
send_letter:
	pop ax
	out 00h, al
	mov al, 00000001b
	out 01h, al
	mov al, 00000101b
	out 01h, al
	mov al, 00000001b
	out 01h, al
	ret

send_control:
	pop ax
	out 00h, al
	mov al, 00000000b
	out 01h, al
	inc al
	out 01h, al
	dec al
	out 01h, al
	ret

load_al:
	pop ax
	mov bx, sp
	mov al, [bx + 2]
	ret
