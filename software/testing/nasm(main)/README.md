## NASM

This is the main assembler in use for the moment, until GCC has a bit more functionality. The current file does these things:

1. Jump to C000:0000, the start of code in ROM
2. Init the CPU, and stack
3. Init the 8255 PPI
4. Init LCD
5. Set up IRQ Vector
6. Init the 8259 PIC
7. Write a string to the LCD
8. Initlize the YM3812
9. Sit in a loop, playing the YM3812

# I/O Ports

- 0x00 - 0x03: 8255 PPI
- 0x10 - 0x11: YM3812 FM Sound
- 0x20 - 0x21: 8259 PIC
- 0x30 - 0x31: SCN2674 AVDC
