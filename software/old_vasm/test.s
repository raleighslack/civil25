  .org 0x3000
start:
  nop
  mov %al, 0x05
  mov %cl, 0x05
  add %cl, %al
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop

  .org 0x3fff0
  jmp start
  .8byte 0x00000000
  .2byte 0x00
  .byte 0x0