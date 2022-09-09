  .org 0x0

start:
  nop

loop:
	mov %al, 0x01
	mov %ah, 0xFF
	xor %al, %al
	mov %ah, 0x90
	jmp start

  .org 0x3fff0
  jmp start
  .8byte 0x00000000
  .2byte 0x00
  .byte 0x0