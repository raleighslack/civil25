  .org 0x3000
start:
  nop
  mov %al, 0x05
  mov %ah, %al
  xor %al, %al
  xor %ah, %ah
  jmp start

  .org 0x3fff0
  jmp start
  .8byte 0x00000000
  .2byte 0x00
  .byte 0x0