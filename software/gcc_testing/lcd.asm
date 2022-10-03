	CPU 8086
	BITS 16

	SECTION .text
	GLOBAL send_letter
	GLOBAL load_al

send_letter:
	out 00h, al
	mov al, 00000001b
	out 01h, al
	mov al, 00000101b
	out 01h, al
	mov al, 00000001b
	out 01h, al
	ret

load_al:
	mov bx, sp
	mov al, [bx + 2]
	ret
