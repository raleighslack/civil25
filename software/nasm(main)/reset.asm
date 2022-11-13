        CPU 8086
        BITS 16

        GLOBAL reset
        SECTION .reset

reset:
        jmp 0xC000:0x0000 ;Jumps to start of code in ROM