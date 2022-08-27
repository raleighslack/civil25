  .org 0x3000

start:
  nop

loop:
  mov %al, 0x01
  nop
  xor %al, 0x00
  jmp loop

  .org 0x3fff0
  jmp start
  .8byte 0x00000000
  .2byte 0x00
  .byte 0x0