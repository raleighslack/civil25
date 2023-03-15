        CPU 8086
        BITS 16

        SECTION .resetvec

        GLOBAL reset

        EXTERN init
        

reset:
        jmp 0xC000:init ;Jumps to start of code in ROM