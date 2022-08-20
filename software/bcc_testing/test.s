  .org 0x3000
start:
  nop
  mov al, 0x05
  mov cl, 0x05
  add cl, al

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
