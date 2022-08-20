  ;.org 0x0

start:
  nop
  mov al, 0x05
  mov cl, 0x05
  add cl, al
  jmp start
	 
  ;.org 0x3fff0
  jmp start
